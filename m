Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932573AbWHHIb1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932573AbWHHIb1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 04:31:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932579AbWHHIb1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 04:31:27 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:55002 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S932573AbWHHIb1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 04:31:27 -0400
From: Magnus Damm <magnus@valinux.co.jp>
To: linux-kernel@vger.kernel.org
Cc: Magnus Damm <magnus@valinux.co.jp>, fastboot@lists.osdl.org,
       ebiederm@xmission.com
Message-Id: <20060808083307.391.45887.sendpatchset@cherry.local>
Subject: [PATCH] CONFIG_RELOCATABLE modpost fix
Date: Tue,  8 Aug 2006 17:32:11 +0900 (JST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_RELOCATABLE modpost fix

Run modpost on vmlinux regardless of CONFIG_MODULES. The modpost code is also
extended to ignore references from ".pci_fixup" to ".init.text".

Signed-off-by: Magnus Damm <magnus@valinux.co.jp>
---

 This patch applies on top of Eric W. Biedermans CONFIG_RELOCATABLE tree

 Makefile                 |    1 +
 scripts/Makefile         |    4 ++--
 scripts/Makefile.modpost |    6 +++++-
 scripts/mod/modpost.c    |   14 +++++++++++---

--- 0001/Makefile
+++ work/Makefile	2006-08-07 13:11:44.000000000 +0900
@@ -723,6 +723,7 @@ endif # ifdef CONFIG_KALLSYMS
 # vmlinux image - including updated kernel symbols
 vmlinux: $(vmlinux-lds) $(vmlinux-init) $(vmlinux-main) $(kallsyms.o) FORCE
 	$(call if_changed_rule,vmlinux__)
+	$(Q)$(MAKE) -rR -f $(srctree)/scripts/Makefile.modpost __modpost_kernel
 	$(Q)rm -f .old_version
 
 # The actual objects are generated when descending, 
--- 0001/scripts/Makefile
+++ work/scripts/Makefile	2006-08-07 13:09:47.000000000 +0900
@@ -16,7 +16,7 @@ hostprogs-$(CONFIG_IKCONFIG)     += bin2
 always		:= $(hostprogs-y)
 
 subdir-$(CONFIG_MODVERSIONS) += genksyms
-subdir-$(CONFIG_MODULES)     += mod
+subdir-y                     += mod
 
 # Let clean descend into subdirs
-subdir-	+= basic kconfig package
+subdir-	+= basic kconfig package mod
--- 0001/scripts/Makefile.modpost
+++ work/scripts/Makefile.modpost	2006-08-07 13:10:44.000000000 +0900
@@ -61,7 +61,11 @@ quiet_cmd_modpost = MODPOST
 	$(filter-out FORCE,$^)
 
 PHONY += __modpost
-__modpost: $(wildcard vmlinux) $(modules:.ko=.o) FORCE
+__modpost: $(modules:.ko=.o) FORCE
+	$(call cmd,modpost)
+
+PHONY += __modpost_kernel
+__modpost_kernel: $(wildcard vmlinux) FORCE
 	$(call cmd,modpost)
 
 # Declare generated files as targets for modpost
--- 0001/scripts/mod/modpost.c
+++ work/scripts/mod/modpost.c	2006-08-07 16:45:30.000000000 +0900
@@ -581,8 +581,8 @@ static int strrcmp(const char *s, const 
  *   fromsec = .data
  *   atsym = *driver, *_template, *_sht, *_ops, *_probe, *probe_one
  **/
-static int secref_whitelist(const char *tosec, const char *fromsec,
-			    const char *atsym)
+static int secref_whitelist(const char *modname, const char *tosec, 
+			    const char *fromsec, const char *atsym)
 {
 	int f1 = 1, f2 = 1;
 	const char **s;
@@ -596,6 +596,13 @@ static int secref_whitelist(const char *
 		NULL
 	};
 
+	/* Ignore all references from .pci_fixup section if vmlinux */
+	if (strcmp(modname, "vmlinux") == 0) {
+		if ((strcmp(fromsec, ".pci_fixup") == 0) && 
+		    (strcmp(tosec, ".init.text") == 0))
+		return 1;
+	}
+
 	/* Check for pattern 1 */
 	if (strcmp(tosec, ".init.data") != 0)
 		f1 = 0;
@@ -726,7 +733,8 @@ static void warn_sec_mismatch(const char
 
 	/* check whitelist - we may ignore it */
 	if (before &&
-	    secref_whitelist(secname, fromsec, elf->strtab + before->st_name))
+	    secref_whitelist(modname, secname, fromsec, 
+			     elf->strtab + before->st_name))
 		return;
 
 	if (before && after) {
