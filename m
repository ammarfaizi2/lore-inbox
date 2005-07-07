Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261226AbVGGPcw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261226AbVGGPcw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 11:32:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261296AbVGGL1a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 07:27:30 -0400
Received: from coderock.org ([193.77.147.115]:23946 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261295AbVGGL0z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 07:26:55 -0400
Message-Id: <20050707112634.943174000@homer>
References: <20050707112551.331553000@homer>
Date: Thu, 07 Jul 2005 13:25:53 +0200
From: domen@coderock.org
To: linux-kernel@vger.kernel.org
Cc: damm@opensource.se, domen@coderock.org
Subject: [patch 2/5] autoparam: makefile
Content-Disposition: inline; filename=autoparam_2-makefile
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Domen Puncer <domen@coderock.org>


Build .kernel-parameters.o when vmlinux is (re)built.
Add target "kernelparams" which generates descriptions of parameters
in Documentation/kernel-parameters-gen.txt

Signed-off-by: Domen Puncer <domen@coderock.org>

 Makefile |   24 +++++++++++++++++++++++-
 1 files changed, 23 insertions(+), 1 deletion(-)

Index: a/Makefile
===================================================================
--- a.orig/Makefile
+++ a/Makefile
@@ -650,6 +650,7 @@ define rule_vmlinux__
 		/bin/false;                             \
 	fi;
 	$(verify_kallsyms)
+	$(extract_kernel_parameters)
 endef
 
 
@@ -916,6 +917,15 @@ modules modules_install: FORCE
 
 endif # CONFIG_MODULES
 
+# Extract kernel parameters
+# ---------------------------------------------------------------------------
+
+define extract_kernel_parameters
+	$(Q)$(OBJCOPY) -j __param_strings $(objtree)/vmlinux -O binary \
+		$(objtree)/.kernel-parameters.o
+	$(Q)$(OBJCOPY) -R __param_strings $(objtree)/vmlinux $(objtree)/vmlinux
+endef
+
 # Generate asm-offsets.h 
 # ---------------------------------------------------------------------------
 
@@ -946,7 +956,8 @@ endef
 # Directories & files removed with 'make clean'
 CLEAN_DIRS  += $(MODVERDIR)
 CLEAN_FILES +=	vmlinux System.map \
-                .tmp_kallsyms* .tmp_version .tmp_vmlinux* .tmp_System.map
+                .tmp_kallsyms* .tmp_version .tmp_vmlinux* .tmp_System.map \
+		.kernel-parameters.o
 
 # Directories & files removed with 'make mrproper'
 MRPROPER_DIRS  += include/config include2
@@ -1048,6 +1059,8 @@ help:
 	@echo  ''
 	@echo  'Documentation targets:'
 	@$(MAKE) -f $(srctree)/Documentation/DocBook/Makefile dochelp
+	@echo  '  kernelparams    - Generates list of boot parameters in'
+	@echo  '                    Documentation/kernel-parameters-gen.txt'
 	@echo  ''
 	@echo  'Architecture specific targets ($(ARCH)):'
 	@$(if $(archhelp),$(archhelp),\
@@ -1142,6 +1155,15 @@ help:
 	@echo  ''
 endif # KBUILD_EXTMOD
 
+
+kernelparams:
+	$(Q)if [ ! -f $(objtree)/.kernel-parameters.o ]; then \
+		echo "You have to build a kernel (vmlinux) first."; \
+		exit 1; \
+	fi
+	$(O)$(PERL) -w $(srctree)/scripts/kernelparams.pl $(objtree)/.kernel-parameters.o \
+		> $(srctree)/Documentation/kernel-parameters-gen.txt
+
 # Generate tags for editors
 # ---------------------------------------------------------------------------
 

--
