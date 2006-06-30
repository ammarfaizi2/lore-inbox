Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932559AbWF3VME@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932559AbWF3VME (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 17:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932564AbWF3VME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 17:12:04 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:1193 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932559AbWF3VMC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 17:12:02 -0400
Subject: [PATCH] aic94xx: disable split completion timer/setting by default
From: Alexis Bruemmer <alexisb@us.ibm.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 30 Jun 2006 14:10:56 -0700
Message-Id: <1151701856.16075.59.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The aic94xx driver will lock up under heavy load with a split completion
error.  There is a split completion timer/setting which should be
disabled by default but is not.  This patch fixes this problem.

Signed-off-by: Adaptec
Acked-by: Alexis Bruemmer <alexisb@us.ibm.com>

----------

Index: aic94xx-sas-2.6-patched/drivers/scsi/aic94xx/aic94xx_hwi.c
===================================================================
--- aic94xx-sas-2.6-patched.orig/drivers/scsi/aic94xx/aic94xx_hwi.c	2006-06-23 11:12:01.000000000 -0700
+++ aic94xx-sas-2.6-patched/drivers/scsi/aic94xx/aic94xx_hwi.c	2006-06-29 12:10:08.000000000 -0700
@@ -604,11 +604,26 @@
 int asd_init_hw(struct asd_ha_struct *asd_ha)
 {
 	int err;
+	u32 v;
 
 	err = asd_init_sw(asd_ha);
 	if (err)
 		return err;
 
+	err = pci_read_config_dword(asd_ha->pcidev, PCIC_HSTPCIX_CNTRL, &v);
+	if (err) {
+		asd_printk("couldn't read PCIC_HSTPCIX_CNTRL of %s\n",
+			   pci_name(asd_ha->pcidev));
+		return err;
+	}
+	pci_write_config_dword(asd_ha->pcidev, PCIC_HSTPCIX_CNTRL,
+					v | SC_TMR_DIS);
+	if (err) {
+		asd_printk("couldn't disable split completion timer of %s\n",
+			   pci_name(asd_ha->pcidev));
+		return err;
+	}
+
 	err = asd_read_ocm(asd_ha);
 	if (err) {
 		asd_printk("couldn't read ocm(%d)\n", err);
Index: aic94xx-sas-2.6-patched/drivers/scsi/aic94xx/aic94xx_reg_def.h
===================================================================
--- aic94xx-sas-2.6-patched.orig/drivers/scsi/aic94xx/aic94xx_reg_def.h	2006-06-23 11:12:01.000000000 -0700
+++ aic94xx-sas-2.6-patched/drivers/scsi/aic94xx/aic94xx_reg_def.h	2006-06-29 11:57:49.000000000 -0700
@@ -1787,6 +1787,7 @@
 #define PCIC_HSTPCIX_CNTRL	0xA0
 
 #define 	REWIND_DIS		0x0800
+#define		SC_TMR_DIS		0x04000000
 
 #define PCIC_MBAR0_MASK	0xA8
 #define		PCIC_MBAR0_SIZE_MASK 	0x1FFFE000


