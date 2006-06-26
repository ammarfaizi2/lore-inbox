Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965101AbWFZBFB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965101AbWFZBFB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 21:05:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965147AbWFZBEi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 21:04:38 -0400
Received: from terminus.zytor.com ([192.83.249.54]:24207 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S965047AbWFZA71
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 20:59:27 -0400
Date: Sun, 25 Jun 2006 17:58:09 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: linux-kernel@vger.kernel.org, klibc@zytor.com
Subject: [klibc 40/43] kinit: replacement for in-kernel do_mount, ipconfig, nfsroot
Message-Id: <klibc.200606251757.40@tazenda.hos.anvin.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[klibc] kinit: replacement for in-kernel do_mount, ipconfig, nfsroot

kinit provides the default root-mounting code.  It should be
compatible with the in-kernel root-mounting code (modulo bugs); it
also provides a few minor enhancements.

Signed-off-by: H. Peter Anvin <hpa@zytor.com>

---
commit f0b65bb7d198f7bde27107c762d4ff0bf43754b2
tree 4890fa3f418bc3b068ee6c4c0e8ddeedaf9e4416
parent 331e12895f91848ae0eff9acdbd5058b3c1056af
author H. Peter Anvin <hpa@zytor.com> Sun, 25 Jun 2006 16:58:59 -0700
committer H. Peter Anvin <hpa@zytor.com> Sun, 25 Jun 2006 16:58:59 -0700

 usr/kinit/Kbuild                    |   28 +
 usr/kinit/README                    |    9 
 usr/kinit/devname.c                 |  114 +++++
 usr/kinit/do_mounts.c               |  221 ++++++++++
 usr/kinit/do_mounts.h               |   48 ++
 usr/kinit/do_mounts_md.c            |  398 ++++++++++++++++++
 usr/kinit/do_mounts_mtd.c           |   44 ++
 usr/kinit/fstype/Kbuild             |   25 +
 usr/kinit/fstype/cramfs_fs.h        |   85 ++++
 usr/kinit/fstype/ext2_fs.h          |   79 ++++
 usr/kinit/fstype/ext3_fs.h          |   92 ++++
 usr/kinit/fstype/fstype.c           |  296 ++++++++++++++
 usr/kinit/fstype/fstype.h           |   23 +
 usr/kinit/fstype/jfs_superblock.h   |  114 +++++
 usr/kinit/fstype/luks_fs.h          |   44 ++
 usr/kinit/fstype/lvm2_sb.h          |   18 +
 usr/kinit/fstype/main.c             |   58 +++
 usr/kinit/fstype/minix_fs.h         |   85 ++++
 usr/kinit/fstype/reiserfs_fs.h      |   69 +++
 usr/kinit/fstype/romfs_fs.h         |   56 +++
 usr/kinit/fstype/swap_fs.h          |   18 +
 usr/kinit/fstype/xfs_sb.h           |   16 +
 usr/kinit/getarg.c                  |   57 +++
 usr/kinit/getintfile.c              |   30 +
 usr/kinit/initrd.c                  |  199 +++++++++
 usr/kinit/ipconfig/Kbuild           |   31 +
 usr/kinit/ipconfig/README           |  103 +++++
 usr/kinit/ipconfig/bootp_packet.h   |   34 ++
 usr/kinit/ipconfig/bootp_proto.c    |  213 ++++++++++
 usr/kinit/ipconfig/bootp_proto.h    |    8 
 usr/kinit/ipconfig/dhcp_proto.c     |  212 ++++++++++
 usr/kinit/ipconfig/dhcp_proto.h     |   18 +
 usr/kinit/ipconfig/ipconfig.h       |   35 ++
 usr/kinit/ipconfig/main.c           |  758 +++++++++++++++++++++++++++++++++++
 usr/kinit/ipconfig/netdev.c         |  251 ++++++++++++
 usr/kinit/ipconfig/netdev.h         |   83 ++++
 usr/kinit/ipconfig/packet.c         |  286 +++++++++++++
 usr/kinit/ipconfig/packet.h         |    9 
 usr/kinit/kinit.c                   |  330 +++++++++++++++
 usr/kinit/kinit.h                   |   73 +++
 usr/kinit/name_to_dev.c             |  202 +++++++++
 usr/kinit/nfsmount/Kbuild           |   27 +
 usr/kinit/nfsmount/README.locking   |   26 +
 usr/kinit/nfsmount/dummypmap.c      |  188 +++++++++
 usr/kinit/nfsmount/dummypmap.h      |   13 +
 usr/kinit/nfsmount/dummypmap_test.c |    2 
 usr/kinit/nfsmount/main.c           |  263 ++++++++++++
 usr/kinit/nfsmount/mount.c          |  357 ++++++++++++++++
 usr/kinit/nfsmount/nfsmount.h       |   39 ++
 usr/kinit/nfsmount/portmap.c        |   73 +++
 usr/kinit/nfsmount/sunrpc.c         |  253 ++++++++++++
 usr/kinit/nfsmount/sunrpc.h         |   99 +++++
 usr/kinit/nfsroot.c                 |  113 +++++
 usr/kinit/open.c                    |   18 +
 usr/kinit/ramdisk_load.c            |  271 +++++++++++++
 usr/kinit/readfile.c                |   86 ++++
 usr/kinit/resume.c                  |   75 +++
 usr/kinit/run-init/Kbuild           |   25 +
 usr/kinit/run-init/run-init.c       |   95 ++++
 usr/kinit/run-init/run-init.h       |   38 ++
 usr/kinit/run-init/runinitlib.c     |  216 ++++++++++
 usr/kinit/xpio.c                    |   51 ++
 usr/kinit/xpio.h                    |   11 +
 63 files changed, 7211 insertions(+), 0 deletions(-)

Patch suppressed due to size (185 K), available at:
http://www.kernel.org/pub/linux/kernel/people/hpa/klibc-patchset/40-kinit-replacement-for-in-kernel-do-mount-ipconfig-nfsroot.patch
