Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261733AbUCBSnh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 13:43:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261741AbUCBSnM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 13:43:12 -0500
Received: from NS1.idleaire.net ([65.220.16.2]:35518 "EHLO iasrv1.idleaire.net")
	by vger.kernel.org with ESMTP id S261734AbUCBSkO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 13:40:14 -0500
Subject: [PATCH 3/3] Auto checkout for kbuild
From: Dave Dillow <ddillow@idleaire.com>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-1y7kugSZ3xBrQUkOvUHi"
Message-Id: <1078252811.31306.27.camel@dillow.idleaire.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 02 Mar 2004 13:40:11 -0500
X-OriginalArrivalTime: 02 Mar 2004 18:40:11.0686 (UTC) FILETIME=[CB6E2460:01C40085]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-1y7kugSZ3xBrQUkOvUHi
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Cosmetic cleanups when checking out/cleaning files.
-- 
Dave Dillow <ddillow@idleaire.com>

--=-1y7kugSZ3xBrQUkOvUHi
Content-Disposition: attachment; filename=autoget-cleanup.patch
Content-Type: text/plain; name=autoget-cleanup.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1506  -> 1.1507 
#	scripts/Makefile.clean	1.13    -> 1.15   
#	            Makefile	1.441   -> 1.443  
#	scripts/Makefile.build	1.42    -> 1.43   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/12/04	dave@thedillows.org	1.1507
# Make the build process a bit less verbose and a bit cleaner during a build
# from a "cleaned" repository.
# --------------------------------------------
#
diff -Nru a/Makefile b/Makefile
--- a/Makefile	Tue Mar  2 13:33:25 2004
+++ b/Makefile	Tue Mar  2 13:33:25 2004
@@ -402,7 +402,11 @@
 
 endif
 
+ifeq ($(KBUILD_VERBOSE),1)
 include $(srctree)/arch/$(ARCH)/Makefile
+else
+-include $(srctree)/arch/$(ARCH)/Makefile
+endif
 
 # Let architecture Makefiles change CPPFLAGS if needed
 CFLAGS := $(CPPFLAGS) $(CFLAGS)
@@ -946,8 +950,14 @@
 ifeq ($(KBUILD_SRC),)
 
 # Command to use to perform actual pull of a file from the repository
-GET = get
-export GET
+GET	:= get
+GFLAGS	:=
+
+ifneq ($(KBUILD_VERBOSE),1)
+	GFLAGS += -q
+endif
+
+export GET GFLAGS
 
 # Need this rule so that getfiles will get the proper CFLAGS to complete
 # its dependency checkout
@@ -961,6 +971,7 @@
 kbuild_base_files += scripts/Makefile.modpost scripts/Makefile.modinst
 kbuild_base_files += scripts/Makefile.repo scripts/mkversion
 kbuild_base_files += scripts/getfiles scripts/mkcompile_h
+kbuild_base_files += scripts/Makefile.clean
 
 # These rules will ensure these files exist, or are pulled from the repository
 .PHONY: kbuild_files
@@ -992,7 +1003,11 @@
 endif # filter on nokconfig_targtes
 endif # ifeq ($(KBUILD_SRC),)
 
+ifeq ($(KBUILD_VERBOSE),1)
 include $(srctree)/scripts/Makefile.repo
+else
+-include $(srctree)/scripts/Makefile.repo
+endif
 
 
 # FIXME Should go into a make.lib or something 
diff -Nru a/scripts/Makefile.build b/scripts/Makefile.build
--- a/scripts/Makefile.build	Tue Mar  2 13:33:25 2004
+++ b/scripts/Makefile.build	Tue Mar  2 13:33:25 2004
@@ -10,9 +10,16 @@
 # Read .config if it exist, otherwise ignore
 -include .config
 
+ifeq ($(KBUILD_VERBOSE),1)
 include $(obj)/Makefile
-
 include scripts/Makefile.lib
+include scripts/Makefile.repo
+else
+-include $(obj)/Makefile
+-include scripts/Makefile.lib
+-include scripts/Makefile.repo
+endif
+
 
 ifneq ($(KBUILD_SRC),)
 # Create output directory if not already present
@@ -23,8 +30,6 @@
 _dummy := $(foreach d,$(obj-dirs), $(shell [ -d $(d) ] || mkdir -p $(d)))
 endif
 
-
-include scripts/Makefile.repo
 
 ifdef EXTRA_TARGETS
 $(warning kbuild: $(obj)/Makefile - Usage of EXTRA_TARGETS is obsolete in 2.6. Please fix!)
diff -Nru a/scripts/Makefile.clean b/scripts/Makefile.clean
--- a/scripts/Makefile.clean	Tue Mar  2 13:33:25 2004
+++ b/scripts/Makefile.clean	Tue Mar  2 13:33:25 2004
@@ -7,7 +7,13 @@
 .PHONY: __clean
 __clean:
 
+ifeq ($(KBUILD_VERBOSE),1)
 include $(obj)/Makefile
+include $(srctree)/scripts/Makefile.repo
+else
+-include $(obj)/Makefile
+-include $(srctree)/scripts/Makefile.repo
+endif
 
 # Figure out what we need to build from the various variables
 # ==========================================================================

--=-1y7kugSZ3xBrQUkOvUHi--

