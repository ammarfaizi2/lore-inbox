Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161182AbWHJLg1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161182AbWHJLg1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 07:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161183AbWHJLg1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 07:36:27 -0400
Received: from ns.oss.ntt.co.jp ([222.151.198.98]:8085 "EHLO
	serv1.oss.ntt.co.jp") by vger.kernel.org with ESMTP
	id S1161182AbWHJLg0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 07:36:26 -0400
Subject: [PATCH 2/2] i386: Disallow kprobes on NMI handlers - try #2
From: Fernando Luis =?ISO-8859-1?Q?V=E1zquez?= Cao 
	<fernando@oss.ntt.co.jp>
To: Andi Kleen <ak@suse.de>
Cc: prasanna@in.ibm.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: =?UTF-8?Q?NTT=E3=82=AA=E3=83=BC=E3=83=97=E3=83=B3=E3=82=BD=E3=83=BC?=
	=?UTF-8?Q?=E3=82=B9=E3=82=BD=E3=83=95=E3=83=88=E3=82=A6=E3=82=A7?=
	=?UTF-8?Q?=E3=82=A2=E3=82=BB=E3=83=B3=E3=82=BF?=
Date: Thu, 10 Aug 2006 20:36:24 +0900
Message-Id: <1155209784.4141.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A kprobe executes IRET early and that could cause NMI recursion and stack
corruption.

Note: This problem was originally spotted by Andi Kleen. This patch
      adds fixes not included in his original patch.

Signed-off-by: Fernando Vazquez <fernando@intellilink.co.jp>
---

diff -urNp linux-2.6.18-rc4-orig/arch/i386/kernel/mca.c linux-2.6.18-rc4/arch/i386/kernel/mca.c
--- linux-2.6.18-rc4-orig/arch/i386/kernel/mca.c	2006-08-10 20:04:10.000000000 +0900
+++ linux-2.6.18-rc4/arch/i386/kernel/mca.c	2006-08-10 20:11:59.000000000 +0900
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


