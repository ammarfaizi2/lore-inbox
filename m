Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932124AbWEWSeG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124AbWEWSeG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 14:34:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751225AbWEWSdo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 14:33:44 -0400
Received: from mx.pathscale.com ([64.160.42.68]:7607 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751223AbWEWSdf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 14:33:35 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 6 of 10] ipath - enable GPIO interrupt on HT-460
X-Mercurial-Node: 5d7e365286b3a3096fbad1c834ca4f3b9e1be6a2
Message-Id: <5d7e365286b3a3096fba.1148409154@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1148409148@eng-12.pathscale.com>
Date: Tue, 23 May 2006 11:32:34 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is required for even semi-decent performance on OpenIB.

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r 6bf52c0f0f0d -r 5d7e365286b3 drivers/infiniband/hw/ipath/ipath_eeprom.c
--- a/drivers/infiniband/hw/ipath/ipath_eeprom.c	Tue May 23 11:29:15 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_eeprom.c	Tue May 23 11:29:16 2006 -0700
@@ -505,11 +505,10 @@ static u8 flash_csum(struct ipath_flash 
  * ipath_get_guid - get the GUID from the i2c device
  * @dd: the infinipath device
  *
- * When we add the multi-chip support, we will probably have to add
- * the ability to use the number of guids field, and get the guid from
- * the first chip's flash, to use for all of them.
- */
-void ipath_get_guid(struct ipath_devdata *dd)
+ * We have the capability to use the ipath_nguid field, and get
+ * the guid from the first chip's flash, to use for all of them.
+ */
+void ipath_get_eeprom_info(struct ipath_devdata *dd)
 {
 	void *buf;
 	struct ipath_flash *ifp;
diff -r 6bf52c0f0f0d -r 5d7e365286b3 drivers/infiniband/hw/ipath/ipath_ht400.c
--- a/drivers/infiniband/hw/ipath/ipath_ht400.c	Tue May 23 11:29:15 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_ht400.c	Tue May 23 11:29:16 2006 -0700
@@ -607,7 +607,12 @@ static int ipath_ht_boardname(struct ipa
 	case 4:		/* Ponderosa is one of the bringup boards */
 		n = "Ponderosa";
 		break;
-	case 5:		/* HT-460 original production board */
+	case 5:	
+		/*
+		 * HT-460 original production board; two production levels, with
+		 * different serial number ranges.   See ipath_ht_early_init() for
+		 * case where we enable IPATH_GPIO_INTR for later serial # range.
+		 */
 		n = "InfiniPath_HT-460";
 		break;
 	case 6:
@@ -642,7 +647,7 @@ static int ipath_ht_boardname(struct ipa
 	if (n)
 		snprintf(name, namelen, "%s", n);
 
-	if (dd->ipath_majrev != 3 || dd->ipath_minrev != 2) {
+	if (dd->ipath_majrev != 3 || (dd->ipath_minrev < 2 || dd->ipath_minrev > 3)) {
 		/*
 		 * This version of the driver only supports the HT-400
 		 * Rev 3.2
@@ -1520,6 +1525,18 @@ static int ipath_ht_early_init(struct ip
 	 */
 	ipath_write_kreg(dd, dd->ipath_kregs->kr_sendctrl,
 			 INFINIPATH_S_ABORT);
+
+	ipath_get_eeprom_info(dd);
+	if(dd->ipath_boardrev == 5 && dd->ipath_serial[0] == '1' &&
+		dd->ipath_serial[1] == '2' && dd->ipath_serial[2] == '8') {
+		/*
+		 * Later production HT-460 has same changes as HT-465, so
+		 * can use GPIO interrupts.  They have serial #'s starting
+		 * with 128, rather than 112.
+		 */
+		dd->ipath_flags |= IPATH_GPIO_INTR;
+		dd->ipath_flags &= ~IPATH_POLL_RX_INTR;
+	}
 	return 0;
 }
 
diff -r 6bf52c0f0f0d -r 5d7e365286b3 drivers/infiniband/hw/ipath/ipath_init_chip.c
--- a/drivers/infiniband/hw/ipath/ipath_init_chip.c	Tue May 23 11:29:15 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_init_chip.c	Tue May 23 11:29:16 2006 -0700
@@ -879,7 +879,6 @@ int ipath_init_chip(struct ipath_devdata
 
 done:
 	if (!ret) {
-		ipath_get_guid(dd);
 		*dd->ipath_statusp |= IPATH_STATUS_CHIP_PRESENT;
 		if (!dd->ipath_f_intrsetup(dd)) {
 			/* now we can enable all interrupts from the chip */
diff -r 6bf52c0f0f0d -r 5d7e365286b3 drivers/infiniband/hw/ipath/ipath_kernel.h
--- a/drivers/infiniband/hw/ipath/ipath_kernel.h	Tue May 23 11:29:15 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_kernel.h	Tue May 23 11:29:16 2006 -0700
@@ -650,7 +650,7 @@ void ipath_init_pe800_funcs(struct ipath
 void ipath_init_pe800_funcs(struct ipath_devdata *);
 /* init HT-400-specific func */
 void ipath_init_ht400_funcs(struct ipath_devdata *);
-void ipath_get_guid(struct ipath_devdata *);
+void ipath_get_eeprom_info(struct ipath_devdata *);
 u64 ipath_snap_cntr(struct ipath_devdata *, ipath_creg);
 
 /*
diff -r 6bf52c0f0f0d -r 5d7e365286b3 drivers/infiniband/hw/ipath/ipath_pe800.c
--- a/drivers/infiniband/hw/ipath/ipath_pe800.c	Tue May 23 11:29:15 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_pe800.c	Tue May 23 11:29:16 2006 -0700
@@ -1180,6 +1180,8 @@ static int ipath_pe_early_init(struct ip
 	 */
 	dd->ipath_rhdrhead_intr_off = 1ULL<<32;
 
+	ipath_get_eeprom_info(dd);
+
 	return 0;
 }
 
