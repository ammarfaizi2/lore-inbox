Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261211AbVCGSIb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261211AbVCGSIb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 13:08:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261209AbVCGSIb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 13:08:31 -0500
Received: from lakshmi.addtoit.com ([198.99.130.6]:59652 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S261211AbVCGSHg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 13:07:36 -0500
Message-Id: <200503072037.j27Kbgbc003957@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 4/16] UML - Get rid of uneccessary hostfs build trick
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 07 Mar 2005 15:37:42 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Get rid of the grepping for __st_ino in hostfs, since it doesn't work on x86_64
(the grep finds it, but it is ifdefed out), and Al says it's unnecessary
anyway.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.11/fs/hostfs/Makefile
===================================================================
--- linux-2.6.11.orig/fs/hostfs/Makefile	2005-03-05 12:07:31.000000000 -0500
+++ linux-2.6.11/fs/hostfs/Makefile	2005-03-05 12:09:15.000000000 -0500
@@ -3,13 +3,6 @@
 # Licensed under the GPL
 #
 
-# struct stat64 changed the inode field name between 2.2 and 2.4 from st_ino
-# to __st_ino.  It stayed in the same place, so as long as the correct name
-# is used, hostfs compiled on 2.2 should work on 2.4 and vice versa.
-
-STAT64_INO_FIELD := $(shell grep -q __st_ino /usr/include/bits/stat.h && \
-				echo __)st_ino
-
 hostfs-objs := hostfs_kern.o hostfs_user.o
 
 obj-y =
@@ -20,7 +13,5 @@
 USER_OBJS := $(filter %_user.o,$(obj-y) $(obj-m) $(SINGLE_OBJS))
 USER_OBJS := $(foreach file,$(USER_OBJS),$(obj)/$(file))
 
-USER_CFLAGS += -DSTAT64_INO_FIELD=$(STAT64_INO_FIELD)
-
 $(USER_OBJS) : %.o: %.c
 	$(CC) $(CFLAGS_$(notdir $@)) $(USER_CFLAGS) -c -o $@ $<
Index: linux-2.6.11/fs/hostfs/hostfs_user.c
===================================================================
--- linux-2.6.11.orig/fs/hostfs/hostfs_user.c	2005-03-05 12:07:31.000000000 -0500
+++ linux-2.6.11/fs/hostfs/hostfs_user.c	2005-03-05 12:09:15.000000000 -0500
@@ -28,10 +28,7 @@
 	if(lstat64(path, &buf) < 0)
 		return(-errno);
 
-	/* See the Makefile for why STAT64_INO_FIELD is passed in
-	 * by the build
-	 */
-	if(inode_out != NULL) *inode_out = buf.STAT64_INO_FIELD;
+	if(inode_out != NULL) *inode_out = buf.st_ino;
 	if(mode_out != NULL) *mode_out = buf.st_mode;
 	if(nlink_out != NULL) *nlink_out = buf.st_nlink;
 	if(uid_out != NULL) *uid_out = buf.st_uid;

