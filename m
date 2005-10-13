Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751612AbVJMTT2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751612AbVJMTT2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 15:19:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751621AbVJMTT1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 15:19:27 -0400
Received: from xproxy.gmail.com ([66.249.82.196]:65114 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751612AbVJMTTZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 15:19:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=JkC8M7u798v/N40039wBptKd5LmnAeXM/L+R1jFmmu5LAL8sjvxZ1eGCvZgrX8yk2OUsXEte6S51zIOv/W9mcPeLLIqFBSe5V1puZibITXbt1uPCCiYF5MSgeFpRXUuAuyA3hrGUz43IgCDxkEPAO7OuL4GzRyq1SUFnngRcDBc=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: [PATCH 01/14] Big kfree NULL check cleanup - drivers/scsi
Date: Thu, 13 Oct 2005 21:22:08 +0200
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>, linux-scsi@vger.kernel.org,
       "James E.J. Bottomley" <James.Bottomley@steeleye.com>,
       linuxraid@amcc.com, Eric Youngdale <eric@andante.org>,
       Tommy Thorn <Tommy.Thorn@irisa.fr>,
       John Aycock <aycock@cpsc.ucalgary.ca>,
       Russell King <rmk@arm.linux.org.uk>, Oliver Neukum <oliver@neukum.name>,
       Go Taniguchi <go@turbolinux.co.jp>, linux-eata@i-connect.net,
       Dario Ballabio <ballabio_dario@emc.com>,
       Gadi Oxman <gadio@netvision.net.il>, ipslinux@adaptec.com,
       James Smart <james.smart@emulex.com>,
       Atul Mukker <Atul.Mukker@lsil.com>,
       Andrew Vasquez <andrew.vasquez@qlogic.com>,
       Lawrence Foard <entropy@world.std.com>,
       Kai Makisara <Kai.Makisara@kolumbus.fi>,
       Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200510132122.09667.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the drivers/scsi/ part of the big kfree cleanup patch.

Remove pointless checks for NULL prior to calling kfree() in drivers/scsi/.


Sorry about the long Cc: list, but I wanted to make sure I included everyone
who's code I've changed with this patch.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

Please see the initial announcement mail on LKML with subject
"[PATCH 00/14] Big kfree NULL check cleanup"
for additional details.

 drivers/scsi/3w-9xxx.c                |    3 --
 drivers/scsi/aacraid/commsup.c        |   14 ++++---------
 drivers/scsi/advansys.c               |   12 +++--------
 drivers/scsi/aha1542.c                |   36 +++++++++++-----------------------
 drivers/scsi/aic7xxx_old.c            |    3 --
 drivers/scsi/arm/queue.c              |    3 --
 drivers/scsi/dc395x.c                 |    3 --
 drivers/scsi/dpt_i2o.c                |   27 +++++++------------------
 drivers/scsi/eata.c                   |    3 --
 drivers/scsi/ide-scsi.c               |   10 ++++-----
 drivers/scsi/ips.c                    |   18 +++++------------
 drivers/scsi/lpfc/lpfc_els.c          |    9 ++------
 drivers/scsi/lpfc/lpfc_init.c         |    6 +----
 drivers/scsi/lpfc/lpfc_mbox.c         |    7 +-----
 drivers/scsi/lpfc/lpfc_sli.c          |    7 +-----
 drivers/scsi/megaraid/megaraid_mbox.c |    5 +---
 drivers/scsi/megaraid/megaraid_mm.c   |   11 ++--------
 drivers/scsi/qla2xxx/qla_init.c       |   16 ++++-----------
 drivers/scsi/sg.c                     |    9 ++------
 drivers/scsi/st.c                     |    3 --
 drivers/scsi/u14-34f.c                |    9 ++++----
 21 files changed, 73 insertions(+), 141 deletions(-)

--- linux-2.6.14-rc4-orig/drivers/scsi/arm/queue.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/drivers/scsi/arm/queue.c	2005-10-12 17:08:25.000000000 +0200
@@ -91,8 +91,7 @@ void queue_free (Queue_t *queue)
 {
 	if (!list_empty(&queue->head))
 		printk(KERN_WARNING "freeing non-empty queue %p\n", queue);
-	if (queue->alloc)
-		kfree(queue->alloc);
+	kfree(queue->alloc);
 }
      
 
--- linux-2.6.14-rc4-orig/drivers/scsi/lpfc/lpfc_init.c	2005-10-11 22:41:20.000000000 +0200
+++ linux-2.6.14-rc4/drivers/scsi/lpfc/lpfc_init.c	2005-10-12 17:09:03.000000000 +0200
@@ -888,8 +888,7 @@ lpfc_post_buffer(struct lpfc_hba * phba,
 		    mp1->virt = lpfc_mbuf_alloc(phba, MEM_PRI,
 						&mp1->phys);
 		if (mp1 == 0 || mp1->virt == 0) {
-			if (mp1)
-				kfree(mp1);
+			kfree(mp1);
 			spin_lock_irq(phba->host->host_lock);
 			list_add_tail(&iocb->list, lpfc_iocb_list);
 			spin_unlock_irq(phba->host->host_lock);
@@ -905,8 +904,7 @@ lpfc_post_buffer(struct lpfc_hba * phba,
 				mp2->virt = lpfc_mbuf_alloc(phba, MEM_PRI,
 							    &mp2->phys);
 			if (mp2 == 0 || mp2->virt == 0) {
-				if (mp2)
-					kfree(mp2);
+				kfree(mp2);
 				lpfc_mbuf_free(phba, mp1->virt, mp1->phys);
 				kfree(mp1);
 				spin_lock_irq(phba->host->host_lock);
--- linux-2.6.14-rc4-orig/drivers/scsi/lpfc/lpfc_mbox.c	2005-10-11 22:41:20.000000000 +0200
+++ linux-2.6.14-rc4/drivers/scsi/lpfc/lpfc_mbox.c	2005-10-12 17:09:18.000000000 +0200
@@ -248,8 +248,7 @@ lpfc_read_sparam(struct lpfc_hba * phba,
 
 	if (((mp = kmalloc(sizeof (struct lpfc_dmabuf), GFP_KERNEL)) == 0) ||
 	    ((mp->virt = lpfc_mbuf_alloc(phba, 0, &(mp->phys))) == 0)) {
-		if (mp)
-			kfree(mp);
+		kfree(mp);
 		mb->mbxCommand = MBX_READ_SPARM64;
 		/* READ_SPARAM: no buffers */
 		lpfc_printf_log(phba,
@@ -363,9 +362,7 @@ lpfc_reg_login(struct lpfc_hba * phba,
 	/* Get a buffer to hold NPorts Service Parameters */
 	if (((mp = kmalloc(sizeof (struct lpfc_dmabuf), GFP_KERNEL)) == NULL) ||
 	    ((mp->virt = lpfc_mbuf_alloc(phba, 0, &(mp->phys))) == 0)) {
-		if (mp)
-			kfree(mp);
-
+		kfree(mp);
 		mb->mbxCommand = MBX_REG_LOGIN64;
 		/* REG_LOGIN: no buffers */
 		lpfc_printf_log(phba,
--- linux-2.6.14-rc4-orig/drivers/scsi/lpfc/lpfc_els.c	2005-10-11 22:41:19.000000000 +0200
+++ linux-2.6.14-rc4/drivers/scsi/lpfc/lpfc_els.c	2005-10-12 17:09:55.000000000 +0200
@@ -130,8 +130,7 @@ lpfc_prep_els_iocb(struct lpfc_hba * phb
 	if (((pcmd = kmalloc(sizeof (struct lpfc_dmabuf), GFP_KERNEL)) == 0) ||
 	    ((pcmd->virt = lpfc_mbuf_alloc(phba,
 					   MEM_PRI, &(pcmd->phys))) == 0)) {
-		if (pcmd)
-			kfree(pcmd);
+		kfree(pcmd);
 
 		list_add_tail(&elsiocb->list, lpfc_iocb_list);
 		return NULL;
@@ -146,8 +145,7 @@ lpfc_prep_els_iocb(struct lpfc_hba * phb
 			prsp->virt = lpfc_mbuf_alloc(phba, MEM_PRI,
 						     &prsp->phys);
 		if (prsp == 0 || prsp->virt == 0) {
-			if (prsp)
-				kfree(prsp);
+			kfree(prsp);
 			lpfc_mbuf_free(phba, pcmd->virt, pcmd->phys);
 			kfree(pcmd);
 			list_add_tail(&elsiocb->list, lpfc_iocb_list);
@@ -169,8 +167,7 @@ lpfc_prep_els_iocb(struct lpfc_hba * phb
 		lpfc_mbuf_free(phba, prsp->virt, prsp->phys);
 		kfree(pcmd);
 		kfree(prsp);
-		if (pbuflist)
-			kfree(pbuflist);
+		kfree(pbuflist);
 		return NULL;
 	}
 
--- linux-2.6.14-rc4-orig/drivers/scsi/lpfc/lpfc_sli.c	2005-10-11 22:41:20.000000000 +0200
+++ linux-2.6.14-rc4/drivers/scsi/lpfc/lpfc_sli.c	2005-10-12 17:10:25.000000000 +0200
@@ -2300,11 +2300,8 @@ lpfc_sli_hba_down(struct lpfc_hba * phba
 
 		INIT_LIST_HEAD(&(pring->txq));
 
-		if (pring->fast_lookup) {
-			kfree(pring->fast_lookup);
-			pring->fast_lookup = NULL;
-		}
-
+		kfree(pring->fast_lookup);
+		pring->fast_lookup = NULL;
 	}
 
 	spin_unlock_irqrestore(phba->host->host_lock, flags);
--- linux-2.6.14-rc4-orig/drivers/scsi/sg.c	2005-10-11 22:41:20.000000000 +0200
+++ linux-2.6.14-rc4/drivers/scsi/sg.c	2005-10-12 17:12:22.000000000 +0200
@@ -475,8 +475,7 @@ sg_read(struct file *filp, char __user *
 	sg_finish_rem_req(srp);
 	retval = count;
 free_old_hdr:
-	if (old_hdr)
-		kfree(old_hdr);
+	kfree(old_hdr);
 	return retval;
 }
 
@@ -1706,10 +1705,8 @@ exit_sg(void)
 	sg_sysfs_valid = 0;
 	unregister_chrdev_region(MKDEV(SCSI_GENERIC_MAJOR, 0),
 				 SG_MAX_DEVS);
-	if (sg_dev_arr != NULL) {
-		kfree((char *) sg_dev_arr);
-		sg_dev_arr = NULL;
-	}
+	kfree((char *)sg_dev_arr);
+	sg_dev_arr = NULL;
 	sg_dev_max = 0;
 }
 
--- linux-2.6.14-rc4-orig/drivers/scsi/st.c	2005-10-11 22:41:20.000000000 +0200
+++ linux-2.6.14-rc4/drivers/scsi/st.c	2005-10-12 17:12:41.000000000 +0200
@@ -4108,8 +4108,7 @@ out_free_tape:
 	write_unlock(&st_dev_arr_lock);
 out_put_disk:
 	put_disk(disk);
-	if (tpnt)
-		kfree(tpnt);
+	kfree(tpnt);
 out_buffer_free:
 	kfree(buffer);
 out:
--- linux-2.6.14-rc4-orig/drivers/scsi/qla2xxx/qla_init.c	2005-10-11 22:41:20.000000000 +0200
+++ linux-2.6.14-rc4/drivers/scsi/qla2xxx/qla_init.c	2005-10-12 17:13:23.000000000 +0200
@@ -1966,8 +1966,7 @@ qla2x00_configure_local_loop(scsi_qla_ho
 	}
 
 cleanup_allocation:
-	if (new_fcport)
-		kfree(new_fcport);
+	kfree(new_fcport);
 
 	if (rval != QLA_SUCCESS) {
 		DEBUG2(printk("scsi(%ld): Configure local loop error exit: "
@@ -2337,8 +2336,7 @@ qla2x00_find_all_fabric_devs(scsi_qla_ho
 	/* Allocate temporary fcport for any new fcports discovered. */
 	new_fcport = qla2x00_alloc_fcport(ha, GFP_KERNEL);
 	if (new_fcport == NULL) {
-		if (swl)
-			kfree(swl);
+		kfree(swl);
 		return (QLA_MEMORY_ALLOC_FAILED);
 	}
 	new_fcport->flags |= (FCF_FABRIC_DEVICE | FCF_LOGIN_NEEDED);
@@ -2474,19 +2472,15 @@ qla2x00_find_all_fabric_devs(scsi_qla_ho
 		nxt_d_id.b24 = new_fcport->d_id.b24;
 		new_fcport = qla2x00_alloc_fcport(ha, GFP_KERNEL);
 		if (new_fcport == NULL) {
-			if (swl)
-				kfree(swl);
+			kfree(swl);
 			return (QLA_MEMORY_ALLOC_FAILED);
 		}
 		new_fcport->flags |= (FCF_FABRIC_DEVICE | FCF_LOGIN_NEEDED);
 		new_fcport->d_id.b24 = nxt_d_id.b24;
 	}
 
-	if (swl)
-		kfree(swl);
-
-	if (new_fcport)
-		kfree(new_fcport);
+	kfree(swl);
+	kfree(new_fcport);
 
 	if (!list_empty(new_fcports))
 		ha->device_flags |= DFLG_FABRIC_DEVICES;
--- linux-2.6.14-rc4-orig/drivers/scsi/ide-scsi.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/drivers/scsi/ide-scsi.c	2005-10-12 17:15:01.000000000 +0200
@@ -325,9 +325,9 @@ static int idescsi_check_condition(ide_d
 	rq = kmalloc (sizeof (struct request), GFP_ATOMIC);
 	buf = kmalloc(SCSI_SENSE_BUFFERSIZE, GFP_ATOMIC);
 	if (pc == NULL || rq == NULL || buf == NULL) {
-		if (pc) kfree(pc);
-		if (rq) kfree(rq);
-		if (buf) kfree(buf);
+		kfree(buf);
+		kfree(rq);
+		kfree(pc);
 		return -ENOMEM;
 	}
 	memset (pc, 0, sizeof (idescsi_pc_t));
@@ -943,8 +943,8 @@ static int idescsi_queue (struct scsi_cm
 	spin_lock_irq(host->host_lock);
 	return 0;
 abort:
-	if (pc) kfree (pc);
-	if (rq) kfree (rq);
+	kfree (pc);
+	kfree (rq);
 	cmd->result = DID_ERROR << 16;
 	done(cmd);
 	return 0;
--- linux-2.6.14-rc4-orig/drivers/scsi/ips.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/drivers/scsi/ips.c	2005-10-12 17:15:29.000000000 +0200
@@ -4491,10 +4491,8 @@ ips_free(ips_ha_t * ha)
 			ha->enq = NULL;
 		}
 
-		if (ha->conf) {
-			kfree(ha->conf);
-			ha->conf = NULL;
-		}
+		kfree(ha->conf);
+		ha->conf = NULL;
 
 		if (ha->adapt) {
 			pci_free_consistent(ha->pcidev,
@@ -4512,15 +4510,11 @@ ips_free(ips_ha_t * ha)
 			ha->logical_drive_info = NULL;
 		}
 
-		if (ha->nvram) {
-			kfree(ha->nvram);
-			ha->nvram = NULL;
-		}
+		kfree(ha->nvram);
+		ha->nvram = NULL;
 
-		if (ha->subsys) {
-			kfree(ha->subsys);
-			ha->subsys = NULL;
-		}
+		kfree(ha->subsys);
+		ha->subsys = NULL;
 
 		if (ha->ioctl_data) {
 			pci_free_consistent(ha->pcidev, ha->ioctl_len,
--- linux-2.6.14-rc4-orig/drivers/scsi/aha1542.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/drivers/scsi/aha1542.c	2005-10-12 17:16:32.000000000 +0200
@@ -543,10 +543,8 @@ static void aha1542_intr_handle(struct S
 			return;
 		}
 		my_done = SCtmp->scsi_done;
-		if (SCtmp->host_scribble) {
-			kfree(SCtmp->host_scribble);
-			SCtmp->host_scribble = NULL;
-		}
+		kfree(SCtmp->host_scribble);
+		SCtmp->host_scribble = NULL;
 		/* Fetch the sense data, and tuck it away, in the required slot.  The
 		   Adaptec automatically fetches it, and there is no guarantee that
 		   we will still have it in the cdb when we come back */
@@ -1431,10 +1429,8 @@ static int aha1542_dev_reset(Scsi_Cmnd *
 		    HOSTDATA(SCpnt->host)->SCint[i]->target == SCpnt->target) {
 			Scsi_Cmnd *SCtmp;
 			SCtmp = HOSTDATA(SCpnt->host)->SCint[i];
-			if (SCtmp->host_scribble) {
-				kfree(SCtmp->host_scribble);
-				SCtmp->host_scribble = NULL;
-			}
+			kfree(SCtmp->host_scribble);
+			SCtmp->host_scribble = NULL;
 			HOSTDATA(SCpnt->host)->SCint[i] = NULL;
 			HOSTDATA(SCpnt->host)->mb[i].status = 0;
 		}
@@ -1494,10 +1490,8 @@ static int aha1542_bus_reset(Scsi_Cmnd *
 				 */
 				continue;
 			}
-			if (SCtmp->host_scribble) {
-				kfree(SCtmp->host_scribble);
-				SCtmp->host_scribble = NULL;
-			}
+			kfree(SCtmp->host_scribble);
+			SCtmp->host_scribble = NULL;
 			HOSTDATA(SCpnt->device->host)->SCint[i] = NULL;
 			HOSTDATA(SCpnt->device->host)->mb[i].status = 0;
 		}
@@ -1564,10 +1558,8 @@ static int aha1542_host_reset(Scsi_Cmnd 
 				 */
 				continue;
 			}
-			if (SCtmp->host_scribble) {
-				kfree(SCtmp->host_scribble);
-				SCtmp->host_scribble = NULL;
-			}
+			kfree(SCtmp->host_scribble);
+			SCtmp->host_scribble = NULL;
 			HOSTDATA(SCpnt->device->host)->SCint[i] = NULL;
 			HOSTDATA(SCpnt->device->host)->mb[i].status = 0;
 		}
@@ -1710,10 +1702,8 @@ static int aha1542_old_reset(Scsi_Cmnd *
 				Scsi_Cmnd *SCtmp;
 				SCtmp = HOSTDATA(SCpnt->host)->SCint[i];
 				SCtmp->result = DID_RESET << 16;
-				if (SCtmp->host_scribble) {
-					kfree(SCtmp->host_scribble);
-					SCtmp->host_scribble = NULL;
-				}
+				kfree(SCtmp->host_scribble);
+				SCtmp->host_scribble = NULL;
 				printk(KERN_WARNING "Sending DID_RESET for target %d\n", SCpnt->target);
 				SCtmp->scsi_done(SCpnt);
 
@@ -1756,10 +1746,8 @@ fail:
 						Scsi_Cmnd *SCtmp;
 						SCtmp = HOSTDATA(SCpnt->host)->SCint[i];
 						SCtmp->result = DID_RESET << 16;
-						if (SCtmp->host_scribble) {
-							kfree(SCtmp->host_scribble);
-							SCtmp->host_scribble = NULL;
-						}
+						kfree(SCtmp->host_scribble);
+						SCtmp->host_scribble = NULL;
 						printk(KERN_WARNING "Sending DID_RESET for target %d\n", SCpnt->target);
 						SCtmp->scsi_done(SCpnt);
 
--- linux-2.6.14-rc4-orig/drivers/scsi/dpt_i2o.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/drivers/scsi/dpt_i2o.c	2005-10-12 17:18:23.000000000 +0200
@@ -1037,18 +1037,10 @@ static void adpt_i2o_delete_hba(adpt_hba
 	if(pHba->msg_addr_virt != pHba->base_addr_virt){
 		iounmap(pHba->msg_addr_virt);
 	}
-	if(pHba->hrt) {
-		kfree(pHba->hrt);
-	}
-	if(pHba->lct){
-		kfree(pHba->lct);
-	}
-	if(pHba->status_block) {
-		kfree(pHba->status_block);
-	}
-	if(pHba->reply_pool){
-		kfree(pHba->reply_pool);
-	}
+	kfree(pHba->hrt);
+	kfree(pHba->lct);
+	kfree(pHba->status_block);
+	kfree(pHba->reply_pool);
 
 	for(d = pHba->devices; d ; d = next){
 		next = d->next;
@@ -2716,14 +2708,12 @@ static s32 adpt_i2o_init_outbound_q(adpt
 	// If the command was successful, fill the fifo with our reply
 	// message packets
 	if(*status != 0x04 /*I2O_EXEC_OUTBOUND_INIT_COMPLETE*/) {
-		kfree((void*)status);
+		kfree(status);
 		return -2;
 	}
-	kfree((void*)status);
+	kfree(status);
 
-	if(pHba->reply_pool != NULL){
-		kfree(pHba->reply_pool);
-	}
+	kfree(pHba->reply_pool);
 
 	pHba->reply_pool = (u32*)kmalloc(pHba->reply_fifo_size * REPLY_FRAME_SIZE * 4, GFP_KERNEL|ADDR32);
 	if(!pHba->reply_pool){
@@ -2941,8 +2931,7 @@ static int adpt_i2o_build_sys_table(void
 	sys_tbl_len = sizeof(struct i2o_sys_tbl) +	// Header + IOPs
 				(hba_count) * sizeof(struct i2o_sys_tbl_entry);
 
-	if(sys_tbl)
-		kfree(sys_tbl);
+	kfree(sys_tbl);
 
 	sys_tbl = kmalloc(sys_tbl_len, GFP_KERNEL|ADDR32);
 	if(!sys_tbl) {
--- linux-2.6.14-rc4-orig/drivers/scsi/aic7xxx_old.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/drivers/scsi/aic7xxx_old.c	2005-10-12 17:19:38.000000000 +0200
@@ -8492,8 +8492,7 @@ aic7xxx_free(struct aic7xxx_host *p)
                                      - scb_dma->dma_offset),
 			    scb_dma->dma_address);
       }
-      if (p->scb_data->scb_array[i]->kmalloc_ptr != NULL)
-        kfree(p->scb_data->scb_array[i]->kmalloc_ptr);
+      kfree(p->scb_data->scb_array[i]->kmalloc_ptr);
       p->scb_data->scb_array[i] = NULL;
     }
   
--- linux-2.6.14-rc4-orig/drivers/scsi/eata.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/drivers/scsi/eata.c	2005-10-12 17:19:55.000000000 +0200
@@ -2590,8 +2590,7 @@ static int eata2x_release(struct Scsi_Ho
 	unsigned int i;
 
 	for (i = 0; i < shost->can_queue; i++)
-		if ((&ha->cp[i])->sglist)
-			kfree((&ha->cp[i])->sglist);
+		kfree((&ha->cp[i])->sglist);
 
 	for (i = 0; i < shost->can_queue; i++)
 		pci_unmap_single(ha->pdev, ha->cp[i].cp_dma_addr,
--- linux-2.6.14-rc4-orig/drivers/scsi/3w-9xxx.c	2005-10-11 22:41:13.000000000 +0200
+++ linux-2.6.14-rc4/drivers/scsi/3w-9xxx.c	2005-10-12 17:20:08.000000000 +0200
@@ -1017,8 +1017,7 @@ static void twa_free_device_extension(TW
 				    tw_dev->generic_buffer_virt[0],
 				    tw_dev->generic_buffer_phys[0]);
 
-	if (tw_dev->event_queue[0])
-		kfree(tw_dev->event_queue[0]);
+	kfree(tw_dev->event_queue[0]);
 } /* End twa_free_device_extension() */
 
 /* This function will free a request id */
--- linux-2.6.14-rc4-orig/drivers/scsi/dc395x.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/drivers/scsi/dc395x.c	2005-10-12 17:20:22.000000000 +0200
@@ -4257,8 +4257,7 @@ static void adapter_sg_tables_free(struc
 	const unsigned srbs_per_page = PAGE_SIZE/SEGMENTX_LEN;
 
 	for (i = 0; i < DC395x_MAX_SRB_CNT; i += srbs_per_page)
-		if (acb->srb_array[i].segment_x)
-			kfree(acb->srb_array[i].segment_x);
+		kfree(acb->srb_array[i].segment_x);
 }
 
 
--- linux-2.6.14-rc4-orig/drivers/scsi/aacraid/commsup.c	2005-10-11 22:41:13.000000000 +0200
+++ linux-2.6.14-rc4/drivers/scsi/aacraid/commsup.c	2005-10-12 17:21:55.000000000 +0200
@@ -1136,7 +1136,7 @@ int aac_command_thread(struct aac_dev * 
 						kfree(hw_fib_pool);
 						hw_fib_pool = NULL;
 					}
-				} else if (hw_fib_pool) {
+				} else {
 					kfree(hw_fib_pool);
 					hw_fib_pool = NULL;
 				}
@@ -1219,17 +1219,13 @@ int aac_command_thread(struct aac_dev * 
 				hw_fib_p = hw_fib_pool;
 				fib_p = fib_pool;
 				while (hw_fib_p < &hw_fib_pool[num]) {
-					if (*hw_fib_p)
-						kfree(*hw_fib_p);
-					if (*fib_p)
-						kfree(*fib_p);
+					kfree(*hw_fib_p);
+					kfree(*fib_p);
 					++fib_p;
 					++hw_fib_p;
 				}
-				if (hw_fib_pool)
-					kfree(hw_fib_pool);
-				if (fib_pool)
-					kfree(fib_pool);
+				kfree(hw_fib_pool);
+				kfree(fib_pool);
 			}
 			kfree(fib);
 			spin_lock_irqsave(dev->queues->queue[HostNormCmdQueue].lock, flags);
--- linux-2.6.14-rc4-orig/drivers/scsi/megaraid/megaraid_mbox.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/drivers/scsi/megaraid/megaraid_mbox.c	2005-10-12 17:22:27.000000000 +0200
@@ -3939,9 +3939,8 @@ megaraid_sysfs_free_resources(adapter_t 
 {
 	mraid_device_t	*raid_dev = ADAP2RAIDDEV(adapter);
 
-	if (raid_dev->sysfs_uioc) kfree(raid_dev->sysfs_uioc);
-
-	if (raid_dev->sysfs_mbox64) kfree(raid_dev->sysfs_mbox64);
+	kfree(raid_dev->sysfs_uioc);
+	kfree(raid_dev->sysfs_mbox64);
 
 	if (raid_dev->sysfs_buffer) {
 		pci_free_consistent(adapter->pdev, PAGE_SIZE,
--- linux-2.6.14-rc4-orig/drivers/scsi/megaraid/megaraid_mm.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/drivers/scsi/megaraid/megaraid_mm.c	2005-10-12 17:22:55.000000000 +0200
@@ -995,17 +995,13 @@ pthru_dma_pool_error:
 
 memalloc_error:
 
-	if (adapter->kioc_list)
-		kfree(adapter->kioc_list);
-
-	if (adapter->mbox_list)
-		kfree(adapter->mbox_list);
+	kfree(adapter->kioc_list);
+	kfree(adapter->mbox_list);
 
 	if (adapter->pthru_dma_pool)
 		pci_pool_destroy(adapter->pthru_dma_pool);
 
-	if (adapter)
-		kfree(adapter);
+	kfree(adapter);
 
 	return rval;
 }
@@ -1157,7 +1153,6 @@ mraid_mm_free_adp_resources(mraid_mmadp_
 	}
 
 	kfree(adp->kioc_list);
-
 	kfree(adp->mbox_list);
 
 	pci_pool_destroy(adp->pthru_dma_pool);
--- linux-2.6.14-rc4-orig/drivers/scsi/advansys.c	2005-10-11 22:41:13.000000000 +0200
+++ linux-2.6.14-rc4/drivers/scsi/advansys.c	2005-10-12 17:25:49.000000000 +0200
@@ -5402,10 +5402,8 @@ advansys_detect(struct scsi_host_templat
                 release_region(shp->io_port, boardp->asc_n_io_port);
                 if (ASC_WIDE_BOARD(boardp)) {
                     iounmap(boardp->ioremap_addr);
-                    if (boardp->orig_carrp) {
-                        kfree(boardp->orig_carrp);
-                        boardp->orig_carrp = NULL;
-                    }
+                    kfree(boardp->orig_carrp);
+                    boardp->orig_carrp = NULL;
                     if (boardp->orig_reqp) {
                         kfree(boardp->orig_reqp);
                         boardp->orig_reqp = boardp->adv_reqp = NULL;
@@ -5457,10 +5455,8 @@ advansys_release(struct Scsi_Host *shp)
         adv_sgblk_t    *sgp = NULL;
 
         iounmap(boardp->ioremap_addr);
-        if (boardp->orig_carrp) {
-            kfree(boardp->orig_carrp);
-            boardp->orig_carrp = NULL;
-        }
+        kfree(boardp->orig_carrp);
+        boardp->orig_carrp = NULL;
         if (boardp->orig_reqp) {
             kfree(boardp->orig_reqp);
             boardp->orig_reqp = boardp->adv_reqp = NULL;
--- linux-2.6.14-rc4-orig/drivers/scsi/u14-34f.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/drivers/scsi/u14-34f.c	2005-10-12 17:36:07.000000000 +0200
@@ -1956,11 +1956,11 @@ static int u14_34f_release(struct Scsi_H
 
    for (j = 0; sh[j] != NULL && sh[j] != shpnt; j++);
 
-   if (sh[j] == NULL) panic("%s: release, invalid Scsi_Host pointer.\n",
-                            driver_name);
+   if (sh[j] == NULL)
+      panic("%s: release, invalid Scsi_Host pointer.\n", driver_name);
 
    for (i = 0; i < sh[j]->can_queue; i++)
-      if ((&HD(j)->cp[i])->sglist) kfree((&HD(j)->cp[i])->sglist);
+      kfree((&HD(j)->cp[i])->sglist);
 
    for (i = 0; i < sh[j]->can_queue; i++)
       pci_unmap_single(HD(j)->pdev, HD(j)->cp[i].cp_dma_addr,
@@ -1968,7 +1968,8 @@ static int u14_34f_release(struct Scsi_H
 
    free_irq(sh[j]->irq, &sha[j]);
 
-   if (sh[j]->dma_channel != NO_DMA) free_dma(sh[j]->dma_channel);
+   if (sh[j]->dma_channel != NO_DMA)
+      free_dma(sh[j]->dma_channel);
 
    release_region(sh[j]->io_port, sh[j]->n_io_port);
    scsi_unregister(sh[j]);



