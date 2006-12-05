Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031329AbWLEUkB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031329AbWLEUkB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 15:40:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968691AbWLEUkA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 15:40:00 -0500
Received: from liaag1ae.mx.compuserve.com ([149.174.40.31]:55889 "EHLO
	liaag1ae.mx.compuserve.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S968688AbWLEUkA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 15:40:00 -0500
Date: Tue, 5 Dec 2006 15:32:54 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: BUG? atleast >=2.6.19-rc5, x86 chroot on x86_64
To: David Howells <dhowells@redhat.com>
Cc: vojtech@suse.cz, ak@muc.de, linux-kernel <linux-kernel@vger.kernel.org>,
       Kasper Sandberg <lkml@metanurb.dk>, Andrew Morton <akpm@osdl.org>
Message-ID: <200612051536_MC3-1-D404-9990@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <4701.1165328393@redhat.com>

On Tue, 05 Dec 2006 14:19:53 +0000, David Howells wrote:
> > Here is a patch to reverse that.  Kasper, can you test it?
> > (Your filesystem is on a FAT/VFAT volume, I assume.)
> 
> Please don't revert that patch.  If you do, you'll break CONFIG_BLOCK=n.
> 
> Can you compile and run the attached program as both 32-bit and 64-bit?

I only have 32-bit userspace.  When I run your program against
a directory on a JFS filesystem (msdos ioctls not supported)
I get this on vanilla 2.6.19:

$ ./vfat_ioctl32.ex .
268 : 82187201, 82187202
268 : 82187201, 82187202
Calling VFAT_IOCTL_READDIR_BOTH32
ioctl: Invalid argument
Calling VFAT_IOCTL_READDIR_BOTH
ioctl: Invalid argument

After reverting the msdos compat ioctls patch it changes to:

$ ./vfat_ioctl32.ex .
268 : 82187201, 82187202
268 : 82187201, 82187202
Calling VFAT_IOCTL_READDIR_BOTH32
ioctl: Inappropriate ioctl for device
Calling VFAT_IOCTL_READDIR_BOTH
ioctl: Inappropriate ioctl for device

> | i have only tested with >=rc5, thw folling, as an example, appears in
> | dmesg:
> | ioctl32(regedit.exe:11801): Unknown cmd fd(9) cmd(82187201){02}
> | arg(00221000) on /home/redeeman
> | ioctl32(regedit.exe:11801): Unknown cmd fd(9) cmd(82187201){02}
> | arg(00221000) on /home/redeeman/.wine/drive_c/windows/system32
> | ioctl32(regedit.exe:11801): Unknown cmd fd(9) cmd(82187201){02}
> | arg(00221000) on /home/redeeman/.wine/drive_c/windows/system
> 
> How do you get that? 

I get those messages when the ioctl call returns 'invalid argument.'

In fs/compat.s::compat_sys_ioctl() you can see it changing the
return value after it prints the message:

                static int count;

                if (++count <= 50)
                        compat_ioctl_error(filp, fd, cmd, arg);
                error = -EINVAL;

So apparently this is a feature?

-- 
Chuck
"Even supernovas have their duller moments."

