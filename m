Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751205AbWHJTm3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205AbWHJTm3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 15:42:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932706AbWHJTiJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:38:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:27884 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932697AbWHJThr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:37:47 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [144/145] i386: Disallow kprobes on NMI handlers
Message-Id: <20060810193744.CF0AB13B8E@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:37:44 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

From: Fernando Luis =?ISO-8859-1?Q?V=E1zquez?= Cao <fernando@oss.ntt.co.jp>

A kprobe executes IRET early and that could cause NMI recursion and stack
corruption.

Note: This problem was originally spotted by Andi Kleen. This patch
      adds fixes not included in his original patch.
[AK: Jan Beulich originally discovered these classes of bugs]

Signed-off-by: Fernando Vazquez <fernando@intellilink.co.jp>
Signed-off-by: Andi Kleen <ak@suse.de>

---

---
 arch/i386/kernel/mca.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

Index: linux/arch/i386/kernel/mca.c
===================================================================
--- linux.orig/arch/i386/kernel/mca.c
+++ linux/arch/i386/kernel/mca.c
@@ -42,6 +42,7 @@
 #include <linux/errno.h>
 #include <linux/kernel.h>
 #include <linux/mca.h>
+#include <linux/kprobes.h>
 #include <asm/system.h>
 #include <asm/io.h>
 #include <linux/proc_fs.h>
@@ -414,7 +415,8 @@ subsys_initcall(mca_init);
 
 /*--------------------------------------------------------------------*/
 
-static void mca_handle_nmi_device(struct mca_device *mca_dev, int check_flag)
+static __kprobes void
+mca_handle_nmi_device(struct mca_device *mca_dev, int check_flag)
 {
 	int slot = mca_dev->slot;
 
@@ -444,7 +446,7 @@ static void mca_handle_nmi_device(struct
 
 /*--------------------------------------------------------------------*/
 
-static int mca_handle_nmi_callback(struct device *dev, void *data)
+static int __kprobes mca_handle_nmi_callback(struct device *dev, void *data)
 {
 	struct mca_device *mca_dev = to_mca_device(dev);
 	unsigned char pos5;
@@ -462,7 +464,7 @@ static int mca_handle_nmi_callback(struc
 	return 0;
 }
 
-void mca_handle_nmi(void)
+void __kprobes mca_handle_nmi(void)
 {
 	/* First try - scan the various adapters and see if a specific
 	 * adapter was responsible for the error.
