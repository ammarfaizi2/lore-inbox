Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264633AbUGVMpp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264633AbUGVMpp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 08:45:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265199AbUGVMpp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 08:45:45 -0400
Received: from pxy1allmi.all.mi.charter.com ([24.247.15.38]:10423 "EHLO
	proxy1.gha.chartermi.net") by vger.kernel.org with ESMTP
	id S264633AbUGVMph (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 08:45:37 -0400
Message-ID: <40FFB6D4.30908@quark.didntduck.org>
Date: Thu, 22 Jul 2004 08:45:08 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040625
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] Move modpost files to a new subdir [2/2]
Content-Type: multipart/mixed;
 boundary="------------000903060602000601030602"
X-Charter-Information: 
X-Charter-Scan: 
X-Charter-Score: s
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000903060602000601030602
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Fix up path names and Makefiles for modpost.

--
				Brian Gerst

--------------000903060602000601030602
Content-Type: text/plain;
 name="modpost-1b"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="modpost-1b"

diff -urN linux-mv/scripts/Makefile linux/scripts/Makefile
--- linux-mv/scripts/Makefile	2004-07-18 12:27:55.937519106 -0400
+++ linux/scripts/Makefile	2004-07-18 12:37:24.735893892 -0400
@@ -5,24 +5,11 @@
 # docproc: 	 Preprocess .tmpl file in order to generate .sgml docs
 # conmakehash:	 Create arrays for initializing the kernel console tables
 
-host-progs	:= conmakehash kallsyms modpost mk_elfconfig pnmtologo bin2c
-always		:= $(host-progs) empty.o
-
-modpost-objs	:= modpost.o file2alias.o sumversion.o
+host-progs	:= conmakehash kallsyms pnmtologo bin2c
+always		:= $(host-progs)
 
 subdir-$(CONFIG_MODVERSIONS)	+= genksyms
+subdir-y	+= modpost
 
 # Let clean descend into subdirs
 subdir-	+= basic lxdialog kconfig package
-
-# dependencies on generated files need to be listed explicitly
-
-$(obj)/modpost.o $(obj)/file2alias.o $(obj)/sumversion.o: $(obj)/elfconfig.h
-
-quiet_cmd_elfconfig = MKELF   $@
-      cmd_elfconfig = $(obj)/mk_elfconfig $(ARCH) < $< > $@
-
-$(obj)/elfconfig.h: $(obj)/empty.o $(obj)/mk_elfconfig FORCE
-	$(call if_changed,elfconfig)
-
-targets += elfconfig.h
diff -urN linux-mv/scripts/Makefile.modpost linux/scripts/Makefile.modpost
--- linux-mv/scripts/Makefile.modpost	2004-07-18 12:27:55.937519106 -0400
+++ linux/scripts/Makefile.modpost	2004-07-18 12:45:50.139036800 -0400
@@ -50,7 +50,7 @@
 # Step 2), invoke modpost
 #  Includes step 3,4
 quiet_cmd_modpost = MODPOST
-      cmd_modpost = scripts/modpost \
+      cmd_modpost = scripts/modpost/modpost \
 	$(if $(KBUILD_EXTMOD),-i,-o) $(symverfile) \
 	$(filter-out FORCE,$^)
 
diff -urN linux-mv/scripts/modpost/file2alias.c linux/scripts/modpost/file2alias.c
--- linux-mv/scripts/modpost/file2alias.c	2004-06-23 18:05:42.000000000 -0400
+++ linux/scripts/modpost/file2alias.c	2004-07-19 10:08:54.244446008 -0400
@@ -27,7 +27,7 @@
 /* Big exception to the "don't include kernel headers into userspace, which
  * even potentially has different endianness and word sizes, since 
  * we handle those differences explicitly below */
-#include "../include/linux/mod_devicetable.h"
+#include "../../include/linux/mod_devicetable.h"
 
 #define ADD(str, sep, cond, field)                              \
 do {                                                            \
diff -urN linux-mv/scripts/modpost/Makefile linux/scripts/modpost/Makefile
--- linux-mv/scripts/modpost/Makefile	1969-12-31 19:00:00.000000000 -0500
+++ linux/scripts/modpost/Makefile	2004-07-19 10:09:08.304389355 -0400
@@ -0,0 +1,16 @@
+host-progs	:= modpost mk_elfconfig
+always		:= $(host-progs) empty.o
+
+modpost-objs	:= modpost.o file2alias.o sumversion.o
+
+# dependencies on generated files need to be listed explicitly
+
+$(obj)/modpost.o $(obj)/file2alias.o $(obj)/sumversion.o: $(obj)/elfconfig.h
+
+quiet_cmd_elfconfig = MKELF   $@
+      cmd_elfconfig = $(obj)/mk_elfconfig $(ARCH) < $< > $@
+
+$(obj)/elfconfig.h: $(obj)/empty.o $(obj)/mk_elfconfig FORCE
+	$(call if_changed,elfconfig)
+
+targets += elfconfig.h

--------------000903060602000601030602--
