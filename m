Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265077AbSL0QIz>; Fri, 27 Dec 2002 11:08:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265093AbSL0QHC>; Fri, 27 Dec 2002 11:07:02 -0500
Received: from amsfep16-int.chello.nl ([213.46.243.26]:39228 "EHLO
	amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id <S265077AbSL0QDo>; Fri, 27 Dec 2002 11:03:44 -0500
Date: Fri, 27 Dec 2002 17:11:11 +0100
Message-Id: <200212271611.gBRGBBJI008035@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] M68k mac local_irq*() updates
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert m68k Mac drivers to new local_irq*() framework:
  - Mac IIfx and Quadra 9x0 ADB
  - Mac II and IIsi ADB
  - Powerbook ADB

--- linux-2.5.53/drivers/macintosh/adb-iop.c	Wed Feb 16 07:39:01 2000
+++ linux-m68k-2.5.53/drivers/macintosh/adb-iop.c	Fri Nov  8 22:40:52 2002
@@ -83,15 +83,14 @@
 	struct adb_request *req;
 	uint flags;
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 
 	req = current_req;
 	if ((adb_iop_state == sending) && req && req->reply_expected) {
 		adb_iop_state = awaiting_reply;
 	}
 
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 /*
@@ -107,8 +106,7 @@
 	struct adb_request *req;
 	uint flags;
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 
 	req = current_req;
 
@@ -150,7 +148,7 @@
 		memcpy(msg->reply, msg->message, IOP_MSG_LEN);
 	}
 	iop_complete_message(msg);
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 /*
@@ -170,8 +168,7 @@
 	req = current_req;
 	if (!req) return;
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 
 #ifdef DEBUG_ADB_IOP
 	printk("adb_iop_start: sending packet, %d bytes:", req->nbytes);
@@ -192,7 +189,7 @@
 
 	req->sent = 1;
 	adb_iop_state = sending;
-	restore_flags(flags);
+	local_irq_restore(flags);
 
 	/* Now send it. The IOP manager will call adb_iop_complete */
 	/* when the packet has been sent.                          */
@@ -236,8 +233,7 @@
 		return -EINVAL;
 	}
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 
 	req->next = 0;
 	req->sent = 0;
@@ -252,7 +248,7 @@
 		last_req = req;
 	}
 
-	restore_flags(flags);
+	local_irq_restore(flags);
 	if (adb_iop_state == idle) adb_iop_start();
 	return 0;
 }
--- linux-2.5.53/drivers/macintosh/via-macii.c	Fri Dec 27 14:17:35 2002
+++ linux-m68k-2.5.53/drivers/macintosh/via-macii.c	Mon Nov 18 22:39:10 2002
@@ -145,8 +145,7 @@
 	unsigned long flags;
 	int err;
 	
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 	
 	err = macii_init_via();
 	if (err) return err;
@@ -156,7 +155,7 @@
 	if (err) return err;
 
 	macii_state = idle;
-	restore_flags(flags);	
+	local_irq_restore(flags);
 	return 0;
 }
 
@@ -197,13 +196,12 @@
 	adb_request(&req, NULL, ADBREQ_REPLY|ADBREQ_NOSEND, 1,
 		    ADB_READREG(device, 0));
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 
 	req.next = current_req;
 	current_req = &req;
 
-	restore_flags(flags);
+	local_irq_restore(flags);
 	macii_start();
 	in_poll--;
 }
@@ -222,8 +220,7 @@
 	adb_request(&rt, NULL, ADBREQ_REPLY|ADBREQ_NOSEND, 1,
 		    ADB_READREG(device, 0));
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 
 	if (current_req != NULL) {
 		last_req->next = &rt;
@@ -235,7 +232,7 @@
 
 	if (macii_state == idle) macii_start();
 
-	restore_flags(flags);
+	local_irq_restore(flags);
 	in_retransmit--;
 }
 
@@ -268,7 +265,7 @@
 	req->complete = 0;
 	req->reply_len = 0;
 
-	save_flags(flags); cli();
+	local_irq_save(flags);
 
 	if (current_req != NULL) {
 		last_req->next = req;
@@ -279,7 +276,7 @@
 		if (macii_state == idle) macii_start();
 	}
 
-	restore_flags(flags);
+	local_irq_restore(flags);
 	return 0;
 }
 
@@ -297,9 +294,9 @@
 {
 	unsigned long flags;
 
-	save_flags(flags); cli();
+	local_irq_save(flags);
 	if (via[IFR] & SR_INT) macii_interrupt(0, 0, 0);
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 /* Reset the bus */
@@ -329,7 +326,7 @@
 		return;
 	}
 
-	save_flags(flags); cli();
+	local_irq_save(flags);
 	
 	/* 
 	 * IRQ signaled ?? (means ADB controller wants to send, or might 
@@ -357,7 +354,7 @@
 					(uint) via[B] & (ST_MASK|TREQ));
 			retry_req = req;
 			/* set ADB status here ? */
-			restore_flags(flags);
+			local_irq_restore(flags);
 			return;
 		} else {
 			need_poll = 0;
@@ -386,7 +383,7 @@
 	macii_state = sending;
 	data_index = 2;
 
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 /*
@@ -422,10 +419,10 @@
 	last_status = status;
 
 	/* prevent races due to SCSI enabling ints */
-	save_flags(flags); cli();
+	local_irq_save(flags);
 
 	if (driver_running) {
-		restore_flags(flags);
+		local_irq_restore(flags);
 		return;
 	}
 
@@ -651,5 +648,5 @@
 	}
 	/* reset mutex and interrupts */
 	driver_running = 0;
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
--- linux-2.5.53/drivers/macintosh/via-maciisi.c	Fri Dec 27 14:17:35 2002
+++ linux-m68k-2.5.53/drivers/macintosh/via-maciisi.c	Mon Nov 18 22:39:10 2002
@@ -313,8 +313,7 @@
 	req->complete = 0;
 	req->reply_len = 0;
 	
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 
 	if (current_req) {
 		last_req->next = req;
@@ -328,7 +327,7 @@
 		i = maciisi_start();
 		if(i != 0)
 		{
-			restore_flags(flags);
+			local_irq_restore(flags);
 			return i;
 		}
 	}
@@ -337,11 +336,11 @@
 #ifdef DEBUG_MACIISI_ADB
 		printk(KERN_DEBUG "maciisi_write: would start, but state is %d\n", maciisi_state);
 #endif
-		restore_flags(flags);
+		local_irq_restore(flags);
 		return -EBUSY;
 	}
 
-	restore_flags(flags);
+	local_irq_restore(flags);
 
 	return 0;
 }
@@ -402,15 +401,14 @@
 {
 	unsigned long flags;
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 	if (via[IFR] & SR_INT) {
 		maciisi_interrupt(0, 0, 0);
 	}
 	else /* avoid calling this function too quickly in a loop */
 		udelay(ADB_DELAY);
 
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 /* Shift register interrupt - this is *supposed* to mean that the
@@ -427,8 +425,7 @@
 	int i;
 	unsigned long flags;
 
-	save_flags(flags);
-	cli();
+	local_irq_save(flags);
 
 	status = via[B] & (TIP|TREQ);
 #ifdef DEBUG_MACIISI_ADB
@@ -438,7 +435,7 @@
 	if (!(via[IFR] & SR_INT)) {
 		/* Shouldn't happen, we hope */
 		printk(KERN_ERR "maciisi_interrupt: called without interrupt flag set\n");
-		restore_flags(flags);
+		local_irq_restore(flags);
 		return;
 	}
 
@@ -637,7 +634,7 @@
 	default:
 		printk("maciisi_interrupt: unknown maciisi_state %d?\n", maciisi_state);
 	}
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 static void
--- linux-2.5.53/drivers/macintosh/via-pmu68k.c	Fri Dec 27 14:17:35 2002
+++ linux-m68k-2.5.53/drivers/macintosh/via-pmu68k.c	Mon Nov 18 22:39:10 2002
@@ -496,7 +496,7 @@
 	req->next = 0;
 	req->sent = 0;
 	req->complete = 0;
-	save_flags(flags); cli();
+	local_irq_save(flags);
 
 	if (current_req != 0) {
 		last_req->next = req;
@@ -508,7 +508,7 @@
 			pmu_start();
 	}
 
-	restore_flags(flags);
+	local_irq_restore(flags);
 	return 0;
 }
 
@@ -538,7 +538,7 @@
 
 	/* assert pmu_state == idle */
 	/* get the packet to send */
-	save_flags(flags); cli();
+	local_irq_save(flags);
 	req = current_req;
 	if (req == 0 || pmu_state != idle
 	    || (req->reply_expected && req_awaiting_reply))
@@ -552,16 +552,15 @@
 	send_byte(req->data[0]);
 
 out:
-	restore_flags(flags);
+	local_irq_restore(flags);
 }
 
 void 
 pmu_poll()
 {
-	unsigned long cpu_flags;
+	unsigned long flags;
 
-	save_flags(cpu_flags);
-	cli();
+	local_irq_save(flags);
 	if (via1[IFR] & SR_INT) {
 		via1[IFR] = SR_INT;
 		pmu_interrupt(IRQ_MAC_ADB_SR, NULL, NULL);
@@ -570,7 +569,7 @@
 		via1[IFR] = CB1_INT;
 		pmu_interrupt(IRQ_MAC_ADB_CL, NULL, NULL);
 	}
-	restore_flags(cpu_flags);
+	local_irq_restore(flags);
 }
 
 static void 
@@ -964,9 +963,9 @@
 	asm volatile("mfspr %0,1008" : "=r" (hid0) :);
 	hid0 = (hid0 & ~(HID0_NAP | HID0_DOZE)) | HID0_SLEEP;
 	asm volatile("mtspr 1008,%0" : : "r" (hid0));
-	save_flags(msr);
+	local_save_flags(msr);
 	msr |= MSR_POW | MSR_EE;
-	restore_flags(msr);
+	local_irq_restore(msr);
 	udelay(10);
 
 	/* OK, we're awake again, start restoring things */

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
