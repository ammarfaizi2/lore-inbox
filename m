Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290371AbSAPFvf>; Wed, 16 Jan 2002 00:51:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290370AbSAPFvZ>; Wed, 16 Jan 2002 00:51:25 -0500
Received: from gear.torque.net ([204.138.244.1]:18436 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S290367AbSAPFuz>;
	Wed, 16 Jan 2002 00:50:55 -0500
Message-ID: <3C451480.17A1B8A@torque.net>
Date: Wed, 16 Jan 2002 00:49:52 -0500
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.3-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, axboe@suse.de,
        Bob Frey <rtfrey@ieee.org>
Subject: [PATCH] advansys scsi driver 2.5.3-pre1
Content-Type: multipart/mixed;
 boundary="------------764668D6992FC4E35F504368"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------764668D6992FC4E35F504368
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Here is another attempt to fix the advansys scsi
adapter driver (it has been functionally broken
for the lk 2.5 series to date). 
This time for lk 2.5.3-pre1 .

It has been tested on advansys U2W and 940U adapters on
a Athlon UP box. It has also been tested on UW adapter
on a dual Celeron (SMP) box. This post is being
written on the former system.


Note for other scsi adapter driver patchers in lk 2.5.2+ ...
'host_lock' is now a pointer to a spinlock_t (before 2.5.2
it was an instance).


After today's "patch included or attached" thread this patch
appears below and is attached.

Doug Gilbert


--- linux/drivers/scsi/advansys.c       Tue Jan 15 19:11:49 2002
+++ linux/drivers/scsi/advansys.cmin4   Wed Jan 16 00:13:21 2002
@@ -1,4 +1,4 @@
-#define ASC_VERSION "3.3G"    /* AdvanSys Driver Version */
+#define ASC_VERSION "3.3GH"    /* AdvanSys Driver Version */
 
 /*
  * advansys.c - Linux Host Driver for AdvanSys SCSI Adapters
@@ -670,6 +670,9 @@
          1. Return an error from narrow boards if passed a 16 byte
             CDB. The wide board can already handle 16 byte CDBs.
 
+     3.3GH (1/15/02):
+        1. hacks for lk 2.5 series (D. Gilbert)
+
   I. Known Problems/Fix List (XXX)
 
      1. Need to add memory mapping workaround. Test the memory mapping.
@@ -4054,6 +4057,7 @@
         ADVEEP_38C1600_CONFIG adv_38C1600_eep;  /* 38C1600 EEPROM config. */
     } eep_config;
     ulong                last_reset;            /* Saved last reset time */
+    spinlock_t lock;                            /* Board spinlock */
 #ifdef CONFIG_PROC_FS
     /* /proc/scsi/advansys/[0...] */
     char                 *prtbuf;               /* /proc print buffer */
@@ -4206,7 +4210,7 @@
 STATIC void       advansys_interrupt(int, void *, struct pt_regs *);
 STATIC void       advansys_select_queue_depths(struct Scsi_Host *,
                                                Scsi_Device *);
-STATIC void       asc_scsi_done_list(Scsi_Cmnd *);
+STATIC void       asc_scsi_done_list(Scsi_Cmnd *, int from_isr);
 STATIC int        asc_execute_scsi_cmnd(Scsi_Cmnd *);
 STATIC int        asc_build_req(asc_board_t *, Scsi_Cmnd *);
 STATIC int        adv_build_req(asc_board_t *, Scsi_Cmnd *, ADV_SCSI_REQ_Q **);
@@ -4799,6 +4803,9 @@
             memset(boardp, 0, sizeof(asc_board_t));
             boardp->id = asc_board_count - 1;
 
+            /* Initialize spinlock. */
+            boardp->lock = SPIN_LOCK_UNLOCKED;
+
             /*
              * Handle both narrow and wide boards.
              *
@@ -5511,7 +5518,7 @@
                 }
             } else {
                 ADV_CARR_T      *carrp;
-                int             req_cnt;
+                int             req_cnt = 0;
                 adv_req_t       *reqp = NULL;
                 int             sg_cnt = 0;
 
@@ -5845,7 +5852,9 @@
     boardp = ASC_BOARDP(shp);
     ASC_STATS(shp, queuecommand);
 
-    spin_lock_irqsave(&shp->host_lock, flags);
+    /* host_lock taken by mid-level prior to call but need to protect */
+    /* against own ISR */
+    spin_lock_irqsave(&boardp->lock, flags);
 
     /*
      * Block new commands while handling a reset or abort request.
@@ -5862,7 +5871,7 @@
          * handling.
          */
         asc_enqueue(&boardp->done, scp, ASC_BACK);
-        spin_unlock_irqrestore(&shp->host_lock, flags);
+       spin_unlock_irqrestore(&boardp->lock, flags);
         return 0;
     }
 
@@ -5902,11 +5911,11 @@
     default:
         done_scp = asc_dequeue_list(&boardp->done, NULL, ASC_TID_ALL);
         /* Interrupts could be enabled here. */
-        asc_scsi_done_list(done_scp);
+        asc_scsi_done_list(done_scp, 0);
         break;
     }
+    spin_unlock_irqrestore(&boardp->lock, flags);
 
-    spin_unlock_irqrestore(&shp->host_lock, flags);
     return 0;
 }
 
@@ -5952,13 +5961,13 @@
     /*
      * Check for re-entrancy.
      */
-    spin_lock_irqsave(&shp->host_lock, flags);
+    spin_lock_irqsave(&boardp->lock, flags);
     if (boardp->flags & ASC_HOST_IN_RESET) {
-        spin_unlock_irqrestore(&shp->host_lock, flags);
+       spin_unlock_irqrestore(&boardp->lock, flags);
         return FAILED;
     }
     boardp->flags |= ASC_HOST_IN_RESET;
-    spin_unlock_irqrestore(&shp->host_lock, flags);
+    spin_unlock_irqrestore(&boardp->lock, flags);
 
     if (ASC_NARROW_BOARD(boardp)) {
         /*
@@ -5989,11 +5998,7 @@
         }
 
         ASC_DBG(1, "advansys_reset: after AscInitAsc1000Driver()\n");
-
-        /*
-         * Acquire the board lock.
-         */
-        spin_lock_irqsave(&shp->host_lock, flags);
+       spin_lock_irqsave(&boardp->lock, flags);
 
     } else {
         /*
@@ -6020,14 +6025,9 @@
             ret = FAILED;
             break;
         }
-        /*
-         * Acquire the board lock and ensure all requests completed by the
-         * microcode have been processed by calling AdvISR().
-         */
-        spin_lock_irqsave(&shp->host_lock, flags);
+       spin_lock_irqsave(&boardp->lock, flags);
         (void) AdvISR(adv_dvc_varp);
     }
-
     /* Board lock is held. */
 
     /*
@@ -6088,15 +6088,13 @@
 
     /* Clear reset flag. */
     boardp->flags &= ~ASC_HOST_IN_RESET;
-
-    /* Release the board. */
-    spin_unlock_irqrestore(&shp->host_lock, flags);
+    spin_unlock_irqrestore(&boardp->lock, flags);
 
     /*
      * Complete all the 'done_scp' requests.
      */
     if (done_scp != NULL) {
-        asc_scsi_done_list(done_scp);
+        asc_scsi_done_list(done_scp, 0);
     }
 
     ASC_DBG1(1, "advansys_reset: ret %d\n", ret);
@@ -6259,6 +6257,7 @@
     asc_board_t     *boardp;
     Scsi_Cmnd       *done_scp = NULL, *last_scp = NULL;
     Scsi_Cmnd       *new_last_scp;
+    struct Scsi_Host *shp;
 
     ASC_DBG(1, "advansys_interrupt: begin\n");
 
@@ -6267,17 +6266,17 @@
      * AscISR() will call asc_isr_callback().
      */
     for (i = 0; i < asc_board_count; i++) {
-       struct Scsi_Host *shp = asc_host[i];
+       shp = asc_host[i];
         boardp = ASC_BOARDP(shp);
         ASC_DBG2(2, "advansys_interrupt: i %d, boardp 0x%lx\n",
             i, (ulong) boardp);
-        spin_lock_irqsave(&shp->host_lock, flags);
+        spin_lock_irqsave(&boardp->lock, flags);
         if (ASC_NARROW_BOARD(boardp)) {
             /*
              * Narrow Board
              */
-            if (AscIsIntPending(asc_host[i]->io_port)) {
-                ASC_STATS(asc_host[i], interrupt);
+            if (AscIsIntPending(shp->io_port)) {
+                ASC_STATS(shp, interrupt);
                 ASC_DBG(1, "advansys_interrupt: before AscISR()\n");
                 AscISR(&boardp->dvc_var.asc_dvc_var);
             }
@@ -6287,7 +6286,7 @@
              */
             ASC_DBG(1, "advansys_interrupt: before AdvISR()\n");
             if (AdvISR(&boardp->dvc_var.adv_dvc_var)) {
-                ASC_STATS(asc_host[i], interrupt);
+                ASC_STATS(shp, interrupt);
             }
         }
 
@@ -6327,7 +6326,7 @@
                 }
             }
         }
-        spin_unlock_irqrestore(&shp->host_lock, flags);
+        spin_unlock_irqrestore(&boardp->lock, flags);
     }
 
     /*
@@ -6336,7 +6335,8 @@
      *
      * Complete all requests on the done list.
      */
-    asc_scsi_done_list(done_scp);
+
+    asc_scsi_done_list(done_scp, 1);
 
     ASC_DBG(1, "advansys_interrupt: end\n");
     return;
@@ -6383,9 +6383,10 @@
  * Interrupts can be enabled on entry.
  */
 STATIC void
-asc_scsi_done_list(Scsi_Cmnd *scp)
+asc_scsi_done_list(Scsi_Cmnd *scp, int from_isr)
 {
     Scsi_Cmnd    *tscp;
+    ulong        flags = 0;
 
     ASC_DBG(2, "asc_scsi_done_list: begin\n");
     while (scp != NULL) {
@@ -6394,7 +6395,11 @@
         REQPNEXT(scp) = NULL;
         ASC_STATS(scp->host, done);
         ASC_ASSERT(scp->scsi_done != NULL);
+       if (from_isr)
+           spin_lock_irqsave(scp->host->host_lock, flags);
         scp->scsi_done(scp);
+       if (from_isr)
+           spin_unlock_irqrestore(scp->host->host_lock, flags);
         scp = tscp;
     }
     ASC_DBG(2, "asc_scsi_done_list: done\n");
@@ -6728,7 +6733,9 @@
         slp = (struct scatterlist *) scp->request_buffer;
         for (sgcnt = 0; sgcnt < scp->use_sg; sgcnt++, slp++) {
             asc_sg_head.sg_list[sgcnt].addr =
-                cpu_to_le32(virt_to_bus(slp->address));
+                cpu_to_le32(virt_to_bus(slp->address ? 
+               (unsigned char *)slp->address :
+               (unsigned char *)page_address(slp->page) + slp->offset));
             asc_sg_head.sg_list[sgcnt].bytes = cpu_to_le32(slp->length);
             ASC_STATS_ADD(scp->host, sg_xfer, ASC_CEILING(slp->length, 512));
         }
@@ -6986,7 +6993,9 @@
         for (i = 0; i < NO_OF_SG_PER_BLOCK; i++)
         {
             sg_block->sg_list[i].sg_addr =
-                cpu_to_le32(virt_to_bus(slp->address));
+                cpu_to_le32(virt_to_bus(slp->address ? 
+               (unsigned char *)slp->address :
+                (unsigned char *)page_address(slp->page) + slp->offset));
             sg_block->sg_list[i].sg_count = cpu_to_le32(slp->length);
             ASC_STATS_ADD(scp->host, sg_xfer, ASC_CEILING(slp->length, 512));
 
@@ -9411,8 +9420,9 @@
         s->dma_channel, s->this_id, s->can_queue);
 
     printk(
-" cmd_per_lun %d, sg_tablesize %d, unchecked_isa_dma %d\n",
-        s->cmd_per_lun, s->sg_tablesize, s->unchecked_isa_dma);
+" cmd_per_lun %d, sg_tablesize %d, unchecked_isa_dma %d, loaded_as_module %d\n",
+        s->cmd_per_lun, s->sg_tablesize, s->unchecked_isa_dma,
+        s->loaded_as_module);
 
     if (ASC_NARROW_BOARD(boardp)) {
         asc_prt_asc_dvc_var(&ASC_BOARDP(s)->dvc_var.asc_dvc_var);
--------------764668D6992FC4E35F504368
Content-Type: text/plain; charset=us-ascii;
 name="advansys_253p1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="advansys_253p1.diff"

--- linux/drivers/scsi/advansys.c	Tue Jan 15 19:11:49 2002
+++ linux/drivers/scsi/advansys.cmin4	Wed Jan 16 00:13:21 2002
@@ -1,4 +1,4 @@
-#define ASC_VERSION "3.3G"    /* AdvanSys Driver Version */
+#define ASC_VERSION "3.3GH"    /* AdvanSys Driver Version */
 
 /*
  * advansys.c - Linux Host Driver for AdvanSys SCSI Adapters
@@ -670,6 +670,9 @@
          1. Return an error from narrow boards if passed a 16 byte
             CDB. The wide board can already handle 16 byte CDBs.
 
+     3.3GH (1/15/02):
+	 1. hacks for lk 2.5 series (D. Gilbert)
+
   I. Known Problems/Fix List (XXX)
 
      1. Need to add memory mapping workaround. Test the memory mapping.
@@ -4054,6 +4057,7 @@
         ADVEEP_38C1600_CONFIG adv_38C1600_eep;  /* 38C1600 EEPROM config. */
     } eep_config;
     ulong                last_reset;            /* Saved last reset time */
+    spinlock_t lock;                            /* Board spinlock */
 #ifdef CONFIG_PROC_FS
     /* /proc/scsi/advansys/[0...] */
     char                 *prtbuf;               /* /proc print buffer */
@@ -4206,7 +4210,7 @@
 STATIC void       advansys_interrupt(int, void *, struct pt_regs *);
 STATIC void       advansys_select_queue_depths(struct Scsi_Host *,
                                                Scsi_Device *);
-STATIC void       asc_scsi_done_list(Scsi_Cmnd *);
+STATIC void       asc_scsi_done_list(Scsi_Cmnd *, int from_isr);
 STATIC int        asc_execute_scsi_cmnd(Scsi_Cmnd *);
 STATIC int        asc_build_req(asc_board_t *, Scsi_Cmnd *);
 STATIC int        adv_build_req(asc_board_t *, Scsi_Cmnd *, ADV_SCSI_REQ_Q **);
@@ -4799,6 +4803,9 @@
             memset(boardp, 0, sizeof(asc_board_t));
             boardp->id = asc_board_count - 1;
 
+            /* Initialize spinlock. */
+            boardp->lock = SPIN_LOCK_UNLOCKED;
+
             /*
              * Handle both narrow and wide boards.
              *
@@ -5511,7 +5518,7 @@
                 }
             } else {
                 ADV_CARR_T      *carrp;
-                int             req_cnt;
+                int             req_cnt = 0;
                 adv_req_t       *reqp = NULL;
                 int             sg_cnt = 0;
 
@@ -5845,7 +5852,9 @@
     boardp = ASC_BOARDP(shp);
     ASC_STATS(shp, queuecommand);
 
-    spin_lock_irqsave(&shp->host_lock, flags);
+    /* host_lock taken by mid-level prior to call but need to protect */
+    /* against own ISR */
+    spin_lock_irqsave(&boardp->lock, flags);
 
     /*
      * Block new commands while handling a reset or abort request.
@@ -5862,7 +5871,7 @@
          * handling.
          */
         asc_enqueue(&boardp->done, scp, ASC_BACK);
-        spin_unlock_irqrestore(&shp->host_lock, flags);
+	spin_unlock_irqrestore(&boardp->lock, flags);
         return 0;
     }
 
@@ -5902,11 +5911,11 @@
     default:
         done_scp = asc_dequeue_list(&boardp->done, NULL, ASC_TID_ALL);
         /* Interrupts could be enabled here. */
-        asc_scsi_done_list(done_scp);
+        asc_scsi_done_list(done_scp, 0);
         break;
     }
+    spin_unlock_irqrestore(&boardp->lock, flags);
 
-    spin_unlock_irqrestore(&shp->host_lock, flags);
     return 0;
 }
 
@@ -5952,13 +5961,13 @@
     /*
      * Check for re-entrancy.
      */
-    spin_lock_irqsave(&shp->host_lock, flags);
+    spin_lock_irqsave(&boardp->lock, flags);
     if (boardp->flags & ASC_HOST_IN_RESET) {
-        spin_unlock_irqrestore(&shp->host_lock, flags);
+	spin_unlock_irqrestore(&boardp->lock, flags);
         return FAILED;
     }
     boardp->flags |= ASC_HOST_IN_RESET;
-    spin_unlock_irqrestore(&shp->host_lock, flags);
+    spin_unlock_irqrestore(&boardp->lock, flags);
 
     if (ASC_NARROW_BOARD(boardp)) {
         /*
@@ -5989,11 +5998,7 @@
         }
 
         ASC_DBG(1, "advansys_reset: after AscInitAsc1000Driver()\n");
-
-        /*
-         * Acquire the board lock.
-         */
-        spin_lock_irqsave(&shp->host_lock, flags);
+	spin_lock_irqsave(&boardp->lock, flags);
 
     } else {
         /*
@@ -6020,14 +6025,9 @@
             ret = FAILED;
             break;
         }
-        /*
-         * Acquire the board lock and ensure all requests completed by the
-         * microcode have been processed by calling AdvISR().
-         */
-        spin_lock_irqsave(&shp->host_lock, flags);
+	spin_lock_irqsave(&boardp->lock, flags);
         (void) AdvISR(adv_dvc_varp);
     }
-
     /* Board lock is held. */
 
     /*
@@ -6088,15 +6088,13 @@
 
     /* Clear reset flag. */
     boardp->flags &= ~ASC_HOST_IN_RESET;
-
-    /* Release the board. */
-    spin_unlock_irqrestore(&shp->host_lock, flags);
+    spin_unlock_irqrestore(&boardp->lock, flags);
 
     /*
      * Complete all the 'done_scp' requests.
      */
     if (done_scp != NULL) {
-        asc_scsi_done_list(done_scp);
+        asc_scsi_done_list(done_scp, 0);
     }
 
     ASC_DBG1(1, "advansys_reset: ret %d\n", ret);
@@ -6259,6 +6257,7 @@
     asc_board_t     *boardp;
     Scsi_Cmnd       *done_scp = NULL, *last_scp = NULL;
     Scsi_Cmnd       *new_last_scp;
+    struct Scsi_Host *shp;
 
     ASC_DBG(1, "advansys_interrupt: begin\n");
 
@@ -6267,17 +6266,17 @@
      * AscISR() will call asc_isr_callback().
      */
     for (i = 0; i < asc_board_count; i++) {
-	struct Scsi_Host *shp = asc_host[i];
+	shp = asc_host[i];
         boardp = ASC_BOARDP(shp);
         ASC_DBG2(2, "advansys_interrupt: i %d, boardp 0x%lx\n",
             i, (ulong) boardp);
-        spin_lock_irqsave(&shp->host_lock, flags);
+        spin_lock_irqsave(&boardp->lock, flags);
         if (ASC_NARROW_BOARD(boardp)) {
             /*
              * Narrow Board
              */
-            if (AscIsIntPending(asc_host[i]->io_port)) {
-                ASC_STATS(asc_host[i], interrupt);
+            if (AscIsIntPending(shp->io_port)) {
+                ASC_STATS(shp, interrupt);
                 ASC_DBG(1, "advansys_interrupt: before AscISR()\n");
                 AscISR(&boardp->dvc_var.asc_dvc_var);
             }
@@ -6287,7 +6286,7 @@
              */
             ASC_DBG(1, "advansys_interrupt: before AdvISR()\n");
             if (AdvISR(&boardp->dvc_var.adv_dvc_var)) {
-                ASC_STATS(asc_host[i], interrupt);
+                ASC_STATS(shp, interrupt);
             }
         }
 
@@ -6327,7 +6326,7 @@
                 }
             }
         }
-        spin_unlock_irqrestore(&shp->host_lock, flags);
+        spin_unlock_irqrestore(&boardp->lock, flags);
     }
 
     /*
@@ -6336,7 +6335,8 @@
      *
      * Complete all requests on the done list.
      */
-    asc_scsi_done_list(done_scp);
+
+    asc_scsi_done_list(done_scp, 1);
 
     ASC_DBG(1, "advansys_interrupt: end\n");
     return;
@@ -6383,9 +6383,10 @@
  * Interrupts can be enabled on entry.
  */
 STATIC void
-asc_scsi_done_list(Scsi_Cmnd *scp)
+asc_scsi_done_list(Scsi_Cmnd *scp, int from_isr)
 {
     Scsi_Cmnd    *tscp;
+    ulong	  flags = 0;
 
     ASC_DBG(2, "asc_scsi_done_list: begin\n");
     while (scp != NULL) {
@@ -6394,7 +6395,11 @@
         REQPNEXT(scp) = NULL;
         ASC_STATS(scp->host, done);
         ASC_ASSERT(scp->scsi_done != NULL);
+	if (from_isr)
+	    spin_lock_irqsave(scp->host->host_lock, flags);
         scp->scsi_done(scp);
+	if (from_isr)
+	    spin_unlock_irqrestore(scp->host->host_lock, flags);
         scp = tscp;
     }
     ASC_DBG(2, "asc_scsi_done_list: done\n");
@@ -6728,7 +6733,9 @@
         slp = (struct scatterlist *) scp->request_buffer;
         for (sgcnt = 0; sgcnt < scp->use_sg; sgcnt++, slp++) {
             asc_sg_head.sg_list[sgcnt].addr =
-                cpu_to_le32(virt_to_bus(slp->address));
+                cpu_to_le32(virt_to_bus(slp->address ? 
+		(unsigned char *)slp->address :
+		(unsigned char *)page_address(slp->page) + slp->offset));
             asc_sg_head.sg_list[sgcnt].bytes = cpu_to_le32(slp->length);
             ASC_STATS_ADD(scp->host, sg_xfer, ASC_CEILING(slp->length, 512));
         }
@@ -6986,7 +6993,9 @@
         for (i = 0; i < NO_OF_SG_PER_BLOCK; i++)
         {
             sg_block->sg_list[i].sg_addr =
-                cpu_to_le32(virt_to_bus(slp->address));
+                cpu_to_le32(virt_to_bus(slp->address ? 
+		(unsigned char *)slp->address :
+                (unsigned char *)page_address(slp->page) + slp->offset));
             sg_block->sg_list[i].sg_count = cpu_to_le32(slp->length);
             ASC_STATS_ADD(scp->host, sg_xfer, ASC_CEILING(slp->length, 512));
 
@@ -9411,8 +9420,9 @@
         s->dma_channel, s->this_id, s->can_queue);
 
     printk(
-" cmd_per_lun %d, sg_tablesize %d, unchecked_isa_dma %d\n",
-        s->cmd_per_lun, s->sg_tablesize, s->unchecked_isa_dma);
+" cmd_per_lun %d, sg_tablesize %d, unchecked_isa_dma %d, loaded_as_module %d\n",
+        s->cmd_per_lun, s->sg_tablesize, s->unchecked_isa_dma,
+        s->loaded_as_module);
 
     if (ASC_NARROW_BOARD(boardp)) {
         asc_prt_asc_dvc_var(&ASC_BOARDP(s)->dvc_var.asc_dvc_var);

--------------764668D6992FC4E35F504368--

