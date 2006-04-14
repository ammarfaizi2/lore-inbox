Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965010AbWDNPGK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965010AbWDNPGK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 11:06:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964995AbWDNPGK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 11:06:10 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:58249 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S964992AbWDNPGI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 11:06:08 -0400
Subject: [PATCH] make: add modules_update target
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: kbuild-devel@lists.sourceforge.net
Cc: dustin.kirkland@us.ibm.com, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 14 Apr 2006 10:06:56 -0500
Message-Id: <1145027216.12054.164.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a a patch that adds a kernel build target called
"modules_update".  

The existing "modules_install" target blows away the entire 
/lib/modules/`uname -r`/kernel directory and copies out every single
module when called at the top level.

This new "modules_update" target only copies out modules that have
changed, using "cp -u".  This less zealous method is a more efficient
approach to module installation for kernel developers working on single,
or small numbers of modules.  

Where "make modules_install" was taking ~ 3 minutes, "make
modules_update" is taking < 1 minute, as a rough benchmark.

Signed-off-by: Kylie Hall <kjhall@us.ibm.com>
Signed-off-by: Dustin Kirkland <dustin.kirkland@us.ibm.com>
---
 Makefile                 |   34 ++++++++++++++++++++++++++++++++++
 scripts/Makefile.modupdt |   29 +++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+)

--- linux-2.6.15-rc5/Makefile	2005-12-03 23:10:42.000000000 -0600
+++ linux-2.6.15-rc5-mm3/Makefile	2006-04-13 12:05:26.000000000 -0500
@@ -922,6 +919,40 @@ modules: $(vmlinux-dirs) $(if $(KBUILD_B
 .PHONY: modules_prepare
 modules_prepare: prepare scripts
 
+# Target to update modules
+.PHONY: modules_update
+modules_update: _modupdt_ _modupdt_post
+
+.PHONY: _modupdt_
+_modupdt_:
+	@if [ -z "`$(DEPMOD) -V 2>/dev/null | grep module-init-tools`" ]; then \
+		echo "Warning: you may need to install module-init-tools"; \
+		echo "See http://www.codemonkey.org.uk/docs/post-halloween-2.6.txt";\
+		sleep 1; \
+	fi
+	@rm -f $(MODLIB)/source
+	@mkdir -p $(MODLIB)/kernel
+	@ln -s $(srctree) $(MODLIB)/source
+	@if [ ! $(objtree) -ef  $(MODLIB)/build ]; then \
+		rm -f $(MODLIB)/build ; \
+		ln -s $(objtree) $(MODLIB)/build ; \
+	fi
+	$(Q)$(MAKE) -rR -f $(srctree)/scripts/Makefile.modupdt
+
+# If System.map exists, run depmod.  This deliberately does not have a
+# dependency on System.map since that would run the dependency tree on
+# vmlinux.  This depmod is only for convenience to give the initial
+# boot a modules.dep even before / is mounted read-write.  However the
+# boot script depmod is the master version.
+ifeq "$(strip $(INSTALL_MOD_PATH))" ""
+depmod_opts	:=
+else
+depmod_opts	:= -b $(INSTALL_MOD_PATH) -r
+endif
+.PHONY: _modupdt_post
+_modupdt_post: _modupdt_
+	if [ -r System.map -a -x $(DEPMOD) ]; then $(DEPMOD) -ae -F System.map $(depmod_opts) $(KERNELRELEASE); fi
+
 # Target to install modules
 .PHONY: modules_install
 modules_install: _modinst_ _modinst_post
--- linux-2.6.15-rc5/scripts/Makefile.modupdt	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.15-rc5-mm3/scripts/Makefile.modupdt	2006-04-13 13:37:24.000000000 -0500
@@ -0,0 +1,29 @@
+# ==========================================================================
+# Installing modules
+# ==========================================================================
+
+.PHONY: __modupdt
+__modupdt:
+
+include scripts/Kbuild.include
+
+#
+
+__modules := $(sort $(shell grep -h '\.ko' /dev/null $(wildcard $(MODVERDIR)/*.mod)))
+modules := $(patsubst %.o,%.ko,$(wildcard $(__modules:.ko=.o)))
+
+.PHONY: $(modules)
+__modupdt: $(modules)
+	@:
+
+      cmd_modules_update = mkdir -p $(2); cp -vu $@ $(2) | $(AWK) -F"'" '{print $$1}' | sed "s/\`/  UPDATE /"
+
+# Modules built outside the kernel source tree go into extra by default
+INSTALL_MOD_DIR ?= extra
+ext-mod-dir = $(INSTALL_MOD_DIR)$(subst $(KBUILD_EXTMOD),,$(@D))
+
+modinst_dir = $(if $(KBUILD_EXTMOD),$(ext-mod-dir),kernel/$(@D))
+
+$(modules):
+	$(call cmd,modules_update,$(MODLIB)/$(modinst_dir))
+


