Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266876AbSLJWm2>; Tue, 10 Dec 2002 17:42:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266918AbSLJWm1>; Tue, 10 Dec 2002 17:42:27 -0500
Received: from mg03.austin.ibm.com ([192.35.232.20]:35814 "EHLO
	mg03.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S266876AbSLJWm0>; Tue, 10 Dec 2002 17:42:26 -0500
Content-Type: text/plain; charset=US-ASCII
From: Kevin Corry <corryk@us.ibm.com>
Organization: IBM
To: Joe Thornber <joe@fib011235813.fsnet.co.uk>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] dm-ioctl.h  -  device-mapper ioctl packet fixes
Date: Tue, 10 Dec 2002 16:03:49 -0600
X-Mailer: KMail [version 1.2]
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, lvm-devel@sistina.com
MIME-Version: 1.0
Message-Id: <02121016034907.02220@boiler>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe, Linus,

This patch fixes some device-mapper ioctl packet definitions in dm-ioctl.h
in 2.5.51.

Notes:
- The "dev" fields in "struct dm_ioctl" and "struct dm_target_deps" should
  be fixed-size to avoid requiring translation code on architectures such as
  ppc64 and sparc64 with 32-bit user-space and 64-bit kernel-space.
- The "length" field in "struct dm_target_spec" should be should be 64-bit
  to allow single targets within a device to be greater than 2 TB.
- The "status" field in "struct dm_target_spec" should be moved to ensure
  proper field alignment on 64-bit architectures.
- The version of the ioctl interface changes from 1.0.6 to 2.0.0, because
  the new structure definitions are not backwards compatible with the previous
  definitions.

-- 
Kevin Corry
corryk@us.ibm.com
http://evms.sourceforge.net/


--- linux-2.5.51a/include/linux/dm-ioctl.h	Tue Dec 10 10:59:55 2002
+++ linux-2.5.51b/include/linux/dm-ioctl.h	Wed Nov 20 14:44:06 2002
@@ -50,7 +50,7 @@
 	uint32_t open_count;	/* out */
 	uint32_t flags;		/* in/out */
 
-	__kernel_dev_t dev;	/* in/out */
+	uint32_t dev;		/* in/out */
 
 	char name[DM_NAME_LEN];	/* device name */
 	char uuid[DM_UUID_LEN];	/* unique identifier for
@@ -62,9 +62,9 @@
  * dm_ioctl.
  */
 struct dm_target_spec {
-	int32_t status;		/* used when reading from kernel only */
 	uint64_t sector_start;
-	uint32_t length;
+	uint64_t length;
+	int32_t status;		/* used when reading from kernel only */
 
 	/*
 	 * Offset in bytes (from the start of this struct) to
@@ -87,7 +87,7 @@
 struct dm_target_deps {
 	uint32_t count;
 
-	__kernel_dev_t dev[0];	/* out */
+	uint32_t dev[0];	/* out */
 };
 
 /*
@@ -129,10 +129,10 @@
 #define DM_TARGET_STATUS _IOWR(DM_IOCTL, DM_TARGET_STATUS_CMD, struct dm_ioctl)
 #define DM_TARGET_WAIT   _IOWR(DM_IOCTL, DM_TARGET_WAIT_CMD, struct dm_ioctl)
 
-#define DM_VERSION_MAJOR	1
+#define DM_VERSION_MAJOR	2
 #define DM_VERSION_MINOR	0
-#define DM_VERSION_PATCHLEVEL	6
-#define DM_VERSION_EXTRA	"-ioctl (2002-10-15)"
+#define DM_VERSION_PATCHLEVEL	0
+#define DM_VERSION_EXTRA	"-ioctl (2002-12-10)"
 
 /* Status bits */
 #define DM_READONLY_FLAG	0x00000001
