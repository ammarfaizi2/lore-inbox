Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311454AbSCXA6U>; Sat, 23 Mar 2002 19:58:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311452AbSCXA6K>; Sat, 23 Mar 2002 19:58:10 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:3315 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S311447AbSCXA6F>;
	Sat, 23 Mar 2002 19:58:05 -0500
Date: Sat, 23 Mar 2002 19:58:03 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Henrik Storner <henrik@hswn.dk>, linux-kernel@vger.kernel.org
Subject: [PATCH] Re: [2.5.7] initrd issue
In-Reply-To: <20020322101138.A7163@hswn.dk>
Message-ID: <Pine.GSO.4.21.0203231953560.6560-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 22 Mar 2002, Henrik Storner wrote:

> I've since changed my setup so I do not need the initrd to boot
> (moved my root-fs from an LVM volume to a separate partition),
> but if you need testing let me know.

Grrr...  The problem appeared back in 2.5.2-pre6 when kdev_t type had been
changed.  Offending line is
-               if (initrd_load() && ROOT_DEV != MKDEV(RAMDISK_MAJOR, 0)) {
+               if (initrd_load() && kdev_same(ROOT_DEV, mk_kdev(RAMDISK_MAJOR, 

and obvious fix is

diff -urN C7-0/init/do_mounts.c C7-current/init/do_mounts.c
--- C7-0/init/do_mounts.c	Fri Mar  8 02:09:56 2002
+++ C7-current/init/do_mounts.c	Sat Mar 23 19:53:27 2002
@@ -826,7 +826,7 @@
 
 	create_dev("/dev/root", ROOT_DEV, NULL);
 	if (mount_initrd) {
-		if (initrd_load() && kdev_same(ROOT_DEV, mk_kdev(RAMDISK_MAJOR, 0))) {
+		if (initrd_load() && !kdev_same(ROOT_DEV, mk_kdev(RAMDISK_MAJOR, 0))) {
 			handle_initrd();
 			goto out;
 		}

