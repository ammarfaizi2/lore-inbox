Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268482AbUIFTJx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268482AbUIFTJx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 15:09:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268480AbUIFTJw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 15:09:52 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:62519 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S268472AbUIFTJS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 15:09:18 -0400
Date: Mon, 6 Sep 2004 21:12:35 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: kbuild: Simplify vmlinux generation
Message-ID: <20040906191235.GC8230@mars.ravnborg.org>
Mail-Followup-To: Horst von Brand <vonbrand@inf.utfsm.cl>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040905201235.GC16901@mars.ravnborg.org> <200409061841.i86Ifdnj008952@laptop11.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409061841.i86Ifdnj008952@laptop11.inf.utfsm.cl>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 06, 2004 at 02:41:39PM -0400, Horst von Brand wrote:
> Sam Ravnborg <sam@ravnborg.org> said:
> 
> [...]
> 
> Some comments interspersed.


To address the lock-up issue Andrew hit I dropped the built-in.o intermidiate
step.
Will be pushed out if I receive a success report.

	Sam
	
Following patch apply on top of the last posted:

===== Makefile 1.531 vs edited =====
--- 1.531/Makefile	2004-09-06 20:22:01 +02:00
+++ edited/Makefile	2004-09-06 21:04:01 +02:00
@@ -545,7 +545,7 @@
 
 # Build vmlinux
 # ---------------------------------------------------------------------------
-# vmlinux is build from the objects seleted by $(vmlinux-init) and
+# vmlinux is build from the objects selected by $(vmlinux-init) and
 # $(vmlinux-main). Most are built-in.o files from top-level directories
 # in the kernel tree, others are specified in arch/$(ARCH)Makefile.
 # Ordering when linking is important, and $(vmlinux-init) must be first.
@@ -556,30 +556,33 @@
 #   +-< $(vmlinux-init)
 #   |   +--< init/version.o + more
 #   |
-#   +-< built-in.o
-#   |   +--< $(vmlinux-main)
-#   |        +--< driver/built-in.o mm/built-in.o + more
+#   +--< $(vmlinux-main)
+#   |    +--< driver/built-in.o mm/built-in.o + more
 #   |
 #   +-< kallsyms.o (see description in CONFIG_KALLSYMS section)
 #
-# vmlinux version cannot be updated during normal descending-into-subdirs
-# phase since we do not yet know if we need to update vmlinux.
+# vmlinux version (uname -v) cannot be updated during normal
+# descending-into-subdirs phase since we do not yet know if we need to
+# update vmlinux.
 # Therefore this step is delayed until just before final link of vmlinux -
-# except in kallsyms case where it is done just before adding the
+# except in the kallsyms case where it is done just before adding the
 # symbols to the kernel.
 #
 # System.map is generated to document addresses of all kernel symbols
 
 vmlinux-init := $(head-y) $(init-y)
 vmlinux-main := $(core-y) $(libs-y) $(drivers-y) $(net-y)
-vmlinux-all  := $(vmlinux-init) built-in.o
+vmlinux-all  := $(vmlinux-init) $(vmlinux-main)
 vmlinux-lds  := arch/$(ARCH)/kernel/vmlinux.lds
 
 # Rule to link vmlinux - also used during CONFIG_KALLSYMS
 # May be overridden by arch/$(ARCH)/Makefile
+# Require first prerequisite to be the lds file
 quiet_cmd_vmlinux__  = LD      $@
-      cmd_vmlinux__  = $(LD) $(LDFLAGS) $(LDFLAGS_vmlinux) \
-                           -T $(filter-out FORCE, $^) -o $@
+      cmd_vmlinux__  = $(LD) $(LDFLAGS) $(LDFLAGS_vmlinux) -o $@ \
+      -T $(vmlinux-lds) $(vmlinux-init)                          \
+      --start-group $(vmlinux-main) --end-group                  \
+      $(filter-out $(vmlinux-lds) $(vmlinux-init) $(vmlinux-main) FORCE ,$^)
 
 # Generate new vmlinux version
 quiet_cmd_vmlinux_version = GEN     .version
@@ -619,7 +622,7 @@
 # o .tmp_vmlinux1 has all symbols and sections, but __kallsyms is
 #   empty
 #   Running kallsyms on that gives us .tmp_kallsyms1.o with
-#   the right size - vmlinux version updated during this step
+#   the right size - vmlinux version (uname -v) is updated during this step
 # o .tmp_vmlinux2 now has a __kallsyms section of the right size,
 #   but due to the added section, some addresses have shifted.
 #   From here, we generate a correct .tmp_kallsyms2.o
@@ -684,19 +687,8 @@
 endif # ifdef CONFIG_KALLSYMS
 
 # vmlinux image - including updated kernel symbols
-vmlinux: $(vmlinux-lds) $(vmlinux-init) built-in.o $(kallsyms.o) FORCE
+vmlinux: $(vmlinux-lds) $(vmlinux-init) $(vmlinux-main) $(kallsyms.o) FORCE
 	$(call if_changed_rule,vmlinux__)
-
-# Link $(vmlinux-main) to speed up rest of build phase. No need to
-# relink this part too many times.
-# Use start/end-group to make sure to resolve all possible symbols
-quiet_rule_vmlinux_partial = LD      $@
-       cmd_vmlinux_partial = $(LD) $(LDFLAGS) $(LDFLAGS_$(*F)) -r \
-                                   --start-group $(filter-out FORCE, $^) \
-				   --end-group -o $@
-				   
-built-in.o: $(vmlinux-main) FORCE
-	$(call if_changed,vmlinux_partial)
 
 # The actual objects are generated when descending, 
 # make sure no implicit rule kicks in
