Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266411AbTADHxI>; Sat, 4 Jan 2003 02:53:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266431AbTADHxI>; Sat, 4 Jan 2003 02:53:08 -0500
Received: from sullivan.realtime.net ([205.238.132.76]:34310 "EHLO
	sullivan.realtime.net") by vger.kernel.org with ESMTP
	id <S266411AbTADHxG>; Sat, 4 Jan 2003 02:53:06 -0500
Date: Sat, 4 Jan 2003 02:01:38 -0600 (CST)
Message-Id: <200301040801.h0481cf00212@sullivan.realtime.net>
To: linux-kernel@vger.kernel.org
Cc: Helge Hafting <helgehaf@aitel.hist.no>, Andrew Morton <akpm@digeo.com>
Subject: [PATCH] fix CONFIG_DEVFS=y root=<number>
From: Milton Miller <miltonm@bga.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Based on a patch by Adam J. Richter <adam@yggdrasil.com> [1], this fixes
the problem since 2.5.47 with mounting a devfs=y system with root=<number>

sys_get_dents64 returns -EINVAL if there is not space for an entry, so
we need to activate the loop code to expand the buffer.  

[1] http://marc.theaimsgroup.com/?l=linux-kernel&m=103762980207529&w=2
Tested with 2.5.53-um2


diff -Nru a/init/do_mounts.c b/init/do_mounts.c
--- a/init/do_mounts.c	Sat Jan  4 00:14:34 2003
+++ b/init/do_mounts.c	Sat Jan  4 00:14:34 2003
@@ -333,7 +333,7 @@
 	for (bytes = 0, p = buf; bytes < len; bytes += n, p+=n) {
 		n = sys_getdents64(fd, p, len - bytes);
 		if (n < 0)
-			return -1;
+			return n;
 		if (n == 0)
 			return bytes;
 	}
@@ -361,7 +361,7 @@
 			return p;
 		}
 		kfree(p);
-		if (n < 0)
+		if (n < 0 && n != -EINVAL)
 			break;
 	}
 	close(fd);
