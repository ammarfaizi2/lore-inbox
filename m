Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266001AbUGAQPa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266001AbUGAQPa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 12:15:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266003AbUGAQPa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 12:15:30 -0400
Received: from fw.osdl.org ([65.172.181.6]:43948 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266001AbUGAQPX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 12:15:23 -0400
Date: Thu, 1 Jul 2004 09:15:01 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Pavel Machek <pavel@suse.cz>, vojtech@suse.cz,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Andrew Morton <akpm@osdl.org>, Paul Jackson <pj@sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       PARISC list <parisc-linux@lists.parisc-linux.org>
Subject: Re: [parisc-linux] Re: [PATCH] Fix the cpumask rewrite
In-Reply-To: <1088690821.4621.11.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0407010908260.11212@ppc970.osdl.org>
References: <1088266111.1943.15.camel@mulgrave>  <Pine.LNX.4.58.0406260924570.14449@ppc970.osdl.org>
  <1088268405.1942.25.camel@mulgrave>  <Pine.LNX.4.58.0406260948070.14449@ppc970.osdl.org>
  <20040701131158.GP698@openzaurus.ucw.cz> <1088690821.4621.11.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 1 Jul 2004, Alan Cox wrote:
>
> On Iau, 2004-07-01 at 14:11, Pavel Machek wrote:
> > Heh, with vojtech we introduced locking into input layer
> > (there was none before)... using test_bit/set_bit.
> > 
> > (I just hope set_bit etc implies memory barrier... or we'll have to do
> > it once more)
> 		
> It doesn't - the ppp layer got burned badly by this long ago. set_bit is
> not a memory barrier. OTOH you can just add an mb()

The "test_and_xxx()" things are memory barriers, but set_bit/clear_bit 
aren't (since ther aren't really supposed to be usable for locking).

It _happens_ to be one on x86, so sadly it works on 99% of the machines 
out there. And to avoid the extra (suprefluous) mb(), there are

	smp_mb__before_clear_bit()
	smp_mb__after_clear_bit()

that only works with "clear_bit()", on the assumption that the way you'd 
do locking is:

	lock:
		while (test_and_set_bit(..)) /* This is a memory barrier */
			while (test_bit(..))
				cpu_relax();

	.. protected region ..

	unlock:
		smp_mb__before_clear_bit();
		clear_bit(..);

but the fact is, the above is broken too, for a totally _unrelated_ 
reason, namely preemption. And then you have the SMP case etc still.

The fact is, you shouldn't use the bitops for locking. You _will_ get it 
wrong. Use a spinlock, and if you _really_ really need just a single bit, 
use

	bit_spin_lock(bitnum,addr)
	..
	bit_spin_unlock(bitnum,addr)

which should get all of this right, and if we ever chaneg the consistency 
rules, we'll make sure the bitlocks still work.

So please..

		Linus
