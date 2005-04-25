Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262600AbVDYLrw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262600AbVDYLrw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 07:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262599AbVDYLrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 07:47:52 -0400
Received: from magic.adaptec.com ([216.52.22.17]:30630 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S262593AbVDYLre convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 07:47:34 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [2.6 PATCH] drivers/scsi/dpt_i2o.c: cleanup useless code
Date: Mon, 25 Apr 2005 07:47:29 -0400
Message-ID: <60807403EABEB443939A5A7AA8A7458B0112CFE2@otce2k01.adaptec.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [2.6 PATCH] drivers/scsi/dpt_i2o.c: cleanup useless code
Thread-Index: AcVIMAJa2gdPgQkAQSSd7N3U6KsNAQBXHIrw
From: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
To: "Benoit Boissinot" <benoit.boissinot@ens-lyon.org>,
       "Andrew Morton" <akpm@osdl.org>
Cc: <James.Bottomley@steeleye.com>, <linux-scsi@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>,
       "Markus Lidel" <Markus.Lidel@shadowconnect.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I approve, applied to Adaptec branch.

Sincerely -- Mark Salyzyn

-----Original Message-----
From: Benoit Boissinot [mailto:benoit.boissinot@ens-lyon.org] 
Sent: Saturday, April 23, 2005 2:12 PM
To: Andrew Morton
Cc: James.Bottomley@steeleye.com; linux-scsi@vger.kernel.org;
linux-kernel@vger.kernel.org; Markus Lidel; Salyzyn, Mark
Subject: [2.6 PATCH] drivers/scsi/dpt_i2o.c: cleanup useless code

This patch removes the array 'hbas' as it seems to be useless
and redundant with the linked list hbas_chain.

Signed-off-by: Benoit Boissinot <benoit.boissinot@ens-lyon.org>

--- ./drivers/scsi/dpt_i2o.c.orig	2005-04-23 20:07:46.000000000
+0200
+++ ./drivers/scsi/dpt_i2o.c	2005-04-23 20:08:10.000000000 +0200
@@ -113,7 +113,6 @@ static struct i2o_sys_tbl *sys_tbl = NUL
 static int sys_tbl_ind = 0;
 static int sys_tbl_len = 0;
 
-static adpt_hba* hbas[DPTI_MAX_HBA];
 static adpt_hba* hba_chain = NULL;
 static int hba_count = 0;
 
@@ -875,7 +874,6 @@ static int adpt_install_hba(struct scsi_
 	void __iomem *msg_addr_virt = NULL;
 
 	int raptorFlag = FALSE;
-	int i;
 
 	if(pci_enable_device(pDev)) {
 		return -EINVAL;
@@ -935,12 +933,6 @@ static int adpt_install_hba(struct scsi_
 	memset(pHba, 0, sizeof(adpt_hba));
 
 	down(&adpt_configuration_lock);
-	for(i=0;i<DPTI_MAX_HBA;i++) {
-		if(hbas[i]==NULL) {
-			hbas[i]=pHba;
-			break;
-		}
-	}
 
 	if(hba_chain != NULL){
 		for(p = hba_chain; p->next; p = p->next);
@@ -950,7 +942,7 @@ static int adpt_install_hba(struct scsi_
 	}
 	pHba->next = NULL;
 	pHba->unit = hba_count;
-	sprintf(pHba->name, "dpti%d", i);
+	sprintf(pHba->name, "dpti%d", hba_count);
 	hba_count++;
 	
 	up(&adpt_configuration_lock);
@@ -1015,11 +1007,6 @@ static void adpt_i2o_delete_hba(adpt_hba
 	if(pHba->host){
 		free_irq(pHba->host->irq, pHba);
 	}
-	for(i=0;i<DPTI_MAX_HBA;i++) {
-		if(hbas[i]==pHba) {
-			hbas[i] = NULL;
-		}
-	}
 	p2 = NULL;
 	for( p1 = hba_chain; p1; p2 = p1,p1=p1->next){
 		if(p1 == pHba) {
@@ -1076,12 +1063,7 @@ static void adpt_i2o_delete_hba(adpt_hba
 
 static int adpt_init(void)
 {
-	int i;
-
 	printk("Loading Adaptec I2O RAID: Version " DPT_I2O_VERSION
"\n");
-	for (i = 0; i < DPTI_MAX_HBA; i++) {
-		hbas[i] = NULL;
-	}
 #ifdef REBOOT_NOTIFIER
 	register_reboot_notifier(&adpt_reboot_notifier);
 #endif
