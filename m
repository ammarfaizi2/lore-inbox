Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263850AbTLEDfq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 22:35:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263849AbTLEDe7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 22:34:59 -0500
Received: from pcp03710388pcs.westk01.tn.comcast.net ([68.34.200.110]:53450
	"EHLO ori.thedillows.org") by vger.kernel.org with ESMTP
	id S263846AbTLEDcm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 22:32:42 -0500
Subject: [BK PATCH 3/3] Teach kbuild to pull files from BK repository
From: David Dillow <dave@thedillows.org>
To: linux-kernel@vger.kernel.org
Cc: kbuild-devel@lists.sourceforge.net
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1070595129.4585.32.camel@ori.thedillows.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 04 Dec 2003 22:32:09 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
--- a/Makefile	Thu Dec  4 00:24:41 2003
+++ b/Makefile	Thu Dec  4 00:24:41 2003
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
--- a/scripts/Makefile.build	Thu Dec  4 00:24:41 2003
+++ b/scripts/Makefile.build	Thu Dec  4 00:24:41 2003
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
--- a/scripts/Makefile.clean	Thu Dec  4 00:24:41 2003
+++ b/scripts/Makefile.clean	Thu Dec  4 00:24:41 2003
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


