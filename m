Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292027AbSBOAfO>; Thu, 14 Feb 2002 19:35:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292020AbSBOAfH>; Thu, 14 Feb 2002 19:35:07 -0500
Received: from gear.torque.net ([204.138.244.1]:19716 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S292017AbSBOAe4>;
	Thu, 14 Feb 2002 19:34:56 -0500
Message-ID: <3C6C579F.960DE0D7@torque.net>
Date: Thu, 14 Feb 2002 19:34:39 -0500
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Gerold J. Wucherpfennig" <gjwucherpfennig@gmx.net>
CC: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: Compile error with linux-2.5.5-pre1 & advansys scsi
Content-Type: multipart/mixed;
 boundary="------------55A91D6E0ACF0846ED2DFDBF"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------55A91D6E0ACF0846ED2DFDBF
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

"Gerold J. Wucherpfennig" <gjwucherpfennig@gmx.net> wrote:

> The advansys scsi driver of linux-2.5.5-pre1 doesn't compile ...

Gerold,
Please try the attachment, tested on i386 UP + SMP.

Doug Gilbert
--------------55A91D6E0ACF0846ED2DFDBF
Content-Type: text/plain; charset=us-ascii;
 name="advansys_255p1min6.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="advansys_255p1min6.diff"

--- linux/drivers/scsi/advansys.c	Thu Feb  7 22:31:04 2002
+++ linux/drivers/scsi/advansys.cmin6	Thu Feb  7 23:23:59 2002
@@ -1,4 +1,4 @@
-#define ASC_VERSION "3.3GG"    /* AdvanSys Driver Version */
+#define ASC_VERSION "3.3GI"    /* AdvanSys Driver Version */
 
 /*
  * advansys.c - Linux Host Driver for AdvanSys SCSI Adapters
@@ -670,7 +670,7 @@
          1. Return an error from narrow boards if passed a 16 byte
             CDB. The wide board can already handle 16 byte CDBs.
 
-     3.3GG (01/02/02):
+     3.3GI (2/07/02):
 	 1. hacks for lk 2.5 series (D. Gilbert)
 
   I. Known Problems/Fix List (XXX)
@@ -752,7 +752,6 @@
 
 */
 
-#error Please convert me to Documentation/DMA-mapping.txt
 
 /*
  * --- Linux Version
@@ -869,8 +868,8 @@
  * will give us time to change the HW and FW to handle 64-bit
  * addresses.
  */
-#define ASC_VADDR_TO_U32   virt_to_bus
-#define ASC_U32_TO_VADDR   bus_to_virt
+#define ASC_VADDR_TO_U32   __pa
+#define ASC_U32_TO_VADDR   __va
 
 typedef unsigned char uchar;
 
@@ -2151,8 +2150,8 @@
  * will give us time to change the HW and FW to handle 64-bit
  * addresses.
  */
-#define ADV_VADDR_TO_U32   virt_to_bus
-#define ADV_U32_TO_VADDR   bus_to_virt
+#define ADV_VADDR_TO_U32   __pa
+#define ADV_U32_TO_VADDR   __va
 
 #define AdvPortAddr  ulong              /* Virtual memory address size */
 
@@ -3614,23 +3613,6 @@
 #define ASC_MIN(a, b) (((a) < (b)) ? (a) : (b))
 #endif /* CONFIG_PROC_FS */
 
-/*
- * XXX - Release and acquire the io_request_lock. These macros are needed
- * because the 2.4 kernel SCSI mid-level driver holds the 'io_request_lock'
- * on entry to SCSI low-level drivers.
- *
- * These definitions and all code that uses code should be removed when the
- * SCSI mid-level driver no longer holds the 'io_request_lock' on entry to
- * SCSI low-level driver detect, queuecommand, and reset entrypoints.
- *
- * The interrupt flags values doesn't matter in the macros because the
- * SCSI mid-level will save and restore the flags values before and after
- * calling advansys_detect, advansys_queuecommand, and advansys_reset where
- * these macros are used. We do want interrupts enabled after the lock is
- * released so an explicit sti() is done. The driver only needs interrupts
- * disabled when it acquires the per board lock.
- */
-
 /* Asc Library return codes */
 #define ASC_TRUE        1
 #define ASC_FALSE       0
@@ -4822,7 +4804,7 @@
             boardp->id = asc_board_count - 1;
 
             /* Initialize spinlock. */
-            boardp->lock = SPIN_LOCK_UNLOCKED; /* replaced by host_lock dpg */
+            boardp->lock = SPIN_LOCK_UNLOCKED;
 
             /*
              * Handle both narrow and wide boards.
@@ -5872,7 +5854,7 @@
 
     /* host_lock taken by mid-level prior to call but need to protect */
     /* against own ISR */
-    spin_lock_irqsave(boardp->lock, flags);
+    spin_lock_irqsave(&boardp->lock, flags);
 
     /*
      * Block new commands while handling a reset or abort request.
@@ -6676,7 +6658,7 @@
     asc_scsi_q.q1.target_id = ASC_TID_TO_TARGET_ID(scp->target);
     asc_scsi_q.q1.target_lun = scp->lun;
     asc_scsi_q.q2.target_ix = ASC_TIDLUN_TO_IX(scp->target, scp->lun);
-    asc_scsi_q.q1.sense_addr = cpu_to_le32(virt_to_bus(&scp->sense_buffer[0]));
+    asc_scsi_q.q1.sense_addr = cpu_to_le32(__pa(&scp->sense_buffer[0]));
     asc_scsi_q.q1.sense_len = sizeof(scp->sense_buffer);
 
     /*
@@ -6707,7 +6689,7 @@
          */
         ASC_STATS(scp->host, cont_cnt);
         asc_scsi_q.q1.data_addr =
-            cpu_to_le32(virt_to_bus(scp->request_buffer));
+            cpu_to_le32(__pa(scp->request_buffer));
         asc_scsi_q.q1.data_cnt = cpu_to_le32(scp->request_bufflen);
         ASC_STATS_ADD(scp->host, cont_xfer,
                       ASC_CEILING(scp->request_bufflen, 512));
@@ -6751,8 +6733,7 @@
         slp = (struct scatterlist *) scp->request_buffer;
         for (sgcnt = 0; sgcnt < scp->use_sg; sgcnt++, slp++) {
             asc_sg_head.sg_list[sgcnt].addr =
-                cpu_to_le32(virt_to_bus(slp->address ? 
-		(unsigned char *)slp->address :
+                cpu_to_le32(__pa(
 		(unsigned char *)page_address(slp->page) + slp->offset));
             asc_sg_head.sg_list[sgcnt].bytes = cpu_to_le32(slp->length);
             ASC_STATS_ADD(scp->host, sg_xfer, ASC_CEILING(slp->length, 512));
@@ -6848,7 +6829,7 @@
     scsiqp->target_id = scp->target;
     scsiqp->target_lun = scp->lun;
 
-    scsiqp->sense_addr = cpu_to_le32(virt_to_bus(&scp->sense_buffer[0]));
+    scsiqp->sense_addr = cpu_to_le32(__pa(&scp->sense_buffer[0]));
     scsiqp->sense_len = sizeof(scp->sense_buffer);
 
     /*
@@ -6857,7 +6838,7 @@
      */
     scsiqp->data_cnt = cpu_to_le32(scp->request_bufflen);
     scsiqp->vdata_addr = scp->request_buffer;
-    scsiqp->data_addr = cpu_to_le32(virt_to_bus(scp->request_buffer));
+    scsiqp->data_addr = cpu_to_le32(__pa(scp->request_buffer));
 
     if (scp->use_sg == 0) {
         /*
@@ -6977,7 +6958,7 @@
              * the allocated ADV_SG_BLOCK structure.
              */
             sg_block = (ADV_SG_BLOCK *) ADV_8BALIGN(&sgblkp->sg_block);
-            sg_block_paddr = virt_to_bus(sg_block);
+            sg_block_paddr = __pa(sg_block);
 
             /*
              * Check if this is the first 'adv_sgblk_t' for the request.
@@ -7011,9 +6992,8 @@
         for (i = 0; i < NO_OF_SG_PER_BLOCK; i++)
         {
             sg_block->sg_list[i].sg_addr =
-                cpu_to_le32(virt_to_bus(slp->address ? 
-		(unsigned char *)slp->address :
-                (unsigned char *)page_address(slp->page) + slp->offset));
+                cpu_to_le32(__pa(
+                   (unsigned char *)page_address(slp->page) + slp->offset));
             sg_block->sg_list[i].sg_count = cpu_to_le32(slp->length);
             ASC_STATS_ADD(scp->host, sg_xfer, ASC_CEILING(slp->length, 512));
 
@@ -9162,7 +9142,7 @@
 {
     ADV_PADDR           paddr;
 
-    paddr = virt_to_bus(vaddr);
+    paddr = __pa(vaddr);
 
     ASC_DBG4(4,
         "DvcGetPhyAddr: vaddr 0x%lx, lenp 0x%lx *lenp %lu, paddr 0x%lx\n",
@@ -9415,8 +9395,8 @@
 
     printk("Scsi_Host at addr 0x%lx\n", (ulong) s);
     printk(
-" next 0x%lx, extra_bytes %u, host_busy %u, host_no %d, last_reset %d,\n",
-        (ulong) s->next, s->extra_bytes, s->host_busy, s->host_no,
+" next 0x%lx, host_busy %u, host_no %d, last_reset %d,\n",
+        (ulong) s->next, s->host_busy, s->host_no,
         (unsigned) s->last_reset);
 
 #if ASC_LINUX_KERNEL24
@@ -12764,7 +12744,7 @@
                      ASC_TID_TO_TARGET_ID(asc_dvc->cfg->chip_scsi_id));
 
     /* Align overrun buffer on an 8 byte boundary. */
-    phy_addr = virt_to_bus(asc_dvc->cfg->overrun_buf);
+    phy_addr = __pa(asc_dvc->cfg->overrun_buf);
     phy_addr = cpu_to_le32((phy_addr + 7) & ~0x7);
     AscMemDWordCopyPtrToLram(iop_base, ASCV_OVERRUN_PADDR_D,
         (uchar *) &phy_addr, 1);

--------------55A91D6E0ACF0846ED2DFDBF--

