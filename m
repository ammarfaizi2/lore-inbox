Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262662AbSKROUi>; Mon, 18 Nov 2002 09:20:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262712AbSKROUi>; Mon, 18 Nov 2002 09:20:38 -0500
Received: from h-64-105-34-70.SNVACAID.covad.net ([64.105.34.70]:55237 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S262662AbSKROUh>; Mon, 18 Nov 2002 09:20:37 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Mon, 18 Nov 2002 06:27:27 -0800
Message-Id: <200211181427.GAA01519@baldur.yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: Patch(2.5.48)?: initial ramdisk broken
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	linux-2.5.48 adds some kind of pseudo-filesytem in
init/do_mounts.c.  The expanded code cannot find the initial ramdisk
if you use devfs, due to a problem either with its interpretation of
results from sys_getdents64, or the corresponding implementation in
devfs.  do_read_dir attempts to fill a 512 byte buffer.  getdents
returns 400+ bytes the first time.  Then do_read_dir calls getdents
again, asking it to read the remaining bytes, which I guess is not
enough space to hold an additional entry, to which getdents return
-EINVAL.  I'm not sure who is wrong: getdents or the new do_mounts.c
code that interprets its return values.

	Here is a possible patch, on the assumption that getdents is
right and the new code in do_mounts.c is wrong.  I am not sure of its
correctness, although it works.

	By the way, I'd be interested in knowing the benefits of the
new code in init/do_mounts.c.  A compressed romfs initial ramdisk
has worked fine for me up to this point.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

--- linux-2.5.48/init/do_mounts.c	2002-11-17 20:29:31.000000000 -0800
+++ linux/init/do_mounts.c	2002-11-18 04:21:27.000000000 -0800
@@ -355,17 +355,17 @@
 			break;
 		n = do_read_dir(fd, p, size);
 		if (n > 0) {
 			close(fd);
 			*len = n;
 			return p;
 		}
 		kfree(p);
-		if (n < 0)
+		if (n < 0 && n != -EINVAL)
 			break;
 	}
 	close(fd);
 	return NULL;
 }
 #endif
 
 struct linux_dirent64 {
