Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261744AbUCBSmk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 13:42:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261742AbUCBSmj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 13:42:39 -0500
Received: from NS1.idleaire.net ([65.220.16.2]:34750 "EHLO iasrv1.idleaire.net")
	by vger.kernel.org with ESMTP id S261722AbUCBSkN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 13:40:13 -0500
Subject: [PATCH 2/3] Auto checkout for kbuild
From: Dave Dillow <ddillow@idleaire.com>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-D6cTBLB+S3RU1bwTZJkY"
Message-Id: <1078252809.31308.25.camel@dillow.idleaire.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 02 Mar 2004 13:40:09 -0500
X-OriginalArrivalTime: 02 Mar 2004 18:40:09.0811 (UTC) FILETIME=[CA500A30:01C40085]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-D6cTBLB+S3RU1bwTZJkY
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Support for auto checkout of Kconfig files.
-- 
Dave Dillow <ddillow@idleaire.com>

--=-D6cTBLB+S3RU1bwTZJkY
Content-Disposition: attachment; filename=autoget-kconfig.patch
Content-Type: text/plain; name=autoget-kconfig.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1505  -> 1.1506 
#	scripts/kconfig/lkc.h	1.5     -> 1.6    
#	            Makefile	1.440   -> 1.441  
#	scripts/kconfig/zconf.l	1.7     -> 1.8    
#	scripts/kconfig/lex.zconf.c_shipped	1.7     -> 1.8    
#	scripts/kconfig/Makefile	1.11    -> 1.12   
#	               (new)	        -> 1.1     scripts/depkconfig
#	               (new)	        -> 1.1     scripts/kconfig/listkconfigs.c
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/12/04	dave@thedillows.org	1.1506
# Teach the kbuild system how to retrieve the Kconfig files from
# the repository. This involves modifying the kconfig lexer/parser
# to give us a list of sourced Kconfig files so that we can tell
# make about the dependencies. Then is just a matter of makeing sure
# that make will extract those files before they are needed in the
# build process.
# --------------------------------------------
#
diff -Nru a/Makefile b/Makefile
--- a/Makefile	Tue Mar  2 13:19:31 2004
+++ b/Makefile	Tue Mar  2 13:19:31 2004
@@ -308,7 +308,7 @@
 scripts/docproc scripts/split-include : scripts ;
 
 .PHONY: scripts scripts/fixdep
-scripts:
+scripts: kbuild_files
 	$(Q)$(MAKE) $(build)=scripts
 
 scripts/fixdep:
@@ -329,6 +329,7 @@
 config-targets := 0
 mixed-targets  := 0
 dot-config     := 1
+config-type    := 
 
 ifneq ($(filter $(no-dot-config-targets), $(MAKECMDGOALS)),)
 	ifeq ($(filter-out $(no-dot-config-targets), $(MAKECMDGOALS)),)
@@ -338,6 +339,7 @@
 
 ifneq ($(filter config %config,$(MAKECMDGOALS)),)
 	config-targets := 1
+	config-type := $(filter config %config,$(MAKECMDGOALS))
 	ifneq ($(filter-out config %config,$(MAKECMDGOALS)),)
 		mixed-targets := 1
 	endif
@@ -357,9 +359,7 @@
 # *config targets only - make sure prerequisites are updated, and descend
 # in scripts/kconfig to make the *config target
 
-%config: scripts/fixdep FORCE
-	$(Q)$(MAKE) $(build)=scripts/kconfig $@
-config : scripts/fixdep FORCE
+$(config-type) : scripts/fixdep FORCE
 	$(Q)$(MAKE) $(build)=scripts/kconfig $@
 
 else
@@ -941,6 +941,10 @@
 # Rules to automatically check files out of the repository during build
 # ===========================================================================
 
+# Don't need these if doing an out-of-tree build
+#
+ifeq ($(KBUILD_SRC),)
+
 # Command to use to perform actual pull of a file from the repository
 GET = get
 export GET
@@ -958,11 +962,35 @@
 kbuild_base_files += scripts/Makefile.repo scripts/mkversion
 kbuild_base_files += scripts/getfiles scripts/mkcompile_h
 
-# This rule will ensure these files exist, or are pulled from the repository
-.get_kbuild_files.d: $(kbuild_base_files)
+# These rules will ensure these files exist, or are pulled from the repository
+.PHONY: kbuild_files
+kbuild_files: $(kbuild_base_files) ;
+
+.get_kbuild_files.d: kbuild_files
 	$(Q)touch .get_kbuild_files.d
 
 -include .get_kbuild_files.d
+
+# These targets do not require the Kconfig files. Everything else does.
+nokconfig_targets := help clean mrproper distclean
+
+scripts/kconfig/listkconfigs: scripts FORCE
+	$(Q)$(MAKE) $(build)=scripts/kconfig $@
+
+ifeq ($(filter $(nokconfig_targets),$(MAKECMDGOALS)),)
+
+quiet_cmd_kconfig_checkout_dep = GENDEP  $<
+cmd_kconfig_checkout_dep = $(srctree)/scripts/depkconfig $< $@
+
+.checkout_Kconfig.d: scripts/depkconfig
+.checkout_Kconfig.d: scripts/kconfig/listkconfigs
+.checkout_Kconfig.d: arch/$(ARCH)/Kconfig
+	$(call cmd,kconfig_checkout_dep)
+
+-include .checkout_Kconfig.d
+
+endif # filter on nokconfig_targtes
+endif # ifeq ($(KBUILD_SRC),)
 
 include $(srctree)/scripts/Makefile.repo
 
diff -Nru a/scripts/depkconfig b/scripts/depkconfig
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/scripts/depkconfig	Tue Mar  2 13:19:31 2004
@@ -0,0 +1,58 @@
+#!/bin/bash
+#
+# Script to convert the output of listkconfig to a form make will understand.
+# The output from this script is in the form of a Makefile fragment, and
+# makes the output file depend on every Kconfig file seen.
+#
+# Copyright (C) 2003 David Dillow <dave@thedillows.org>
+#
+# Released under the GNU GPL, see COPYING for details
+#
+
+usage() {
+	echo "usage: depkconfig <starting Kconfig> <output file>\n" 1>&2
+	echo -e "\tconvert sourced Kconfig files from starting file into" 1>&2
+	echo -e "\tmake dependency rules in output file" 1>&2
+	exit 2
+}
+
+mark_precious() {
+	precious="$precious $1"
+}
+
+add_kconfig() {
+	kconfigs="$kconfigs $1"
+}
+
+[[ $# -eq 2 ]] || usage
+
+in=$1
+out=$2
+
+if [[ ! -e $in ]]; then
+	echo "depkconfig: $in does not exist!" 1>&2
+	exit 1
+fi
+
+kconfigs=""
+precious=""
+
+mark_precious $in
+add_kconfig $in
+
+for file in `scripts/kconfig/listkconfigs $in | grep ^KDEP | cut -f2- -d' '`;
+do
+	mark_precious $file
+	add_kconfig $file
+done
+
+cat /dev/null > $out
+for file in $kconfigs; do
+	echo "$out: $file" >> $out
+done
+
+[[ $precious ]] && echo -n ".PRECIOUS:" >> $out
+for file in $precious; do
+	echo -n " $file" >> $out
+done
+echo >> $out
diff -Nru a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
--- a/scripts/kconfig/Makefile	Tue Mar  2 13:19:31 2004
+++ b/scripts/kconfig/Makefile	Tue Mar  2 13:19:31 2004
@@ -56,20 +56,24 @@
 
 # ===========================================================================
 # Shared Makefile for the various kconfig executables:
-# conf:	  Used for defconfig, oldconfig and related targets
-# mconf:  Used for the mconfig target.
-#         Utilizes the lxdialog package
-# qconf:  Used for the xconfig target
-#         Based on QT which needs to be installed to compile it
-# gconf:  Used for the gconfig target
-#         Based on GTK which needs to be installed to compile it
+# conf:	  	Used for defconfig, oldconfig and related targets
+# mconf:  	Used for the mconfig target.
+#         	Utilizes the lxdialog package
+# qconf:  	Used for the xconfig target
+#         	Based on QT which needs to be installed to compile it
+# gconf:  	Used for the gconfig target
+#         	Based on GTK which needs to be installed to compile it
+# listkconfigs:	Used to generate a list of Kconfigs so that make will
+#		pull them from the repository for us
+#
 # object files used by all kconfig flavours
 
 libkconfig-objs := zconf.tab.o
 
-host-progs	:= conf mconf qconf gconf
-conf-objs	:= conf.o  libkconfig.so
-mconf-objs	:= mconf.o libkconfig.so
+host-progs		:= conf mconf qconf gconf listkconfigs
+conf-objs		:= conf.o  libkconfig.so
+mconf-objs		:= mconf.o libkconfig.so
+listkconfigs-objs	:= listkconfigs.o libkconfig.so
 
 ifeq ($(MAKECMDGOALS),xconfig)
 	qconf-target := 1
@@ -102,6 +106,7 @@
 HOSTCFLAGS_gconf.o	= `pkg-config gtk+-2.0 gmodule-2.0 libglade-2.0 --cflags`
 
 $(obj)/conf.o $(obj)/mconf.o $(obj)/qconf.o $(obj)/gconf.o: $(obj)/zconf.tab.h
+$(obj)/listkconfigs.o: $(obj)/zconf.tab.h
 
 $(obj)/qconf.o: $(obj)/.tmp_qtcheck
 
diff -Nru a/scripts/kconfig/lex.zconf.c_shipped b/scripts/kconfig/lex.zconf.c_shipped
--- a/scripts/kconfig/lex.zconf.c_shipped	Tue Mar  2 13:19:31 2004
+++ b/scripts/kconfig/lex.zconf.c_shipped	Tue Mar  2 13:19:31 2004
@@ -1,5 +1,6 @@
+#line 2 "scripts/kconfig/lex.zconf.c"
 
-#line 3 "lex.zconf.c"
+#line 4 "scripts/kconfig/lex.zconf.c"
 
 #define  YY_INT_ALIGNED short int
 
@@ -1997,7 +1998,9 @@
 #define YY_MORE_ADJ 0
 #define YY_RESTORE_YY_MORE_OFFSET
 char *zconftext;
+#line 1 "scripts/kconfig/zconf.l"
 
+#line 5 "scripts/kconfig/zconf.l"
 /*
  * Copyright (C) 2002 Roman Zippel <zippel@linux-m68k.org>
  * Released under the terms of the GNU GPL v2.0.
@@ -2030,6 +2033,8 @@
 static void zconf_endhelp(void);
 static struct buffer *zconf_endfile(void);
 
+int zconf_print_sources;
+
 void new_string(void)
 {
 	text = malloc(START_STRSIZE);
@@ -2059,6 +2064,7 @@
 	memcpy(text, str, size);
 	text[size] = 0;
 }
+#line 2068 "scripts/kconfig/lex.zconf.c"
 
 #define INITIAL 0
 #define COMMAND 1
@@ -2195,9 +2201,13 @@
 	register char *yy_cp, *yy_bp;
 	register int yy_act;
     
+#line 73 "scripts/kconfig/zconf.l"
+
 	int str = 0;
 	int ts, i;
 
+#line 2210 "scripts/kconfig/lex.zconf.c"
+
 	if ( (yy_init) )
 		{
 		(yy_init) = 0;
@@ -2255,25 +2265,30 @@
 case 1:
 /* rule 1 can match eol */
 YY_RULE_SETUP
+#line 77 "scripts/kconfig/zconf.l"
 current_file->lineno++;
 	YY_BREAK
 case 2:
 YY_RULE_SETUP
+#line 78 "scripts/kconfig/zconf.l"
 
 	YY_BREAK
 case 3:
 /* rule 3 can match eol */
 YY_RULE_SETUP
+#line 80 "scripts/kconfig/zconf.l"
 current_file->lineno++; return T_EOL;
 	YY_BREAK
 case 4:
 YY_RULE_SETUP
+#line 82 "scripts/kconfig/zconf.l"
 {
 	BEGIN(COMMAND);
 }
 	YY_BREAK
 case 5:
 YY_RULE_SETUP
+#line 86 "scripts/kconfig/zconf.l"
 {
 	unput(zconftext[0]);
 	BEGIN(COMMAND);
@@ -2282,122 +2297,152 @@
 
 case 6:
 YY_RULE_SETUP
+#line 93 "scripts/kconfig/zconf.l"
 BEGIN(PARAM); return T_MAINMENU;
 	YY_BREAK
 case 7:
 YY_RULE_SETUP
+#line 94 "scripts/kconfig/zconf.l"
 BEGIN(PARAM); return T_MENU;
 	YY_BREAK
 case 8:
 YY_RULE_SETUP
+#line 95 "scripts/kconfig/zconf.l"
 BEGIN(PARAM); return T_ENDMENU;
 	YY_BREAK
 case 9:
 YY_RULE_SETUP
+#line 96 "scripts/kconfig/zconf.l"
 BEGIN(PARAM); return T_SOURCE;
 	YY_BREAK
 case 10:
 YY_RULE_SETUP
+#line 97 "scripts/kconfig/zconf.l"
 BEGIN(PARAM); return T_CHOICE;
 	YY_BREAK
 case 11:
 YY_RULE_SETUP
+#line 98 "scripts/kconfig/zconf.l"
 BEGIN(PARAM); return T_ENDCHOICE;
 	YY_BREAK
 case 12:
 YY_RULE_SETUP
+#line 99 "scripts/kconfig/zconf.l"
 BEGIN(PARAM); return T_COMMENT;
 	YY_BREAK
 case 13:
 YY_RULE_SETUP
+#line 100 "scripts/kconfig/zconf.l"
 BEGIN(PARAM); return T_CONFIG;
 	YY_BREAK
 case 14:
 YY_RULE_SETUP
+#line 101 "scripts/kconfig/zconf.l"
 BEGIN(PARAM); return T_MENUCONFIG;
 	YY_BREAK
 case 15:
 YY_RULE_SETUP
+#line 102 "scripts/kconfig/zconf.l"
 BEGIN(PARAM); return T_HELP;
 	YY_BREAK
 case 16:
 YY_RULE_SETUP
+#line 103 "scripts/kconfig/zconf.l"
 BEGIN(PARAM); return T_IF;
 	YY_BREAK
 case 17:
 YY_RULE_SETUP
+#line 104 "scripts/kconfig/zconf.l"
 BEGIN(PARAM); return T_ENDIF;
 	YY_BREAK
 case 18:
 YY_RULE_SETUP
+#line 105 "scripts/kconfig/zconf.l"
 BEGIN(PARAM); return T_DEPENDS;
 	YY_BREAK
 case 19:
 YY_RULE_SETUP
+#line 106 "scripts/kconfig/zconf.l"
 BEGIN(PARAM); return T_REQUIRES;
 	YY_BREAK
 case 20:
 YY_RULE_SETUP
+#line 107 "scripts/kconfig/zconf.l"
 BEGIN(PARAM); return T_OPTIONAL;
 	YY_BREAK
 case 21:
 YY_RULE_SETUP
+#line 108 "scripts/kconfig/zconf.l"
 BEGIN(PARAM); return T_DEFAULT;
 	YY_BREAK
 case 22:
 YY_RULE_SETUP
+#line 109 "scripts/kconfig/zconf.l"
 BEGIN(PARAM); return T_PROMPT;
 	YY_BREAK
 case 23:
 YY_RULE_SETUP
+#line 110 "scripts/kconfig/zconf.l"
 BEGIN(PARAM); return T_TRISTATE;
 	YY_BREAK
 case 24:
 YY_RULE_SETUP
+#line 111 "scripts/kconfig/zconf.l"
 BEGIN(PARAM); return T_DEF_TRISTATE;
 	YY_BREAK
 case 25:
 YY_RULE_SETUP
+#line 112 "scripts/kconfig/zconf.l"
 BEGIN(PARAM); return T_BOOLEAN;
 	YY_BREAK
 case 26:
 YY_RULE_SETUP
+#line 113 "scripts/kconfig/zconf.l"
 BEGIN(PARAM); return T_BOOLEAN;
 	YY_BREAK
 case 27:
 YY_RULE_SETUP
+#line 114 "scripts/kconfig/zconf.l"
 BEGIN(PARAM); return T_DEF_BOOLEAN;
 	YY_BREAK
 case 28:
 YY_RULE_SETUP
+#line 115 "scripts/kconfig/zconf.l"
 BEGIN(PARAM); return T_DEF_BOOLEAN;
 	YY_BREAK
 case 29:
 YY_RULE_SETUP
+#line 116 "scripts/kconfig/zconf.l"
 BEGIN(PARAM); return T_INT;
 	YY_BREAK
 case 30:
 YY_RULE_SETUP
+#line 117 "scripts/kconfig/zconf.l"
 BEGIN(PARAM); return T_HEX;
 	YY_BREAK
 case 31:
 YY_RULE_SETUP
+#line 118 "scripts/kconfig/zconf.l"
 BEGIN(PARAM); return T_STRING;
 	YY_BREAK
 case 32:
 YY_RULE_SETUP
+#line 119 "scripts/kconfig/zconf.l"
 BEGIN(PARAM); return T_SELECT;
 	YY_BREAK
 case 33:
 YY_RULE_SETUP
+#line 120 "scripts/kconfig/zconf.l"
 BEGIN(PARAM); return T_SELECT;
 	YY_BREAK
 case 34:
 YY_RULE_SETUP
+#line 121 "scripts/kconfig/zconf.l"
 BEGIN(PARAM); return T_RANGE;
 	YY_BREAK
 case 35:
 YY_RULE_SETUP
+#line 122 "scripts/kconfig/zconf.l"
 {
 		alloc_string(zconftext, zconfleng);
 		zconflval.string = text;
@@ -2406,52 +2451,65 @@
 	YY_BREAK
 case 36:
 YY_RULE_SETUP
+#line 127 "scripts/kconfig/zconf.l"
 
 	YY_BREAK
 case 37:
 /* rule 37 can match eol */
 YY_RULE_SETUP
+#line 128 "scripts/kconfig/zconf.l"
 current_file->lineno++; BEGIN(INITIAL);
 	YY_BREAK
 
+
 case 38:
 YY_RULE_SETUP
+#line 132 "scripts/kconfig/zconf.l"
 return T_AND;
 	YY_BREAK
 case 39:
 YY_RULE_SETUP
+#line 133 "scripts/kconfig/zconf.l"
 return T_OR;
 	YY_BREAK
 case 40:
 YY_RULE_SETUP
+#line 134 "scripts/kconfig/zconf.l"
 return T_OPEN_PAREN;
 	YY_BREAK
 case 41:
 YY_RULE_SETUP
+#line 135 "scripts/kconfig/zconf.l"
 return T_CLOSE_PAREN;
 	YY_BREAK
 case 42:
 YY_RULE_SETUP
+#line 136 "scripts/kconfig/zconf.l"
 return T_NOT;
 	YY_BREAK
 case 43:
 YY_RULE_SETUP
+#line 137 "scripts/kconfig/zconf.l"
 return T_EQUAL;
 	YY_BREAK
 case 44:
 YY_RULE_SETUP
+#line 138 "scripts/kconfig/zconf.l"
 return T_UNEQUAL;
 	YY_BREAK
 case 45:
 YY_RULE_SETUP
+#line 139 "scripts/kconfig/zconf.l"
 return T_IF;
 	YY_BREAK
 case 46:
 YY_RULE_SETUP
+#line 140 "scripts/kconfig/zconf.l"
 return T_ON;
 	YY_BREAK
 case 47:
 YY_RULE_SETUP
+#line 141 "scripts/kconfig/zconf.l"
 {
 		str = zconftext[0];
 		new_string();
@@ -2461,14 +2519,17 @@
 case 48:
 /* rule 48 can match eol */
 YY_RULE_SETUP
+#line 146 "scripts/kconfig/zconf.l"
 BEGIN(INITIAL); current_file->lineno++; return T_EOL;
 	YY_BREAK
 case 49:
 YY_RULE_SETUP
+#line 147 "scripts/kconfig/zconf.l"
 /* ignore */
 	YY_BREAK
 case 50:
 YY_RULE_SETUP
+#line 148 "scripts/kconfig/zconf.l"
 {
 		alloc_string(zconftext, zconfleng);
 		zconflval.string = text;
@@ -2477,29 +2538,35 @@
 	YY_BREAK
 case 51:
 YY_RULE_SETUP
+#line 153 "scripts/kconfig/zconf.l"
 /* comment */
 	YY_BREAK
 case 52:
 /* rule 52 can match eol */
 YY_RULE_SETUP
+#line 154 "scripts/kconfig/zconf.l"
 current_file->lineno++;
 	YY_BREAK
 case 53:
 YY_RULE_SETUP
+#line 155 "scripts/kconfig/zconf.l"
 
 	YY_BREAK
 case YY_STATE_EOF(PARAM):
+#line 156 "scripts/kconfig/zconf.l"
 {
 		BEGIN(INITIAL);
 	}
 	YY_BREAK
 
+
 case 54:
 /* rule 54 can match eol */
 *yy_cp = (yy_hold_char); /* undo effects of setting up zconftext */
 (yy_c_buf_p) = yy_cp -= 1;
 YY_DO_BEFORE_ACTION; /* set up zconftext again */
 YY_RULE_SETUP
+#line 162 "scripts/kconfig/zconf.l"
 {
 		append_string(zconftext, zconfleng);
 		zconflval.string = text;
@@ -2508,6 +2575,7 @@
 	YY_BREAK
 case 55:
 YY_RULE_SETUP
+#line 167 "scripts/kconfig/zconf.l"
 {
 		append_string(zconftext, zconfleng);
 	}
@@ -2518,6 +2586,7 @@
 (yy_c_buf_p) = yy_cp -= 1;
 YY_DO_BEFORE_ACTION; /* set up zconftext again */
 YY_RULE_SETUP
+#line 170 "scripts/kconfig/zconf.l"
 {
 		append_string(zconftext + 1, zconfleng - 1);
 		zconflval.string = text;
@@ -2526,12 +2595,14 @@
 	YY_BREAK
 case 57:
 YY_RULE_SETUP
+#line 175 "scripts/kconfig/zconf.l"
 {
 		append_string(zconftext + 1, zconfleng - 1);
 	}
 	YY_BREAK
 case 58:
 YY_RULE_SETUP
+#line 178 "scripts/kconfig/zconf.l"
 {
 		if (str == zconftext[0]) {
 			BEGIN(PARAM);
@@ -2544,6 +2615,7 @@
 case 59:
 /* rule 59 can match eol */
 YY_RULE_SETUP
+#line 186 "scripts/kconfig/zconf.l"
 {
 		printf("%s:%d:warning: multi-line strings not supported\n", zconf_curname(), zconf_lineno());
 		current_file->lineno++;
@@ -2552,13 +2624,16 @@
 	}
 	YY_BREAK
 case YY_STATE_EOF(STRING):
+#line 192 "scripts/kconfig/zconf.l"
 {
 		BEGIN(INITIAL);
 	}
 	YY_BREAK
 
+
 case 60:
 YY_RULE_SETUP
+#line 198 "scripts/kconfig/zconf.l"
 {
 		ts = 0;
 		for (i = 0; i < zconfleng; i++) {
@@ -2588,6 +2663,7 @@
 (yy_c_buf_p) = yy_cp -= 1;
 YY_DO_BEFORE_ACTION; /* set up zconftext again */
 YY_RULE_SETUP
+#line 220 "scripts/kconfig/zconf.l"
 {
 		current_file->lineno++;
 		zconf_endhelp();
@@ -2597,6 +2673,7 @@
 case 62:
 /* rule 62 can match eol */
 YY_RULE_SETUP
+#line 225 "scripts/kconfig/zconf.l"
 {
 		current_file->lineno++;
 		append_string("\n", 1);
@@ -2604,6 +2681,7 @@
 	YY_BREAK
 case 63:
 YY_RULE_SETUP
+#line 229 "scripts/kconfig/zconf.l"
 {
 		append_string(zconftext, zconfleng);
 		if (!first_ts)
@@ -2611,6 +2689,7 @@
 	}
 	YY_BREAK
 case YY_STATE_EOF(HELP):
+#line 234 "scripts/kconfig/zconf.l"
 {
 		zconf_endhelp();
 		return T_HELPTEXT;
@@ -2619,6 +2698,7 @@
 
 case YY_STATE_EOF(INITIAL):
 case YY_STATE_EOF(COMMAND):
+#line 240 "scripts/kconfig/zconf.l"
 {
 	if (current_buf) {
 		zconf_endfile();
@@ -2630,8 +2710,10 @@
 	YY_BREAK
 case 64:
 YY_RULE_SETUP
+#line 249 "scripts/kconfig/zconf.l"
 YY_FATAL_ERROR( "flex scanner jammed" );
 	YY_BREAK
+#line 2717 "scripts/kconfig/lex.zconf.c"
 
 	case YY_END_OF_BUFFER:
 		{
@@ -3566,6 +3648,8 @@
 #undef YY_DECL_IS_OURS
 #undef YY_DECL
 #endif
+#line 249 "scripts/kconfig/zconf.l"
+
 
 void zconf_starthelp(void)
 {
@@ -3580,6 +3664,7 @@
 	BEGIN(INITIAL);
 }
 
+
 /*
  * Try to open specified file with following names:
  * ./name
@@ -3622,16 +3707,31 @@
 
 void zconf_nextfile(const char *name)
 {
-	struct file *file = file_lookup(name);
-	struct buffer *buf = malloc(sizeof(*buf));
-	memset(buf, 0, sizeof(*buf));
+	FILE *nextfile;
+	struct file *file;
+	struct buffer *buf;
+
+	if(zconf_print_sources)
+		printf("KDEP %s\n", name);
+
+	nextfile = zconf_fopen(name);
+	if (!nextfile) {
+		/* If we're just here to find filenames, it's not fatal
+		 * for a file to be missing...
+		 */
+		if(zconf_print_sources)
+			return;
 
-	current_buf->state = YY_CURRENT_BUFFER;
-	zconfin = zconf_fopen(name);
-	if (!zconfin) {
 		printf("%s:%d: can't open file \"%s\"\n", zconf_curname(), zconf_lineno(), name);
 		exit(1);
 	}
+
+	file = file_lookup(name);
+	buf = malloc(sizeof(*buf));
+	memset(buf, 0, sizeof(*buf));
+
+	current_buf->state = YY_CURRENT_BUFFER;
+	zconfin = nextfile;
 	zconf_switch_to_buffer(zconf_create_buffer(zconfin,YY_BUF_SIZE));
 	buf->parent = current_buf;
 	current_buf = buf;
diff -Nru a/scripts/kconfig/listkconfigs.c b/scripts/kconfig/listkconfigs.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/scripts/kconfig/listkconfigs.c	Tue Mar  2 13:19:31 2004
@@ -0,0 +1,22 @@
+/*
+ * Copyright (C) 2003 David Dillow <dave@thedillows.org>
+ * Released under the terms of the GNU GPL, see COPYING for details
+ */
+#include <stdio.h>
+#include <stdlib.h>
+
+#define LKC_DIRECT_LINK
+#include "lkc.h"
+
+int main(int argc, char **argv)
+{
+	if(argc != 2) {
+		fprintf(stderr, "usage: %s inputfile\n", argv[0]);
+		exit(2);
+	}
+
+	/* tell the zconf parser to just print the files we source */
+	zconf_print_sources = 1;
+	conf_parse(argv[1]);
+	exit(0);
+}
diff -Nru a/scripts/kconfig/lkc.h b/scripts/kconfig/lkc.h
--- a/scripts/kconfig/lkc.h	Tue Mar  2 13:19:31 2004
+++ b/scripts/kconfig/lkc.h	Tue Mar  2 13:19:31 2004
@@ -34,6 +34,8 @@
 int zconf_lineno(void);
 char *zconf_curname(void);
 
+extern int zconf_print_sources;
+
 /* confdata.c */
 extern const char conf_def_filename[];
 extern char conf_filename[];
diff -Nru a/scripts/kconfig/zconf.l b/scripts/kconfig/zconf.l
--- a/scripts/kconfig/zconf.l	Tue Mar  2 13:19:31 2004
+++ b/scripts/kconfig/zconf.l	Tue Mar  2 13:19:31 2004
@@ -34,6 +34,8 @@
 static void zconf_endhelp(void);
 static struct buffer *zconf_endfile(void);
 
+int zconf_print_sources;
+
 void new_string(void)
 {
 	text = malloc(START_STRSIZE);
@@ -301,16 +303,31 @@
 
 void zconf_nextfile(const char *name)
 {
-	struct file *file = file_lookup(name);
-	struct buffer *buf = malloc(sizeof(*buf));
-	memset(buf, 0, sizeof(*buf));
+	FILE *nextfile;
+	struct file *file;
+	struct buffer *buf;
+
+	if(zconf_print_sources)
+		printf("KDEP %s\n", name);
+
+	nextfile = zconf_fopen(name);
+	if (!nextfile) {
+		/* If we're just here to find filenames, it's not fatal
+		 * for a file to be missing...
+		 */
+		if(zconf_print_sources)
+			return;
 
-	current_buf->state = YY_CURRENT_BUFFER;
-	yyin = zconf_fopen(name);
-	if (!yyin) {
 		printf("%s:%d: can't open file \"%s\"\n", zconf_curname(), zconf_lineno(), name);
 		exit(1);
 	}
+
+	file = file_lookup(name);
+	buf = malloc(sizeof(*buf));
+	memset(buf, 0, sizeof(*buf));
+
+	current_buf->state = YY_CURRENT_BUFFER;
+	yyin = nextfile;
 	yy_switch_to_buffer(yy_create_buffer(yyin, YY_BUF_SIZE));
 	buf->parent = current_buf;
 	current_buf = buf;

--=-D6cTBLB+S3RU1bwTZJkY--

