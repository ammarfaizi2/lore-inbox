Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263272AbREWVtM>; Wed, 23 May 2001 17:49:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263278AbREWVtC>; Wed, 23 May 2001 17:49:02 -0400
Received: from voyager.powersurfr.com ([24.109.67.8]:50955 "EHLO
	unity.starfire") by vger.kernel.org with ESMTP id <S263272AbREWVsq>;
	Wed, 23 May 2001 17:48:46 -0400
From: Maciek Nowacki <maciek@Voyager.powersurfr.com>
Date: Wed, 23 May 2001 15:48:44 -0600
To: linux-kernel@vger.kernel.org
Subject: Busy on BLKFLSBUF w/initrd
Message-ID: <20010523154843.A32583@Voyager.powersurfr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have continuing problems with getting the initrd ramdisk out of memory once
bootup is complete.

This is with recent -ac kernels which have the fix-up posted a few months ago
applied.

The sequence is roughly:

- boot via pxelinux, loads up bzImage <1MB and root.romfs.gz ~7MB, expands to
  about 30.
- mount -n -t tmpfs none tmp
- cp root -> /tmp
- pivot_root -> /tmp
- umount old_root/dev (devfs kernel)
- umount old_root

Then another pivot_root a bit later on before /sbin/init is invoked. The
point is to move the initrd to a tmpfs which will reclaim memory in the event
that the filesystem cannot be unmounted, due to having mountpoints for
loopback host filesystems in this case.

It seems to work fine, and the initrd _does_ unmount with no problems
(unmounting old_root/dev does complain about mtab, but works, ls old_root/dev
shows empty). However, blockdev --flushbufs /dev/rd/0 fails with busy on
BLKFLSBUF once the system is running.

About the only odd thing besides the message about mtab from umount is the
kernel notice right before entering /bin/sh on the romfs initrd - it prints
out two messages about mounting the ramdisk:

May 22 09:14:30 wintermute kernel: Linux version 2.4.4-ac12 (maciek@wintermute) (gcc version 2.95.4 20010506 (Debian prerelease)) #1 Mon May 21 20:08:36 MDT 2001
[...]
May 22 09:14:31 wintermute kernel: RAMDISK: romfs filesystem found at block 0
May 22 09:14:31 wintermute kernel: RAMDISK: Loading 28216 blocks [1 disk] into ram disk... done.
May 22 09:14:31 wintermute kernel: Freeing initrd memory: 28216k freed
May 22 09:14:31 wintermute kernel: VFS: Mounted root (romfs filesystem) readonly.
May 22 09:14:31 wintermute kernel: Mounted devfs on /dev
May 22 09:14:31 wintermute kernel: VFS: Mounted root (romfs filesystem) readonly.
May 22 09:14:31 wintermute kernel: change_root: old root has d_count=7
May 22 09:14:31 wintermute kernel: Mounted devfs on /dev
May 22 09:14:31 wintermute kernel: Trying to unmount old root ... okay

Perhaps they're bumping up the reference count so that it is impossible to
free the ramdisk later?

Thanks very much for any help!

Maciek
