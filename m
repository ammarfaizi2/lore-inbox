Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261962AbVDKW75@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261962AbVDKW75 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 18:59:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261961AbVDKW75
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 18:59:57 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:31373 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261986AbVDKW7g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 18:59:36 -0400
Subject: [PATCH 2/3] mm/Kconfig: hide "Memory Model" selection menu
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, zippel@linux-m68k.org,
       Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Mon, 11 Apr 2005 15:59:33 -0700
Message-Id: <E1DL7sT-000353-00@kernel.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I got some feedback from users who think that the new "Memory
Model" menu is a little invasive.  This patch will hide that menu,
except when CONFIG_EXPERIMENTAL is enabled *or* when an individual
architecture wants it.

An individual arch may want to enable it because they've removed
their arch-specific DISCONTIG prompt in favor of the mm/Kconfig one.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 arch/i386/Kconfig          |    0 
 memhotplug-dave/mm/Kconfig |   21 +++++++++++++++++----
 2 files changed, 17 insertions(+), 4 deletions(-)

diff -puN mm/Kconfig~A1-mm-Kconfig-hide-selection-menu mm/Kconfig
--- memhotplug/mm/Kconfig~A1-mm-Kconfig-hide-selection-menu	2005-04-11 15:49:10.000000000 -0700
+++ memhotplug-dave/mm/Kconfig	2005-04-11 15:49:10.000000000 -0700
@@ -1,9 +1,14 @@
+config SELECT_MEMORY_MODEL
+	def_bool y
+	depends on EXPERIMENTAL || ARCH_SELECT_MEMORY_MODEL
+
 choice
 	prompt "Memory model"
-	default DISCONTIGMEM if ARCH_DISCONTIGMEM_DEFAULT
-	default FLATMEM
+	depends on SELECT_MEMORY_MODEL
+	default DISCONTIGMEM_MANUAL if ARCH_DISCONTIGMEM_DEFAULT
+	default FLATMEM_MANUAL
 
-config FLATMEM
+config FLATMEM_MANUAL
 	bool "Flat Memory"
 	depends on !ARCH_DISCONTIGMEM_ENABLE || ARCH_FLATMEM_ENABLE
 	help
@@ -14,7 +19,7 @@ config FLATMEM
 
 	  If unsure, choose this option over any other.
 
-config DISCONTIGMEM
+config DISCONTIGMEM_MANUAL
 	bool "Discontigious Memory"
 	depends on ARCH_DISCONTIGMEM_ENABLE
 	help
@@ -22,6 +27,14 @@ config DISCONTIGMEM
 
 endchoice
 
+config DISCONTIGMEM
+	def_bool y
+	depends on (!SELECT_MEMORY_MODEL && ARCH_DISCONTIGMEM_ENABLE) || DISCONTIGMEM_MANUAL
+
+config FLATMEM
+	def_bool y
+	depends on !DISCONTIGMEM || FLATMEM_MANUAL
+
 #
 # Both the NUMA code and DISCONTIGMEM use arrays of pg_data_t's
 # to represent different areas of memory.  This variable allows
diff -puN arch/i386/Kconfig~A1-mm-Kconfig-hide-selection-menu arch/i386/Kconfig
_
