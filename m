Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264971AbVBDWYf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264971AbVBDWYf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 17:24:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264721AbVBDWUs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 17:20:48 -0500
Received: from gannet.scg.man.ac.uk ([130.88.94.110]:523 "EHLO
	gannet.scg.man.ac.uk") by vger.kernel.org with ESMTP
	id S263185AbVBDWHQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 17:07:16 -0500
Message-ID: <4203F2DB.9010604@gentoo.org>
Date: Fri, 04 Feb 2005 22:10:35 +0000
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-pm@osdl.org
Subject: [-mm PATCH] driver model: PM type conversions in drivers/mmc
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------070000070008090008010708"
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1CxBbf-000LZh-BG*jgJT72zYQ8.*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070000070008090008010708
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This fixes PM driver model type checking for drivers/mmc.
Acked by Pavel Machek.

Signed-off-by: Daniel Drake <dsd@gentoo.org>

--------------070000070008090008010708
Content-Type: text/x-patch;
 name="mmc-pm-type-safety.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mmc-pm-type-safety.patch"

diff -urNpX dontdiff linux-2.6.11-rc2-mm2/drivers/mmc/mmc.c linux-dsd/drivers/mmc/mmc.c
--- linux-2.6.11-rc2-mm2/drivers/mmc/mmc.c	2005-02-02 21:54:17.000000000 +0000
+++ linux-dsd/drivers/mmc/mmc.c	2005-02-02 21:26:44.000000000 +0000
@@ -884,7 +884,7 @@ EXPORT_SYMBOL(mmc_free_host);
  *	@host: mmc host
  *	@state: suspend mode (PM_SUSPEND_xxx)
  */
-int mmc_suspend_host(struct mmc_host *host, u32 state)
+int mmc_suspend_host(struct mmc_host *host, pm_message_t state)
 {
 	mmc_claim_host(host);
 	mmc_deselect_cards(host);
diff -urNpX dontdiff linux-2.6.11-rc2-mm2/drivers/mmc/mmci.c linux-dsd/drivers/mmc/mmci.c
--- linux-2.6.11-rc2-mm2/drivers/mmc/mmci.c	2005-02-02 21:54:17.000000000 +0000
+++ linux-dsd/drivers/mmc/mmci.c	2005-02-02 21:27:17.000000000 +0000
@@ -603,7 +603,7 @@ static int mmci_remove(struct amba_devic
 }
 
 #ifdef CONFIG_PM
-static int mmci_suspend(struct amba_device *dev, u32 state)
+static int mmci_suspend(struct amba_device *dev, pm_message_t state)
 {
 	struct mmc_host *mmc = amba_get_drvdata(dev);
 	int ret = 0;
diff -urNpX dontdiff linux-2.6.11-rc2-mm2/drivers/mmc/pxamci.c linux-dsd/drivers/mmc/pxamci.c
--- linux-2.6.11-rc2-mm2/drivers/mmc/pxamci.c	2005-02-02 21:54:17.000000000 +0000
+++ linux-dsd/drivers/mmc/pxamci.c	2005-02-02 21:27:33.000000000 +0000
@@ -558,7 +558,7 @@ static int pxamci_remove(struct device *
 }
 
 #ifdef CONFIG_PM
-static int pxamci_suspend(struct device *dev, u32 state, u32 level)
+static int pxamci_suspend(struct device *dev, pm_message_t state, u32 level)
 {
 	struct mmc_host *mmc = dev_get_drvdata(dev);
 	int ret = 0;
diff -urNpX dontdiff linux-2.6.11-rc2-mm2/drivers/mmc/wbsd.c linux-dsd/drivers/mmc/wbsd.c
--- linux-2.6.11-rc2-mm2/drivers/mmc/wbsd.c	2005-02-02 21:54:17.000000000 +0000
+++ linux-dsd/drivers/mmc/wbsd.c	2005-02-02 21:28:50.000000000 +0000
@@ -1563,7 +1563,7 @@ static int wbsd_remove(struct device* de
  */
 
 #ifdef CONFIG_PM
-static int wbsd_suspend(struct device *dev, u32 state, u32 level)
+static int wbsd_suspend(struct device *dev, pm_message_t state, u32 level)
 {
 	DBGF("Not yet supported\n");
 
diff -urNpX dontdiff linux-2.6.11-rc2-mm2/include/linux/mmc/host.h linux-dsd/include/linux/mmc/host.h
--- linux-2.6.11-rc2-mm2/include/linux/mmc/host.h	2004-12-24 21:34:58.000000000 +0000
+++ linux-dsd/include/linux/mmc/host.h	2005-02-02 21:26:34.000000000 +0000
@@ -98,7 +98,7 @@ extern void mmc_free_host(struct mmc_hos
 #define mmc_priv(x)	((void *)((x) + 1))
 #define mmc_dev(x)	((x)->dev)
 
-extern int mmc_suspend_host(struct mmc_host *, u32);
+extern int mmc_suspend_host(struct mmc_host *, pm_message_t);
 extern int mmc_resume_host(struct mmc_host *);
 
 extern void mmc_detect_change(struct mmc_host *);

--------------070000070008090008010708--
