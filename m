Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262069AbTELJvk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 05:51:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262039AbTELJtr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 05:49:47 -0400
Received: from amsfep12-int.chello.nl ([213.46.243.18]:5157 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S262057AbTELJpO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 05:45:14 -0400
Date: Mon, 12 May 2003 11:54:43 +0200
Message-Id: <200305120954.h4C9shCN001045@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] M68k IRQ API updates [16/20]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k mac drivers: Update to the new irq API (from Roman Zippel and me) [16/20]

--- linux-2.5.69/drivers/macintosh/via-macii.c	Thu Jan  2 12:54:27 2003
+++ linux-m68k-2.5.69/drivers/macintosh/via-macii.c	Fri May  9 10:21:32 2003
@@ -77,7 +77,7 @@
 
 static int  macii_init_via(void);
 static void macii_start(void);
-static void macii_interrupt(int irq, void *arg, struct pt_regs *regs);
+static irqreturn_t macii_interrupt(int irq, void *arg, struct pt_regs *regs);
 static void macii_retransmit(int);
 static void macii_queue_poll(void);
 
@@ -151,7 +151,7 @@
 	if (err) return err;
 
 	err = request_irq(IRQ_MAC_ADB, macii_interrupt, IRQ_FLG_LOCK, "ADB",
-		    macii_interrupt);
+			  macii_interrupt);
 	if (err) return err;
 
 	macii_state = idle;
@@ -410,7 +410,7 @@
  * Note: As of 21/10/97, the MacII ADB part works including timeout detection
  * and retransmit (Talk to the last active device).
  */
-void macii_interrupt(int irq, void *arg, struct pt_regs *regs)
+static irqreturn_t macii_interrupt(int irq, void *arg, struct pt_regs *regs)
 {
 	int x, adbdir;
 	unsigned long flags;
@@ -423,7 +423,7 @@
 
 	if (driver_running) {
 		local_irq_restore(flags);
-		return;
+		return IRQ_NONE;
 	}
 
 	driver_running = 1;
@@ -649,4 +649,5 @@
 	/* reset mutex and interrupts */
 	driver_running = 0;
 	local_irq_restore(flags);
+	return IRQ_HANDLED;
 }
--- linux-2.5.69/drivers/macintosh/via-maciisi.c	Thu Jan  2 12:54:27 2003
+++ linux-m68k-2.5.69/drivers/macintosh/via-maciisi.c	Fri May  9 10:21:32 2003
@@ -84,7 +84,7 @@
 static int maciisi_send_request(struct adb_request* req, int sync);
 static void maciisi_sync(struct adb_request *req);
 static int maciisi_write(struct adb_request* req);
-static void maciisi_interrupt(int irq, void* arg, struct pt_regs* regs);
+static irqreturn_t maciisi_interrupt(int irq, void* arg, struct pt_regs* regs);
 static void maciisi_input(unsigned char *buf, int nb, struct pt_regs *regs);
 static int maciisi_init_via(void);
 static void maciisi_poll(void);
@@ -414,7 +414,7 @@
 /* Shift register interrupt - this is *supposed* to mean that the
    register is either full or empty. In practice, I have no idea what
    it means :( */
-static void
+static irqreturn_t
 maciisi_interrupt(int irq, void* arg, struct pt_regs* regs)
 {
 	int status;
@@ -436,7 +436,7 @@
 		/* Shouldn't happen, we hope */
 		printk(KERN_ERR "maciisi_interrupt: called without interrupt flag set\n");
 		local_irq_restore(flags);
-		return;
+		return IRQ_NONE;
 	}
 
 	/* Clear the interrupt */
@@ -635,6 +635,7 @@
 		printk("maciisi_interrupt: unknown maciisi_state %d?\n", maciisi_state);
 	}
 	local_irq_restore(flags);
+	return IRQ_HANDLED;
 }
 
 static void
--- linux-2.5.69/drivers/macintosh/via-pmu68k.c	Thu Jan  9 10:19:55 2003
+++ linux-m68k-2.5.69/drivers/macintosh/via-pmu68k.c	Fri May  9 10:21:32 2003
@@ -107,7 +107,7 @@
 static int pmu_probe(void);
 static int pmu_init(void);
 static void pmu_start(void);
-static void pmu_interrupt(int irq, void *arg, struct pt_regs *regs);
+static irqreturn_t pmu_interrupt(int irq, void *arg, struct pt_regs *regs);
 static int pmu_send_request(struct adb_request *req, int sync);
 static int pmu_autopoll(int devs);
 void pmu_poll(void);
@@ -572,7 +572,7 @@
 	local_irq_restore(flags);
 }
 
-static void 
+static irqreturn_t
 pmu_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
 	struct adb_request *req;
@@ -688,6 +688,7 @@
 	printk("pmu_interrupt: exit state %d acr %02X, b %02X data_index %d/%d adb_int_pending %d\n",
 		pmu_state, (uint) via1[ACR], (uint) via2[B], data_index, data_len, adb_int_pending);
 #endif
+	return IRQ_HANDLED;
 }
 
 static void 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
