Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262647AbSJBV5a>; Wed, 2 Oct 2002 17:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262649AbSJBV5a>; Wed, 2 Oct 2002 17:57:30 -0400
Received: from 200-171-183-235.dsl.telesp.net.br ([200.171.183.235]:28175 "EHLO
	techlinux.com.br") by vger.kernel.org with ESMTP id <S262647AbSJBV5I>;
	Wed, 2 Oct 2002 17:57:08 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Carlos E Gorges <carlos@techlinux.com.br>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.40 - random fixes
Date: Wed, 2 Oct 2002 19:02:35 -0300
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200210021902.35813.carlos@techlinux.com.br>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


diff -uar linux-2.5.40/drivers/block/DAC960.h linux-2.5/drivers/block/DAC960.h
--- linux-2.5.40/drivers/block/DAC960.h	Tue Oct  1 04:07:34 2002
+++ linux-2.5/drivers/block/DAC960.h	Wed Oct  2 16:07:12 2002
@@ -2569,7 +2569,40 @@
   spin_unlock_irqrestore(Controller->RequestQueue->queue_lock, *ProcessorFlags);
 }
 
-#error I am a non-portable driver, please convert me to use the Documentation/DMA-mapping.txt interfaces
+#warning I am a non-portable driver, please convert me to use the Documentation/DMA-mapping.txt interfaces
+
+/*
+  Virtual_to_Bus32 maps from Kernel Virtual Addresses to 32 Bit PCI Bus
+  Addresses.
+*/
+
+static inline DAC960_BusAddress32_T Virtual_to_Bus32(void *VirtualAddress)
+{
+  return (DAC960_BusAddress32_T) virt_to_bus(VirtualAddress);
+}
+
+
+/*
+  Bus32_to_Virtual maps from 32 Bit PCI Bus Addresses to Kernel Virtual
+  Addresses.
+*/
+
+static inline void *Bus32_to_Virtual(DAC960_BusAddress32_T BusAddress)
+{
+  return (void *) bus_to_virt(BusAddress);
+}
+
+
+/*
+  Virtual_to_Bus64 maps from Kernel Virtual Addresses to 64 Bit PCI Bus
+  Addresses.
+*/
+
+static inline DAC960_BusAddress64_T Virtual_to_Bus64(void *VirtualAddress)
+{
+  return (DAC960_BusAddress64_T) virt_to_bus(VirtualAddress);
+}
+
 
 /*
   Define the DAC960 BA Series Controller Interface Register Offsets.
diff -uar linux-2.5.40/drivers/char/drm/gamma_dma.c linux-2.5/drivers/char/drm/gamma_dma.c
--- linux-2.5.40/drivers/char/drm/gamma_dma.c	Tue Oct  1 04:07:38 2002
+++ linux-2.5/drivers/char/drm/gamma_dma.c	Wed Oct  2 10:46:18 2002
@@ -128,8 +128,7 @@
 		clear_bit(0, &dev->dma_flag);
 
 				/* Dispatch new buffer */
-		queue_task(&dev->tq, &tq_immediate);
-		mark_bh(IMMEDIATE_BH);
+		schedule_task(&dev->tq);
 	}
 }
 
diff -uar linux-2.5.40/drivers/ieee1394/ieee1394_core.c linux-2.5/drivers/ieee1394/ieee1394_core.c
--- linux-2.5.40/drivers/ieee1394/ieee1394_core.c	Tue Oct  1 04:06:24 2002
+++ linux-2.5/drivers/ieee1394/ieee1394_core.c	Wed Oct  2 12:39:23 2002
@@ -378,7 +378,7 @@
                 packet->state = hpsb_complete;
                 up(&packet->state_change);
                 up(&packet->state_change);
-                run_task_queue(&packet->complete_tq);
+		flush_scheduled_tasks();
                 return;
         }
 
@@ -390,7 +390,7 @@
         spin_unlock_irqrestore(&host->pending_pkt_lock, flags);
 
         up(&packet->state_change);
-        queue_task(&host->timeout_tq, &tq_timer);
+        schedule_task(&host->timeout_tq);
 }
 
 /**
@@ -528,7 +528,7 @@
 
         packet->state = hpsb_complete;
         up(&packet->state_change);
-        run_task_queue(&packet->complete_tq);
+	flush_scheduled_tasks();
 }
 
 
@@ -748,7 +748,7 @@
                 packet->state = hpsb_complete;
                 packet->ack_code = ACKX_ABORTED;
                 up(&packet->state_change);
-                run_task_queue(&packet->complete_tq);
+		flush_scheduled_tasks();
         }
 }
 
@@ -781,7 +781,7 @@
         }
 
         if (!list_empty(&host->pending_packets)) {
-                queue_task(&host->timeout_tq, &tq_timer);
+                schedule_task(&host->timeout_tq);
         }
         spin_unlock_irqrestore(&host->pending_pkt_lock, flags);
 
@@ -790,7 +790,7 @@
                 packet->state = hpsb_complete;
                 packet->ack_code = ACKX_TIMEOUT;
                 up(&packet->state_change);
-                run_task_queue(&packet->complete_tq);
+		flush_scheduled_tasks();
         }
 }
 
diff -uar linux-2.5.40/drivers/ieee1394/ieee1394_core.h linux-2.5/drivers/ieee1394/ieee1394_core.h
--- linux-2.5.40/drivers/ieee1394/ieee1394_core.h	Tue Oct  1 04:06:20 2002
+++ linux-2.5/drivers/ieee1394/ieee1394_core.h	Wed Oct  2 12:29:17 2002
@@ -69,7 +69,7 @@
         /* Very core internal, don't care. */
         struct semaphore state_change;
 
-        task_queue complete_tq;
+        struct list_head complete_tq;
 
         /* Store jiffies for implementing bus timeouts. */
         unsigned long sendtime;
diff -uar linux-2.5.40/drivers/isdn/act2000/act2000.h linux-2.5/drivers/isdn/act2000/act2000.h
--- linux-2.5.40/drivers/isdn/act2000/act2000.h	Tue Oct  1 04:07:01 2002
+++ linux-2.5/drivers/isdn/act2000/act2000.h	Wed Oct  2 12:43:16 2002
@@ -179,20 +179,17 @@
 
 extern __inline__ void act2000_schedule_tx(act2000_card *card)
 {
-        queue_task(&card->snd_tq, &tq_immediate);
-        mark_bh(IMMEDIATE_BH);
+	schedule_task(&card->snd_tq);
 }
 
 extern __inline__ void act2000_schedule_rx(act2000_card *card)
 {
-        queue_task(&card->rcv_tq, &tq_immediate);
-        mark_bh(IMMEDIATE_BH);
+	schedule_task(&card->rcv_tq);
 }
 
 extern __inline__ void act2000_schedule_poll(act2000_card *card)
 {
-        queue_task(&card->poll_tq, &tq_immediate);
-        mark_bh(IMMEDIATE_BH);
+	schedule_task(&card->poll_tq);
 }
 
 extern char *act2000_find_eaz(act2000_card *, char);
diff -uar linux-2.5.40/drivers/isdn/eicon/eicon.h linux-2.5/drivers/isdn/eicon/eicon.h
--- linux-2.5.40/drivers/isdn/eicon/eicon.h	Tue Oct  1 04:06:27 2002
+++ linux-2.5/drivers/isdn/eicon/eicon.h	Wed Oct  2 12:50:20 2002
@@ -349,20 +349,17 @@
 
 extern __inline__ void eicon_schedule_tx(eicon_card *card)
 {
-        queue_task(&card->snd_tq, &tq_immediate);
-        mark_bh(IMMEDIATE_BH);
+	schedule_task(&card->snd_tq);
 }
 
 extern __inline__ void eicon_schedule_rx(eicon_card *card)
 {
-        queue_task(&card->rcv_tq, &tq_immediate);
-        mark_bh(IMMEDIATE_BH);
+	schedule_task(&card->rcv_tq);
 }
 
 extern __inline__ void eicon_schedule_ack(eicon_card *card)
 {
-        queue_task(&card->ack_tq, &tq_immediate);
-        mark_bh(IMMEDIATE_BH);
+	schedule_task(&card->ack_tq);
 }
 
 extern int eicon_addcard(int, int, int, char *, int);
diff -uar linux-2.5.40/drivers/isdn/eicon/linsys.c linux-2.5/drivers/isdn/eicon/linsys.c
--- linux-2.5.40/drivers/isdn/eicon/linsys.c	Tue Oct  1 04:06:57 2002
+++ linux-2.5/drivers/isdn/eicon/linsys.c	Wed Oct  2 12:51:32 2002
@@ -84,8 +84,7 @@
 	DivasTask.routine = DivasDoDpc;
 	DivasTask.data = (void *) 0;
 
-	queue_task(&DivasTask, &tq_immediate);
-	mark_bh(IMMEDIATE_BH);
+	schedule_task(&DivasTask);
 
 	return 0;
 }
@@ -97,8 +96,7 @@
 	DivasTask.routine = DivasDoRequestDpc;
 	DivasTask.data = (void *) 0;
 
-	queue_task(&DivasTask, &tq_immediate);
-	mark_bh(IMMEDIATE_BH);
+	schedule_task(&DivasTask);
 
 	return 0;
 }
diff -uar linux-2.5.40/drivers/isdn/hisax/amd7930_fn.c linux-2.5/drivers/isdn/hisax/amd7930_fn.c
--- linux-2.5.40/drivers/isdn/hisax/amd7930_fn.c	Tue Oct  1 04:07:09 2002
+++ linux-2.5/drivers/isdn/hisax/amd7930_fn.c	Wed Oct  2 14:57:32 2002
@@ -277,8 +277,7 @@
         }
 
         test_and_set_bit(event, &cs->event);
-	queue_task(&cs->tqueue, &tq_immediate);
-	mark_bh(IMMEDIATE_BH);
+	schedule_task(&cs->tqueue);
 }
 
 static void
diff -uar linux-2.5.40/drivers/isdn/hisax/avm_pci.c linux-2.5/drivers/isdn/hisax/avm_pci.c
--- linux-2.5.40/drivers/isdn/hisax/avm_pci.c	Tue Oct  1 04:06:29 2002
+++ linux-2.5/drivers/isdn/hisax/avm_pci.c	Wed Oct  2 14:58:19 2002
@@ -200,8 +200,7 @@
 hdlc_sched_event(struct BCState *bcs, int event)
 {
 	bcs->event |= 1 << event;
-	queue_task(&bcs->tqueue, &tq_immediate);
-	mark_bh(IMMEDIATE_BH);
+	schedule_task(&bcs->tqueue);
 }
 
 void
diff -uar linux-2.5.40/drivers/isdn/hisax/config.c linux-2.5/drivers/isdn/hisax/config.c
--- linux-2.5.40/drivers/isdn/hisax/config.c	Tue Oct  1 04:07:36 2002
+++ linux-2.5/drivers/isdn/hisax/config.c	Wed Oct  2 14:53:45 2002
@@ -1818,8 +1818,7 @@
 static void hisax_sched_event(struct IsdnCardState *cs, int event)
 {
 	cs->event |= 1 << event;
-	queue_task(&cs->tqueue, &tq_immediate);
-	mark_bh(IMMEDIATE_BH);
+	schedule_task(&cs->tqueue);
 }
 
 static void hisax_bh(struct IsdnCardState *cs)
@@ -1845,8 +1844,7 @@
 static void hisax_b_sched_event(struct BCState *bcs, int event)
 {
 	bcs->event |= 1 << event;
-	queue_task(&bcs->tqueue, &tq_immediate);
-	mark_bh(IMMEDIATE_BH);
+	schedule_task(&bcs->tqueue);
 }
 
 static inline void D_L2L1(struct hisax_d_if *d_if, int pr, void *arg)
diff -uar linux-2.5.40/drivers/isdn/hisax/hfc_2bds0.c linux-2.5/drivers/isdn/hisax/hfc_2bds0.c
--- linux-2.5.40/drivers/isdn/hisax/hfc_2bds0.c	Tue Oct  1 04:06:15 2002
+++ linux-2.5/drivers/isdn/hisax/hfc_2bds0.c	Wed Oct  2 14:54:14 2002
@@ -202,8 +202,7 @@
 hfc_sched_event(struct BCState *bcs, int event)
 {
 	bcs->event |= 1 << event;
-	queue_task(&bcs->tqueue, &tq_immediate);
-	mark_bh(IMMEDIATE_BH);
+	schedule_task(&bcs->tqueue);
 }
 
 static struct sk_buff
@@ -646,8 +645,7 @@
 sched_event_D(struct IsdnCardState *cs, int event)
 {
 	test_and_set_bit(event, &cs->event);
-	queue_task(&cs->tqueue, &tq_immediate);
-	mark_bh(IMMEDIATE_BH);
+	schedule_task(&cs->tqueue);
 }
 
 static
diff -uar linux-2.5.40/drivers/isdn/hisax/hfc_2bs0.c linux-2.5/drivers/isdn/hisax/hfc_2bs0.c
--- linux-2.5.40/drivers/isdn/hisax/hfc_2bs0.c	Tue Oct  1 04:06:17 2002
+++ linux-2.5/drivers/isdn/hisax/hfc_2bs0.c	Wed Oct  2 15:00:51 2002
@@ -86,8 +86,7 @@
 hfc_sched_event(struct BCState *bcs, int event)
 {
 	bcs->event |= 1 << event;
-	queue_task(&bcs->tqueue, &tq_immediate);
-	mark_bh(IMMEDIATE_BH);
+	schedule_task(&bcs->tqueue);
 }
 
 static void
diff -uar linux-2.5.40/drivers/isdn/hisax/hfc_pci.c linux-2.5/drivers/isdn/hisax/hfc_pci.c
--- linux-2.5.40/drivers/isdn/hisax/hfc_pci.c	Tue Oct  1 04:06:57 2002
+++ linux-2.5/drivers/isdn/hisax/hfc_pci.c	Wed Oct  2 15:05:14 2002
@@ -194,8 +194,7 @@
 sched_event_D_pci(struct IsdnCardState *cs, int event)
 {
 	test_and_set_bit(event, &cs->event);
-	queue_task(&cs->tqueue, &tq_immediate);
-	mark_bh(IMMEDIATE_BH);
+	schedule_task(&cs->tqueue);
 }
 
 /*********************************/
@@ -205,8 +204,7 @@
 hfcpci_sched_event(struct BCState *bcs, int event)
 {
 	bcs->event |= 1 << event;
-	queue_task(&bcs->tqueue, &tq_immediate);
-	mark_bh(IMMEDIATE_BH);
+	schedule_task(&bcs->tqueue);
 }
 
 /************************************************/
diff -uar linux-2.5.40/drivers/isdn/hisax/hfc_sx.c linux-2.5/drivers/isdn/hisax/hfc_sx.c
--- linux-2.5.40/drivers/isdn/hisax/hfc_sx.c	Tue Oct  1 04:06:16 2002
+++ linux-2.5/drivers/isdn/hisax/hfc_sx.c	Wed Oct  2 15:00:13 2002
@@ -464,8 +464,7 @@
 sched_event_D_sx(struct IsdnCardState *cs, int event)
 {
 	test_and_set_bit(event, &cs->event);
-	queue_task(&cs->tqueue, &tq_immediate);
-	mark_bh(IMMEDIATE_BH);
+	schedule_task(&cs->tqueue);
 }
 
 /*********************************/
@@ -475,8 +474,7 @@
 hfcsx_sched_event(struct BCState *bcs, int event)
 {
 	bcs->event |= 1 << event;
-	queue_task(&bcs->tqueue, &tq_immediate);
-	mark_bh(IMMEDIATE_BH);
+	schedule_task(&bcs->tqueue);
 }
 
 /************************************************/
diff -uar linux-2.5.40/drivers/isdn/hisax/hscx.c linux-2.5/drivers/isdn/hisax/hscx.c
--- linux-2.5.40/drivers/isdn/hisax/hscx.c	Tue Oct  1 04:06:13 2002
+++ linux-2.5/drivers/isdn/hisax/hscx.c	Wed Oct  2 15:01:09 2002
@@ -95,8 +95,7 @@
 hscx_sched_event(struct BCState *bcs, int event)
 {
 	bcs->event |= 1 << event;
-	queue_task(&bcs->tqueue, &tq_immediate);
-	mark_bh(IMMEDIATE_BH);
+	schedule_task(&bcs->tqueue);
 }
 
 void
diff -uar linux-2.5.40/drivers/isdn/hisax/icc.c linux-2.5/drivers/isdn/hisax/icc.c
--- linux-2.5.40/drivers/isdn/hisax/icc.c	Tue Oct  1 04:06:15 2002
+++ linux-2.5/drivers/isdn/hisax/icc.c	Wed Oct  2 15:04:39 2002
@@ -191,8 +191,7 @@
 icc_sched_event(struct IsdnCardState *cs, int event)
 {
 	test_and_set_bit(event, &cs->event);
-	queue_task(&cs->tqueue, &tq_immediate);
-	mark_bh(IMMEDIATE_BH);
+	schedule_task(&cs->tqueue);
 }
 
 void
diff -uar linux-2.5.40/drivers/isdn/hisax/ipacx.c linux-2.5/drivers/isdn/hisax/ipacx.c
--- linux-2.5.40/drivers/isdn/hisax/ipacx.c	Tue Oct  1 04:07:00 2002
+++ linux-2.5/drivers/isdn/hisax/ipacx.c	Wed Oct  2 15:02:27 2002
@@ -304,8 +304,7 @@
 dch_sched_event(struct IsdnCardState *cs, int event)
 {
 	set_bit(event, &cs->event);
-	queue_task(&cs->tqueue, &tq_immediate);
-	mark_bh(IMMEDIATE_BH);
+	schedule_task(&cs->tqueue);
 }
 
 //----------------------------------------------------------
@@ -593,8 +592,7 @@
 bch_sched_event(struct BCState *bcs, int event)
 {
 	bcs->event |= 1 << event;
-	queue_task(&bcs->tqueue, &tq_immediate);
-	mark_bh(IMMEDIATE_BH);
+	schedule_task(&bcs->tqueue);
 }
 
 //----------------------------------------------------------
diff -uar linux-2.5.40/drivers/isdn/hisax/isac.c linux-2.5/drivers/isdn/hisax/isac.c
--- linux-2.5.40/drivers/isdn/hisax/isac.c	Tue Oct  1 04:06:18 2002
+++ linux-2.5/drivers/isdn/hisax/isac.c	Wed Oct  2 15:00:33 2002
@@ -195,8 +195,7 @@
 isac_sched_event(struct IsdnCardState *cs, int event)
 {
 	test_and_set_bit(event, &cs->event);
-	queue_task(&cs->tqueue, &tq_immediate);
-	mark_bh(IMMEDIATE_BH);
+	schedule_task(&cs->tqueue);
 }
 
 void
diff -uar linux-2.5.40/drivers/isdn/hisax/isar.c linux-2.5/drivers/isdn/hisax/isar.c
--- linux-2.5.40/drivers/isdn/hisax/isar.c	Tue Oct  1 04:06:57 2002
+++ linux-2.5/drivers/isdn/hisax/isar.c	Wed Oct  2 14:57:59 2002
@@ -447,8 +447,7 @@
 isar_sched_event(struct BCState *bcs, int event)
 {
 	bcs->event |= 1 << event;
-	queue_task(&bcs->tqueue, &tq_immediate);
-	mark_bh(IMMEDIATE_BH);
+	schedule_task(&bcs->tqueue);
 }
 
 static inline void
diff -uar linux-2.5.40/drivers/isdn/hisax/jade.c linux-2.5/drivers/isdn/hisax/jade.c
--- linux-2.5.40/drivers/isdn/hisax/jade.c	Tue Oct  1 04:06:28 2002
+++ linux-2.5/drivers/isdn/hisax/jade.c	Wed Oct  2 14:57:09 2002
@@ -138,8 +138,7 @@
 jade_sched_event(struct BCState *bcs, int event)
 {
     bcs->event |= 1 << event;
-    queue_task(&bcs->tqueue, &tq_immediate);
-    mark_bh(IMMEDIATE_BH);
+    schedule_task(&bcs->tqueue);
 }
 
 static void
diff -uar linux-2.5.40/drivers/isdn/hisax/netjet.c linux-2.5/drivers/isdn/hisax/netjet.c
--- linux-2.5.40/drivers/isdn/hisax/netjet.c	Tue Oct  1 04:06:19 2002
+++ linux-2.5/drivers/isdn/hisax/netjet.c	Wed Oct  2 14:54:47 2002
@@ -434,8 +434,7 @@
 		skb_queue_tail(&bcs->rqueue, skb);
 	}
 	bcs->event |= 1 << B_RCVBUFREADY;
-	queue_task(&bcs->tqueue, &tq_immediate);
-	mark_bh(IMMEDIATE_BH);
+	schedule_task(&bcs->tqueue);
 	
 	if (bcs->cs->debug & L1_DEB_RECEIVE_FRAME)
 		printframe(bcs->cs, bcs->hw.tiger.rcvbuf, count, "rec");
@@ -791,8 +790,7 @@
 							cnt - s_cnt);
 				}
 				bcs->event |= 1 << B_XMTBUFREADY;
-				queue_task(&bcs->tqueue, &tq_immediate);
-				mark_bh(IMMEDIATE_BH);
+				schedule_task(&bcs->tqueue);
 			}
 		}
 	} else if (test_and_clear_bit(BC_FLG_NOFRAME, &bcs->Flag)) {
diff -uar linux-2.5.40/drivers/isdn/hisax/w6692.c linux-2.5/drivers/isdn/hisax/w6692.c
--- linux-2.5.40/drivers/isdn/hisax/w6692.c	Tue Oct  1 04:07:36 2002
+++ linux-2.5/drivers/isdn/hisax/w6692.c	Wed Oct  2 14:56:41 2002
@@ -135,16 +135,14 @@
 W6692_sched_event(struct IsdnCardState *cs, int event)
 {
 	test_and_set_bit(event, &cs->event);
-	queue_task(&cs->tqueue, &tq_immediate);
-	mark_bh(IMMEDIATE_BH);
+	schedule_task(&cs->tqueue);
 }
 
 static void
 W6692B_sched_event(struct BCState *bcs, int event)
 {
 	bcs->event |= 1 << event;
-	queue_task(&bcs->tqueue, &tq_immediate);
-	mark_bh(IMMEDIATE_BH);
+	schedule_task(&bcs->tqueue);
 }
 
 static void
diff -uar linux-2.5.40/drivers/isdn/hysdn/boardergo.c linux-2.5/drivers/isdn/hysdn/boardergo.c
--- linux-2.5.40/drivers/isdn/hysdn/boardergo.c	Tue Oct  1 04:07:01 2002
+++ linux-2.5/drivers/isdn/hysdn/boardergo.c	Wed Oct  2 15:07:41 2002
@@ -59,10 +59,9 @@
 	b |= dpr->ToHyInt;	/* and for champ */
 
 	/* start kernel task immediately after leaving all interrupts */
-	if (!card->hw_lock) {
-		queue_task(&card->irq_queue, &tq_immediate);
-		mark_bh(IMMEDIATE_BH);
-	}
+	if (!card->hw_lock)
+		schedule_task(&card->irq_queue);
+
 	restore_flags(flags);
 }				/* ergo_interrupt */
 
@@ -177,8 +176,7 @@
 		card->err_log_state = ERRLOG_STATE_STOP;	/* request stop */
 
 	restore_flags(flags);
-	queue_task(&card->irq_queue, &tq_immediate);
-	mark_bh(IMMEDIATE_BH);
+	schedule_task(&card->irq_queue);
 }				/* ergo_set_errlog_state */
 
 /******************************************/
diff -uar linux-2.5.40/drivers/isdn/hysdn/hysdn_net.c linux-2.5/drivers/isdn/hysdn/hysdn_net.c
--- linux-2.5.40/drivers/isdn/hysdn/hysdn_net.c	Tue Oct  1 04:06:16 2002
+++ linux-2.5/drivers/isdn/hysdn/hysdn_net.c	Wed Oct  2 15:06:50 2002
@@ -168,10 +168,9 @@
 
 	spin_unlock_irq(&lp->lock);
 
-	if (lp->sk_count <= 3) {
-		queue_task(&((hysdn_card *) dev->priv)->irq_queue, &tq_immediate);
-		mark_bh(IMMEDIATE_BH);
-	}
+	if (lp->sk_count <= 3)
+		schedule_task(&((hysdn_card *) dev->priv)->irq_queue);
+
 	return (0);		/* success */
 }				/* net_send_packet */
 
diff -uar linux-2.5.40/drivers/isdn/hysdn/hysdn_sched.c linux-2.5/drivers/isdn/hysdn/hysdn_sched.c
--- linux-2.5.40/drivers/isdn/hysdn/hysdn_sched.c	Tue Oct  1 04:06:18 2002
+++ linux-2.5/drivers/isdn/hysdn/hysdn_sched.c	Wed Oct  2 15:07:08 2002
@@ -175,8 +175,8 @@
 	card->async_busy = 1;	/* request transfer */
 
 	/* now queue the task */
-	queue_task(&card->irq_queue, &tq_immediate);
-	mark_bh(IMMEDIATE_BH);
+	schedule_task(&card->irq_queue);
+
 	sti();
 
 	if (card->debug_flags & LOG_SCHED_ASYN)
diff -uar linux-2.5.40/drivers/isdn/i4l/isdn_concap.c linux-2.5/drivers/isdn/i4l/isdn_concap.c
--- linux-2.5.40/drivers/isdn/i4l/isdn_concap.c	Tue Oct  1 04:06:28 2002
+++ linux-2.5/drivers/isdn/i4l/isdn_concap.c	Wed Oct  2 15:22:21 2002
@@ -19,7 +19,9 @@
 #include "isdn_net.h"
 #include <linux/concap.h>
 #include "isdn_concap.h"
+#include <linux/if_arp.h>
 
+#ifdef CONFIG_ISDN_X25
 
 /* The following set of device service operations are for encapsulation
    protocols that require for reliable datalink semantics. That means:
diff -uar linux-2.5.40/drivers/isdn/i4l/isdn_net.c linux-2.5/drivers/isdn/i4l/isdn_net.c
--- linux-2.5.40/drivers/isdn/i4l/isdn_net.c	Tue Oct  1 04:07:50 2002
+++ linux-2.5/drivers/isdn/i4l/isdn_net.c	Wed Oct  2 15:13:17 2002
@@ -161,8 +161,7 @@
 
 	if (!(isdn_net_device_busy(lp))) {
 		if (!skb_queue_empty(&lp->super_tx_queue)) {
-			queue_task(&lp->tqueue, &tq_immediate);
-			mark_bh(IMMEDIATE_BH);
+			schedule_task(&lp->tqueue);
 		} else {
 			isdn_net_device_wake_queue(lp);
 		}
@@ -852,8 +851,7 @@
 		// we can't grab the lock from irq context, 
 		// so we just queue the packet
 		skb_queue_tail(&lp->super_tx_queue, skb); 
-		queue_task(&lp->tqueue, &tq_immediate);
-		mark_bh(IMMEDIATE_BH);
+		schedule_task(&lp->tqueue);
 		return;
 	}
 
diff -uar linux-2.5.40/drivers/isdn/i4l/isdn_tty.c linux-2.5/drivers/isdn/i4l/isdn_tty.c
--- linux-2.5.40/drivers/isdn/i4l/isdn_tty.c	Tue Oct  1 04:06:20 2002
+++ linux-2.5/drivers/isdn/i4l/isdn_tty.c	Wed Oct  2 15:15:46 2002
@@ -101,7 +101,7 @@
 #endif
 					if (info->emu.mdmreg[REG_CPPP] & BIT_CPPP)
 						tty->flip.flag_buf_ptr[len - 1] = 0xff;
-					queue_task(&tty->flip.tqueue, &tq_timer);
+					schedule_task(&tty->flip.tqueue);
 					kfree_skb(skb);
 					return 1;
 				}
@@ -153,7 +153,7 @@
 							tty->flip.flag_buf_ptr += r;
 							tty->flip.char_buf_ptr += r;
 							if (r)
-								queue_task(&tty->flip.tqueue, &tq_timer);
+								schedule_task(&tty->flip.tqueue);
 							restore_flags(flags);
 						}
 					} else
@@ -2498,7 +2498,7 @@
 
 	} else {
 		restore_flags(flags);
-		queue_task(&tty->flip.tqueue, &tq_timer);
+		schedule_task(&tty->flip.tqueue);
 	}
 }
 
diff -uar linux-2.5.40/drivers/message/fusion/mptlan.c linux-2.5/drivers/message/fusion/mptlan.c
--- linux-2.5.40/drivers/message/fusion/mptlan.c	Tue Oct  1 04:07:00 2002
+++ linux-2.5/drivers/message/fusion/mptlan.c	Wed Oct  2 15:53:12 2002
@@ -875,14 +875,7 @@
 	struct mpt_lan_priv *priv = dev->priv;
 	
 	if (test_and_set_bit(0, &priv->post_buckets_active) == 0) {
-		if (priority) {
-			queue_task(&priv->post_buckets_task, &tq_immediate);
-			mark_bh(IMMEDIATE_BH);
-		} else {
-			queue_task(&priv->post_buckets_task, &tq_timer);
-			dioprintk((KERN_INFO MYNAM ": post_buckets queued on "
-				   "timer.\n"));
-		}
+		schedule_task(&priv->post_buckets_task);
 	        dioprintk((KERN_INFO MYNAM ": %s/%s: Queued post_buckets task.\n",
 			   IOC_AND_NETDEV_NAMES_s_s(dev) ));
 	}
diff -uar linux-2.5.40/drivers/message/fusion/mptscsih.c linux-2.5/drivers/message/fusion/mptscsih.c
--- linux-2.5.40/drivers/message/fusion/mptscsih.c	Tue Oct  1 04:06:56 2002
+++ linux-2.5/drivers/message/fusion/mptscsih.c	Wed Oct  2 15:56:25 2002
@@ -2023,7 +2023,7 @@
 						mptscsih_dvTask.routine = mptscsih_domainValidation;
 						mptscsih_dvTask.data = (void *) hd;
 
-						SCHEDULE_TASK(&mptscsih_dvTask);
+						schedule_task(&mptscsih_dvTask);
 					} else {
 						spin_unlock_irqrestore(&dvtaskQ_lock, lflags);
 					}
diff -uar linux-2.5.40/drivers/mtd/mtdblock_ro.c linux-2.5/drivers/mtd/mtdblock_ro.c
--- linux-2.5.40/drivers/mtd/mtdblock_ro.c	Tue Oct  1 04:06:59 2002
+++ linux-2.5/drivers/mtd/mtdblock_ro.c	Wed Oct  2 16:04:43 2002
@@ -15,6 +15,7 @@
 
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/compatmac.h>
+#include <linux/genhd.h>
 
 #define LOCAL_END_REQUEST
 #define MAJOR_NR MTD_BLOCK_MAJOR
diff -uar linux-2.5.40/drivers/net/fc/iph5526.c linux-2.5/drivers/net/fc/iph5526.c
--- linux-2.5.40/drivers/net/fc/iph5526.c	Tue Oct  1 04:06:24 2002
+++ linux-2.5/drivers/net/fc/iph5526.c	Wed Oct  2 16:29:55 2002
@@ -35,6 +35,8 @@
 static const char *version =
     "iph5526.c:v1.0 07.08.99 Vineet Abraham (vmabraham@hotmail.com)\n";
 
+#error Convert me to understand page+offset based scatterlists
+
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
diff -uar linux-2.5.40/drivers/net/hamradio/baycom_epp.c linux-2.5/drivers/net/hamradio/baycom_epp.c
--- linux-2.5.40/drivers/net/hamradio/baycom_epp.c	Tue Oct  1 04:07:48 2002
+++ linux-2.5/drivers/net/hamradio/baycom_epp.c	Wed Oct  2 16:31:15 2002
@@ -928,7 +928,7 @@
 	bc->debug_vals.mod_cycles = time2 - time1;
 	bc->debug_vals.demod_cycles = time3 - time2;
 #endif /* BAYCOM_DEBUG */
-	queue_task(&bc->run_bh, &tq_timer);
+	schedule_task(&bc->run_bh);
 	if (!bc->skb)
 		netif_wake_queue(dev);
 	return;
@@ -1121,7 +1121,7 @@
 	bc->hdlctx.slotcnt = bc->ch_params.slottime;
 	bc->hdlctx.calibrate = 0;
 	/* start the bottom half stuff */
-	queue_task(&bc->run_bh, &tq_timer);
+	schedule_task(&bc->run_bh);
 	netif_start_queue(dev);
 	MOD_INC_USE_COUNT;
 	return 0;
diff -uar linux-2.5.40/drivers/net/hamradio/dmascc.c linux-2.5/drivers/net/hamradio/dmascc.c
--- linux-2.5.40/drivers/net/hamradio/dmascc.c	Tue Oct  1 04:06:57 2002
+++ linux-2.5/drivers/net/hamradio/dmascc.c	Wed Oct  2 16:30:45 2002
@@ -1073,8 +1073,7 @@
 	  priv->rx_head = (priv->rx_head + 1) % NUM_RX_BUF;
 	  priv->rx_count++;
 	  /* Mark bottom half handler */
-	  queue_task(&priv->rx_task, &tq_immediate);
-	  mark_bh(IMMEDIATE_BH);
+	  schedule_task(&priv->rx_task);
 	} else {
 	  priv->stats.rx_errors++;
 	  priv->stats.rx_over_errors++;
diff -uar linux-2.5.40/drivers/net/plip.c linux-2.5/drivers/net/plip.c
--- linux-2.5.40/drivers/net/plip.c	Tue Oct  1 04:07:44 2002
+++ linux-2.5/drivers/net/plip.c	Wed Oct  2 16:03:01 2002
@@ -378,10 +378,8 @@
 {
 	struct net_local *nl = (struct net_local *)dev->priv;
 
-	if (nl->is_deferred) {
-		queue_task(&nl->immediate, &tq_immediate);
-		mark_bh(IMMEDIATE_BH);
-	}
+	if (nl->is_deferred) 
+		schedule_task(&nl->immediate);
 }
 
 /* Forward declarations of internal routines */
@@ -432,7 +430,7 @@
 	if ((r = (*f)(dev, nl, snd, rcv)) != OK
 	    && (r = plip_bh_timeout_error(dev, nl, snd, rcv, r)) != OK) {
 		nl->is_deferred = 1;
-		queue_task(&nl->deferred, &tq_timer);
+		schedule_task(&nl->deferred);
 	}
 }
 
@@ -444,7 +442,7 @@
 	if (!(atomic_read (&nl->kill_timer))) {
 		plip_interrupt (-1, dev, NULL);
 
-		queue_task (&nl->timer, &tq_timer);
+		schedule_task (&nl->timer);
 	}
 	else {
 		up (&nl->killed_timer_sem);
@@ -665,7 +663,7 @@
 				rcv->state = PLIP_PK_DONE;
 				nl->is_deferred = 1;
 				nl->connection = PLIP_CN_SEND;
-				queue_task(&nl->deferred, &tq_timer);
+				schedule_task(&nl->deferred);
 				enable_parport_interrupts (dev);
 				ENABLE(dev->irq);
 				return OK;
@@ -740,8 +738,7 @@
 		if (snd->state != PLIP_PK_DONE) {
 			nl->connection = PLIP_CN_SEND;
 			spin_unlock_irq(&nl->lock);
-			queue_task(&nl->immediate, &tq_immediate);
-			mark_bh(IMMEDIATE_BH);
+			schedule_task(&nl->immediate);
 			enable_parport_interrupts (dev);
 			ENABLE(dev->irq);
 			return OK;
@@ -909,7 +906,7 @@
 			printk(KERN_DEBUG "%s: send end\n", dev->name);
 		nl->connection = PLIP_CN_CLOSING;
 		nl->is_deferred = 1;
-		queue_task(&nl->deferred, &tq_timer);
+		schedule_task(&nl->deferred);
 		enable_parport_interrupts (dev);
 		ENABLE(dev->irq);
 		return OK;
@@ -953,7 +950,7 @@
 		netif_wake_queue (dev);
 	} else {
 		nl->is_deferred = 1;
-		queue_task(&nl->deferred, &tq_timer);
+		schedule_task(&nl->deferred);
 	}
 
 	return OK;
@@ -997,8 +994,7 @@
 		rcv->state = PLIP_PK_TRIGGER;
 		nl->connection = PLIP_CN_RECEIVE;
 		nl->timeout_count = 0;
-		queue_task(&nl->immediate, &tq_immediate);
-		mark_bh(IMMEDIATE_BH);
+		schedule_task(&nl->immediate);
 		break;
 
 	case PLIP_CN_RECEIVE:
@@ -1051,8 +1047,7 @@
 		nl->connection = PLIP_CN_SEND;
 		nl->timeout_count = 0;
 	}
-	queue_task(&nl->immediate, &tq_immediate);
-	mark_bh(IMMEDIATE_BH);
+	schedule_task(&nl->immediate);
 	spin_unlock_irq(&nl->lock);
 	
 	return 0;
@@ -1131,7 +1126,7 @@
 	if (dev->irq == -1)
 	{
 		atomic_set (&nl->kill_timer, 0);
-		queue_task (&nl->timer, &tq_timer);
+		schedule_task (&nl->timer);
 	}
 
 	/* Initialize the state machine. */
diff -uar linux-2.5.40/drivers/scsi/aha152x.c linux-2.5/drivers/scsi/aha152x.c
--- linux-2.5.40/drivers/scsi/aha152x.c	Tue Oct  1 04:06:16 2002
+++ linux-2.5/drivers/scsi/aha152x.c	Wed Oct  2 16:55:39 2002
@@ -1941,8 +1941,7 @@
 	/* Poke the BH handler */
 	HOSTDATA(shpnt)->service++;
 	aha152x_tq.routine = (void *) run;
-	queue_task(&aha152x_tq, &tq_immediate);
-	mark_bh(IMMEDIATE_BH);
+	schedule_task(&aha152x_tq);
 }
 
 /*
diff -uar linux-2.5.40/drivers/scsi/fdomain.c linux-2.5/drivers/scsi/fdomain.c
--- linux-2.5.40/drivers/scsi/fdomain.c	Tue Oct  1 04:06:19 2002
+++ linux-2.5/drivers/scsi/fdomain.c	Wed Oct  2 16:58:43 2002
@@ -271,6 +271,9 @@
 
  **************************************************************************/
 
+
+#error Please convert me to Documentation/DMA-mapping.txt
+
 #include <linux/module.h>
 
 #ifdef PCMCIA
diff -uar linux-2.5.40/drivers/scsi/imm.c linux-2.5/drivers/scsi/imm.c
--- linux-2.5.40/drivers/scsi/imm.c	Tue Oct  1 04:07:46 2002
+++ linux-2.5/drivers/scsi/imm.c	Wed Oct  2 11:02:27 2002
@@ -898,7 +898,7 @@
     if (imm_engine(tmp, cmd)) {
 	tmp->imm_tq.data = (void *) tmp;
 	tmp->imm_tq.sync = 0;
-	queue_task(&tmp->imm_tq, &tq_timer);
+	schedule_task(&tmp->imm_tq);
 	return;
     }
     /* Command must of completed hence it is safe to let go... */
@@ -1105,8 +1105,8 @@
 
     imm_hosts[host_no].imm_tq.data = imm_hosts + host_no;
     imm_hosts[host_no].imm_tq.sync = 0;
-    queue_task(&imm_hosts[host_no].imm_tq, &tq_immediate);
-    mark_bh(IMMEDIATE_BH);
+
+    schedule_task(&imm_hosts[host_no].imm_tq);
 
     return 0;
 }
diff -uar linux-2.5.40/drivers/scsi/in2000.c linux-2.5/drivers/scsi/in2000.c
--- linux-2.5.40/drivers/scsi/in2000.c	Tue Oct  1 04:07:33 2002
+++ linux-2.5/drivers/scsi/in2000.c	Wed Oct  2 16:58:27 2002
@@ -104,6 +104,8 @@
  *
  */
 
+#error Please convert me to Documentation/DMA-mapping.txt
+
 #include <linux/module.h>
 
 #include <asm/system.h>
diff -uar linux-2.5.40/drivers/scsi/pci2000.c linux-2.5/drivers/scsi/pci2000.c
--- linux-2.5.40/drivers/scsi/pci2000.c	Tue Oct  1 04:07:11 2002
+++ linux-2.5/drivers/scsi/pci2000.c	Wed Oct  2 16:53:32 2002
@@ -35,6 +35,9 @@
  ****************************************************************************/
 #define PCI2000_VERSION		"1.20"
 
+#error Please convert me to Documentation/DMA-mapping.txt
+#error Convert me to understand page+offset based scatterlists
+
 #include <linux/module.h>
 
 #include <linux/kernel.h>
diff -uar linux-2.5.40/drivers/scsi/ppa.c linux-2.5/drivers/scsi/ppa.c
--- linux-2.5.40/drivers/scsi/ppa.c	Tue Oct  1 04:06:13 2002
+++ linux-2.5/drivers/scsi/ppa.c	Wed Oct  2 11:01:21 2002
@@ -110,7 +110,7 @@
 
 int ppa_detect(Scsi_Host_Template * host)
 {
-    struct Scsi_Host *hreg;
+    struct Scsi_Host *hreg = NULL;
     int ports;
     int i, nhosts, try_again;
     struct parport *pb;
@@ -801,7 +801,7 @@
     if (ppa_engine(tmp, cmd)) {
 	tmp->ppa_tq.data = (void *) tmp;
 	tmp->ppa_tq.sync = 0;
-	queue_task(&tmp->ppa_tq, &tq_timer);
+	schedule_task(&tmp->ppa_tq);
 	return;
     }
     /* Command must of completed hence it is safe to let go... */
@@ -986,8 +986,8 @@
 
     ppa_hosts[host_no].ppa_tq.data = ppa_hosts + host_no;
     ppa_hosts[host_no].ppa_tq.sync = 0;
-    queue_task(&ppa_hosts[host_no].ppa_tq, &tq_immediate);
-    mark_bh(IMMEDIATE_BH);
+
+    schedule_task(&ppa_hosts[host_no].ppa_tq);
 
     return 0;
 }
diff -uar linux-2.5.40/drivers/scsi/seagate.c linux-2.5/drivers/scsi/seagate.c
--- linux-2.5.40/drivers/scsi/seagate.c	Tue Oct  1 04:06:58 2002
+++ linux-2.5/drivers/scsi/seagate.c	Wed Oct  2 16:58:05 2002
@@ -87,6 +87,8 @@
  *                the CONTROL an DATA registers.
  */
 
+#error Please convert me to Documentation/DMA-mapping.txt
+
 #include <linux/module.h>
 
 #include <asm/io.h>
diff -uar linux-2.5.40/drivers/telephony/ixj.c linux-2.5/drivers/telephony/ixj.c
--- linux-2.5.40/drivers/telephony/ixj.c	Tue Oct  1 04:06:16 2002
+++ linux-2.5/drivers/telephony/ixj.c	Wed Oct  2 18:40:27 2002
@@ -274,8 +274,8 @@
 
 #include "ixj.h"
 
-#define TYPE(dev) (MINOR(dev) >> 4)
-#define NUM(dev) (MINOR(dev) & 0xf)
+#define TYPE(dev) (minor(dev) >> 4)
+#define NUM(dev) (minor(dev) & 0xf)
 
 static int ixjdebug;
 static int hertz = HZ;
@@ -6202,7 +6202,7 @@
 	IXJ_FILTER_RAW jfr;
 
 	unsigned int raise, mant;
-	unsigned int minor = MINOR(inode->i_rdev);
+	unsigned int minor = minor(inode->i_rdev);
 	int board = NUM(inode->i_rdev);
 
 	IXJ *j = get_ixj(NUM(inode->i_rdev));
diff -uar linux-2.5.40/drivers/telephony/ixj.h linux-2.5/drivers/telephony/ixj.h
--- linux-2.5.40/drivers/telephony/ixj.h	Tue Oct  1 04:07:49 2002
+++ linux-2.5/drivers/telephony/ixj.h	Wed Oct  2 17:56:46 2002
@@ -1199,7 +1199,7 @@
 	unsigned char cid_play_flag;
 	char play_mode;
 	IXJ_FLAGS flags;
-	unsigned int busyflags;
+	unsigned long busyflags;
 	unsigned int rec_frame_size;
 	unsigned int play_frame_size;
 	unsigned int cid_play_frame_size;
diff -uar linux-2.5.40/include/asm-i386/system.h linux-2.5/include/asm-i386/system.h
--- linux-2.5.40/include/asm-i386/system.h	Tue Oct  1 04:05:47 2002
+++ linux-2.5/include/asm-i386/system.h	Wed Oct  2 13:06:49 2002
@@ -323,6 +323,27 @@
 /* For spinlocks etc */
 #define local_irq_save(x)	__asm__ __volatile__("pushfl ; popl %0 ; cli":"=g" (x): /* no input */ :"memory")
 
+#ifdef CONFIG_SMP
+
+extern void __global_cli(void);
+extern void __global_sti(void);
+extern unsigned long __global_save_flags(void);
+extern void __global_restore_flags(unsigned long);
+#define cli() __global_cli()
+#define sti() __global_sti()
+#define save_flags(x) ((x)=__global_save_flags())
+#define restore_flags(x) __global_restore_flags(x)
+
+#else
+
+#define cli() local_irq_disable()
+#define sti() local_irq_enable()
+#define save_flags(x) local_save_flags(x)
+#define restore_flags(x) local_irq_restore(x)
+
+#endif
+
+
 /*
  * disable hlt during certain critical i/o operations
  */
diff -uar linux-2.5.40/include/linux/interrupt.h linux-2.5/include/linux/interrupt.h
--- linux-2.5.40/include/linux/interrupt.h	Tue Oct  1 04:07:02 2002
+++ linux-2.5/include/linux/interrupt.h	Wed Oct  2 13:03:07 2002
@@ -25,18 +25,6 @@
 #include <asm/hardirq.h>
 #include <asm/softirq.h>
 
-/*
- * Temporary defines for UP kernels, until all code gets fixed.
- */
-#if !CONFIG_SMP
-# define cli()			local_irq_disable()
-# define sti()			local_irq_enable()
-# define save_flags(x)		local_save_flags(x)
-# define restore_flags(x)	local_irq_restore(x)
-# define save_and_cli(x)	local_irq_save(x)
-#endif
-
-
 /* PLEASE, avoid to allocate new softirqs, if you need not _really_ high
    frequency threaded job scheduling. For almost all the purposes
    tasklets are more than enough. F.e. all serial device BHs et
diff -uar linux-2.5.40/net/irda/ircomm/ircomm_param.c linux-2.5/net/irda/ircomm/ircomm_param.c
--- linux-2.5.40/net/irda/ircomm/ircomm_param.c	Tue Oct  1 04:07:00 2002
+++ linux-2.5/net/irda/ircomm/ircomm_param.c	Wed Oct  2 17:18:19 2002
@@ -166,8 +166,7 @@
 
 	if (flush) {
 		/* ircomm_tty_do_softint will take care of the rest */
-		queue_task(&self->tqueue, &tq_immediate);
-		mark_bh(IMMEDIATE_BH);
+		schedule_task(&self->tqueue);
 	}
 
 	return count;
diff -uar linux-2.5.40/net/irda/ircomm/ircomm_tty.c linux-2.5/net/irda/ircomm/ircomm_tty.c
--- linux-2.5.40/net/irda/ircomm/ircomm_tty.c	Tue Oct  1 04:06:28 2002
+++ linux-2.5/net/irda/ircomm/ircomm_tty.c	Wed Oct  2 17:17:41 2002
@@ -632,8 +632,7 @@
 	 * Let do_softint() do this to avoid race condition with 
 	 * do_softint() ;-) 
 	 */
-	queue_task(&self->tqueue, &tq_immediate);
-	mark_bh(IMMEDIATE_BH);
+	schedule_task(&self->tqueue);
 }
 
 /*
@@ -806,8 +805,7 @@
 	 * its 256 byte tx buffer). We will then defragment and send out
 	 * all this data as one single packet.  
 	 */
-	queue_task(&self->tqueue, &tq_immediate);
-	mark_bh(IMMEDIATE_BH);
+	schedule_task(&self->tqueue);
 	
 	return len;
 }
@@ -1132,8 +1130,7 @@
 				/* Wake up processes blocked on open */
 				wake_up_interruptible(&self->open_wait);
 
-				queue_task(&self->tqueue, &tq_immediate);
-				mark_bh(IMMEDIATE_BH);
+				schedule_task(&self->tqueue);
 				return;
 			}
 		} else {
@@ -1246,8 +1243,7 @@
 		tty->hw_stopped = 0;
 
 		/* ircomm_tty_do_softint will take care of the rest */
-		queue_task(&self->tqueue, &tq_immediate);
-		mark_bh(IMMEDIATE_BH);
+		schedule_task(&self->tqueue);
 		break;
 	default:  /* If we get here, something is very wrong, better stop */
 	case FLOW_STOP:
diff -uar linux-2.5.40/net/irda/ircomm/ircomm_tty_attach.c linux-2.5/net/irda/ircomm/ircomm_tty_attach.c
--- linux-2.5.40/net/irda/ircomm/ircomm_tty_attach.c	Tue Oct  1 04:07:37 2002
+++ linux-2.5/net/irda/ircomm/ircomm_tty_attach.c	Wed Oct  2 17:18:02 2002
@@ -535,8 +535,7 @@
 		wake_up_interruptible(&self->open_wait);
 	}
 
-	queue_task(&self->tqueue, &tq_immediate);
-	mark_bh(IMMEDIATE_BH);
+	schedule_task(&self->tqueue);
 }
 
 /*

----

http://www.techlinux.com.br/~carlos/tmp/2.5.40-1.diff


-- 
	 _________________________
	 Carlos E Gorges          
	 (carlos@techlinux.com.br)
	 Tech informática LTDA
	 Brazil                   
	 _________________________


