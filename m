Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265464AbUAGKQI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 05:16:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266159AbUAGKQI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 05:16:08 -0500
Received: from ns.suse.de ([195.135.220.2]:21982 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265464AbUAGKQB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 05:16:01 -0500
Date: Wed, 7 Jan 2004 11:15:59 +0100
From: Olaf Hering <olh@suse.de>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Rob Love <rml@ximian.com>, Nathan Conrad <lk@bungled.net>,
       Pascal Schmidt <der.eremit@email.de>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
Subject: Re: udev and devfs - The final word
Message-ID: <20040107101559.GA22770@suse.de>
References: <18Cz7-7Ep-7@gated-at.bofh.it> <E1AbWgJ-0000aT-00@neptune.local> <20031231192306.GG25389@kroah.com> <1072901961.11003.14.camel@fur> <20031231220107.GC11032@bungled.net> <1072909218.11003.24.camel@fur> <20031231225536.GP4176@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20031231225536.GP4176@parcelfarce.linux.theplanet.co.uk>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Wed, Dec 31, viro@parcelfarce.linux.theplanet.co.uk wrote:

> On Wed, Dec 31, 2003 at 05:20:18PM -0500, Rob Love wrote:
> > On Wed, 2003-12-31 at 17:01, Nathan Conrad wrote:

> > Uh, Unix systems (Linux included) do not use the filename of the device
> > node at all.  Those are just names for you, the user.
> > 
> > The kernel uses the device number to understand what device user-space
> > is trying to access.  The kernel associates the device with a device
> > number.  Normally that number is static, and known a priori, so we just
> > create a huge /dev directory with all possible devices and their
> > assigned numbers (you can see these numbers with ls -la).
> > 
> > But if the kernel _tells_ user-space what the device number is, for each
> > device as it is created, we do not need a static /dev directory.  We can
> > assemble the directory on the fly and device numbers really no longer
> > matter.  This is what udev does.
> 
> I think you've missed a point here.  There are several places where kernel
> deals with device identification.
> 	a) when normal pathname lookup results in a device node on filesystem.
> That's the regular way.
> 	b) when we create a new device node; device number is passed to
> ->mknod() and new device node is created.  Also a normal codepath.
> 	c) when late-boot code mounts the final root.  It used to be black
> magic, but these days it's done by regular syscalls.  Namely, we parse the
> "device name" (most of the work is done by lookups in sysfs), do mknod(2)
> and mount(2).  It's still done from the kernel mode, but it could be moved
> to userland.  Should be, actually.
> 	d) when kernel deals with resume/suspend stuff.  Currently - black
> magic.  Should be moved to early userland (same parser as for final root
> name + mknod on rootfs + open() to get the device in question).
> 	e) in several pathological syscalls we pass device number to
> identify a device.  ustat(2) and its ilk - bad API that can't die.
> 	f) /dev/raw passes device number to bind raw device to block device.
> Bad API; we probably ought to replace it with saner one at some point.
> 	g) RAID setup - mix of both pathologies; should be done in userland
> and interfaces are in bad need of cleanup.
> 	h) nfsd uses device number as a substitute for export ID if said
> ID is not given explicitly.  That, BTW, is a big problem for crackpipe
> dreams about random device numbers - export ID _must_ be stable across
> reboots.
> 	i) mtdblk parses "device name" on boot; should be take to early
> userland, same as RAID et.al.

This is about the /proc/self/mounts format:

Why does it contain stuff like "/dev/root" or "/dev/sda3" or
"/dev/myblockdevice"? Does anyone __really__ care about it? I doubt
that. What I have here (with 2.4) is:

olh@melon:~> cat /proc/mounts
rootfs / rootfs rw 0 0
/dev/root / ext3 rw 0 0
proc /proc proc rw 0 0
devpts /dev/pts devpts rw 0 0
/dev/vg_melon/abuild /abuild ext3 rw 0 0
/dev/vg_melon/data1 /data1 ext3 rw 0 0
/dev/vg_melon/data2 /data2 ext3 rw 0 0
shmfs /dev/shm shm rw 0 0
automount(pid937) /suse autofs rw 0 0
wotan:/real-home/jplack /suse/jplack nfs rw,nosuid,v3,rsize=8192,wsize=8192,hard,intr,tcp,nolock,addr=wotan 0 0
wotan:/real-home/olh /suse/olh nfs rw,nosuid,v3,rsize=8192,wsize=8192,hard,intr,tcp,nolock,addr=wotan 0 0

Now, thats just fine and it was always been that way.
What if I chroot into /foo, proc is mounted on /foo/proc,
and run fsck /dev/sda3 in that chroot? 
That silly app looks for /etc/mtab (oh my...) and start the work.
Fine. Now, /dev/root is in reality /dev/sda3. Bad for me.

the whole thing would work as expected of /proc/self/mounts would have
a sane format:
olh@melon:~> cat /proc/mounts
0:0 / rootfs rw 0 0
8:3 / ext3 rw 0 0
proc /proc proc rw 0 0
devpts /dev/pts devpts rw 0 0
58:0 /abuild ext3 rw 0 0
58:1 /data1 ext3 rw 0 0
58:2 /data2 ext3 rw 0 0
shmfs /dev/shm shm rw 0 0
automount(pid937) /suse autofs rw 0 0
wotan:/real-home/jplack /suse/jplack nfs rw,nosuid,v3,rsize=8192,wsize=8192,hard,intr,tcp,nolock,addr=wotan 0 0
wotan:/real-home/olh /suse/olh nfs rw,nosuid,v3,rsize=8192,wsize=8192,hard,intr,tcp,nolock,addr=wotan 0 0

Now fsck could look for /dev/sda3, realize that it is a block
device node and look for that in the kernel mount table.
If it is mounted, abort with a nice and meaningful error message.

So my question is: why was this strange format invented in the first place?
And: will 2.7 get a sane /proc/self/mounts format for block devices?

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
