Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261306AbVDDRu2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261306AbVDDRu2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 13:50:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261312AbVDDRu1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 13:50:27 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:16555 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261306AbVDDRuM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 13:50:12 -0400
Subject: [PATCH 1/4] create mm/Kconfig for arch-independent memory options
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Dave Hansen <haveblue@us.ibm.com>, apw@shadowen.org
From: Dave Hansen <haveblue@us.ibm.com>
Date: Mon, 04 Apr 2005 10:50:09 -0700
Message-Id: <E1DIViE-0006Kf-00@kernel.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


With sparsemem being introduced, we need a central place for new
memory-related .config options: mm/Kconfig.  This allows us to
remove many of the duplicated arch-specific options.

The new option, CONFIG_FLATMEM, is there to enable us to detangle
NUMA and DISCONTIGMEM.  This is a requirement for sparsemem
because sparsemem uses the NUMA code without the presence of
DISCONTIGMEM. The sparsemem patches use CONFIG_FLATMEM in generic
code, so this patch is a requirement before applying them.

Almost all places that used to do '#ifndef CONFIG_DISCONTIGMEM'
should use '#ifdef CONFIG_FLATMEM' instead.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 memhotplug-dave/mm/Kconfig |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+)

diff -puN mm/Kconfig~A6-mm-Kconfig mm/Kconfig
--- memhotplug/mm/Kconfig~A6-mm-Kconfig	2005-04-04 09:04:48.000000000 -0700
+++ memhotplug-dave/mm/Kconfig	2005-04-04 10:15:23.000000000 -0700
@@ -0,0 +1,25 @@
+choice
+	prompt "Memory model"
+	default FLATMEM
+	default SPARSEMEM if ARCH_SPARSEMEM_DEFAULT
+	default DISCONTIGMEM if ARCH_DISCONTIGMEM_DEFAULT
+
+config FLATMEM
+	bool "Flat Memory"
+	depends on !ARCH_DISCONTIGMEM_ENABLE || ARCH_FLATMEM_ENABLE
+	help
+	  This option allows you to change some of the ways that
+	  Linux manages its memory internally.  Most users will
+	  only have one option here: FLATMEM.  This is normal
+	  and a correct option.
+
+	  If unsure, choose this option over any other.
+
+config DISCONTIGMEM
+	bool "Discontigious Memory"
+	depends on ARCH_DISCONTIGMEM_ENABLE
+	help
+	  If unsure, choose "Flat Memory" over this option.
+
+endchoice
+
_
