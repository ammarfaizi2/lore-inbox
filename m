Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262212AbTCWBfK>; Sat, 22 Mar 2003 20:35:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262219AbTCWBeK>; Sat, 22 Mar 2003 20:34:10 -0500
Received: from dp.samba.org ([66.70.73.150]:37847 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S262213AbTCWBdj>;
	Sat, 22 Mar 2003 20:33:39 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15997.3948.688276.293771@nanango.paulus.ozlabs.org>
Date: Sun, 23 Mar 2003 12:35:40 +1100 (EST)
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] update via-cuda driver
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates the CUDA driver (the power/reset/ADB controller on
older powermacs) to fix some SMP issues and to match the 2.4 version
of the driver.  From Ben Herrenschmidt.

Please apply.  This patch depends on the patch to include/linux/cuda.h
that I sent earlier.

Paul.

diff -urN linux-2.5/drivers/macintosh/via-cuda.c pmac-2.5/drivers/macintosh/via-cuda.c
--- linux-2.5/drivers/macintosh/via-cuda.c	2002-11-19 04:38:42.000000000 +1100
+++ pmac-2.5/drivers/macintosh/via-cuda.c	2003-03-03 13:51:01.000000000 +1100
@@ -176,8 +176,8 @@
     /* for us by the main VIA driver in arch/m68k/mac/via.c        */
 
 #ifndef CONFIG_MAC
-    via[IFR] = 0x7f; eieio();	/* clear interrupts by writing 1s */
-    via[IER] = IER_SET|SR_INT; eieio();	/* enable interrupt from SR */
+    out_8(&via[IFR], 0x7f);	/* clear interrupts by writing 1s */
+    out_8(&via[IER], IER_SET|SR_INT); /* enable interrupt from SR */
 #endif
 
     /* enable autopoll */
@@ -246,7 +246,8 @@
 #endif /* CONFIG_ADB */
 
 #define WAIT_FOR(cond, what)					\
-    do {							\
+    do {                                                        \
+    	int x;							\
 	for (x = 1000; !(cond); --x) {				\
 	    if (x == 0) {					\
 		printk("Timeout waiting for " what "\n");	\
@@ -259,40 +260,40 @@
 static int
 cuda_init_via()
 {
-    int x;
-
-    via[DIRB] = (via[DIRB] | TACK | TIP) & ~TREQ;	/* TACK & TIP out */
-    via[B] |= TACK | TIP;				/* negate them */
-    via[ACR] = (via[ACR] & ~SR_CTRL) | SR_EXT;		/* SR data in */
-    eieio();
-    x = via[SR]; eieio();	/* clear any left-over data */
+    out_8(&via[DIRB], (in_8(&via[DIRB]) | TACK | TIP) & ~TREQ);	/* TACK & TIP out */
+    out_8(&via[B], in_8(&via[B]) | TACK | TIP);			/* negate them */
+    out_8(&via[ACR] ,(in_8(&via[ACR]) & ~SR_CTRL) | SR_EXT);	/* SR data in */
+    (void)in_8(&via[SR]);						/* clear any left-over data */
 #ifndef CONFIG_MAC
-    via[IER] = 0x7f; eieio();	/* disable interrupts from VIA */
+    out_8(&via[IER], 0x7f);					/* disable interrupts from VIA */
+    (void)in_8(&via[IER]);
 #endif
-    eieio();
 
     /* delay 4ms and then clear any pending interrupt */
     mdelay(4);
-    x = via[SR]; eieio();
+    (void)in_8(&via[SR]);
+    out_8(&via[IFR], in_8(&via[IFR]) & 0x7f);
 
     /* sync with the CUDA - assert TACK without TIP */
-    via[B] &= ~TACK; eieio();
+    out_8(&via[B], in_8(&via[B]) & ~TACK);
 
     /* wait for the CUDA to assert TREQ in response */
-    WAIT_FOR((via[B] & TREQ) == 0, "CUDA response to sync");
+    WAIT_FOR((in_8(&via[B]) & TREQ) == 0, "CUDA response to sync");
 
     /* wait for the interrupt and then clear it */
-    WAIT_FOR(via[IFR] & SR_INT, "CUDA response to sync (2)");
-    x = via[SR]; eieio();
+    WAIT_FOR(in_8(&via[IFR]) & SR_INT, "CUDA response to sync (2)");
+    (void)in_8(&via[SR]);
+    out_8(&via[IFR], in_8(&via[IFR]) & 0x7f);
 
     /* finish the sync by negating TACK */
-    via[B] |= TACK; eieio();
+    out_8(&via[B], in_8(&via[B]) | TACK);
 
     /* wait for the CUDA to negate TREQ and the corresponding interrupt */
-    WAIT_FOR(via[B] & TREQ, "CUDA response to sync (3)");
-    WAIT_FOR(via[IFR] & SR_INT, "CUDA response to sync (4)");
-    x = via[SR]; eieio();
-    via[B] |= TIP; eieio();	/* should be unnecessary */
+    WAIT_FOR(in_8(&via[B]) & TREQ, "CUDA response to sync (3)");
+    WAIT_FOR(in_8(&via[IFR]) & SR_INT, "CUDA response to sync (4)");
+    (void)in_8(&via[SR]);
+    out_8(&via[IFR], in_8(&via[IFR]) & 0x7f);
+    out_8(&via[B], in_8(&via[B]) | TIP);	/* should be unnecessary */
 
     return 0;
 }
@@ -415,55 +416,59 @@
     req = current_req;
     if (req == 0)
 	return;
-    if ((via[B] & TREQ) == 0)
+    if ((in_8(&via[B]) & TREQ) == 0)
 	return;			/* a byte is coming in from the CUDA */
 
     /* set the shift register to shift out and send a byte */
-    via[ACR] |= SR_OUT; eieio();
-    via[SR] = req->data[0]; eieio();
-    via[B] &= ~TIP;
+    out_8(&via[ACR], in_8(&via[ACR]) | SR_OUT);
+    out_8(&via[SR], req->data[0]);
+    out_8(&via[B], in_8(&via[B]) & ~TIP);
     cuda_state = sent_first_byte;
 }
 
 void
 cuda_poll()
 {
-    if (via[IFR] & SR_INT) {
-	unsigned long flags;
+    unsigned long flags;
 
-	/* cuda_interrupt only takes a normal lock, we disable
-	 * interrupts here to avoid re-entering and thus deadlocking.
-	 * An option would be to disable only the IRQ source with
-	 * disable_irq(), would that work on m68k ? --BenH
-	 */
-	local_irq_save(flags);
-	cuda_interrupt(0, 0, 0);
-	local_irq_restore(flags);
-    }
+    /* cuda_interrupt only takes a normal lock, we disable
+     * interrupts here to avoid re-entering and thus deadlocking.
+     * An option would be to disable only the IRQ source with
+     * disable_irq(), would that work on m68k ? --BenH
+     */
+    local_irq_save(flags);
+    cuda_interrupt(0, 0, 0);
+    local_irq_restore(flags);
 }
 
 static void
 cuda_interrupt(int irq, void *arg, struct pt_regs *regs)
 {
-    int x, status;
+    int status;
     struct adb_request *req = NULL;
     unsigned char ibuf[16];
     int ibuf_len = 0;
     int complete = 0;
+    unsigned char virq;
     
-    if ((via[IFR] & SR_INT) == 0)
-	return;
-
     spin_lock(&cuda_lock);
-    status = (~via[B] & (TIP|TREQ)) | (via[ACR] & SR_OUT); eieio();
+
+    virq = in_8(&via[IFR]) & 0x7f;
+    out_8(&via[IFR], virq);   
+    if ((virq & SR_INT) == 0) {
+        spin_unlock(&cuda_lock);
+	return;
+    }
+    
+    status = (~in_8(&via[B]) & (TIP|TREQ)) | (in_8(&via[ACR]) & SR_OUT);
     /* printk("cuda_interrupt: state=%d status=%x\n", cuda_state, status); */
     switch (cuda_state) {
     case idle:
 	/* CUDA has sent us the first byte of data - unsolicited */
 	if (status != TREQ)
 	    printk("cuda: state=idle, status=%x\n", status);
-	x = via[SR]; eieio();
-	via[B] &= ~TIP; eieio();
+	(void)in_8(&via[SR]);
+	out_8(&via[B], in_8(&via[B]) & ~TIP);
 	cuda_state = reading;
 	reply_ptr = cuda_rbuf;
 	reading_reply = 0;
@@ -473,8 +478,8 @@
 	/* CUDA has sent us the first byte of data of a reply */
 	if (status != TREQ)
 	    printk("cuda: state=awaiting_reply, status=%x\n", status);
-	x = via[SR]; eieio();
-	via[B] &= ~TIP; eieio();
+	(void)in_8(&via[SR]);
+	out_8(&via[B], in_8(&via[B]) & ~TIP);
 	cuda_state = reading;
 	reply_ptr = current_req->reply;
 	reading_reply = 1;
@@ -483,16 +488,16 @@
     case sent_first_byte:
 	if (status == TREQ + TIP + SR_OUT) {
 	    /* collision */
-	    via[ACR] &= ~SR_OUT; eieio();
-	    x = via[SR]; eieio();
-	    via[B] |= TIP | TACK; eieio();
+	    out_8(&via[ACR], in_8(&via[ACR]) & ~SR_OUT);
+	    (void)in_8(&via[SR]);
+	    out_8(&via[B], in_8(&via[B]) | TIP | TACK);
 	    cuda_state = idle;
 	} else {
 	    /* assert status == TIP + SR_OUT */
 	    if (status != TIP + SR_OUT)
 		printk("cuda: state=sent_first_byte status=%x\n", status);
-	    via[SR] = current_req->data[1]; eieio();
-	    via[B] ^= TACK; eieio();
+	    out_8(&via[SR], current_req->data[1]);
+	    out_8(&via[B], in_8(&via[B]) ^ TACK);
 	    data_index = 2;
 	    cuda_state = sending;
 	}
@@ -501,9 +506,9 @@
     case sending:
 	req = current_req;
 	if (data_index >= req->nbytes) {
-	    via[ACR] &= ~SR_OUT; eieio();
-	    x = via[SR]; eieio();
-	    via[B] |= TACK | TIP; eieio();
+	    out_8(&via[ACR], in_8(&via[ACR]) & ~SR_OUT);
+	    (void)in_8(&via[SR]);
+	    out_8(&via[B], in_8(&via[B]) | TACK | TIP);
 	    req->sent = 1;
 	    if (req->reply_expected) {
 		cuda_state = awaiting_reply;
@@ -515,27 +520,27 @@
 		cuda_start();
 	    }
 	} else {
-	    via[SR] = req->data[data_index++]; eieio();
-	    via[B] ^= TACK; eieio();
+	    out_8(&via[SR], req->data[data_index++]);
+	    out_8(&via[B], in_8(&via[B]) ^ TACK);
 	}
 	break;
 
     case reading:
-	*reply_ptr++ = via[SR]; eieio();
+	*reply_ptr++ = in_8(&via[SR]);
 	if (status == TIP) {
 	    /* that's all folks */
-	    via[B] |= TACK | TIP; eieio();
+	    out_8(&via[B], in_8(&via[B]) | TACK | TIP);
 	    cuda_state = read_done;
 	} else {
 	    /* assert status == TIP | TREQ */
 	    if (status != TIP + TREQ)
 		printk("cuda: state=reading status=%x\n", status);
-	    via[B] ^= TACK; eieio();
+	    out_8(&via[B], in_8(&via[B]) ^ TACK);
 	}
 	break;
 
     case read_done:
-	x = via[SR]; eieio();
+	(void)in_8(&via[SR]);
 	if (reading_reply) {
 	    req = current_req;
 	    req->reply_len = reply_ptr - req->reply;
@@ -564,7 +569,7 @@
 	    memcpy(ibuf, cuda_rbuf, ibuf_len);
 	}
 	if (status == TREQ) {
-	    via[B] &= ~TIP; eieio();
+	    out_8(&via[B], in_8(&via[B]) & ~TIP);
 	    cuda_state = reading;
 	    reply_ptr = cuda_rbuf;
 	    reading_reply = 0;
