Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262011AbVDEUb0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262011AbVDEUb0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 16:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262010AbVDEU2j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 16:28:39 -0400
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:39337 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S261984AbVDEUGP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 16:06:15 -0400
Message-Id: <20050405194446.555492000@delft.aura.cs.cmu.edu>
References: <20050405193859.506836000@delft.aura.cs.cmu.edu>
Date: Tue, 05 Apr 2005 15:39:04 -0400
From: Jan Harkes <jaharkes@cs.cmu.edu>
To: Greg KH <greg@kroah.com>, Sam Ravnborg <sam@ravnborg.org>
Cc: jaharkes@cs.cmu.edu, Dmitry Torokhov <dtor_core@ameritech.net>,
       Marcel Holtmann <marcel@holtmann.org>, linux-kernel@vger.kernel.org
Subject: [patch 5/5] Hotplug firmware loader for Keyspan usb-serial driver
Content-Disposition: inline; filename=keyspan-install_fw
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add "make install_firmware" to the kbuild environment.

Signed-off-by: Jan Harkes <jaharkes@cs.cmu.edu>


 Makefile                    |   33 +++++++++++++++++++++++++++++++++
 drivers/usb/serial/Makefile |    5 +++++
 scripts/Makefile.fwinst     |   34 ++++++++++++++++++++++++++++++++++
 3 files changed, 72 insertions(+)

Index: linux/scripts/Makefile.fwinst
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux/scripts/Makefile.fwinst	2005-04-05 14:36:56.000000000 -0400
@@ -0,0 +1,34 @@
+# ==========================================================================
+# Installing firmware
+# ==========================================================================
+
+src := $(obj)
+
+.PHONY: __fwinst
+__fwinst:
+
+-include .config
+include $(if $(wildcard $(obj)/Kbuild), $(obj)/Kbuild, $(obj)/Makefile)
+include scripts/Makefile.lib
+
+firmware	:= $(fw-y) $(fw-m)
+firmware	:= $(addprefix $(src)/, $(firmware))
+
+# =====================================================================
+
+.PHONY: $(firmware)
+__fwinst: $(firmware) $(subdir-ym)
+	@:
+
+quiet_cmd_firmware_install = INSTALL $@
+      cmd_firmware_install = mkdir -p $(2); cp $@ $(2)
+
+$(firmware):
+	$(call cmd,firmware_install,$(MODLIB)/firmware)
+
+# =====================================================================
+
+.PHONY: $(subdir-ym)
+$(subdir-ym):
+	$(Q)$(MAKE) -f $(if $(KBUILD_SRC),$(srctree)/)scripts/Makefile.fwinst obj=$@
+
Index: linux/Makefile
===================================================================
--- linux.orig/Makefile	2005-03-29 16:19:14.000000000 -0500
+++ linux/Makefile	2005-04-05 14:42:42.000000000 -0400
@@ -927,6 +927,21 @@ modules modules_install: FORCE
 
 endif # CONFIG_MODULES
 
+# ---------------------------------------------------------------------------
+# Firmware
+
+fwinst-dirs      := $(addprefix _fwinst_,$(vmlinux-dirs))
+
+.PHONY: $(fwinst-dirs) _fwinst_ firmware_install
+$(fwinst-dirs):
+	$(Q)$(MAKE) $(fwinst)=$(patsubst _fwinst_%,%,$@)
+
+_fwinst_:
+	@rm -rf $(MODLIB)/firmware
+	@mkdir -p $(MODLIB)/firmware
+
+firmware_install: _fwinst_ $(fwinst-dirs)
+
 # Generate asm-offsets.h 
 # ---------------------------------------------------------------------------
 
@@ -1042,6 +1057,7 @@ help:
 	@echo  '* vmlinux	  - Build the bare kernel'
 	@echo  '* modules	  - Build all modules'
 	@echo  '  modules_install - Install all modules'
+	@echo  '  firmware_install- Install all firmware'
 	@echo  '  dir/            - Build all files in dir and below'
 	@echo  '  dir/file.[ois]  - Build specified target only'
 	@echo  '  rpm		  - Build a kernel as an RPM package'
@@ -1101,6 +1117,10 @@ else # KBUILD_EXTMOD
 # make M=dir modules_install
 #                      Install the modules build in the module directory
 #                      Assumes install directory is already created
+# make M=dir firmware_install
+#                      Install the firmware in the firmware directory
+#                      Assumes install directory is already created
+
 
 # We are always building modules
 KBUILD_MODULES := 1
@@ -1129,6 +1149,13 @@ modules: $(module-dirs)
 modules_install:
 	$(Q)$(MAKE) -rR -f $(srctree)/scripts/Makefile.modinst
 
+fwinst-dirs := $(addprefix _fwinst_,$(KBUILD_EXTMOD))
+.PHONY: $(fwinst-dirs) firmware_install
+$(fwinst-dirs):
+	$(Q)$(MAKE) $(fwinst)=$(patsubst _fwinst_%,%,$@)
+
+firmware_install: $(fwinst-dirs)
+
 clean-dirs := $(addprefix _clean_,$(KBUILD_EXTMOD))
 
 .PHONY: $(clean-dirs) clean
@@ -1149,6 +1176,7 @@ help:
 	@echo  ''
 	@echo  '  modules         - default target, build the module(s)'
 	@echo  '  modules_install - install the module'
+	@echo  '  firmware_install- install firmware'
 	@echo  '  clean           - remove generated files in module directory only'
 	@echo  ''
 endif # KBUILD_EXTMOD
@@ -1346,6 +1374,11 @@ build := -f $(if $(KBUILD_SRC),$(srctree
 # $(Q)$(MAKE) $(clean)=dir
 clean := -f $(if $(KBUILD_SRC),$(srctree)/)scripts/Makefile.clean obj
 
+# Shorthand for $(Q)$(MAKE) -f scripts/Makefile.fwinst obj=dir
+# Usage:
+# $(Q)$(MAKE) $(fwinst)=dir
+fwinst := -f $(if $(KBUILD_SRC),$(srctree)/)scripts/Makefile.fwinst obj
+
 #	$(call descend,<dir>,<target>)
 #	Recursively call a sub-make in <dir> with target <target>
 # Usage is deprecated, because make does not see this as an invocation of make.
Index: linux/drivers/usb/serial/Makefile
===================================================================
--- linux.orig/drivers/usb/serial/Makefile	2005-03-10 16:01:14.000000000 -0500
+++ linux/drivers/usb/serial/Makefile	2005-04-05 13:01:54.000000000 -0400
@@ -36,3 +36,8 @@ obj-$(CONFIG_USB_SERIAL_VISOR)			+= viso
 obj-$(CONFIG_USB_SERIAL_WHITEHEAT)		+= whiteheat.o
 obj-$(CONFIG_USB_SERIAL_XIRCOM)			+= keyspan_pda.o
 
+fw-$(CONFIG_USB_SERIAL_KEYSPAN)			+= \
+	keyspan-mpr.fw     keyspan-usa18x.fw  keyspan-usa19.fw \
+	keyspan-usa19qi.fw keyspan-usa19qw.fw keyspan-usa19w.fw \
+	keyspan-usa28.fw   keyspan-usa28x.fw  keyspan-usa28xa.fw \
+	keyspan-usa28xb.fw keyspan-usa49w.fw  keyspan-usa49wlc.fw

--

