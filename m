Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424062AbWKIPoe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424062AbWKIPoe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 10:44:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424068AbWKIPoe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 10:44:34 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:56999 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1424062AbWKIPod (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 10:44:33 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.19-rc5-mm1: HPC nx6325 breakage, VESA fb problem, md-raid problem
Date: Thu, 9 Nov 2006 16:42:00 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, fbuihuu@gmail.com, adaplas@pol.net,
       Andi Kleen <ak@suse.de>, NeilBrown <neilb@suse.de>
References: <20061108015452.a2bb40d2.akpm@osdl.org> <20061108165540.0d3c4340.akpm@osdl.org> <200611090204.45299.rjw@sisk.pl>
In-Reply-To: <200611090204.45299.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611091642.01453.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 9 November 2006 02:04, Rafael J. Wysocki wrote:
> On Thursday, 9 November 2006 01:55, Andrew Morton wrote:
> > On Thu, 9 Nov 2006 01:44:53 +0100
> > "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > 
> > > On Thursday, 9 November 2006 01:17, Andrew Morton wrote:
> > > > On Thu, 9 Nov 2006 00:31:34 +0100
> > > > "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > > > 
> > > > > On Wednesday, 8 November 2006 10:54, Andrew Morton wrote:
> > > > > > 
> > > > > > Temporarily at
> > > > > > 
> > > > > > http://userweb.kernel.org/~akpm/2.6.19-rc5-mm1/
> > > > > > 
> > > > > > will turn up at
> > > > > > 
> > > > > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc5/2.6.19-rc5-mm1/
> > > > > > 
> > > > > > when kernel.org mirroring catches up.
> > > > > > 
> > > > > > 
> > > > > > 
> > > > > > - Merged the Kernel-based Virtual Machine patches.  See kvm.sf.net for
> > > > > >   userspace tools, instructions, etc.
> > > > > > 
> > > > > >   It needs a recent binutils to build.
> > > > > > 
> > > > > > - The hrtimer+dynticks code still doesn't work right for machines which halt
> > > > > >   their TSC in low-power states.
> > > > > 
> > > > > On my HPC nx6325 it doesn't even reach the point in which the messages become
> > > > > visible on the console, so I'm unable to get any debug info from it.
> > > > 
> > > > Nice.  You're using earlyprintk?
> > > 
> > > earlyprintk=vga doesn't show anything (ie. blank screen), so it seems to crash
> > > really early.
> > 
> > OK, so it's definitely bisection time.
> 
> Well, I've got some data from earlyprintk (forgot I needed to boot with
> vga=normal).
> 
> Unfortunately, I had to rewrite the trace manually:
> 
> clear_IO_APIC_pin+0x15/0x6a
> try_apic_pin+0x7a/0x98
> setup_IO_APIC+0x600/0xb7a
> smp_prepare_cpus+0x33a/0x371
> init+0x60/0x32d
> child_rip+0xa/0x12
> 
> [And then the unwinder said it got stuck.]
> 
> RIP is reported to be at ioapic_read_entry+0x33/0x61,

This is 100% reproducible on the nx6325 (but not on the other boxes) and
apparently caused by x86_64-mm-try-multiple-timer-pins.patch (doesn't
happen with this patch reverted).
 
> > > but on the other SMP box the framebuffer is broken 
> > > (displays all fonts inverted, as in a mirror)
> > 
> > Which fbdev driver?  (suspect fbcon-rere-fix-little-endian-bogosity-in-slow_imageblit.patch)
> 
> vga=792

This indeed is caused by fbcon-rere-fix-little-endian-bogosity-in-slow_imageblit.patch
which affects two out of three boxes on which I tested it (both have Radeon cards).

> > > and the kernel says it cannot mount the root fs (which is on an md-raid).
> > 
> > hm, there was probably some earlier message which tells us why that
> > happened.  Doing a capure-and-compare on the dmesg output would be nice
> > (netconsole?)

This happens because of md-change-lifetime-rules-for-md-devices.patch and
seems to be a universal breakage.

So, in fact there are three different offending patches.


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
