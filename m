Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261411AbVARTiO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbVARTiO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 14:38:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbVARTgI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 14:36:08 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:62858 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261408AbVARTff (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 14:35:35 -0500
Message-Id: <20050118192608.500213000.suse.de>
References: <20050118184123.729034000.suse.de>
Date: Tue, 18 Jan 2005 19:41:23 +0100
From: Andreas Gruenbacher <agruen@suse.de>
To: linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Subject: [kbuild 3/5] Add cloneconfig target
Content-Disposition: inline; filename=cloneconfig.diff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cloneconfig takes the first configuration it finds which appears to
belong to the running kernel, and configures the kernel sources to match
this configuration as closely as possible.

Signed-off-by: Andreas Gruenbacher <agruen@suse.de>

Index: linux-2.6.11-rc1-bk6/scripts/kconfig/Makefile
===================================================================
--- linux-2.6.11-rc1-bk6.orig/scripts/kconfig/Makefile
+++ linux-2.6.11-rc1-bk6/scripts/kconfig/Makefile
@@ -37,6 +37,22 @@ allnoconfig: $(obj)/conf
 allmodconfig: $(obj)/conf
 	$< -m arch/$(ARCH)/Kconfig
 
+UNAME_RELEASE := $(shell uname -r)
+CLONECONFIG := $(firstword $(wildcard /proc/config.gz \
+				      /lib/modules/$(UNAME_RELEASE)/.config \
+				      /etc/kernel-config \
+				      /boot/config-$(UNAME_RELEASE)))
+cloneconfig: $(obj)/conf
+	$(Q)case "$(CLONECONFIG)" in				\
+	'')	echo -e "The configuration of the running"	\
+			"kernel could not be determined\n";	\
+		false ;;					\
+	*.gz)	gzip -cd $(CLONECONFIG) > .config.running ;;	\
+	*)	cat $(CLONECONFIG) > .config.running ;;		\
+	esac &&							\
+	echo -e "Cloning configuration file $(CLONECONFIG)\n"
+	$(Q)$< -D .config.running arch/$(ARCH)/Kconfig
+
 defconfig: $(obj)/conf
 ifeq ($(KBUILD_DEFCONFIG),)
 	$< -d arch/$(ARCH)/Kconfig

--
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX PRODUCTS GMBH

