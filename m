Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261264AbVADLzp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261264AbVADLzp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 06:55:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261365AbVADLzo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 06:55:44 -0500
Received: from mailhost.ntl.com ([212.250.162.8]:65300 "EHLO
	mta13-winn.mailhost.ntl.com") by vger.kernel.org with ESMTP
	id S261264AbVADLzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 06:55:10 -0500
Message-ID: <41DA8DFC.4030801@gentoo.org>
Date: Tue, 04 Jan 2005 12:37:16 +0000
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, opengeometry@yahoo.ca
Subject: [PATCH] Wait and retry mounting root device
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------040109050306020908020808"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040109050306020908020808
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This is based a patch by William Park <opengeometry@yahoo.ca> included in
2.6.10-mm1, in order to fix booting from usb-storage devices which no longer
make their partitions immediately available.

While William's patch fixed the situation where you boot from a "root=8:1"
parameter (to correspond to /dev/sda1), it does not allow you to use
"root=/dev/sda1" (which apparently worked in 2.6.9 and earlier), because
the name-->dev_t discovery is done before the "retry" loop starts, and is
not retried during the loop.

This patch, which replaces William's, solves the above problems.

Signed-off-by: Daniel Drake <dsd@gentoo.org>


--------------040109050306020908020808
Content-Type: text/x-patch;
 name="boot-delay-retry.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="boot-delay-retry.patch"


--- linux-2.6.10/init/do_mounts.c.orig	2005-01-04 12:01:37.933995432 +0000
+++ linux-2.6.10/init/do_mounts.c	2005-01-04 12:01:03.511228488 +0000
@@ -6,6 +6,7 @@
 #include <linux/suspend.h>
 #include <linux/root_dev.h>
 #include <linux/security.h>
+#include <linux/delay.h>
 
 #include <linux/nfs_fs.h>
 #include <linux/nfs_fs_sb.h>
@@ -136,10 +137,12 @@
 
 dev_t __init name_to_dev_t(char *name)
 {
-	char s[32];
+	char fullname[32], devname[32], absname[32];
 	char *p;
 	dev_t res = 0;
-	int part;
+	int part = 0;
+	int tryabs = 0;
+	int tryagain = 20;
 
 #ifdef CONFIG_SYSFS
 	int mkdir_err = sys_mkdir("/sys", 0700);
@@ -171,28 +174,54 @@
 
 	if (strlen(name) > 31)
 		goto fail;
-	strcpy(s, name);
-	for (p = s; *p; p++)
+
+	strcpy(absname, name);
+	for (p = absname; *p; p++)
 		if (*p == '/')
 			*p = '!';
-	res = try_name(s, 0);
+
+	strcpy(fullname, absname);
+
+	while (p > absname && isdigit(p[-1]))
+		p--;
+
+	if (p > absname && *p && *p != '0') {
+		part = simple_strtoul(p, NULL, 10);
+		*p = '\0';		
+	}
+
+	strcpy(devname, absname);
+
+	if (p >= absname + 2 && isdigit(p[-2]) && p[-1] == 'p') {
+		p[-1] = '\0';
+		tryabs = 1;
+	}
+
+retry:
+	res = try_name(fullname, 0);
 	if (res)
 		goto done;
 
-	while (p > s && isdigit(p[-1]))
-		p--;
-	if (p == s || !*p || *p == '0')
-		goto fail;
-	part = simple_strtoul(p, NULL, 10);
-	*p = '\0';
-	res = try_name(s, part);
+	if (!part)
+		goto next;
+	
+	res = try_name(devname, part);
 	if (res)
 		goto done;
 
-	if (p < s + 2 || !isdigit(p[-2]) || p[-1] != 'p')
-		goto fail;
-	p[-1] = '\0';
-	res = try_name(s, part);
+	if (!tryabs)
+		goto next;
+
+	res = try_name(absname, part);
+	if (res)
+		goto done;
+
+next:
+	if (--tryagain) {
+		printk(KERN_WARNING "VFS: Root device '%s' not available, waiting %dsec\n", name, tryagain);
+		ssleep(1);
+		goto retry;
+	}
 done:
 #ifdef CONFIG_SYSFS
 	sys_umount("/sys", 0);

--------------040109050306020908020808--
