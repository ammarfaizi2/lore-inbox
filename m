Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267998AbUJOUTV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267998AbUJOUTV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 16:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268228AbUJOUTV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 16:19:21 -0400
Received: from rproxy.gmail.com ([64.233.170.197]:42399 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267998AbUJOUTR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 16:19:17 -0400
DomainKey-Signature: a=rsa-sha1; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=B/Uo7ObtuHUb5BAtV/0flnkC2Y8EdxTuZZMsHTsdxAYHsn3S9akeix18qN4B6goaAuXMTfwWhl3vM3aaKoi7EJYRRKmqmgUWEs3u9XCxoYZkhrPkOlvfDbqXDcZcIZr1VzJdOIpynA4tgHCdJuaGNgDUS+24ENMzuXCfySecRNE
Message-ID: <9e4733910410151319159482ce@mail.gmail.com>
Date: Fri, 15 Oct 2004 16:19:16 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Kendall Bennett <kendallb@scitechsoft.com>
Subject: Re: Generic VESA framebuffer driver and Video card BOOT?
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       fbdev <linux-fbdev-devel@lists.sourceforge.net>
In-Reply-To: <416FB275.6425.1C3D985@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <416E8322.25700.29ACC2F1@localhost>
	 <1097843969.9863.8.camel@localhost.localdomain>
	 <416FB275.6425.1C3D985@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Oct 2004 11:20:21 -0700, Kendall Bennett
<kendallb@scitechsoft.com> wrote:
> Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> 
> > On Iau, 2004-10-14 at 21:46, Kendall Bennett wrote:
> > > a way to spawn a user mode process that early in the boot sequence (it
> > > would have to come from the initrd image I expect) then the only option
> > > is to compile it into the kernel.
> >
> > There is exactly that in 2.6 - the hotplug interfaces allow the
> > kernel to fire off userspace programs. Jon Smirl (who you should
> > definitely talk to about this stuff) has been hammering out a
> > design for moving almost all the mode switching into user space for
> > kernel video.
> 
> That is awesome! I am all for moving this outside of the kernel, as it
> would allow the use of ream vm86() services for VGA/VESA BIOS access on
> x86 and the user of the emulator for non-x86 platforms.
> 
> The only catch would be making sure this stuff is available really early
> in the boot sequence. As it stands right now the solution we have brings
> up the video almost imediately after you see the 'uncompressing kernel
> image' message on the serial port. The other solution of course is to get
> this into the boot loader which is what the AmigaOne folks did for their
> machines (U-Boot brings up the video). We are working with those guys to
> update their BIOS emulator to the latest version as the one they have
> doesn't work that reliably.
> 
> Anyway how do I find out more about this in 2.6?
> 
> Also I assume the code would need to end up in the initrg image, correct?
> Can you point me at some resources to learn more about how to get custom
> code into the initrd image?

The plan for this in 2.6 is to first write a VGA device driver. This
driver is responsible for identifying all of the VGA devices in a
system and ensuring only one of them gets enabled a time. I started
writing this but I haven't finished. This driver would be compiled
into the kernel. I can send source if you are interested.

I have added hooks to the PCI subsystem to record the boot video
device. If the VGA driver finds VGA devices other than the boot one it
will generate hotplug events on them. Initramfs should contain a reset
program for using X86 mode to reset these cards. To do this you need
two things from the kernel: 1) a way to make sure only a single VGA
device is active (VGA driver, allow you to disable the current VGA
device, reset the card, restore the active VGA device) and 2) a way to
get the ROM image. There is a patch in -mm that makes the ROMs visible
in sysfs that should be in the kernel shortly.

So, when you first boot you have two choices, 1) use a display the
boot ROM setup, such as VGAcon or PROMcon. or 2) have no display.
People want this both ways. VGAcon/PROMcon will let you get output
very early in the boot process.

Next the VGA driver will initialize. This will trigger user space
resets using the program on initramfs. Now it is possible to use all
of your displays. To control this from something like resume, the
driver sets a lock that is cleared by the reset app and the end of
reset. This will keep other processes out of the driver until reset is
finished.

Right now I am working on a merged fbdev/DRM that supports multi-head
adapters. It's turning out to be much more work than I though because
neither DRM or fbdev handle multihead at the device driver level. You
can get snapshots of the code at mesa3d.bkbits.net but it doesn't work
right yet. This driver is designed to run after the VGAdriver has
reset the hardware.

-- 
Jon Smirl
jonsmirl@gmail.com
