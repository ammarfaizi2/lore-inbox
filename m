Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266457AbUGBEQt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266457AbUGBEQt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 00:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266441AbUGBEQt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 00:16:49 -0400
Received: from ozlabs.org ([203.10.76.45]:58036 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S266474AbUGBEQf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 00:16:35 -0400
Date: Fri, 2 Jul 2004 14:12:15 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: William Lee Irwin III <wli@holomorphy.com>,
       Oleg Nesterov <oleg@tv-sign.ru>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [BUG] hugetlb MAP_PRIVATE mapping vs /dev/zero
Message-ID: <20040702041215.GG5937@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	William Lee Irwin III <wli@holomorphy.com>,
	Oleg Nesterov <oleg@tv-sign.ru>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
References: <40E43BDE.85C5D670@tv-sign.ru> <20040702012012.GC5937@zax> <20040702024422.GG21066@holomorphy.com> <20040702034937.GE5937@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040702034937.GE5937@zax>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 02, 2004 at 01:49:37PM +1000, David Gibson wrote:
> On Thu, Jul 01, 2004 at 07:44:22PM -0700, William Lee Irwin wrote:
> > On Thu, Jul 01, 2004 at 08:29:18PM +0400, Oleg Nesterov wrote:
> > >> We can fix hugetlbfs_file_mmap() or read_zero_pagealigned()
> > >> or both.
> > 
> > On Fri, Jul 02, 2004 at 11:20:12AM +1000, David Gibson wrote:
> > > Err... surely we need to fix both, yes?
> > 
> > No. /dev/zero is innocent. hugetlb is demanding VM_SHARED semantics
> > without actually setting VM_SHARED. /dev/zero tripping over its
> > nonstandard pagetable structure is not something to be dealt with
> > in /dev/zero itself.
> 
> Duh, sorry, misread the sense of the VM_SHARED test in the zeromap
> code.

On second thoughts, though, I think logically it should be fixed in
both places.  For now forcing VM_SHARED in the hugetlbfs code is
sufficient, but if we ever allow (real) MAP_PRIVATE hugepage mappings
(by implementing hugepage COW, for example), then the zeromap code
will need fixing.

Conceptually it's not so much the fact that the hugepage memory is
shared which is tripping up zeromap as the fact that it isn't mapped
in the normal way.

Of course, one could argue that the whole zeromap idea is just too
damn clever for its own good...

-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
