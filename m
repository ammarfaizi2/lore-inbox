Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263312AbVCDXwh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263312AbVCDXwh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 18:52:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263277AbVCDXsq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 18:48:46 -0500
Received: from 206.175.9.210.velocitynet.com.au ([210.9.175.206]:9153 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S263107AbVCDW3b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 17:29:31 -0500
Subject: Re: swsusp: allow resume from initramfs
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Pavel Machek <pavel@suse.cz>
Cc: Andrew Morton <akpm@osdl.org>, mjg59@scrf.ucam.org, hare@suse.de,
       "Barry K. Nathan" <barryn@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050304220709.GE2385@elf.ucw.cz>
References: <20050304101631.GA1824@elf.ucw.cz>
	 <20050304030410.3bc5d4dc.akpm@osdl.org>
	 <20050304175038.GE9796@ip68-4-98-123.oc.oc.cox.net>
	 <1109971327.3772.280.camel@desktop.cunningham.myip.net.au>
	 <20050304214329.GD2385@elf.ucw.cz>
	 <1109973035.3772.291.camel@desktop.cunningham.myip.net.au>
	 <20050304220709.GE2385@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1109975474.3772.305.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Sat, 05 Mar 2005 09:31:14 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Sat, 2005-03-05 at 09:07, Pavel Machek wrote:
> Hi!
> 
> > > > You guys are reinventing the wheel a lot at the moment and I'm in the
> > > > middle of doing it for x86_64 lowlevel code :> Can we see if we can work
> > > > a little more closely - perhaps we can get some shared code going that
> > > > will allow us to handle these issues without stepping on each others'
> > > > feet? In particular, shared code for
> > > > 
> > > > - initramfs and initrd support
> > > 
> > > Its actually done, and it was few strategically placed lines of code
> > > (like 20 lines). I do not think it can be meaningfully shared.
> > 
> > Mmm. But if we're both putting hooks in the same places...
> 
> There are very little hooks... But we may want to make sure we have
> same userland interface. swsusp uses "echo 3:5 > /sys/power/resume" to
> trigger resume from device major 3 minor 5.
> 
> > > > - lowlevel suspend & resume
> > > 
> > > This makes very good sense to share. We have i386, x86-64 and ppc
> > > versions. They simply walk list of pbe's; that should be simple enough
> > > to be usable for suspend2, too....
> > 
> > The CPU save and restore, yes. But I use a different format for
> > recording the image metadata (I use bitmaps to record the locations of
> > pages). Perhaps I should hasten to mention the bitmaps are discontiguous
> > - single pages connected by a kmalloc'd list. The copyback itself will
> > need to stay distinct.
> 
> Hmm, bitmaps? Okay, then low-level code needs to stay separate. (And
> thats bad, I wanted that one to be shared most).

Mmm. As you might remember, I used extents from 1.0 to save space. The
feedback from the last submission to LKML about getting rid of the
page_alloc.c hooks made me re-examine the use of the memory pool, which
made me re-examine the format in which the data was stored. Switching to
bitmaps meant that after saving the LRU pages, I can recalculate what
remains to be saved without ever changing the result in the process.
(Using extents, there was a small chance that the recalculated metadata
would require an extra extent on an extra page, which means you have to
recalculate everything again :<. With discontiguous bitmaps, I get
efficient storage, no need for > order zero allocations and no feedback
whatsoever when recalculating image metadata. Besides removing the
memory pool code, I've already removed some more, and am about to
simplify the code for the remaining extents (for storage metadata). I
hope to also be able to further simplify the image preparation code too.

All that to say "Bitmaps were a definite win!". Perhaps I can sell you
on the advantages of using them :>

By the way, did you see the effect of the memory eating patch? I didn't
think about it until someone emailed me, but the improvement was 50x
speed in the best case!

Nigel
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com
Bus: +61 (2) 6291 9554; Hme: +61 (2) 6292 8028;  Mob: +61 (417) 100 574

Maintainer of Suspend2 Kernel Patches http://softwaresuspend.berlios.de


