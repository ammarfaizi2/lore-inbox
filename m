Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265023AbTFCOPG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 10:15:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265021AbTFCOPG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 10:15:06 -0400
Received: from air-2.osdl.org ([65.172.181.6]:40600 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265020AbTFCOOz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 10:14:55 -0400
Subject: [PATCH] megaraid driver fix for 2.5.70
From: Mark Haverkamp <markh@osdl.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       James Bottomley <James.Bottomley@steeleye.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-scsi <linux-scsi@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1054650567.13617.12.camel@markh1.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 03 Jun 2003 07:29:27 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A recent change to the megaraid driver to fix some memset calls resulted
in overflowing the arrays being cleared and causing a system panic. 
This patch fixes the problem by making sure that the arrays being
cleared are dimensioned to the correct size.  The patch has been tested
on osdl's stp machines that have megaraid controllers.



===== drivers/scsi/megaraid.c 1.45 vs edited =====
--- 1.45/drivers/scsi/megaraid.c	Sat May 17 14:09:51 2003
+++ edited/drivers/scsi/megaraid.c	Tue Jun  3 07:25:23 2003
@@ -723,7 +723,7 @@
 {
 	dma_addr_t	prod_info_dma_handle;
 	mega_inquiry3	*inquiry3;
-	u8	raw_mbox[16];
+	u8	raw_mbox[sizeof(mbox_t)];
 	mbox_t	*mbox;
 	int	retval;
 
@@ -732,7 +732,7 @@
 	mbox = (mbox_t *)raw_mbox;
 
 	memset((void *)adapter->mega_buffer, 0, MEGA_BUFFER_SIZE);
-	memset(mbox, 0, 16);
+	memset(mbox, 0, sizeof(*mbox));
 
 	/*
 	 * Try to issue Inquiry3 command
@@ -2415,7 +2415,7 @@
 {
 	adapter_t	*adapter;
 	mbox_t	*mbox;
-	u_char	raw_mbox[16];
+	u_char	raw_mbox[sizeof(mbox_t)];
 	char	buf[12] = { 0 };
 
 	adapter = (adapter_t *)host->hostdata;
@@ -2424,7 +2424,7 @@
 	printk(KERN_NOTICE "megaraid: being unloaded...");
 
 	/* Flush adapter cache */
-	memset(mbox, 0, 16);
+	memset(mbox, 0, sizeof(*mbox));
 	raw_mbox[0] = FLUSH_ADAPTER;
 
 	irq_disable(adapter);
@@ -2434,7 +2434,7 @@
 	issue_scb_block(adapter, raw_mbox);
 
 	/* Flush disks cache */
-	memset(mbox, 0, 16);
+	memset(mbox, 0, sizeof(*mbox));
 	raw_mbox[0] = FLUSH_SYSTEM;
 
 	/* Issue a blocking (interrupts disabled) command to the card */
@@ -3896,7 +3896,7 @@
 {
 	adapter_t *adapter;
 	struct Scsi_Host *host;
-	u8 raw_mbox[16];
+	u8 raw_mbox[sizeof(mbox_t)];
 	mbox_t *mbox;
 	int i,j;
 
@@ -3912,7 +3912,7 @@
 		mbox = (mbox_t *)raw_mbox;
 
 		/* Flush adapter cache */
-		memset(mbox, 0, 16);
+		memset(mbox, 0, sizeof(*mbox));
 		raw_mbox[0] = FLUSH_ADAPTER;
 
 		irq_disable(adapter);
@@ -3925,7 +3925,7 @@
 		issue_scb_block(adapter, raw_mbox);
 
 		/* Flush disks cache */
-		memset(mbox, 0, 16);
+		memset(mbox, 0, sizeof(*mbox));
 		raw_mbox[0] = FLUSH_SYSTEM;
 
 		issue_scb_block(adapter, raw_mbox);
@@ -4658,7 +4658,7 @@
 static int
 mega_is_bios_enabled(adapter_t *adapter)
 {
-	unsigned char	raw_mbox[16];
+	unsigned char	raw_mbox[sizeof(mbox_t)];
 	mbox_t	*mbox;
 	int	ret;
 
@@ -4691,7 +4691,7 @@
 static void
 mega_enum_raid_scsi(adapter_t *adapter)
 {
-	unsigned char raw_mbox[16];
+	unsigned char raw_mbox[sizeof(mbox_t)];
 	mbox_t *mbox;
 	int i;
 
@@ -4746,7 +4746,7 @@
 mega_get_boot_drv(adapter_t *adapter)
 {
 	struct private_bios_data	*prv_bios_data;
-	unsigned char	raw_mbox[16];
+	unsigned char	raw_mbox[sizeof(mbox_t)];
 	mbox_t	*mbox;
 	u16	cksum = 0;
 	u8	*cksum_p;
@@ -4812,7 +4812,7 @@
 static int
 mega_support_random_del(adapter_t *adapter)
 {
-	unsigned char raw_mbox[16];
+	unsigned char raw_mbox[sizeof(mbox_t)];
 	mbox_t *mbox;
 	int rval;
 
@@ -4841,7 +4841,7 @@
 static int
 mega_support_ext_cdb(adapter_t *adapter)
 {
-	unsigned char raw_mbox[16];
+	unsigned char raw_mbox[sizeof(mbox_t)];
 	mbox_t *mbox;
 	int rval;
 
@@ -4959,7 +4959,7 @@
 static void
 mega_get_max_sgl(adapter_t *adapter)
 {
-	unsigned char	raw_mbox[16];
+	unsigned char	raw_mbox[sizeof(mbox_t)];
 	mbox_t	*mbox;
 
 	mbox = (mbox_t *)raw_mbox;
@@ -5004,7 +5004,7 @@
 static int
 mega_support_cluster(adapter_t *adapter)
 {
-	unsigned char	raw_mbox[16];
+	unsigned char	raw_mbox[sizeof(mbox_t)];
 	mbox_t	*mbox;
 
 	mbox = (mbox_t *)raw_mbox;



-- 
Mark Haverkamp <markh@osdl.org>

