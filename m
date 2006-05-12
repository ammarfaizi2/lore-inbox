Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932195AbWELXpQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932195AbWELXpQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 19:45:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932203AbWELXpM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 19:45:12 -0400
Received: from mx.pathscale.com ([64.160.42.68]:63913 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932287AbWELXoe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 19:44:34 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 46 of 53] ipath - enable GPIO interrupt on HT-460
X-Mercurial-Node: 04c86dd11b2780e114ab6e369171c84bed8184f5
Message-Id: <04c86dd11b2780e114ab.1147477411@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1147477365@eng-12.pathscale.com>
Date: Fri, 12 May 2006 16:43:31 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r b41e576e5202 -r 04c86dd11b27 drivers/infiniband/hw/ipath/ipath_eeprom.c
--- a/drivers/infiniband/hw/ipath/ipath_eeprom.c	Fri May 12 15:55:29 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_eeprom.c	Fri May 12 15:55:29 2006 -0700
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
diff -r b41e576e5202 -r 04c86dd11b27 drivers/infiniband/hw/ipath/ipath_ht400.c
--- a/drivers/infiniband/hw/ipath/ipath_ht400.c	Fri May 12 15:55:29 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_ht400.c	Fri May 12 15:55:29 2006 -0700
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
 
diff -r b41e576e5202 -r 04c86dd11b27 drivers/infiniband/hw/ipath/ipath_init_chip.c
--- a/drivers/infiniband/hw/ipath/ipath_init_chip.c	Fri May 12 15:55:29 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_init_chip.c	Fri May 12 15:55:29 2006 -0700
@@ -857,7 +857,6 @@ int ipath_init_chip(struct ipath_devdata
 
 done:
 	if (!ret) {
-		ipath_get_guid(dd);
 		*dd->ipath_statusp |= IPATH_STATUS_CHIP_PRESENT;
 		if (!dd->ipath_f_intrsetup(dd)) {
 			/* now we can enable all interrupts from the chip */
diff -r b41e576e5202 -r 04c86dd11b27 drivers/infiniband/hw/ipath/ipath_kernel.h
--- a/drivers/infiniband/hw/ipath/ipath_kernel.h	Fri May 12 15:55:29 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_kernel.h	Fri May 12 15:55:29 2006 -0700
@@ -646,7 +646,7 @@ void ipath_init_pe800_funcs(struct ipath
 void ipath_init_pe800_funcs(struct ipath_devdata *);
 /* init HT-400-specific func */
 void ipath_init_ht400_funcs(struct ipath_devdata *);
-void ipath_get_guid(struct ipath_devdata *);
+void ipath_get_eeprom_info(struct ipath_devdata *);
 u64 ipath_snap_cntr(struct ipath_devdata *, ipath_creg);
 
 /*
diff -r b41e576e5202 -r 04c86dd11b27 drivers/infiniband/hw/ipath/ipath_pe800.c
--- a/drivers/infiniband/hw/ipath/ipath_pe800.c	Fri May 12 15:55:29 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_pe800.c	Fri May 12 15:55:29 2006 -0700
@@ -1180,6 +1180,8 @@ static int ipath_pe_early_init(struct ip
 	 */
 	dd->ipath_rhdrhead_intr_off = 1ULL<<32;
 
+	ipath_get_eeprom_info(dd);
+
 	return 0;
 }
 
