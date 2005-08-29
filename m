Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751205AbVH2PmT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205AbVH2PmT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 11:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751072AbVH2PmS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 11:42:18 -0400
Received: from mx1.redhat.com ([66.187.233.31]:19129 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751070AbVH2PmS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 11:42:18 -0400
Subject: util-linux: losetup -a
From: Karel Zak <kzak@redhat.com>
To: List linux-kernel <linux-kernel@vger.kernel.org>
Cc: Adrian Bunk <bunk@stusta.de>
Content-Type: text/plain
Date: Mon, 29 Aug 2005 17:44:56 +0200
Message-Id: <1125330296.3391.34.camel@petra>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Hi,

attached losetup patch adds "-a" option that lists all used loop devices. 

 # losetup -a
 /dev/loop0: [0305]:455455 (/boot/initrd-2.6.12-1.1385_FC4.root.img)
 /dev/loop1: [0305]:454285 (/boot/initrd-2.6.5-prep.img)
 /dev/loop5: [0305]:454282 (/boot/initrd-2.6.9-prep.img)


	Karel


--- util-linux-2.13-pre2/mount/lomount.c.all	2005-08-29 16:59:06.000000000 +0200
+++ util-linux-2.13-pre2/mount/lomount.c	2005-08-29 17:17:49.000000000 +0200
@@ -28,6 +28,8 @@
 extern char *xstrdup (const char *s);	/* not: #include "sundries.h" */
 extern void error (const char *fmt, ...);	/* idem */
 
+#define SIZE(a) (sizeof(a)/sizeof(a[0]))
+
 #ifdef LOOP_SET_FD
 
 static int
@@ -128,6 +130,42 @@
 	close (fd);
 	return 1;
 }
+
+static int
+show_used_loop_devices (void) {
+	char dev[20];
+	char *loop_formats[] = { "/dev/loop%d", "/dev/loop/%d" };
+	int i, j, fd, permission = 0, somedev = 0;
+	struct stat statbuf;
+	struct loop_info loopinfo;
+
+	for (j = 0; j < SIZE(loop_formats); j++) {
+	    for(i = 0; i < 256; i++) {
+		sprintf(dev, loop_formats[j], i);
+		if (stat (dev, &statbuf) == 0 && S_ISBLK(statbuf.st_mode)) {
+			somedev++;
+			fd = open (dev, O_RDONLY);
+			if (fd >= 0) {
+				if(ioctl (fd, LOOP_GET_STATUS, &loopinfo) == 0)
+					show_loop(dev);
+				close (fd);
+				somedev++;
+			} else if (errno == EACCES)
+				permission++;
+			continue; /* continue trying as long as devices exist */
+		}
+		break;
+	    }
+	}
+
+	if (somedev==0 && permission) {
+		error(_("%s: no permission to look at /dev/loop#"), progname);
+		return 1;
+	}
+	return 0;
+}
+
+
 #endif
 
 int
@@ -139,8 +177,6 @@
 		major(statbuf.st_rdev) == LOOPMAJOR);
 }
 
-#define SIZE(a) (sizeof(a)/sizeof(a[0]))
-
 char *
 find_unused_loop_device (void) {
 	/* Just creating a device, say in /tmp, is probably a bad idea -
@@ -403,12 +439,13 @@
 
 static void
 usage(void) {
-	fprintf(stderr, _("usage:\n\
-  %s loop_device                                       # give info\n\
-  %s -d loop_device                                    # delete\n\
-  %s -f                                                # find unused\n\
-  %s [-e encryption] [-o offset] {-f|loop_device} file # setup\n"),
-		progname, progname, progname, progname);
+	fprintf(stderr, _("usage:\n"
+  "  %1$s loop_device                                       # give info\n"
+  "  %1$s -d loop_device                                    # delete\n"
+  "  %1$s -f                                                # find unused\n"
+  "  %1$s -a                                                # list all used\n"
+  "  %1$s [-e encryption] [-o offset] {-f|loop_device} file # setup\n"),
+		progname);
 	exit(1);
 }
 
@@ -442,7 +479,7 @@
 int
 main(int argc, char **argv) {
 	char *p, *offset, *encryption, *passfd, *device, *file;
-	int delete, find, c;
+	int delete, find, c, all;
 	int res = 0;
 	int ro = 0;
 	int pfd = -1;
@@ -452,7 +489,7 @@
 	bindtextdomain(PACKAGE, LOCALEDIR);
 	textdomain(PACKAGE);
 
-	delete = find = 0;
+	delete = find = all = 0;
 	off = 0;
 	offset = encryption = passfd = NULL;
 
@@ -460,8 +497,11 @@
 	if ((p = strrchr(progname, '/')) != NULL)
 		progname = p+1;
 
-	while ((c = getopt(argc, argv, "de:E:fo:p:v")) != -1) {
+	while ((c = getopt(argc, argv, "ade:E:fo:p:v")) != -1) {
 		switch (c) {
+		case 'a':
+			all = 1;
+			break;
 		case 'd':
 			delete = 1;
 			break;
@@ -489,17 +529,22 @@
 	if (argc == 1) {
 		usage();
 	} else if (delete) {
-		if (argc != optind+1 || encryption || offset || find)
+		if (argc != optind+1 || encryption || offset || find || all)
 			usage();
 	} else if (find) {
-		if (argc < optind || argc > optind+1)
+		if (all || argc < optind || argc > optind+1)
+			usage();
+	} else if (all) {
+		if (argc > 2)
 			usage();
 	} else {
 		if (argc < optind+1 || argc > optind+2)
 			usage();
 	}
 
-	if (find) {
+	if (all)
+		return show_used_loop_devices();
+	else if (find) {
 		device = find_unused_loop_device();
 		if (device == NULL)
 			return -1;


