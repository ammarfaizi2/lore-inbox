Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751911AbWAEDsz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751911AbWAEDsz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 22:48:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751913AbWAEDsz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 22:48:55 -0500
Received: from ozlabs.org ([203.10.76.45]:46731 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751911AbWAEDsy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 22:48:54 -0500
Date: Thu, 5 Jan 2006 14:39:51 +1100
From: Anton Blanchard <anton@samba.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Linus Torvalds <torvalds@osdl.org>, Nicolas Pitre <nico@cam.org>,
       Joel Schopp <jschopp@austin.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Jes Sorensen <jes@trained-monkey.org>, Al Viro <viro@ftp.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [patch 00/21] mutex subsystem, -V14
Message-ID: <20060105033951.GD10140@krispykreme>
References: <20060104144151.GA27646@elte.hu> <43BC5E15.207@austin.ibm.com> <Pine.LNX.4.64.0601042133230.27409@localhost.localdomain> <Pine.LNX.4.64.0601041847330.3279@g5.osdl.org> <43BC90CE.4040201@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43BC90CE.4040201@yahoo.com.au>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

> Side note, why can't powerpc use lwsync for smp_wmb? The only problem seems 
> to be that it allows loads to be reordered before stores, but that's
> OK with smp_wmb, right?

lwsync implies more ordering than eieio and so may take longer. lwsync
orders everything except store - load, and eieio just orders store - store.

On power3 an lwsync is a full sync which takes forever, although in
newer chips both lwsync and eieio tend to take the same number of
cycles.

> And why is smp_wmb() (ie. the non I/O barrier) doing eieio, while wmb() does
> not? And rmb() does lwsync, which apparently does not order IO at all...

Because people love to abuse the barrier macros :) grep for wmb in
drivers/net and look for the number of places wmb() is being used to
order memory and IO. Architecturally eieio is a store - store ordering
for IO and memory but not between the two. sync is slow but does
guarantee this. 

SGIs mmiowb() might be useful for some of these cases but every time its
brought up everyone ends up confused as to its real use.

Really we should have io_*mb() and smp_*mb(). At that stage we may even
be able to kill the base *mb() macros.

Anton
