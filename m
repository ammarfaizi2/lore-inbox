Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261646AbVDWSE5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261646AbVDWSE5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 14:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261641AbVDWSE5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 14:04:57 -0400
Received: from bernache.ens-lyon.fr ([140.77.167.10]:5768 "EHLO
	bernache.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S261642AbVDWSEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 14:04:20 -0400
Date: Sat, 23 Apr 2005 20:03:55 +0200
From: Benoit Boissinot <benoit.boissinot@ens-lyon.org>
To: Andrew Morton <akpm@osdl.org>
Cc: James.Bottomley@steeleye.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       Markus Lidel <Markus.Lidel@shadowconnect.com>, Mark_Salyzyn@adaptec.com
Subject: [2.6 PATCH] drivers/scsi/dpt_i2o.c: fix compile warnings
Message-ID: <20050423180355.GD8057@ens-lyon.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.8i
X-Spam-Report: *  1.1 NO_DNS_FOR_FROM Domain in From header has no MX or A DNS records
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following warnings:

drivers/scsi/dpt_i2o.c: In function ‘adpt_isr’:
drivers/scsi/dpt_i2o.c:2030: warning: passing argument 1 of ‘readl’ makes pointer from integer without a cast
drivers/scsi/dpt_i2o.c:2031: warning: passing argument 1 of ‘readl’ makes pointer from integer without a cast
drivers/scsi/dpt_i2o.c:2042: warning: passing argument 1 of ‘readl’ makes pointer from integer without a cast
drivers/scsi/dpt_i2o.c:2043: warning: passing argument 2 of ‘writel’ makes pointer from integer without a cast
drivers/scsi/dpt_i2o.c:2046: warning: passing argument 1 of ‘readl’ makes pointer from integer without a cast
drivers/scsi/dpt_i2o.c:2048: warning: passing argument 1 of ‘readl’ makes pointer from integer without a cast
drivers/scsi/dpt_i2o.c:2055: warning: passing argument 1 of ‘readl’ makes pointer from integer without a cast
drivers/scsi/dpt_i2o.c:2062: warning: passing argument 1 of ‘readl’ makes pointer from integer without a cast
drivers/scsi/dpt_i2o.c:2069: warning: passing argument 1 of ‘readl’ makes pointer from integer without a cast
drivers/scsi/dpt_i2o.c: In function ‘adpt_i2o_to_scsi’: drivers/scsi/dpt_i2o.c:2239: warning: passing argument 1 of ‘readl’ makes pointer from integer without a cast
drivers/scsi/dpt_i2o.c:2243: warning: passing argument 1 of ‘readl’ makes pointer from integer without a cast
drivers/scsi/dpt_i2o.c:2248: warning: passing argument 1 of ‘readl’ makes pointer from integer without a cast
drivers/scsi/dpt_i2o.c:2259: warning: passing argument 1 of ‘readl’ makes pointer from integer without a cast

It define variables which are only used with a type of 'void __iomem *'
with this type instead of the incorrect 'unsigned long' type.
It also remove pointless casts.

Signed-off-by: Benoit Boissinot <benoit.boissinot@ens-lyon.org>


diff -Naup tmp.orig/dpt_i2o.c tmp/dpt_i2o.c
--- tmp.orig/drivers/scsi/dpt_i2o.c	2005-04-22 19:26:51.000000000 +0200
+++ tmp/drivers/scsi/dpt_i2o.c	2005-04-23 16:21:50.000000000 +0200
@@ -691,7 +691,7 @@ static int adpt_device_reset(struct scsi
 	u32 msg[4];
 	u32 rcode;
 	int old_state;
-	struct adpt_device* d = (void*) cmd->device->hostdata;
+	struct adpt_device* d = cmd->device->hostdata;
 
 	pHba = (void*) cmd->device->host->hostdata[0];
 	printk(KERN_INFO"%s: Trying to reset device\n",pHba->name);
@@ -707,7 +707,7 @@ static int adpt_device_reset(struct scsi
 
 	old_state = d->state;
 	d->state |= DPTI_DEV_RESET;
-	if( (rcode = adpt_i2o_post_wait(pHba, (void*)msg,sizeof(msg), FOREVER)) ){
+	if( (rcode = adpt_i2o_post_wait(pHba, msg,sizeof(msg), FOREVER)) ){
 		d->state = old_state;
 		if(rcode == -EOPNOTSUPP ){
 			printk(KERN_INFO"%s: Device reset not supported\n",pHba->name);
@@ -737,7 +737,7 @@ static int adpt_bus_reset(struct scsi_cm
 	msg[1] = (I2O_HBA_BUS_RESET<<24|HOST_TID<<12|pHba->channel[cmd->device->channel].tid);
 	msg[2] = 0;
 	msg[3] = 0;
-	if(adpt_i2o_post_wait(pHba, (void*)msg,sizeof(msg), FOREVER) ){
+	if(adpt_i2o_post_wait(pHba, msg,sizeof(msg), FOREVER) ){
 		printk(KERN_WARNING"%s: Bus reset failed.\n",pHba->name);
 		return FAILED;
 	} else {
@@ -1454,7 +1454,7 @@ static int adpt_i2o_parse_lct(adpt_hba* 
 			return -ENOMEM;
 		}
 		
-		d->controller = (void*)pHba;
+		d->controller = pHba;
 		d->next = NULL;
 
 		memcpy(&d->lct_data, &lct->lct_entry[i], sizeof(i2o_lct_entry));
@@ -2000,7 +2000,7 @@ static irqreturn_t adpt_isr(int irq, voi
 	struct scsi_cmnd* cmd;
 	adpt_hba* pHba = dev_id;
 	u32 m;
-	ulong reply;
+	void __iomem *reply;
 	u32 status=0;
 	u32 context;
 	ulong flags = 0;
@@ -2025,11 +2025,11 @@ static irqreturn_t adpt_isr(int irq, voi
 				goto out;
 			}
 		}
-		reply = (ulong)bus_to_virt(m);
+		reply = bus_to_virt(m);
 
 		if (readl(reply) & MSG_FAIL) {
 			u32 old_m = readl(reply+28); 
-			ulong msg;
+			void __iomem *msg;
 			u32 old_context;
 			PDEBUG("%s: Failed message\n",pHba->name);
 			if(old_m >= 0x100000){
@@ -2038,16 +2038,16 @@ static irqreturn_t adpt_isr(int irq, voi
 				continue;
 			}
 			// Transaction context is 0 in failed reply frame
-			msg = (ulong)(pHba->msg_addr_virt + old_m);
+			msg = pHba->msg_addr_virt + old_m;
 			old_context = readl(msg+12);
 			writel(old_context, reply+12);
 			adpt_send_nop(pHba, old_m);
 		} 
 		context = readl(reply+8);
 		if(context & 0x40000000){ // IOCTL
-			ulong p = (ulong)(readl(reply+12));
-			if( p != 0) {
-				memcpy((void*)p, (void*)reply, REPLY_FRAME_SIZE * 4);
+			void *p = (void *)readl(reply+12);
+			if( p != NULL) {
+				memcpy_fromio(p, reply, REPLY_FRAME_SIZE * 4);
 			}
 			// All IOCTLs will also be post wait
 		}
@@ -2231,7 +2231,7 @@ static s32 adpt_scsi_register(adpt_hba* 
 }
 
 
-static s32 adpt_i2o_to_scsi(ulong reply, struct scsi_cmnd* cmd)
+static s32 adpt_i2o_to_scsi(void __iomem *reply, struct scsi_cmnd* cmd)
 {
 	adpt_hba* pHba;
 	u32 hba_status;
@@ -2323,7 +2323,7 @@ static s32 adpt_i2o_to_scsi(ulong reply,
 			u32 len = sizeof(cmd->sense_buffer);
 			len = (len > 40) ?  40 : len;
 			// Copy over the sense data
-			memcpy(cmd->sense_buffer, (void*)(reply+28) , len);
+			memcpy_fromio(cmd->sense_buffer, (reply+28) , len);
 			if(cmd->sense_buffer[0] == 0x70 /* class 7 */ && 
 			   cmd->sense_buffer[2] == DATA_PROTECT ){
 				/* This is to handle an array failed */
@@ -2438,7 +2438,7 @@ static s32 adpt_i2o_reparse_lct(adpt_hba
 					return -ENOMEM;
 				}
 				
-				d->controller = (void*)pHba;
+				d->controller = pHba;
 				d->next = NULL;
 
 				memcpy(&d->lct_data, &lct->lct_entry[i], sizeof(i2o_lct_entry));
@@ -2985,8 +2985,8 @@ static int adpt_i2o_build_sys_table(void
 		sys_tbl->iops[count].frame_size = pHba->status_block->inbound_frame_size;
 		sys_tbl->iops[count].last_changed = sys_tbl_ind - 1; // ??
 		sys_tbl->iops[count].iop_capabilities = pHba->status_block->iop_capabilities;
-		sys_tbl->iops[count].inbound_low = (u32)virt_to_bus((void*)pHba->post_port);
-		sys_tbl->iops[count].inbound_high = (u32)((u64)virt_to_bus((void*)pHba->post_port)>>32);
+		sys_tbl->iops[count].inbound_low = (u32)virt_to_bus(pHba->post_port);
+		sys_tbl->iops[count].inbound_high = (u32)((u64)virt_to_bus(pHba->post_port)>>32);
 
 		count++;
 	}
diff -Naup tmp.orig/dpti.h tmp/dpti.h
--- tmp.orig/drivers/scsi/dpti.h	2005-04-22 19:24:32.000000000 +0200
+++ tmp/drivers/scsi/dpti.h	2005-04-23 16:22:44.000000000 +0200
@@ -296,7 +296,7 @@ static s32 adpt_i2o_status_get(adpt_hba*
 static s32 adpt_i2o_init_outbound_q(adpt_hba* pHba);
 static s32 adpt_i2o_hrt_get(adpt_hba* pHba);
 static s32 adpt_scsi_to_i2o(adpt_hba* pHba, struct scsi_cmnd* cmd, struct adpt_device* dptdevice);
-static s32 adpt_i2o_to_scsi(ulong reply, struct scsi_cmnd* cmd);
+static s32 adpt_i2o_to_scsi(void __iomem *reply, struct scsi_cmnd* cmd);
 static s32 adpt_scsi_register(adpt_hba* pHba,struct scsi_host_template * sht);
 static s32 adpt_hba_reset(adpt_hba* pHba);
 static s32 adpt_i2o_reset_hba(adpt_hba* pHba);

