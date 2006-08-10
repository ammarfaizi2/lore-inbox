Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161122AbWHJKgn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161122AbWHJKgn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 06:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161149AbWHJKgn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 06:36:43 -0400
Received: from serv1.oss.ntt.co.jp ([222.151.198.98]:3211 "EHLO
	serv1.oss.ntt.co.jp") by vger.kernel.org with ESMTP
	id S1161122AbWHJKgn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 06:36:43 -0400
Subject: [PATCH 2/2] i386: Disallow kprobes on NMI handlers
From: Fernando Luis =?ISO-8859-1?Q?V=E1zquez?= Cao 
	<fernando@oss.ntt.co.jp>
To: Andi Kleen <ak@suse.de>
Cc: prasanna@in.ibm.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: =?UTF-8?Q?NTT=E3=82=AA=E3=83=BC=E3=83=97=E3=83=B3=E3=82=BD=E3=83=BC?=
	=?UTF-8?Q?=E3=82=B9=E3=82=BD=E3=83=95=E3=83=88=E3=82=A6=E3=82=A7?=
	=?UTF-8?Q?=E3=82=A2=E3=82=BB=E3=83=B3=E3=82=BF?=
Date: Thu, 10 Aug 2006 19:36:41 +0900
Message-Id: <1155206201.3001.41.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A kprobe executes IRET early and that could cause NMI recursion and stack
corruption.

Note: This problem was originally identified by Andi Kleen. This patch
      adds fixes not included in his original patch.

Signed-off-by: Fernando Vazquez <fernando@intellilink.co.jp>
---

diff -urNp linux-2.6.18-rc4-orig/arch/i386/kernel/mca.c linux-2.6.18-rc4/arch/i386/kernel/mca.c
--- linux-2.6.18-rc4-orig/arch/i386/kernel/mca.c	2006-08-10 17:24:15.000000000 +0900
+++ linux-2.6.18-rc4/arch/i386/kernel/mca.c	2006-08-10 19:34:37.000000000 +0900
@@ -414,7 +414,8 @@ subsys_initcall(mca_init);
 
 /*--------------------------------------------------------------------*/
 
-static void mca_handle_nmi_device(struct mca_device *mca_dev, int check_flag)
+static __kprobes void
+mca_handle_nmi_device(struct mca_device *mca_dev, int check_flag)
 {
 	int slot = mca_dev->slot;
 
@@ -444,7 +445,7 @@ static void mca_handle_nmi_device(struct
 
 /*--------------------------------------------------------------------*/
 
-static int mca_handle_nmi_callback(struct device *dev, void *data)
+static int __kprobes mca_handle_nmi_callback(struct device *dev, void *data)
 {
 	struct mca_device *mca_dev = to_mca_device(dev);
 	unsigned char pos5;
@@ -462,7 +463,7 @@ static int mca_handle_nmi_callback(struc
 	return 0;
 }
 
-void mca_handle_nmi(void)
+void __kprobes mca_handle_nmi(void)
 {
 	/* First try - scan the various adapters and see if a specific
 	 * adapter was responsible for the error.


