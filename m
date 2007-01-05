Return-Path: <linux-kernel-owner+w=401wt.eu-S1422675AbXAESsG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422675AbXAESsG (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 13:48:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422665AbXAESrn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 13:47:43 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:34875 "EHLO
	saraswathi.solana.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422667AbXAESrl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 13:47:41 -0500
Message-Id: <200701051842.l05IgHvh004642@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 8/9] UML - Locking comments in iomem driver
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 05 Jan 2007 13:42:17 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Comment some lack of locking in the iomem driver.

Also, a couple of variables are in the wrong place, so they are moved.

Signed-off-by: Jeff Dike <jdike@addtoit.com>
--
 arch/um/kernel/mem.c     |   10 ----------
 arch/um/kernel/physmem.c |   17 +++++++++++++++++
 2 files changed, 17 insertions(+), 10 deletions(-)
Index: linux-2.6.18-mm/arch/um/kernel/mem.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/kernel/mem.c	2007-01-03 11:36:39.000000000 -0500
+++ linux-2.6.18-mm/arch/um/kernel/mem.c	2007-01-03 11:38:35.000000000 -0500
@@ -368,16 +368,6 @@ struct page *pte_alloc_one(struct mm_str
 	return pte;
 }
 
-struct iomem_region *iomem_regions = NULL;
-int iomem_size = 0;
-
-extern int parse_iomem(char *str, int *add) __init;
-
-__uml_setup("iomem=", parse_iomem,
-"iomem=<name>,<file>\n"
-"    Configure <file> as an IO memory region named <name>.\n\n"
-);
-
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
  * Emacs will notice this stuff at the end of the file and automatically
Index: linux-2.6.18-mm/arch/um/kernel/physmem.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/kernel/physmem.c	2007-01-01 13:34:20.000000000 -0500
+++ linux-2.6.18-mm/arch/um/kernel/physmem.c	2007-01-03 11:38:45.000000000 -0500
@@ -398,6 +398,23 @@ __uml_setup("mem=", uml_mem_setup,
 "	Example: mem=64M\n\n"
 );
 
+extern int __init parse_iomem(char *str, int *add);
+
+__uml_setup("iomem=", parse_iomem,
+"iomem=<name>,<file>\n"
+"    Configure <file> as an IO memory region named <name>.\n\n"
+);
+
+/*
+ * This list is constructed in parse_iomem and addresses filled in in
+ * setup_iomem, both of which run during early boot.  Afterwards, it's
+ * unchanged.
+ */
+struct iomem_region *iomem_regions = NULL;
+
+/* Initialized in parse_iomem */
+int iomem_size = 0;
+
 unsigned long find_iomem(char *driver, unsigned long *len_out)
 {
 	struct iomem_region *region = iomem_regions;

