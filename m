Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751390AbWFVDV2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751390AbWFVDV2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 23:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751489AbWFVDV2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 23:21:28 -0400
Received: from mx1.redhat.com ([66.187.233.31]:14728 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751390AbWFVDV1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 23:21:27 -0400
Date: Thu, 22 Jun 2006 12:21:20 +0900 (JST)
Message-Id: <20060622.122120.261356707.yamato@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: Adding symbols in Kconfig and defconfig to TAGS
From: Masatake YAMATO <jet@gyve.org>
X-Mailer: Mew version 4.2.53 on Emacs 22.0.51 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm using TAGS generated from "make TAGS" to read the kernel source code.

When I met a ifdef block

	  #ifdef CONFIG_FOO
	  	 ...
	  #endif

in the soruce code I would like to know the meaning CONFIG_FOO
to decide whether I should read inside the ifdef block
or not. meaning CONFIG_FOO is well documented in Kconfig.
So it is nice if I can jump to CONFIG_FOO entry in Kconfig
from "#ifdef CONFIG_FOO" with the tag jump.

Here is the patch to add symbols in Kconfig and defconfig to TAGS
in "make TAGS" operation.

Signed-off-by: Masatake YAMATO <jet@gyve.org>

diff --git a/Makefile b/Makefile
index 1700d3f..c2e177e 100644
--- a/Makefile
+++ b/Makefile
@@ -1181,25 +1181,35 @@ endif
 
 ALLSOURCE_ARCHS := $(ARCH)
 
-define all-sources
-	( find $(__srctree) $(RCS_FIND_IGNORE) \
+define find-sources
+        ( find $(__srctree) $(RCS_FIND_IGNORE) \
 	       \( -name include -o -name arch \) -prune -o \
-	       -name '*.[chS]' -print; \
+	       -name $1 -print; \
 	  for ARCH in $(ALLSOURCE_ARCHS) ; do \
 	       find $(__srctree)arch/$${ARCH} $(RCS_FIND_IGNORE) \
-	            -name '*.[chS]' -print; \
+	            -name $1 -print; \
 	  done ; \
 	  find $(__srctree)security/selinux/include $(RCS_FIND_IGNORE) \
-	       -name '*.[chS]' -print; \
+	       -name $1 -print; \
 	  find $(__srctree)include $(RCS_FIND_IGNORE) \
 	       \( -name config -o -name 'asm-*' \) -prune \
-	       -o -name '*.[chS]' -print; \
+	       -o -name $1 -print; \
 	  for ARCH in $(ALLINCLUDE_ARCHS) ; do \
 	       find $(__srctree)include/asm-$${ARCH} $(RCS_FIND_IGNORE) \
-	            -name '*.[chS]' -print; \
+	            -name $1 -print; \
 	  done ; \
 	  find $(__srctree)include/asm-generic $(RCS_FIND_IGNORE) \
-	       -name '*.[chS]' -print )
+	       -name $1 -print )
+endef
+
+define all-sources
+	$(call find-sources,'*.[chS]')
+endef
+define all-kconfigs
+	$(call find-sources,'Kconfig*')
+endef
+define all-defconfigs
+	$(call find-sources,'defconfig')
 endef
 
 quiet_cmd_cscope-file = FILELST cscope.files
@@ -1219,7 +1229,11 @@ define cmd_TAGS
                 echo "-I __initdata,__exitdata,__acquires,__releases  \
                       -I EXPORT_SYMBOL,EXPORT_SYMBOL_GPL              \
                       --extra=+f --c-kinds=+px"`;                     \
-                $(all-sources) | xargs etags $$ETAGSF -a
+                $(all-sources) | xargs etags $$ETAGSF -a;             \
+	if test "x$$ETAGSF" = x; then                                 \
+		$(all-kconfigs)   | xargs etags -a --regex='/^config[ \t]+\([a-zA-Z0-9_]+\)/\1/';  \
+		$(all-defconfigs) | xargs etags -a --regex='/^#?[ \t]?\(CONFIG_[a-zA-Z0-9_]+\)/\1/'; \
+	fi
 endef
 
 TAGS: FORCE
