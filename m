Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261520AbVEOAwc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261520AbVEOAwc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 20:52:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261402AbVEOAwc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 20:52:32 -0400
Received: from mail.dif.dk ([193.138.115.101]:45268 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261381AbVEOAvU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 20:51:20 -0400
Date: Sun, 15 May 2005 02:55:12 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Andrew Morton <akpm@osdl.org>
Cc: "James E.J. Bottomley" <James.Bottomley@SteelEye.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-scsi <linux-scsi@vger.kernel.org>, linux-eata@i-connect.net,
       ipslinux@adaptec.com, linux@advansys.com,
       Adam Radford <linuxraid@amcc.com>,
       Richard Hirst <richard@sleepie.demon.co.uk>,
       Tommy Thorn <Tommy.Thorn@irisa.fr>, Eric Youngdale <eric@andante.org>,
       John Aycock <aycock@cpsc.ucalgary.ca>, "Erik H. Moe" <ehm@cris.com>,
       Go Taniguchi <go@turbolinux.co.jp>, Gadi Oxman <gadio@netvision.net.il>,
       Willem Riede <osst@riede.org>, Jakub Jelinek <jj@sunsite.mff.cuni.cz>,
       Douglas Gilbert <dgilbert@interlog.com>,
       Kai Makisara <Kai.Makisara@kolumbus.fi>,
       Dario Ballabio <dario.ballabio@tiscalinet.it>
Subject: [PATCH] kfree and vfree cleanups for drivers/scsi/* (fwd)
Message-ID: <Pine.LNX.4.62.0505150251280.23696@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew,

The patch below still applies (with a little fuzz) to 2.6.12-rc4.
I'm forwarding it to you directly since I got no reply to my original 
submission on May 7'th.

Patch is compile tested only, but is pretty trivial.

-- 
Jesper 


---------- Forwarded message ----------
Date: Sat, 7 May 2005 02:35:04 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: James E.J. Bottomley <James.Bottomley@SteelEye.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
    linux-scsi <linux-scsi@vger.kernel.org>, linux-eata@i-connect.net,
    ipslinux@adaptec.com, linux@advansys.com, Adam Radford <linuxraid@amcc.com>,
    Richard Hirst <richard@sleepie.demon.co.uk>,
    Tommy Thorn <Tommy.Thorn@irisa.fr>, Eric Youngdale <eric@andante.org>,
    John Aycock <aycock@cpsc.ucalgary.ca>, Erik H. Moe <ehm@cris.com>,
    Go Taniguchi <go@turbolinux.co.jp>, Gadi Oxman <gadio@netvision.net.il>,
    Willem Riede <osst@riede.org>, Jakub Jelinek <jj@sunsite.mff.cuni.cz>,
    Douglas Gilbert <dgilbert@interlog.com>,
    Kai Makisara <Kai.Makisara@kolumbus.fi>,
    Dario Ballabio <dario.ballabio@tiscalinet.it>
Subject: [PATCH] kfree and vfree cleanups for drivers/scsi/*

This patch makes the following changes:
  - don't check pointers for NULL before calling kfree/vfree on them.
  - remove a few unnessesary (as far as I can see) casts in calls to
    kfree/vfree.
  - a few whitespace changes.

Patch is untested.
Please review and consider merging.
Sorry about the huge CC list, but I wanted to add all people who's code 
I've changed.


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
---

 drivers/scsi/3w-9xxx.c     |    3 -
 drivers/scsi/53c7xx.c      |    4 -
 drivers/scsi/advansys.c    |   12 +----
 drivers/scsi/aha1542.c     |   37 +++++-----------
 drivers/scsi/aic7xxx_old.c |    3 -
 drivers/scsi/cpqfcTSinit.c |    5 --
 drivers/scsi/dpt_i2o.c     |   25 ++--------
 drivers/scsi/eata.c        |    3 -
 drivers/scsi/ide-scsi.c    |   10 ++--
 drivers/scsi/ips.c         |  103 ++++++++++++++++++++-------------------------
 drivers/scsi/osst.c        |   13 ++---
 drivers/scsi/pluto.c       |    2
 drivers/scsi/sg.c          |   15 ++----
 drivers/scsi/st.c          |    3 -
 drivers/scsi/u14-34f.c     |    2
 15 files changed, 98 insertions(+), 142 deletions(-)

diff -upr linux-2.6.12-rc3-mm3-orig/drivers/scsi/3w-9xxx.c linux-2.6.12-rc3-mm3/drivers/scsi/3w-9xxx.c
--- linux-2.6.12-rc3-mm3-orig/drivers/scsi/3w-9xxx.c	2005-04-30 18:25:09.000000000 +0200
+++ linux-2.6.12-rc3-mm3/drivers/scsi/3w-9xxx.c	2005-05-07 01:27:13.000000000 +0200
@@ -990,8 +990,7 @@ static void twa_free_device_extension(TW
 				    tw_dev->generic_buffer_virt[0],
 				    tw_dev->generic_buffer_phys[0]);
 
-	if (tw_dev->event_queue[0])
-		kfree(tw_dev->event_queue[0]);
+	kfree(tw_dev->event_queue[0]);
 } /* End twa_free_device_extension() */
 
 /* This function will free a request id */
diff -upr linux-2.6.12-rc3-mm3-orig/drivers/scsi/53c7xx.c linux-2.6.12-rc3-mm3/drivers/scsi/53c7xx.c
--- linux-2.6.12-rc3-mm3-orig/drivers/scsi/53c7xx.c	2005-04-30 18:25:09.000000000 +0200
+++ linux-2.6.12-rc3-mm3/drivers/scsi/53c7xx.c	2005-05-07 02:00:30.000000000 +0200
@@ -6090,8 +6090,8 @@ NCR53c7x0_release(struct Scsi_Host *host
     if (hostdata->num_cmds)
 	printk ("scsi%d : leaked %d NCR53c7x0_cmd structures\n",
 	    host->host_no, hostdata->num_cmds);
-    if (hostdata->events) 
-	vfree ((void *)hostdata->events);
+
+    vfree(hostdata->events);
 
     /* XXX This assumes default cache mode to be IOMAP_FULL_CACHING, which
      * XXX may be invalid (CONFIG_060_WRITETHROUGH)
diff -upr linux-2.6.12-rc3-mm3-orig/drivers/scsi/advansys.c linux-2.6.12-rc3-mm3/drivers/scsi/advansys.c
--- linux-2.6.12-rc3-mm3-orig/drivers/scsi/advansys.c	2005-04-30 18:25:10.000000000 +0200
+++ linux-2.6.12-rc3-mm3/drivers/scsi/advansys.c	2005-05-07 01:30:52.000000000 +0200
@@ -5404,10 +5404,8 @@ advansys_detect(struct scsi_host_templat
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
@@ -5459,10 +5457,8 @@ advansys_release(struct Scsi_Host *shp)
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
diff -upr linux-2.6.12-rc3-mm3-orig/drivers/scsi/aha1542.c linux-2.6.12-rc3-mm3/drivers/scsi/aha1542.c
--- linux-2.6.12-rc3-mm3-orig/drivers/scsi/aha1542.c	2005-03-02 08:38:09.000000000 +0100
+++ linux-2.6.12-rc3-mm3/drivers/scsi/aha1542.c	2005-05-07 01:32:27.000000000 +0200
@@ -543,10 +543,9 @@ static void aha1542_intr_handle(struct S
 			return;
 		}
 		my_done = SCtmp->scsi_done;
-		if (SCtmp->host_scribble) {
-			kfree(SCtmp->host_scribble);
-			SCtmp->host_scribble = NULL;
-		}
+		kfree(SCtmp->host_scribble);
+		SCtmp->host_scribble = NULL;
+
 		/* Fetch the sense data, and tuck it away, in the required slot.  The
 		   Adaptec automatically fetches it, and there is no guarantee that
 		   we will still have it in the cdb when we come back */
@@ -1445,10 +1444,8 @@ static int aha1542_dev_reset(Scsi_Cmnd *
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
@@ -1508,10 +1505,8 @@ static int aha1542_bus_reset(Scsi_Cmnd *
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
@@ -1577,10 +1572,8 @@ static int aha1542_host_reset(Scsi_Cmnd 
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
@@ -1721,10 +1714,8 @@ static int aha1542_old_reset(Scsi_Cmnd *
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
 
@@ -1767,10 +1758,8 @@ fail:
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
 
diff -upr linux-2.6.12-rc3-mm3-orig/drivers/scsi/aic7xxx_old.c linux-2.6.12-rc3-mm3/drivers/scsi/aic7xxx_old.c
--- linux-2.6.12-rc3-mm3-orig/drivers/scsi/aic7xxx_old.c	2005-04-30 18:25:10.000000000 +0200
+++ linux-2.6.12-rc3-mm3/drivers/scsi/aic7xxx_old.c	2005-05-07 01:34:20.000000000 +0200
@@ -8493,8 +8493,7 @@ aic7xxx_free(struct aic7xxx_host *p)
                                      - scb_dma->dma_offset),
 			    scb_dma->dma_address);
       }
-      if (p->scb_data->scb_array[i]->kmalloc_ptr != NULL)
-        kfree(p->scb_data->scb_array[i]->kmalloc_ptr);
+      kfree(p->scb_data->scb_array[i]->kmalloc_ptr);
       p->scb_data->scb_array[i] = NULL;
     }
   
diff -upr linux-2.6.12-rc3-mm3-orig/drivers/scsi/cpqfcTSinit.c linux-2.6.12-rc3-mm3/drivers/scsi/cpqfcTSinit.c
--- linux-2.6.12-rc3-mm3-orig/drivers/scsi/cpqfcTSinit.c	2005-04-30 18:25:10.000000000 +0200
+++ linux-2.6.12-rc3-mm3/drivers/scsi/cpqfcTSinit.c	2005-05-07 02:00:45.000000000 +0200
@@ -692,8 +692,7 @@ int cpqfcTS_ioctl( struct scsi_device *S
         if(  copy_to_user( vendor_cmd->bufp, buf, vendor_cmd->len))
 		result = -EFAULT;
 
-        if( buf) 
-	  kfree( buf);
+	kfree(buf);
 
         return result;
       }
@@ -827,7 +826,7 @@ int cpqfcTS_release(struct Scsi_Host *Ho
  /* we get "vfree: bad address" executing this - need to investigate... 
   if( (void*)((unsigned long)cpqfcHBAdata->fcChip.Registers.MemBase) !=
       cpqfcHBAdata->fcChip.Registers.ReMapMemBase)
-    vfree( cpqfcHBAdata->fcChip.Registers.ReMapMemBase);
+    vfree(cpqfcHBAdata->fcChip.Registers.ReMapMemBase);
 */
   pci_disable_device( cpqfcHBAdata->PciDev);
 
diff -upr linux-2.6.12-rc3-mm3-orig/drivers/scsi/dpt_i2o.c linux-2.6.12-rc3-mm3/drivers/scsi/dpt_i2o.c
--- linux-2.6.12-rc3-mm3-orig/drivers/scsi/dpt_i2o.c	2005-05-06 23:21:16.000000000 +0200
+++ linux-2.6.12-rc3-mm3/drivers/scsi/dpt_i2o.c	2005-05-07 01:38:44.000000000 +0200
@@ -1025,18 +1025,10 @@ static void adpt_i2o_delete_hba(adpt_hba
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
@@ -2716,10 +2708,7 @@ static s32 adpt_i2o_init_outbound_q(adpt
 	}
 	kfree((void*)status);
 
-	if(pHba->reply_pool != NULL){
-		kfree(pHba->reply_pool);
-	}
-
+	kfree(pHba->reply_pool);
 	pHba->reply_pool = (u32*)kmalloc(pHba->reply_fifo_size * REPLY_FRAME_SIZE * 4, GFP_KERNEL|ADDR32);
 	if(!pHba->reply_pool){
 		printk(KERN_ERR"%s: Could not allocate reply pool\n",pHba->name);
@@ -2936,9 +2925,7 @@ static int adpt_i2o_build_sys_table(void
 	sys_tbl_len = sizeof(struct i2o_sys_tbl) +	// Header + IOPs
 				(hba_count) * sizeof(struct i2o_sys_tbl_entry);
 
-	if(sys_tbl)
-		kfree(sys_tbl);
-
+	kfree(sys_tbl);
 	sys_tbl = kmalloc(sys_tbl_len, GFP_KERNEL|ADDR32);
 	if(!sys_tbl) {
 		printk(KERN_WARNING "SysTab Set failed. Out of memory.\n");	
diff -upr linux-2.6.12-rc3-mm3-orig/drivers/scsi/eata.c linux-2.6.12-rc3-mm3/drivers/scsi/eata.c
--- linux-2.6.12-rc3-mm3-orig/drivers/scsi/eata.c	2005-03-02 08:38:25.000000000 +0100
+++ linux-2.6.12-rc3-mm3/drivers/scsi/eata.c	2005-05-07 01:39:01.000000000 +0200
@@ -2593,8 +2593,7 @@ static int eata2x_release(struct Scsi_Ho
 	unsigned int i;
 
 	for (i = 0; i < shost->can_queue; i++)
-		if ((&ha->cp[i])->sglist)
-			kfree((&ha->cp[i])->sglist);
+		kfree((&ha->cp[i])->sglist);
 
 	for (i = 0; i < shost->can_queue; i++)
 		pci_unmap_single(ha->pdev, ha->cp[i].cp_dma_addr,
diff -upr linux-2.6.12-rc3-mm3-orig/drivers/scsi/ide-scsi.c linux-2.6.12-rc3-mm3/drivers/scsi/ide-scsi.c
--- linux-2.6.12-rc3-mm3-orig/drivers/scsi/ide-scsi.c	2005-04-30 18:25:10.000000000 +0200
+++ linux-2.6.12-rc3-mm3/drivers/scsi/ide-scsi.c	2005-05-07 01:42:41.000000000 +0200
@@ -304,9 +304,9 @@ static int idescsi_check_condition(ide_d
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
@@ -928,8 +928,8 @@ static int idescsi_queue (struct scsi_cm
 	spin_lock_irq(host->host_lock);
 	return 0;
 abort:
-	if (pc) kfree (pc);
-	if (rq) kfree (rq);
+	kfree(pc);
+	kfree(rq);
 	cmd->result = DID_ERROR << 16;
 	done(cmd);
 	return 0;
diff -upr linux-2.6.12-rc3-mm3-orig/drivers/scsi/ips.c linux-2.6.12-rc3-mm3/drivers/scsi/ips.c
--- linux-2.6.12-rc3-mm3-orig/drivers/scsi/ips.c	2005-04-30 18:25:10.000000000 +0200
+++ linux-2.6.12-rc3-mm3/drivers/scsi/ips.c	2005-05-07 01:47:39.000000000 +0200
@@ -4463,65 +4463,58 @@ ips_free(ips_ha_t * ha)
 
 	METHOD_TRACE("ips_free", 1);
 
-	if (ha) {
-		if (ha->enq) {
-			pci_free_consistent(ha->pcidev, sizeof(IPS_ENQ),
-					    ha->enq, ha->enq_busaddr);
-			ha->enq = NULL;
-		}
-
-		if (ha->conf) {
-			kfree(ha->conf);
-			ha->conf = NULL;
-		}
-
-		if (ha->adapt) {
-			pci_free_consistent(ha->pcidev,
-					    sizeof (IPS_ADAPTER) +
-					    sizeof (IPS_IO_CMD), ha->adapt,
-					    ha->adapt->hw_status_start);
-			ha->adapt = NULL;
-		}
-
-		if (ha->logical_drive_info) {
-			pci_free_consistent(ha->pcidev,
-					    sizeof (IPS_LD_INFO),
-					    ha->logical_drive_info,
-					    ha->logical_drive_info_dma_addr);
-			ha->logical_drive_info = NULL;
-		}
-
-		if (ha->nvram) {
-			kfree(ha->nvram);
-			ha->nvram = NULL;
-		}
-
-		if (ha->subsys) {
-			kfree(ha->subsys);
-			ha->subsys = NULL;
-		}
-
-		if (ha->ioctl_data) {
-			pci_free_consistent(ha->pcidev, ha->ioctl_len,
-					    ha->ioctl_data, ha->ioctl_busaddr);
-			ha->ioctl_data = NULL;
-			ha->ioctl_datasize = 0;
-			ha->ioctl_len = 0;
-		}
-		ips_deallocatescbs(ha, ha->max_cmds);
+	if (!ha)
+		return;
 
-		/* free memory mapped (if applicable) */
-		if (ha->mem_ptr) {
-			iounmap(ha->ioremap_ptr);
-			ha->ioremap_ptr = NULL;
-			ha->mem_ptr = NULL;
-		}
+	if (ha->enq) {
+		pci_free_consistent(ha->pcidev, sizeof(IPS_ENQ),
+				    ha->enq, ha->enq_busaddr);
+		ha->enq = NULL;
+	}
 
-		if (ha->mem_addr)
-			release_mem_region(ha->mem_addr, ha->mem_len);
-		ha->mem_addr = 0;
+	kfree(ha->conf);
+	ha->conf = NULL;
 
+	if (ha->adapt) {
+		pci_free_consistent(ha->pcidev,
+				    sizeof (IPS_ADAPTER) +
+				    sizeof (IPS_IO_CMD), ha->adapt,
+				    ha->adapt->hw_status_start);
+		ha->adapt = NULL;
 	}
+
+	if (ha->logical_drive_info) {
+		pci_free_consistent(ha->pcidev,
+				    sizeof (IPS_LD_INFO),
+				    ha->logical_drive_info,
+				    ha->logical_drive_info_dma_addr);
+		ha->logical_drive_info = NULL;
+	}
+
+	kfree(ha->nvram);
+	ha->nvram = NULL;
+	kfree(ha->subsys);
+	ha->subsys = NULL;
+
+	if (ha->ioctl_data) {
+		pci_free_consistent(ha->pcidev, ha->ioctl_len,
+				    ha->ioctl_data, ha->ioctl_busaddr);
+		ha->ioctl_data = NULL;
+		ha->ioctl_datasize = 0;
+		ha->ioctl_len = 0;
+	}
+	ips_deallocatescbs(ha, ha->max_cmds);
+
+	/* free memory mapped (if applicable) */
+	if (ha->mem_ptr) {
+		iounmap(ha->ioremap_ptr);
+		ha->ioremap_ptr = NULL;
+		ha->mem_ptr = NULL;
+	}
+
+	if (ha->mem_addr)
+		release_mem_region(ha->mem_addr, ha->mem_len);
+	ha->mem_addr = 0;
 }
 
 /****************************************************************************/
diff -upr linux-2.6.12-rc3-mm3-orig/drivers/scsi/osst.c linux-2.6.12-rc3-mm3/drivers/scsi/osst.c
--- linux-2.6.12-rc3-mm3-orig/drivers/scsi/osst.c	2005-05-06 23:21:17.000000000 +0200
+++ linux-2.6.12-rc3-mm3/drivers/scsi/osst.c	2005-05-07 02:02:19.000000000 +0200
@@ -1377,7 +1377,7 @@ static int osst_read_back_buffer_and_rew
 	
 		if ((STp->buffer)->syscall_result || !SRpnt) {
 			printk(KERN_ERR "%s:E: Failed to read frame back from OnStream buffer\n", name);
-			vfree((void *)buffer);
+			vfree(buffer);
 			*aSRpnt = SRpnt;
 			return (-EIO);
 		}
@@ -1419,7 +1419,7 @@ static int osst_read_back_buffer_and_rew
 
 			if (new_frame > frame + 1000) {
 				printk(KERN_ERR "%s:E: Failed to find writable tape media\n", name);
-				vfree((void *)buffer);
+				vfree(buffer);
 				return (-EIO);
 			}
 			if ( i >= nframes + pending ) break;
@@ -1500,7 +1500,7 @@ static int osst_read_back_buffer_and_rew
 			     SRpnt->sr_sense_buffer[12]         ==  0 &&
 			     SRpnt->sr_sense_buffer[13]         ==  2) {
 				printk(KERN_ERR "%s:E: Volume overflow in write error recovery\n", name);
-				vfree((void *)buffer);
+				vfree(buffer);
 				return (-EIO);			/* hit end of tape = fail */
 			}
 			i = ((SRpnt->sr_sense_buffer[3] << 24) |
@@ -1525,7 +1525,7 @@ static int osst_read_back_buffer_and_rew
 	}
 	if (!pending)
 		osst_copy_to_buffer(STp->buffer, p);	/* so buffer content == at entry in all cases */
-	vfree((void *)buffer);
+	vfree(buffer);
 	return 0;
 }
 
@@ -5852,7 +5852,7 @@ static int osst_remove(struct device *de
 			os_scsi_tapes[i] = NULL;
 			osst_nr_dev--;
 			write_unlock(&os_scsi_tapes_lock);
-			if (tpnt->header_cache != NULL) vfree(tpnt->header_cache);
+			vfree(tpnt->header_cache);
 			if (tpnt->buffer) {
 				normalize_buffer(tpnt->buffer);
 				kfree(tpnt->buffer);
@@ -5896,8 +5896,7 @@ static void __exit exit_osst (void)
 		for (i=0; i < osst_max_dev; ++i) {
 			if (!(STp = os_scsi_tapes[i])) continue;
 			/* This is defensive, supposed to happen during detach */
-			if (STp->header_cache)
-				vfree(STp->header_cache);
+			vfree(STp->header_cache);
 			if (STp->buffer) {
 				normalize_buffer(STp->buffer);
 				kfree(STp->buffer);
diff -upr linux-2.6.12-rc3-mm3-orig/drivers/scsi/pluto.c linux-2.6.12-rc3-mm3/drivers/scsi/pluto.c
--- linux-2.6.12-rc3-mm3-orig/drivers/scsi/pluto.c	2005-05-06 23:21:17.000000000 +0200
+++ linux-2.6.12-rc3-mm3/drivers/scsi/pluto.c	2005-05-07 01:52:09.000000000 +0200
@@ -271,7 +271,7 @@ int __init pluto_detect(Scsi_Host_Templa
 		} else
 			fc->fcp_register(fc, TYPE_SCSI_FCP, 1);
 	}
-	kfree((char *)fcs);
+	kfree(fcs);
 	if (nplutos)
 		printk ("PLUTO: Total of %d SparcSTORAGE Arrays found\n", nplutos);
 	return nplutos;
diff -upr linux-2.6.12-rc3-mm3-orig/drivers/scsi/sg.c linux-2.6.12-rc3-mm3/drivers/scsi/sg.c
--- linux-2.6.12-rc3-mm3-orig/drivers/scsi/sg.c	2005-05-06 23:21:17.000000000 +0200
+++ linux-2.6.12-rc3-mm3/drivers/scsi/sg.c	2005-05-07 01:57:12.000000000 +0200
@@ -475,8 +475,7 @@ sg_read(struct file *filp, char __user *
 	sg_finish_rem_req(srp);
 	retval = count;
 free_old_hdr:
-	if (old_hdr)
-		kfree(old_hdr);
+	kfree(old_hdr);
 	return retval;
 }
 
@@ -1643,7 +1642,7 @@ sg_remove(struct class_device *cl_dev)
 		put_disk(sdp->disk);
 		sdp->disk = NULL;
 		if (NULL == sdp->headfp)
-			kfree((char *) sdp);
+			kfree(sdp);
 	}
 
 	if (delay)
@@ -1707,10 +1706,8 @@ exit_sg(void)
 	sg_sysfs_valid = 0;
 	unregister_chrdev_region(MKDEV(SCSI_GENERIC_MAJOR, 0),
 				 SG_MAX_DEVS);
-	if (sg_dev_arr != NULL) {
-		kfree((char *) sg_dev_arr);
-		sg_dev_arr = NULL;
-	}
+	kfree(sg_dev_arr);
+	sg_dev_arr = NULL;
 	sg_dev_max = 0;
 }
 
@@ -2608,7 +2605,7 @@ sg_remove_sfp(Sg_device * sdp, Sg_fd * s
 			}
 			if (k < maxd)
 				sg_dev_arr[k] = NULL;
-			kfree((char *) sdp);
+			kfree(sdp);
 			res = 1;
 		}
 		write_unlock_irqrestore(&sg_dev_arr_lock, iflags);
@@ -2993,7 +2990,7 @@ static void * dev_seq_next(struct seq_fi
 
 static void dev_seq_stop(struct seq_file *s, void *v)
 {
-	kfree (v);
+	kfree(v);
 }
 
 static int sg_proc_open_dev(struct inode *inode, struct file *file)
diff -upr linux-2.6.12-rc3-mm3-orig/drivers/scsi/st.c linux-2.6.12-rc3-mm3/drivers/scsi/st.c
--- linux-2.6.12-rc3-mm3-orig/drivers/scsi/st.c	2005-05-06 23:21:17.000000000 +0200
+++ linux-2.6.12-rc3-mm3/drivers/scsi/st.c	2005-05-07 01:58:17.000000000 +0200
@@ -4032,8 +4032,7 @@ out_free_tape:
 	write_unlock(&st_dev_arr_lock);
 out_put_disk:
 	put_disk(disk);
-	if (tpnt)
-		kfree(tpnt);
+	kfree(tpnt);
 out_buffer_free:
 	kfree(buffer);
 out:
diff -upr linux-2.6.12-rc3-mm3-orig/drivers/scsi/u14-34f.c linux-2.6.12-rc3-mm3/drivers/scsi/u14-34f.c
--- linux-2.6.12-rc3-mm3-orig/drivers/scsi/u14-34f.c	2005-03-02 08:37:53.000000000 +0100
+++ linux-2.6.12-rc3-mm3/drivers/scsi/u14-34f.c	2005-05-07 01:58:52.000000000 +0200
@@ -1965,7 +1965,7 @@ static int u14_34f_release(struct Scsi_H
                             driver_name);
 
    for (i = 0; i < sh[j]->can_queue; i++)
-      if ((&HD(j)->cp[i])->sglist) kfree((&HD(j)->cp[i])->sglist);
+      kfree((&HD(j)->cp[i])->sglist);
 
    for (i = 0; i < sh[j]->can_queue; i++)
       pci_unmap_single(HD(j)->pdev, HD(j)->cp[i].cp_dma_addr,



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
