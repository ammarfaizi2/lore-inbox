Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932608AbWFCLKb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932608AbWFCLKb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 07:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932609AbWFCLKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 07:10:31 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:58255 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S932608AbWFCLKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 07:10:30 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Sat, 3 Jun 2006 13:08:39 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 2/2] ieee1394: add preprocessor constant for invalid csr
 address
To: linux1394-devel@lists.sourceforge.net
cc: Andreas Schwab <schwab@suse.de>, scjody@modernduck.com,
       bcollins@ubuntu.com, mjt@tls.msk.ru, linux-kernel@vger.kernel.org,
       chrisw@sous-sol.org, Andrew Morton <akpm@osdl.org>
In-Reply-To: <tkrat.3b83a79240807095@s5r6.in-berlin.de>
Message-ID: <tkrat.fb172e110f16cc45@s5r6.in-berlin.de>
References: <tkrat.f195e45ae32b9c02@s5r6.in-berlin.de>
 <20060603013515.GV18769@moss.sous-sol.org>
 <44814A63.1080707@s5r6.in-berlin.de> <44815283.7080306@tls.msk.ru>
 <jemzcu7fgw.fsf@sykes.suse.de> <20060603024305.dd0404d0.akpm@osdl.org>
 <tkrat.3b83a79240807095@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
X-Spam-Score: (-0.365) AWL,BAYES_05
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace occurrences of the magic value ~(u64)0 for invalid
CSR address spaces by a named constant for better readability.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
 drivers/ieee1394/csr1212.c   |    2 +-
 drivers/ieee1394/csr1212.h   |    1 +
 drivers/ieee1394/highlevel.c |    9 +++++----
 drivers/ieee1394/eth1394.c   |   16 +++++++---------
 drivers/ieee1394/eth1394.h   |    2 --
 drivers/ieee1394/sbp2.c      |    8 ++++----
 6 files changed, 18 insertions(+), 20 deletions(-)

Index: linux/drivers/ieee1394/csr1212.h
===================================================================
--- linux.orig/drivers/ieee1394/csr1212.h	2006-04-24 22:20:24.000000000 +0200
+++ linux/drivers/ieee1394/csr1212.h	2006-06-03 12:52:32.000000000 +0200
@@ -192,6 +192,7 @@
 
 #define  CSR1212_EXTENDED_ROM_SIZE		(0x10000 * sizeof(u_int32_t))
 
+#define  CSR1212_INVALID_ADDR_SPACE		-1
 
 /* Config ROM image structures */
 struct csr1212_bus_info_block_img {
Index: linux/drivers/ieee1394/csr1212.c
===================================================================
--- linux.orig/drivers/ieee1394/csr1212.c	2006-04-24 22:20:24.000000000 +0200
+++ linux/drivers/ieee1394/csr1212.c	2006-06-03 12:12:20.000000000 +0200
@@ -779,7 +779,7 @@ static int csr1212_append_new_cache(stru
 	romsize = (romsize + (csr->max_rom - 1)) & ~(csr->max_rom - 1);
 
 	csr_addr = csr->ops->allocate_addr_range(romsize, csr->max_rom, csr->private);
-	if (csr_addr == ~0ULL) {
+	if (csr_addr == CSR1212_INVALID_ADDR_SPACE) {
 		return CSR1212_ENOMEM;
 	}
 	if (csr_addr < CSR1212_REGISTER_SPACE_BASE) {
Index: linux/drivers/ieee1394/highlevel.c
===================================================================
--- linux.orig/drivers/ieee1394/highlevel.c	2006-06-03 02:13:18.000000000 +0200
+++ linux/drivers/ieee1394/highlevel.c	2006-06-03 12:18:23.000000000 +0200
@@ -301,7 +301,7 @@ u64 hpsb_allocate_and_register_addrspace
 {
 	struct hpsb_address_serve *as, *a1, *a2;
 	struct list_head *entry;
-	u64 retval = ~0ULL;
+	u64 retval = CSR1212_INVALID_ADDR_SPACE;
 	unsigned long flags;
 	u64 align_mask = ~(alignment - 1);
 
@@ -315,9 +315,10 @@ u64 hpsb_allocate_and_register_addrspace
 
 	/* default range,
 	 * avoids controller's posted write area (see OHCI 1.1 clause 1.5) */
-	if (start == ~0ULL && end == ~0ULL) {
+	if (start == CSR1212_INVALID_ADDR_SPACE &&
+	    end   == CSR1212_INVALID_ADDR_SPACE) {
 		start = host->middle_addr_space;
-		end = CSR1212_ALL_SPACE_END;
+		end   = CSR1212_ALL_SPACE_END;
 	}
 
 	if (((start|end) & ~align_mask) || (start >= end) || (end > 0x1000000000000ULL)) {
@@ -361,7 +362,7 @@ u64 hpsb_allocate_and_register_addrspace
 
 	write_unlock_irqrestore(&addr_space_lock, flags);
 
-	if (retval == ~0ULL) {
+	if (retval == CSR1212_INVALID_ADDR_SPACE) {
 		kfree(as);
 	}
 
Index: linux/drivers/ieee1394/eth1394.h
===================================================================
--- linux.orig/drivers/ieee1394/eth1394.h	2006-04-24 22:20:24.000000000 +0200
+++ linux/drivers/ieee1394/eth1394.h	2006-06-03 12:14:40.000000000 +0200
@@ -32,8 +32,6 @@
  * S3200 (per Table 16-3 of IEEE 1394b-2002). */
 #define ETHER1394_REGION_ADDR_LEN	4096
 
-#define ETHER1394_INVALID_ADDR		~0ULL
-
 /* GASP identifier numbers for IPv4 over IEEE 1394 */
 #define ETHER1394_GASP_SPECIFIER_ID	0x00005E
 #define ETHER1394_GASP_SPECIFIER_ID_HI	((ETHER1394_GASP_SPECIFIER_ID >> 8) & 0xffff)
Index: linux/drivers/ieee1394/eth1394.c
===================================================================
--- linux.orig/drivers/ieee1394/eth1394.c	2006-06-03 02:13:18.000000000 +0200
+++ linux/drivers/ieee1394/eth1394.c	2006-06-03 12:22:44.000000000 +0200
@@ -367,7 +367,7 @@ static int eth1394_probe(struct device *
 	spin_lock_init(&node_info->pdg.lock);
 	INIT_LIST_HEAD(&node_info->pdg.list);
 	node_info->pdg.sz = 0;
-	node_info->fifo = ETHER1394_INVALID_ADDR;
+	node_info->fifo = CSR1212_INVALID_ADDR_SPACE;
 
 	ud->device.driver_data = node_info;
 	new_node->ud = ud;
@@ -566,13 +566,11 @@ static void ether1394_add_host (struct h
 	if (!(host->config_roms & HPSB_CONFIG_ROM_ENTRY_IP1394))
 		return;
 
-	fifo_addr = hpsb_allocate_and_register_addrspace(&eth1394_highlevel,
-							 host,
-							 &addr_ops,
-							 ETHER1394_REGION_ADDR_LEN,
-							 ETHER1394_REGION_ADDR_LEN,
-							 -1, -1);
-	if (fifo_addr == ~0ULL)
+	fifo_addr = hpsb_allocate_and_register_addrspace(
+			&eth1394_highlevel, host, &addr_ops,
+			ETHER1394_REGION_ADDR_LEN, ETHER1394_REGION_ADDR_LEN,
+			CSR1212_INVALID_ADDR_SPACE, CSR1212_INVALID_ADDR_SPACE);
+	if (fifo_addr == CSR1212_INVALID_ADDR_SPACE)
 		goto out;
 
 	/* We should really have our own alloc_hpsbdev() function in
@@ -1686,7 +1684,7 @@ static int ether1394_tx (struct sk_buff 
 			goto fail;
 		}
 		node_info = (struct eth1394_node_info*)node->ud->device.driver_data;
-		if (node_info->fifo == ETHER1394_INVALID_ADDR) {
+		if (node_info->fifo == CSR1212_INVALID_ADDR_SPACE) {
 			ret = -EAGAIN;
 			goto fail;
 		}
Index: linux/drivers/ieee1394/sbp2.c
===================================================================
--- linux.orig/drivers/ieee1394/sbp2.c	2006-06-03 11:49:18.000000000 +0200
+++ linux/drivers/ieee1394/sbp2.c	2006-06-03 12:27:16.000000000 +0200
@@ -794,7 +794,7 @@ static struct scsi_id_instance_data *sbp
 	scsi_id->ud = ud;
 	scsi_id->speed_code = IEEE1394_SPEED_100;
 	scsi_id->max_payload_size = sbp2_speedto_max_payload[IEEE1394_SPEED_100];
-	scsi_id->status_fifo_addr = ~0ULL;
+	scsi_id->status_fifo_addr = CSR1212_INVALID_ADDR_SPACE;
 	atomic_set(&scsi_id->sbp2_login_complete, 0);
 	INIT_LIST_HEAD(&scsi_id->sbp2_command_orb_inuse);
 	INIT_LIST_HEAD(&scsi_id->sbp2_command_orb_completed);
@@ -848,7 +848,7 @@ static struct scsi_id_instance_data *sbp
 			&sbp2_highlevel, ud->ne->host, &sbp2_ops,
 			sizeof(struct sbp2_status_block), sizeof(quadlet_t),
 			ud->ne->host->low_addr_space, CSR1212_ALL_SPACE_END);
-	if (scsi_id->status_fifo_addr == ~0ULL) {
+	if (scsi_id->status_fifo_addr == CSR1212_INVALID_ADDR_SPACE) {
 		SBP2_ERR("failed to allocate status FIFO address range");
 		goto failed_alloc;
 	}
@@ -1090,9 +1090,9 @@ static void sbp2_remove_device(struct sc
 		SBP2_DMA_FREE("single query logins data");
 	}
 
-	if (scsi_id->status_fifo_addr != ~0ULL)
+	if (scsi_id->status_fifo_addr != CSR1212_INVALID_ADDR_SPACE)
 		hpsb_unregister_addrspace(&sbp2_highlevel, hi->host,
-			scsi_id->status_fifo_addr);
+					  scsi_id->status_fifo_addr);
 
 	scsi_id->ud->device.driver_data = NULL;
 


