Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267351AbUHMTxF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267351AbUHMTxF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 15:53:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267353AbUHMTtx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 15:49:53 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:64554 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S267352AbUHMTon
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 15:44:43 -0400
Date: Fri, 13 Aug 2004 21:47:05 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: [4/12] kbuild: Selective compile of targets in scripts/
Message-ID: <20040813194705.GD10556@mars.ravnborg.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
References: <20040813192804.GA10486@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040813192804.GA10486@mars.ravnborg.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/08/08 21:01:05+02:00 sam@mars.ravnborg.org 
#   kbuild: Selective compile of targets in scripts/
#   
#   Do not build executables unless needed.
#   Same goes for scripts/mod/, descend only when CONFIG_MODULES are enabled.
#   With inputs form: Russell King <rmk+lkml@arm.linux.org.uk> and  Brian Gerst <bgerst@quark.didntduck.org>
#   
#   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
# 
# scripts/Makefile
#   2004/08/08 21:00:50+02:00 sam@mars.ravnborg.org +12 -4
#   Only build required host-progs.
#   Descend into mod/ only when modules are enabled
# 
# Makefile
#   2004/08/08 21:00:50+02:00 sam@mars.ravnborg.org +1 -1
#   Add dependency on kallsyms, so recompile is done when script changes
# 
diff -Nru a/Makefile b/Makefile
--- a/Makefile	2004-08-13 21:09:00 +02:00
+++ b/Makefile	2004-08-13 21:09:00 +02:00
@@ -584,7 +584,7 @@
 .tmp_kallsyms1.o .tmp_kallsyms2.o .tmp_kallsyms3.o: %.o: %.S scripts FORCE
 	$(call if_changed_dep,as_o_S)
 
-.tmp_kallsyms%.S: .tmp_vmlinux%
+.tmp_kallsyms%.S: .tmp_vmlinux% $(KALLSYMS)
 	$(call cmd,kallsyms)
 
 .tmp_vmlinux1: $(vmlinux-objs) arch/$(ARCH)/kernel/vmlinux.lds.s FORCE
diff -Nru a/scripts/Makefile b/scripts/Makefile
--- a/scripts/Makefile	2004-08-13 21:09:00 +02:00
+++ b/scripts/Makefile	2004-08-13 21:09:00 +02:00
@@ -2,14 +2,22 @@
 # scripts contains sources for various helper programs used throughout
 # the kernel for the build process.
 # ---------------------------------------------------------------------------
-# docproc: 	 Preprocess .tmpl file in order to generate .sgml docs
+# kallsyms:      Find all symbols in vmlinux
+# pnmttologo:    Convert pnm files to logo files
+# conmakehash:   Create chartable
 # conmakehash:	 Create arrays for initializing the kernel console tables
 
-host-progs	:= conmakehash kallsyms pnmtologo bin2c
+hostprogs-$(CONFIG_KALLSYMS)     += kallsyms
+hostprogs-$(CONFIG_LOGO)         += pnmtologo
+hostprogs-$(CONFIG_VT)           += conmakehash
+hostprogs-$(CONFIG_PROM_CONSOLE) += conmakehash
+hostprogs-$(CONFIG_IKCONFIG)     += bin2c
+
+host-progs	:= $(sort $(hostprogs-y))
 always		:= $(host-progs)
 
-subdir-$(CONFIG_MODVERSIONS)	+= genksyms
-subdir-y	+= mod
+subdir-$(CONFIG_MODVERSIONS) += genksyms
+subdir-$(CONFIG_MODULES)     += mod
 
 # Let clean descend into subdirs
 subdir-	+= basic lxdialog kconfig package
