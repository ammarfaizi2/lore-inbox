Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266271AbUBFC3I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 21:29:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266398AbUBFC3H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 21:29:07 -0500
Received: from h80ad253b.async.vt.edu ([128.173.37.59]:10880 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S266271AbUBFC3A (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 21:29:00 -0500
Message-Id: <200402060228.i162SwKo004935@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: linux-kernel@vger.kernel.org
Subject: 2.6.2-mm1, selinux, and initrd
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_235859181P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 05 Feb 2004 21:28:57 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_235859181P
Content-Type: text/plain; charset="us-ascii"
Content-Id: <4921.1076034530.1@turing-police.cc.vt.edu>

On my laptop, I use an initrd to get things started (mostly SElinux
and LVM).  (I've attached the 'linuxrc' below).

Under 2.6.2-rc3-mm1, I got the following while booting:

Feb  5 09:40:34 turing-police kernel: RAMDISK: Compressed image found at block 0
Feb  5 09:40:34 turing-police kernel: VFS: Mounted root (ext2 filesystem).
Feb  5 09:40:34 turing-police kernel: Mounted devfs on /dev
Feb  5 09:40:34 turing-police kernel: security:  3 users, 5 roles, 1039 types
Feb  5 09:40:34 turing-police kernel: security:  30 classes, 128126 rules
Feb  5 09:40:35 turing-police kernel: SELinux:  Completing initialization.
Feb  5 09:40:35 turing-police kernel: SELinux:  Setting up existing superblocks.
Feb  5 09:40:35 turing-police kernel: SELinux: initialized (dev , type selinuxfs), uses genfs_contexts
Feb  5 09:40:35 turing-police kernel: SELinux: initialized (dev ram0, type ext2), uses xattr

Booting 2.6.2-mm1, I get:

RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
Mounted devfs on /dev
VFS: Cannot open root device 

and things come to a screeching halt.  Absolutely nothing in the linuxrc
seems to happen - and since the real root is on an LVM, we come to a
screeching halt.

The system boots OK (minus selinux functionality of course)if I pass
'selinux=0' as a kernel parameter, so I'm suspecting these 3 patches:

+selinux-01-context-mount-support.patch
+selinux-02-nfs-context-mounts.patch
+selinux-03-context-mounts-selinux.patch

I'm suspecting that try_context_mount() is choking because we haven't
loaded the policy or anything, so we hit this:

       rc = try_context_mount(sb, data);
        if (rc)
                goto out;

and die a horrid death...

Oh, and the linuxrc:

#!/bin/nash

echo Loading policy
mount -t selinuxfs none /selinux
/bin/load_policy /etc/security/selinux/policy.15
umount /selinux

echo Mounting /proc filesystem
mount -t proc /proc /proc
echo Creating block devices
mkdevices /dev
echo Scanning logical volumes
lvm vgscan
echo Activating logical volumes
lvm vgchange -ay
echo 0x0100 > /proc/sys/kernel/real-root-dev
echo Mounting root filesystem
mount -o noatime,nodev --ro -t ext3 /dev/rootvg/root /sysroot
pivot_root /sysroot /sysroot/initrd
umount /initrd/proc




--==_Exmh_235859181P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAIvvpcC3lWbTT17ARAuBTAKDqtz3UhpDP6e2ztSlS8/woG1hviQCgwkT/
0uugB5rEL/awK+aALdD+L28=
=+AXj
-----END PGP SIGNATURE-----

--==_Exmh_235859181P--
