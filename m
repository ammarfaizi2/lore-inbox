Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbTIXSve (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 14:51:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbTIXSvd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 14:51:33 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:42463 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261603AbTIXSva (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 14:51:30 -0400
Subject: [BKPATCH] [BEFS] fix resource leak on register_filesystem failure
From: Will Dyson <will_dyson@pobox.com>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1064429488.9009.20.camel@thalience>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 24 Sep 2003 14:51:28 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marco Cova noticed a bug in befs's init code. He said:

> It seems there's a (very) rare-case bug in linuxvfs.c:init_befs_fs
> In the current implementation, if register_filesystem() fails, the
> memory allocated through befs_init_inodecache() is not deallocated.

He also provided the trivial patch below (modulo my renaming of the goto
labels).

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or
higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1228  -> 1.1230 
#	  fs/befs/linuxvfs.c	1.8     -> 1.10   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/09/22	will@thalience.(none)	1.1229
# Fix slab memory leak when register_filesystem fails.
# Caught by Marco Cova
# --------------------------------------------
# 03/09/22	will@thalience.(none)	1.1230
# Fixup for previous cset
# --------------------------------------------
#
diff -Nru a/fs/befs/linuxvfs.c b/fs/befs/linuxvfs.c
--- a/fs/befs/linuxvfs.c	Mon Sep 22 23:11:17 2003
+++ b/fs/befs/linuxvfs.c	Mon Sep 22 23:11:17 2003
@@ -939,9 +941,19 @@
 
 	err = befs_init_inodecache();
 	if (err)
-		return err;
+		goto unaquire_none;
+
+	err = register_filesystem(&befs_fs_type);
+	if (err)
+		goto unaquire_inodecache;
+
+	return 0;
+
+unaquire_inodecache:
+	befs_destroy_inodecache();
 
-	return register_filesystem(&befs_fs_type);
+unaquire_none:
+	return err;
 }
 
 static void __exit


-- 
Will Dyson
"Back off man, I'm a scientist!" -Dr. Peter Venkman

