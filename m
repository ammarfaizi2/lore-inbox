Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262773AbVHDXzB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262773AbVHDXzB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 19:55:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262758AbVHDXxD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 19:53:03 -0400
Received: from tim.rpsys.net ([194.106.48.114]:61829 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S262770AbVHDXw1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 19:52:27 -0400
Subject: [patch] Add write protection switch handling to the PXA MMC driver
From: Richard Purdie <rpurdie@rpsys.net>
To: Andrew Morton <akpm@osdl.org>
Cc: Russell King <linux@arm.linux.org.uk>, LKML <linux-kernel@vger.kernel.org>,
       Nicolas Pitre <nico@cam.org>
Content-Type: text/plain
Date: Fri, 05 Aug 2005 00:52:08 +0100
Message-Id: <1123199529.8987.94.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a write protection switch handling code to the PXA MMC driver so
that platform specific code can provide it if available (extending the
MMC/SD patches in -mm).

Signed-off-by: Richard Purdie <rpurdie@rpsys.net>

Index: linux-2.6.12/include/asm-arm/arch-pxa/mmc.h
===================================================================
--- linux-2.6.12.orig/include/asm-arm/arch-pxa/mmc.h	2005-08-05 00:29:17.000000000 +0100
+++ linux-2.6.12/include/asm-arm/arch-pxa/mmc.h	2005-08-05 00:29:43.000000000 +0100
@@ -10,6 +10,7 @@
 struct pxamci_platform_data {
 	unsigned int ocr_mask;			/* available voltages */
 	int (*init)(struct device *, irqreturn_t (*)(int, void *, struct pt_regs *), void *);
+	int (*get_ro)(struct device *);
 	void (*setpower)(struct device *, unsigned int);
 	void (*exit)(struct device *, void *);
 };
Index: linux-2.6.12/drivers/mmc/pxamci.c
===================================================================
--- linux-2.6.12.orig/drivers/mmc/pxamci.c	2005-08-05 00:29:17.000000000 +0100
+++ linux-2.6.12/drivers/mmc/pxamci.c	2005-08-05 00:29:43.000000000 +0100
@@ -362,6 +362,16 @@
 	pxamci_start_cmd(host, mrq->cmd, cmdat);
 }
 
+static int pxamci_get_ro(struct mmc_host *mmc)
+{
+	struct pxamci_host *host = mmc_priv(mmc);
+
+	if (host->pdata && host->pdata->get_ro)
+		return host->pdata->get_ro(mmc->dev);
+	/* Host doesn't support read only detection so assume writeable */
+	return 0;
+}
+
 static void pxamci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct pxamci_host *host = mmc_priv(mmc);
@@ -401,6 +411,7 @@
 
 static struct mmc_host_ops pxamci_ops = {
 	.request	= pxamci_request,
+	.get_ro		= pxamci_get_ro,
 	.set_ios	= pxamci_set_ios,
 };

