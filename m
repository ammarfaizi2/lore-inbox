Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261404AbVARTf5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261404AbVARTf5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 14:35:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbVARTf5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 14:35:57 -0500
Received: from news.suse.de ([195.135.220.2]:58506 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261404AbVARTfe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 14:35:34 -0500
Message-Id: <20050118192608.346931000.suse.de>
References: <20050118184123.729034000.suse.de>
Date: Tue, 18 Jan 2005 19:41:23 +0100
From: Andreas Gruenbacher <agruen@suse.de>
To: linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Subject: [kbuild 1/5] Warn when building external modules without modversions
Content-Disposition: inline; filename=check-symvers.diff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a warning when building external modules (M= or SUBDIRS=
syntax) and there is no Module.symvers in the object tree. A missing
Module.symvers is a clear sign that the kernel tree itself was never
compiled. The resulting modules will work, but no symbol version
information will be attached to kernel symbols the module uses (because
that information comes from Module.symvers), and so the module will be
more unsafe.

The test works with CONFIG_MODVERSIONS enabled or disabled.

Signed-off-by: Andreas Gruenbacher <agruen@suse.de>

Index: linux-2.6.11-rc1-bk6/Makefile
===================================================================
--- linux-2.6.11-rc1-bk6.orig/Makefile
+++ linux-2.6.11-rc1-bk6/Makefile
@@ -1093,9 +1093,17 @@ KBUILD_MODULES := 1
 crmodverdir:
 	$(Q)mkdir -p $(MODVERDIR)
 
+.PHONY: $(objtree)/Module.symvers
+$(objtree)/Module.symvers:
+	@test -e $(objtree)/Module.symvers || ( \
+	echo; \
+	echo "WARNING: Symbol version dump $(objtree)/Module.symvers is " \
+	     "missing; modules will have no modversions."; \
+	echo )
+
 module-dirs := $(addprefix _module_,$(KBUILD_EXTMOD))
 .PHONY: $(module-dirs) modules
-$(module-dirs): crmodverdir
+$(module-dirs): crmodverdir $(objtree)/Module.symvers
 	$(Q)$(MAKE) $(build)=$(patsubst _module_%,%,$@)
 
 modules: $(module-dirs)

--
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX PRODUCTS GMBH

