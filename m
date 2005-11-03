Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030443AbVKCTOG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030443AbVKCTOG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 14:14:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030410AbVKCTOF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 14:14:05 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:62911
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1030443AbVKCTOE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 14:14:04 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: initramfs for /dev/console with udev?
Date: Thu, 3 Nov 2005 13:13:47 -0600
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
References: <20051102222030.GP23316@pengutronix.de> <200511031138.10414.rob@landley.net> <20051103185104.GY23316@pengutronix.de>
In-Reply-To: <20051103185104.GY23316@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511031313.47820.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 03 November 2005 12:51, Robert Schwebel wrote:
> > > Seems
> > > like I'll have to do some deeper investigation of klibc; last time I
> > > looked it didn't even compile for ARCH=um.
> >
> > Klibc didn't, or the kernel didn't?
>
> The kernel works pretty good with 2.6.14; I can now do 'make world' in
> PTXdist and get a rootfs for the ARM and do 'make world NATIVE=1' and
> 'make run NATIVE=1' and the same thing builds for x86 and starts in a
> console. klibc didn't compile for ARCH=um.

I repeat my question: what is it that didn't compile, klibc or the kernel?

ARCH=um is an argument given to the kernel, yet because of an argument given 
to the kernel build, klibc didn't compile?    I'm confused.  Were you 
attempting to compile klibc under User Mode Linux, and the klibc build 
failed?  Or do you mean the kernel is what didn't compile, when you attempted 
to link user mode linux kernel against klibc?

(Yes, I confuse easily sometimes...)

> > > Is there any other known possibility to get just these two device nodes
> > > in an automatic way?
> >
> > From initramfs, you could try:
> >
> > mount -t sysfs /sys /sys
> > CDEV=`cat /sys/class/tty/console`
> > mknod /dev/console c $(echo $CDEV | sed 's/:.*//') \
> >   $(echo $CDEV | sed 's/.*://')
> >
> > Bit of a chicken and egg problem if it refuses to run /init if it's not
> > already there, though.  We're heading towards fully dynamic devices, but
> > not quite there yet...
>
> All that means that I need some libc and tools linking against it (or
> static tools)...

Well, it means you have to work around the deficiency in glibc that "hello 
world" is 400k statically linked.  This is a problem with glibc.  That's why 
I use uClibc instead.  (Full featured, you can build X and everything under 
it, and hello world is 7k statically linked, most of which is the iostream 
stuff.  If you use write() instead, with -Os stripped and statically linked, 
it's 4.2k.)

> > > I'm trying to get rid of devfs, and udev works just
> > > fine. The only thing not solved yet is how to get the beast started
> > > without /dev/console and /dev/null. I don't want to create the nodes
> > > statically, because that's only possible with root permissions.
> >
> > You don't need root access to make an initramfs configuration text file.
> > :)
>
> That was the idea ;) But it seems that if I buy initramfs I'll have to
> buy doing the mknod and rootfs mounting stuff from early userspace as
> well...

I added switch_root to busybox, and I'm planning on adding a stripped down 
udev as well, since this is likely to be a common need.  (Udev itself is 
already pretty small, but it requires fairly extensive configuration to get 
it to do anything, and wants to maintain a database.)

That said, for Firmware Linux, I'm working on a system that has the root 
partition (squashfs) appended to the kernel image.  So the kernel command 
line will have an argument ala FIRMWARE=hda1:/path/to/firmware.img so it can 
find itself, and then chops out the "hda1" from the environment variable, 
finds that under /sys/block, does the appropriate mknod based on what that 
dev file says, and mounts the new root.  This is a very small shell script.  
(The rest finds the firmware image, does an losetup -o $offset, mounts the 
loop device, and does the switch_root.)

> > > Some background: I'm building root filesystems for embedded systems
> > > with PTXdist; the user is able to build the whole thing without root
> > > permissions; either with a cross compiler and mount it via NFS or build
> > > a JFFS2 image, or, with one switch, build and run it with an uml
> > > kernel.
> >
> > I did something like that, only from scratch:
> > http://www.landley.net/code/firmware
> >
> > I'll probably release version 0.8.10 later today.  (Still need to make an
> > installer for the bootable version before I can call it 0.9...)
>
> I'll have a look :)

This morning I had it pointed out to me that it doesn't build an x86-64 
version yet.  In my defense, I haven't got that hardware.  (I have qemu 
though.  It's on my todo list...)

> Thx,
>
> Robert

Rob
