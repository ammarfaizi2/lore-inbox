Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758429AbWLFALh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758429AbWLFALh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 19:11:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758430AbWLFALh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 19:11:37 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:47090 "EHLO
	pfepc.post.tele.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757769AbWLFALg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 19:11:36 -0500
Subject: Re: BUG? atleast >=2.6.19-rc5, x86 chroot on x86_64
From: Kasper Sandberg <lkml@metanurb.dk>
To: David Howells <dhowells@redhat.com>
Cc: Chuck Ebbert <76306.1226@compuserve.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, ak@muc.de, vojtech@suse.cz
In-Reply-To: <4701.1165328393@redhat.com>
References: <200612050436_MC3-1-D3F9-FB3D@compuserve.com>
	 <4701.1165328393@redhat.com>
Content-Type: text/plain
Date: Wed, 06 Dec 2006 01:11:29 +0100
Message-Id: <1165363889.15706.4.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-12-05 at 14:19 +0000, David Howells wrote:
> Chuck Ebbert <76306.1226@compuserve.com> wrote:
> 
> > Here is a patch to reverse that.  Kasper, can you test it?
> > (Your filesystem is on a FAT/VFAT volume, I assume.)

I do have a fat32 filesystem mounted using the vfat driver (the msdos
one arent compiled in), however the chroot in no way has access to this,
and i dont see how ANY 32bit apps can have attempted to access it, ill
go so far as say im certain they havent.

> 
> Please don't revert that patch.  If you do, you'll break CONFIG_BLOCK=n.
okay, i will not.

> 
> Can you compile and run the attached program as both 32-bit and 64-bit?
Yes, i will conduct tests, however it will have to wait till atleast
tomorow (cant garantuee anything though, i have lots of work to do).
> 
> On my x86_64 test box, I did:
> 
> 	[root@andromeda ~]# mkfs.vfat /dev/sda5
> 	[root@andromeda ~]# mount /dev/sda5 /mnt
> 	[root@andromeda ~]# mkdir /mnt/a
> 	[root@andromeda ~]# /tmp/ioctl /mnt/a		# 32-bit
> 	268 : 82187201, 82187202
> 	268 : 82187201, 82187202
> 	Calling VFAT_IOCTL_READDIR_BOTH32
> 	Calling VFAT_IOCTL_READDIR_BOTH
> 	[root@andromeda ~]# /tmp/ioctl /mnt/a		# 64-bit
> 	280 : 82307201, 82307202
> 	268 : 82187201, 82187202
> 	Calling VFAT_IOCTL_READDIR_BOTH32
> 	ioctl: Inappropriate ioctl for device
> 	Calling VFAT_IOCTL_READDIR_BOTH
> 
> Which is what I'd expect (the 64-bit ioctl does not support the 32-bit
> function).  Tracing the 64-bit version shows that the right numbers are being
> given to the syscall, though strace decodes them as the same symbol if not in
> raw mode:
> 
> 	[root@andromeda ~]# strace -eioctl -eraw=ioctl /tmp/ioctl /mnt/a
> 	280 : 82307201, 82307202
> 	268 : 82187201, 82187202
> 	Calling VFAT_IOCTL_READDIR_BOTH32
> 	ioctl(0x3, 0x82187201, 0x7fff9cec36c0)  = -1 (errno 25)
> 	ioctl: Inappropriate ioctl for device
> 	Calling VFAT_IOCTL_READDIR_BOTH
> 	ioctl(0x3, 0x82307201, 0x7fff9cec3490)  = 0x1
> 	Process 3410 detached
> 
> Applying the attached patch to the kernel produces the following elements in
> the log for the 32-bit compilation:
> 
> 	==> fat_compat_dir_ioctl(82187201,ffa803b8)
> 	==> fat_dir_ioctl(82307201,ffff810036a97ca8)
> 	<== fat_dir_ioctl() = 1
> 	<== fat_compat_dir_ioctl() = 1
> 	==> fat_compat_dir_ioctl(82187201,ffa801a0)
> 	==> fat_dir_ioctl(82307201,ffff810036a97ca8)
> 	<== fat_dir_ioctl() = 1
> 	<== fat_compat_dir_ioctl() = 1
> 
> and this for the 64-bit compilation:
> 
> 	==> fat_dir_ioctl(82187201,7fff031f69f0)
> 	call fat_generic_ioctl()
> 	<== fat_dir_ioctl() = -25
> 	==> fat_dir_ioctl(82307201,7fff031f67c0)
> 	<== fat_dir_ioctl() = 1
> 
> Which is entirely what I'd expect.
> 
> However, it's possible that the 64-bit kernel interface used to allow the
> 32-bit calls.  If that's the case could you be running a 64-bit program
> somewhere in your 32-bit chroot?
I am basically positive that i am not running 64bit stuff within my
32bit chroot, however i will check to make absolutely sure.
> 
> | i have only tested with >=rc5, thw folling, as an example, appears in
> | dmesg:
> | ioctl32(regedit.exe:11801): Unknown cmd fd(9) cmd(82187201){02}
> | arg(00221000) on /home/redeeman
> | ioctl32(regedit.exe:11801): Unknown cmd fd(9) cmd(82187201){02}
> | arg(00221000) on /home/redeeman/.wine/drive_c/windows/system32
> | ioctl32(regedit.exe:11801): Unknown cmd fd(9) cmd(82187201){02}
> | arg(00221000) on /home/redeeman/.wine/drive_c/windows/system
> 
> How do you get that?  I don't see anything like that.  I've tried:
all i did was run wine's regedit inside my 32bit chroot.
> 
> 	echo 1 >/proc/sys/kernel/compat-log
> 
> But that doesn't seem to do anything.
> 
> David
> 

