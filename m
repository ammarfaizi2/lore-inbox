Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267299AbTAKR1d>; Sat, 11 Jan 2003 12:27:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267301AbTAKR1d>; Sat, 11 Jan 2003 12:27:33 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:48596 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S267299AbTAKR1a>; Sat, 11 Jan 2003 12:27:30 -0500
Date: Sat, 11 Jan 2003 18:36:12 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: mitch@sfgoth.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.5 patch] small drivers/atm/* cleanup
Message-ID: <20030111173611.GQ10486@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below does the following:
- remove #if'd kernel 2.2 code
- changes one MIN to min

cu
Adrian


--- linux-2.5.56/drivers/atm/horizon.c.old	2003-01-11 18:23:02.000000000 +0100
+++ linux-2.5.56/drivers/atm/horizon.c	2003-01-11 18:23:18.000000000 +0100
@@ -2874,11 +2874,7 @@
 	// writes to adapter memory (handles IRQ and SMP)
 	spin_lock_init (&dev->mem_lock);
 	
-#if LINUX_VERSION_CODE >= 0x20303
 	init_waitqueue_head (&dev->tx_queue);
-#else
-	dev->tx_queue = 0;
-#endif
 	
 	// vpi in 0..4, vci in 6..10
 	dev->atm_dev->ci_range.vpi_bits = vpi_bits;
--- linux-2.5.56/drivers/atm/iphase.h.old	2003-01-11 18:24:08.000000000 +0100
+++ linux-2.5.56/drivers/atm/iphase.h	2003-01-11 18:25:31.000000000 +0100
@@ -808,7 +808,6 @@
 } r_vc_abr_entry;   
 
 #define MRM 3
-#define MIN(x,y)	((x) < (y)) ? (x) : (y)
 
 typedef struct srv_cls_param {
         u32 class_type;         /* CBR/VBR/ABR/UBR; use the enum above */
@@ -1017,13 +1016,8 @@
         spinlock_t            tx_lock;
         IARTN_Q               tx_return_q;
         u32                   close_pending;
-#if LINUX_VERSION_CODE >= 0x20303
         wait_queue_head_t    close_wait;
         wait_queue_head_t    timeout_wait;
-#else
-        struct wait_queue     *close_wait;
-        struct wait_queue     *timeout_wait;
-#endif
 	struct cpcs_trailer_desc *tx_buf;
         u16 num_tx_desc, tx_buf_sz, rate_limit;
         u32 tx_cell_cnt, tx_pkt_cnt;
--- linux-2.5.56/drivers/atm/horizon.h.old	2003-01-11 18:26:00.000000000 +0100
+++ linux-2.5.56/drivers/atm/horizon.h	2003-01-11 18:26:19.000000000 +0100
@@ -422,11 +422,7 @@
   unsigned int        tx_regions; // number of remaining regions
 
   spinlock_t          mem_lock;
-#if LINUX_VERSION_CODE >= 0x20303
   wait_queue_head_t   tx_queue;
-#else
-  struct wait_queue * tx_queue;
-#endif
 
   u8                  irq;
   long		      flags;
--- linux-2.5.56/drivers/atm/iphase.c.old	2003-01-11 18:27:04.000000000 +0100
+++ linux-2.5.56/drivers/atm/iphase.c	2003-01-11 18:27:18.000000000 +0100
@@ -436,7 +436,7 @@
        if (crm == 0) crm = 1;
        f_abr_vc->f_crm = crm & 0xff;
        f_abr_vc->f_pcr = cellrate_to_float(srv_p->pcr);
-       icr = MIN( srv_p->icr, (srv_p->tbe > srv_p->frtt) ?
+       icr = min( srv_p->icr, (srv_p->tbe > srv_p->frtt) ?
 				((srv_p->tbe/srv_p->frtt)*1000000) :
 				(1000000/(srv_p->frtt/srv_p->tbe)));
        f_abr_vc->f_icr = cellrate_to_float(icr);
