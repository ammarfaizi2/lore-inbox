Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261418AbTHSV4N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 17:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261421AbTHSV4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 17:56:12 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:5125 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S261418AbTHSVzR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 17:55:17 -0400
Date: Tue, 19 Aug 2003 23:54:30 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       Sam Ravnborg <sam@ravnborg.org>
Subject: Re: kbuild: Separate output directory - include patch
Message-ID: <20030819215430.GD1791@mars.ravnborg.org>
References: <20030819215157.GA1791@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030819215157.GA1791@mars.ravnborg.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1272  -> 1.1273 
#	     kernel/Makefile	1.32    -> 1.33   
#	scripts/genksyms/Makefile	1.3     -> 1.4    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/08/19	sam@mars.ravnborg.org	1.1273
# kbuild: Fix build with seperate output directory
# 
# Build rule for ikconfig updated.
# Include directive for genksyms updated
# --------------------------------------------
#
diff -Nru a/kernel/Makefile b/kernel/Makefile
--- a/kernel/Makefile	Tue Aug 19 23:41:31 2003
+++ b/kernel/Makefile	Tue Aug 19 23:41:31 2003
@@ -20,8 +20,6 @@
 obj-$(CONFIG_COMPAT) += compat.o
 obj-$(CONFIG_IKCONFIG) += configs.o
 
-# files to be removed upon make clean
-clean-files := ikconfig.h
 
 ifneq ($(CONFIG_IA64),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
@@ -32,8 +30,13 @@
 CFLAGS_sched.o := $(PROFILING) -fno-omit-frame-pointer
 endif
 
-$(obj)/ikconfig.h: scripts/mkconfigs .config Makefile
-	$(CONFIG_SHELL) scripts/mkconfigs .config Makefile > $(obj)/ikconfig.h
+quiet_cmd_ikconfig = IKCFG   $@
+      cmd_ikconfig = $(CONFIG_SHELL) $< .config $(srctree)/Makefile > $@
+
+targets := ikconfig.h
+
+$(obj)/ikconfig.h: scripts/mkconfigs .config Makefile FORCE
+	$(call if_changed,ikconfig)
 
 $(obj)/configs.o: $(obj)/ikconfig.h $(obj)/configs.c \
 		include/linux/version.h include/linux/compile.h
diff -Nru a/scripts/genksyms/Makefile b/scripts/genksyms/Makefile
--- a/scripts/genksyms/Makefile	Tue Aug 19 23:41:31 2003
+++ b/scripts/genksyms/Makefile	Tue Aug 19 23:41:31 2003
@@ -3,13 +3,14 @@
 always		:= $(host-progs)
 
 genksyms-objs	:= genksyms.o parse.o lex.o
-
-HOSTCFLAGS_parse.o := -Wno-uninitialized
+# -I needed for generated C source (shipped source)
+HOSTCFLAGS_parse.o := -Wno-uninitialized -I$(obj)
 
 # dependencies on generated files need to be listed explicitly
 
 $(obj)/lex.o: $(obj)/parse.h $(obj)/keywords.c
-
+# -I needed for generated C source (shipped source)
+HOSTCFLAGS_lex.o := -I$(obj)
 
 ifdef GENERATE_PARSER
 
