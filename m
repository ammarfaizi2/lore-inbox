Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262670AbVDHDki@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262670AbVDHDki (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 23:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262669AbVDHDki
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 23:40:38 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:48891 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262670AbVDHDkQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 23:40:16 -0400
Date: Fri, 8 Apr 2005 04:40:18 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] freepgt2: sys_mincore ignore FIRST_USER_PGD_NR
In-Reply-To: <42554448.6080809@yahoo.com.au>
Message-ID: <Pine.LNX.4.61.0504080425370.26784@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0504070210430.24723@goblin.wat.veritas.com> 
    <Pine.LNX.4.61.0504070204390.24723@goblin.wat.veritas.com> 
    <19283.1112868864@redhat.com> <42554448.6080809@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Apr 2005, Nick Piggin wrote:
> David Howells wrote:
> > Hugh Dickins <hugh@veritas.com> wrote:
> > 
> > > Remove use of FIRST_USER_PGD_NR from sys_mincore: it's inconsistent
> > > (no
> > > other syscall refers to it), unnecessary (sys_mincore loops over vmas
> > > further down) and incorrect (misses user addresses in ARM's first
> > > pgd).
> > 
> > You should make it use FIRST_USER_ADDRESS instead. This check allows NULL
> > pointers and suchlike to be weeded out before having to take the
> > semaphore.
> 
> I'm not sure whether it is worth keeping the singular special
> case here to slightly speed up what would probably be a bug in
> a userspace program.

Well put - though you're more diffident about it than I would be!

Furthermore, it only allows NULL pointers and suchlike to be weeded
out on the ARM (and ARM26) architecture, no other.  I'm not averse
to optimizing ARM and ARM26, but it's much too insignificant an
optimization to warrant reference to such an architectural detail.

And it breaks the (peculiar) sys_mincore convention of doing all the
work while returning -ENOMEM, if there were any holes in the address
range.  David's check stops it from doing any work in that case.

FIRST_USER_ADDRESS should be used in the very few places
it is necessary, and not spread around beyond them.

Hugh
