Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267765AbUHRVIj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267765AbUHRVIj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 17:08:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267746AbUHRVI1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 17:08:27 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:50478 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S267760AbUHRVFX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 17:05:23 -0400
Date: Thu, 19 Aug 2004 01:05:38 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org
Subject: kbuild: make C=2 forces sparse run
Message-ID: <20040818230538.GC23495@mars.ravnborg.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20040818230252.GA23495@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040818230252.GA23495@mars.ravnborg.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/08/17 23:02:08+02:00 sam@mars.ravnborg.org 
#   kbuild: make C=2 now force sparse to be run for all .c files
#   
#   With make C=2 sparse ($(CHECK)) will be run on all .c files also if they
#   do not need to be compiled.
#   Usefull to run sparse on a fully compiled kernel tree.
#   Implemented on request from Al Viro (although he liked to be able to
#   run sparse without building any source).
#   
#   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
# 
# scripts/Makefile.build
#   2004/08/17 23:01:51+02:00 sam@mars.ravnborg.org +9 -2
#   Allow sparse to be forced to be used - for all .c files.
# 
# Makefile
#   2004/08/17 23:01:51+02:00 sam@mars.ravnborg.org +2 -1
#   Document how to force use of sparse, even when no source needs to be compiled.
# 
diff -Nru a/Makefile b/Makefile
--- a/Makefile	2004-08-19 01:05:30 +02:00
+++ b/Makefile	2004-08-19 01:05:30 +02:00
@@ -958,7 +958,8 @@
 
 	@echo  '  make V=0|1 [targets] 0 => quiet build (default), 1 => verbose build'
 	@echo  '  make O=dir [targets] Locate all output files in "dir", including .config'
-	@echo  '  make C=1   [targets] Check all c source with checker tool'
+	@echo  '  make C=1   [targets] Check all c source with $$CHECK (sparse)'
+	@echo  '  make C=2   [targets] Force check of all c source with $$CHECK (sparse)'
 	@echo  ''
 	@echo  'Execute "make" or "make all" to build all targets marked with [*] '
 	@echo  'For further info see the ./README file'
diff -Nru a/scripts/Makefile.build b/scripts/Makefile.build
--- a/scripts/Makefile.build	2004-08-19 01:05:30 +02:00
+++ b/scripts/Makefile.build	2004-08-19 01:05:30 +02:00
@@ -83,8 +83,13 @@
 
 # Linus' kernel sanity checking tool
 ifneq ($(KBUILD_CHECKSRC),0)
-quiet_cmd_checksrc = CHECK   $<
-      cmd_checksrc = $(CHECK) $(c_flags) $< ;
+  ifeq ($(KBUILD_CHECKSRC),2)
+    quiet_cmd_force_checksrc = CHECK   $<
+          cmd_force_checksrc = $(CHECK) $(c_flags) $< ;
+  else
+      quiet_cmd_checksrc     = CHECK   $<
+            cmd_checksrc     = $(CHECK) $(c_flags) $< ;
+  endif
 endif
 
 
@@ -182,11 +187,13 @@
 # Built-in and composite module parts
 
 %.o: %.c FORCE
+	$(call cmd,force_checksrc)
 	$(call if_changed_rule,cc_o_c)
 
 # Single-part modules are special since we need to mark them in $(MODVERDIR)
 
 $(single-used-m): %.o: %.c FORCE
+	$(call cmd,force_checksrc)
 	$(call if_changed_rule,cc_o_c)
 	@{ echo $(@:.o=.ko); echo $@; } > $(MODVERDIR)/$(@F:.o=.mod)
 
