Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264138AbTFDVX4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 17:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264157AbTFDVXz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 17:23:55 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:60687 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S264138AbTFDVWB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 17:22:01 -0400
Date: Wed, 4 Jun 2003 23:39:50 +0200
To: Joe Burks <jburks@wavicle.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why am I getting Kernel Panic VFS cannot mount root fs on 301?
Message-ID: <20030604213950.GC2436@hh.idb.hist.no>
References: <200306041412.27897.jburks@wavicle.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200306041412.27897.jburks@wavicle.org>
User-Agent: Mutt/1.5.4i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 04, 2003 at 02:14:39PM -0700, Joe Burks wrote:
> Unfortunately I cannot copy the exact text I'm getting, but it is something 
> similar to that.  Now that I have time again, I desperately need to maintain 
> drivers/usb/media/vicam.c again and am trying to boot 2.5.70 to do so.  
> Here's what I've tried:
> 
> Freshly installed debian woody
> Freshly downloaded 2.5.70
> Downloaded, compiled and installed init-module-utils 0.9.12 from Rusty's site.
> Downloaded, compiled and installed latest devfsd (although it currently does 
> not seem to get to a point where this would matter, it never mounts the root 
> fs in order to start devfsd)
> Carefully followed instructions in Documentation/filesystems/devfs/README on 
> setting up devfs for the impatient.
> Configured kernel, including enabling devfs and devfs_mount.
> make bzImage modules modules_install install (not in one line, one at  a time)
> went into lilo.conf and added an append="root=<device>" line, then re-ran 
> lilo.  (where I say <device> I have tried about 100 different possibilities 
> ranging from easy ones like /dev/hda1 or /dev/discs/disc0/part1 to 
> /dev/ide/...)  Obviously I only get the "301" error when the root= line is 
> missing and I let lilo write that magic value.
> 
/dev/hda1 probably won't work, as "hda1" don't exist in devfs until
devfsd starts.  The "/dev/ide/.../part1" should work though,
if devfs is configured to mount automatically.

Try to rule out modules problems, make a kernel where
everything is compiled in.  If you aren't using a initrd
then at least devfs, the fs used on your root, and the drivers
for your ide controller _must_ be compiled in because
modules cannot be loaded until _after_ the root
fs is mounted.

I can't help you if you're using an initrd, I don't know
those.  2.5.70-mm4 and those earlier kernels that don't
die from RAID problems boot fine for me, with root
on a RAID-1 consisting of two IDE or SCSI disks.

> No matter what root= line I supplied it just wouldn't boot.  I've also tried 
> devfs=mount, devfs=nomount all to no solution.  So in frustration I rebuilt 
> the kernel without devfs, since I figured that is where my problem was, but 
> the exact error is still occurring.  I tried both leaving in a root= and 
> removing the root= append line with devfs not installed.
> 
> I can still boot fine with whichever kernel woody installed (2.4.16 I think).
> 
> I don't think this is a devfs problem.  I think there is some subtle (or maybe 
> blatantly obvious) kernel option I have not checked which would cause the 
> whole situation to go away.

My guess is that the driver for the "301" device (IDE) is
modular somehow, and this module isn't loaded from some
initrd when you try to mount root.

Debian don't _need_ an initrd if you compile the fs and drivers
into the kernel image as I explained above.  If you use one, you
need to set it up right.  The initrd must contain necessary modules
for the kernel you are trying to boot, in this case 2.5.70.
Also, 2.5.70 needs different modutils than 2.4.16, so debian's
supplied initrd will perhaps not work with 2.5.70.

If setting up an initrd is hard for you, consider dropping
it and go for the non-modular solution.
Stuff not needed for the boot (i.e. usb scanners and such)
may still be modular if you want them to, as modules & devfsd
works after the root is mounted. (And if they fail
you'll be able to work around or fix it at that time.)

Helge Hafting

