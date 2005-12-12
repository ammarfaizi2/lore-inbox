Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750951AbVLLAqF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750951AbVLLAqF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 19:46:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750953AbVLLAqE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 19:46:04 -0500
Received: from w241.dkm.cz ([62.24.88.241]:3732 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750951AbVLLAqD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 19:46:03 -0500
From: Petr Baudis <pasky@suse.cz>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] [kbuild] Allow building of standalone .so libraries
Date: Mon, 12 Dec 2005 01:46:01 +0100
To: zippel@linux-m68k.org
Cc: sam@ravnborg.org, kbuild-devel@lists.sourceforge.net
Message-Id: <20051212004601.31263.49854.stgit@machine.or.cz>
In-Reply-To: <20051212004159.31263.89669.stgit@machine.or.cz>
References: <20051212004159.31263.89669.stgit@machine.or.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch allows specifying .so libraries directly in 'hostprogs-y'.
I need to create a .so library not linked to anything in the
scripts/lxdialog/ directory.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 scripts/Makefile.host |   14 +++++++++++---
 1 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/scripts/Makefile.host b/scripts/Makefile.host
index 2d51970..ff1b54d 100644
--- a/scripts/Makefile.host
+++ b/scripts/Makefile.host
@@ -29,6 +29,12 @@
 # conf.c is compiled as a c program, and conf.o is linked together with
 # libkconfig.so as the executable conf.
 # Note: Shared libraries consisting of C++ files are not supported
+#
+# hostprogs-y := liblxdialog.so
+# liblxdialog-objs := checklist.o util.o
+# Will create a "standalone" liblxdialog.so library in the directory,
+# not linked against anything (useful when you want to link something
+# to it later).
 
 __hostprogs := $(sort $(hostprogs-y)$(hostprogs-m))
 
@@ -39,7 +45,7 @@ obj-dirs := $(strip $(sort $(filter-out 
 
 # C code
 # Executables compiled from a single .c file
-host-csingle	:= $(foreach m,$(__hostprogs),$(if $($(m)-objs),,$(m)))
+host-csingle	:= $(foreach m,$(__hostprogs),$(if $($(m:.so=)-objs),,$(m)))
 
 # C executables linked based on several .o files
 host-cmulti	:= $(foreach m,$(__hostprogs),\
@@ -57,8 +63,10 @@ host-cxxmulti	:= $(foreach m,$(__hostpro
 host-cxxobjs	:= $(sort $(foreach m,$(host-cxxmulti),$($(m)-cxxobjs)))
 
 # Shared libaries (only .c supported)
-# Shared libraries (.so) - all .so files referenced in "xxx-objs"
-host-cshlib	:= $(sort $(filter %.so, $(host-cobjs)))
+# Shared libraries (.so) - all .so files referenced in "xxx-objs", and
+# also standalone .so's referenced in hostprogs.
+host-cshlib	:= $(sort $(filter %.so, $(host-cobjs))) \
+		   $(sort $(filter %.so, $(__hostprogs)))
 # Remove .so files from "xxx-objs"
 host-cobjs	:= $(filter-out %.so,$(host-cobjs))
 

