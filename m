Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161825AbWKVCgo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161825AbWKVCgo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 21:36:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161827AbWKVCgo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 21:36:44 -0500
Received: from smtp.osdl.org ([65.172.181.25]:4275 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161825AbWKVCgn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 21:36:43 -0500
Date: Tue, 21 Nov 2006 18:36:39 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Simple script that locks up my box with recent kernels
In-Reply-To: <9a8748490611211646o2c92564dmfe8d6ffdf66228ba@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0611211827590.3338@woody.osdl.org>
References: <9a8748490610061636r555f1be4x3c53813ceadc9fb2@mail.gmail.com> 
 <Pine.LNX.4.64.0610062000281.3952@g5.osdl.org> 
 <9a8748490610071402m4450365kedff5615d008fcd5@mail.gmail.com> 
 <Pine.LNX.4.64.0610071408220.3952@g5.osdl.org> 
 <9a8748490610081633k7bf011d1q131b2f9e06f2808d@mail.gmail.com> 
 <9a8748490610161545i309c416aja4f39edef8ea04e2@mail.gmail.com> 
 <Pine.LNX.4.64.0610161554140.3962@g5.osdl.org> 
 <9a8748490610161613y7c314e64rfdfafb4046a33a02@mail.gmail.com> 
 <9a8748490610231330y65f3e243pe1101d11a28dbbfa@mail.gmail.com>
 <9a8748490611211646o2c92564dmfe8d6ffdf66228ba@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 22 Nov 2006, Jesper Juhl wrote:
> 
> So it *seems* to be somehow related to running low on RAM and swap
> starting to be used.

Does it happen if you just do some simple "use all memory" script, eg run 
a few copies of

	#define SIZE (100<<20)

	char *buf = malloc(SIZE);
	memset(buf, SIZE, 0);
	sleep(100);

on your box?

> The box has 2GB of RAM and 768MB swap.

I wonder.. It _used_ to be true that we were pretty good at making swap be 
"extra" memory. But maybe we've lost some of that, and we have trouble 
with having more physical memory. We could end up in a situation where we 
allocate it all very quickly (because we don't actually page it out, we 
just allocate backing store for the pages), and we screw something up.

But stupid bugs there should still leave us trivially able to do the SysRQ 
things, so.. 

Is it highmem-related? Some bounce-buffering problem while having to swap? 
What block device driver do you use for the swap device?

I don't think we use any irq-disable locking in the VM itself, but I could 
imagine some nasty situation with the block device layer getting into a 
deadlock with interrupts disabled when it runs out of queue entries and 
cannot allocate more memory..

		Linus
