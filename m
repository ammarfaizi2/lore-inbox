Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263766AbTDGXWI (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 19:22:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263885AbTDGXPI (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 19:15:08 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:57216
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263814AbTDGXEu (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 19:04:50 -0400
Date: Tue, 8 Apr 2003 01:23:43 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200304080023.h380Nh2n009089@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: port ltpc to 2.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/drivers/net/appletalk/ltpc.c linux-2.5.67-ac1/drivers/net/appletalk/ltpc.c
--- linux-2.5.67/drivers/net/appletalk/ltpc.c	2003-02-10 18:38:15.000000000 +0000
+++ linux-2.5.67-ac1/drivers/net/appletalk/ltpc.c	2003-04-04 18:31:37.000000000 +0100
@@ -213,6 +213,7 @@
 #include <linux/interrupt.h>
 #include <linux/ptrace.h>
 #include <linux/ioport.h>
+#include <linux/spinlock.h>
 #include <linux/in.h>
 #include <linux/slab.h>
 #include <linux/string.h>
@@ -235,6 +236,9 @@
 /* our stuff */
 #include "ltpc.h"
 
+static spinlock_t txqueue_lock = SPIN_LOCK_UNLOCKED;
+static spinlock_t mbox_lock = SPIN_LOCK_UNLOCKED;
+
 /* function prototypes */
 static int do_read(struct net_device *dev, void *cbuf, int cbuflen,
 	void *dbuf, int dbuflen);
@@ -283,17 +287,17 @@
 {
 	unsigned long flags;
 	qel->next = NULL;
-	save_flags(flags);
-	cli();
+	
+	spin_lock_irqsave(&txqueue_lock, flags);
 	if (xmQtl) {
 		xmQtl->next = qel;
 	} else {
 		xmQhd = qel;
 	}
 	xmQtl = qel;
-	restore_flags(flags);
+	spin_unlock_irqrestore(&txqueue_lock, flags);
 
-	if (debug&DEBUG_LOWER)
+	if (debug & DEBUG_LOWER)
 		printk("enqueued a 0x%02x command\n",qel->cbuf[0]);
 }
 
@@ -302,18 +306,18 @@
 	unsigned long flags;
 	int i;
 	struct xmitQel *qel=NULL;
-	save_flags(flags);
-	cli();
+	
+	spin_lock_irqsave(&txqueue_lock, flags);
 	if (xmQhd) {
 		qel = xmQhd;
 		xmQhd = qel->next;
 		if(!xmQhd) xmQtl = NULL;
 	}
-	restore_flags(flags);
+	spin_unlock_irqrestore(&txqueue_lock, flags);
 
-	if ((debug&DEBUG_LOWER) && qel) {
+	if ((debug & DEBUG_LOWER) && qel) {
 		int n;
-		printk("ltpc: dequeued command ");
+		printk(KERN_DEBUG "ltpc: dequeued command ");
 		n = qel->cbuflen;
 		if (n>100) n=100;
 		for(i=0;i<n;i++) printk("%02x ",qel->cbuf[i]);
@@ -352,14 +356,13 @@
 	unsigned long flags;
 	int i;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&mbox_lock, flags);
 	for(i=1;i<16;i++) if(!mboxinuse[i]) {
 		mboxinuse[i]=1;
-		restore_flags(flags);
+		spin_unlock_irqrestore(&mbox_lock, flags);
 		return i;
 	}
-	restore_flags(flags);
+	spin_unlock_irqrestore(&mbox_lock, flags);
 	return 0;
 }
 
@@ -503,16 +506,13 @@
 	int i;
 	int base = dev->base_addr;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&txqueue_lock, flags);
 	if(QInIdle) {
-		restore_flags(flags);
+		spin_unlock_irqrestore(&txqueue_lock, flags);
 		return;
 	}
 	QInIdle = 1;
-
-
-	restore_flags(flags);
+	spin_unlock_irqrestore(&txqueue_lock, flags);
 
 	/* this tri-states the IRQ line */
 	(void) inb_p(base+6);
@@ -531,17 +531,17 @@
 	switch(state) {
 		case 0xfc:
 			/* incoming command */
-			if (debug&DEBUG_LOWER) printk("idle: fc\n");
+			if (debug & DEBUG_LOWER) printk("idle: fc\n");
 			handlefc(dev); 
 			break;
 		case 0xfd:
 			/* incoming data */
-			if(debug&DEBUG_LOWER) printk("idle: fd\n");
+			if(debug & DEBUG_LOWER) printk("idle: fd\n");
 			handlefd(dev); 
 			break;
 		case 0xf9:
 			/* result ready */
-			if (debug&DEBUG_LOWER) printk("idle: f9\n");
+			if (debug & DEBUG_LOWER) printk("idle: f9\n");
 			if(!mboxinuse[0]) {
 				mboxinuse[0] = 1;
 				qels[0].cbuf = rescbuf;
@@ -570,7 +570,7 @@
 			break;
 		case 0xfa:
 			/* waiting for command */
-			if(debug&DEBUG_LOWER) printk("idle: fa\n");
+			if(debug & DEBUG_LOWER) printk("idle: fa\n");
 			if (xmQhd) {
 				q=deQ();
 				memcpy(ltdmacbuf,q->cbuf,q->cbuflen);
@@ -608,7 +608,7 @@
 			break;
 		case 0Xfb:
 			/* data transfer ready */
-			if(debug&DEBUG_LOWER) printk("idle: fb\n");
+			if(debug & DEBUG_LOWER) printk("idle: fb\n");
 			if(q->QWrite) {
 				memcpy(ltdmabuf,q->dbuf,q->dbuflen);
 				handlewrite(dev);
@@ -826,7 +826,7 @@
 	struct lt_init c;
 	int ltflags;
 
-	if(debug&DEBUG_VERBOSE) printk("ltpc_ioctl called\n");
+	if(debug & DEBUG_VERBOSE) printk("ltpc_ioctl called\n");
 
 	switch(cmd) {
 		case SIOCSIFADDR:
@@ -872,7 +872,7 @@
 static int ltpc_hard_header (struct sk_buff *skb, struct net_device *dev, 
 	unsigned short type, void *daddr, void *saddr, unsigned len)
 {
-	if(debug&DEBUG_VERBOSE)
+	if(debug & DEBUG_VERBOSE)
 		printk("ltpc_hard_header called for device %s\n",
 			dev->name);
 	return 0;
@@ -914,7 +914,7 @@
 
 	del_timer(&ltpc_timer);
 
-	if(debug&DEBUG_VERBOSE) {
+	if(debug & DEBUG_VERBOSE) {
 		if (!ltpc_poll_counter) {
 			ltpc_poll_counter = 50;
 			printk("ltpc poll is alive\n");
@@ -951,7 +951,7 @@
 	cbuf.length = skb->len;	/* this is host order */
 	skb->h.raw=skb->data;
 
-	if(debug&DEBUG_UPPER) {
+	if(debug & DEBUG_UPPER) {
 		printk("command ");
 		for(i=0;i<6;i++)
 			printk("%02x ",((unsigned char *)&cbuf)[i]);
@@ -960,7 +960,7 @@
 
 	do_write(dev,&cbuf,sizeof(cbuf),skb->h.raw,skb->len);
 
-	if(debug&DEBUG_UPPER) {
+	if(debug & DEBUG_UPPER) {
 		printk("sent %d ddp bytes\n",skb->len);
 		for(i=0;i<skb->len;i++) printk("%02x ",skb->h.raw[i]);
 		printk("\n");
@@ -984,7 +984,7 @@
 static int __init ltpc_probe_dma(int base)
 {
 	int dma = 0;
-  	int timeout;
+  	unsigned long timeout;
   	unsigned long f;
   
   	if (!request_dma(1,"ltpc")) {
@@ -1055,16 +1055,13 @@
 {
 	int err;
 	int x=0,y=0;
-	int timeout;
 	int autoirq;
-	unsigned long flags;
 	unsigned long f;
 	int portfound=0;
+	unsigned long timeout;
 
 	SET_MODULE_OWNER(dev);
 
-	save_flags(flags);
-
 	/* probe for the I/O port address */
 	if (io != 0x240 && request_region(0x220,8,"ltpc")) {
 		x = inb_p(0x220+6);
@@ -1093,15 +1090,13 @@
 	}
 	if(!portfound) {
 		/* give up in despair */
-		printk ("LocalTalk card not found; 220 = %02x, 240 = %02x.\n",
-			x,y);
-		restore_flags(flags);
+		printk(KERN_ERR "LocalTalk card not found; 220 = %02x, 240 = %02x.\n", x,y);
 		return -1;
 	}
 
 	/* probe for the IRQ line */
 	if (irq < 2) {
-		unsigned long irq_mask, delay;
+		unsigned long irq_mask;
 
 		irq_mask = probe_irq_on();
 		/* reset the interrupt line */
@@ -1109,14 +1104,11 @@
 		inb_p(io+7);
 		/* trigger an interrupt (I hope) */
 		inb_p(io+6);
-
-		delay = jiffies + HZ/50;
-		while (time_before(jiffies, delay)) ;
+		mdelay(2);
 		autoirq = probe_irq_off(irq_mask);
 
 		if (autoirq == 0) {
-			printk("ltpc: probe at %#x failed to detect IRQ line.\n",
-				io);
+			printk(KERN_ERR "ltpc: probe at %#x failed to detect IRQ line.\n", io);
 		}
 		else {
 			irq = autoirq;
@@ -1129,12 +1121,11 @@
 	if (ltdmabuf) ltdmacbuf = &ltdmabuf[800];
 
 	if (!ltdmabuf) {
-		printk("ltpc: mem alloc failed\n");
-		restore_flags(flags);
-		return(-1);
+		printk(KERN_ERR "ltpc: mem alloc failed\n");
+		return -1;
 	}
 
-	if(debug&DEBUG_VERBOSE) {
+	if(debug & DEBUG_VERBOSE) {
 		printk("ltdmabuf pointer %08lx\n",(unsigned long) ltdmabuf);
 	}
 
@@ -1142,8 +1133,10 @@
 
 	inb_p(io+1);
 	inb_p(io+3);
-	timeout = jiffies+2*HZ/100;
-	while(time_before(jiffies, timeout)) ; /* hold it in reset for a coupla jiffies */
+
+	set_current_state(TASK_UNINTERRUPTIBLE);
+	schedule_timeout(2*HZ/100);
+
 	inb_p(io+0);
 	inb_p(io+2);
 	inb_p(io+7); /* clear reset */
@@ -1152,12 +1145,9 @@
 	inb_p(io+5); /* enable dma */
 	inb_p(io+6); /* tri-state interrupt line */
 
-	timeout = jiffies+100*HZ/100;
+	set_current_state(TASK_UNINTERRUPTIBLE);
+	schedule_timeout(HZ);
 	
-	while(time_before(jiffies, timeout)) {
-		/* wait for the card to complete initialization */
-	}
- 
 	/* now, figure out which dma channel we're using, unless it's
 	   already been specified */
 	/* well, 0 is a legal DMA channel, but the LTPC card doesn't
@@ -1165,8 +1155,7 @@
 	if (dma == 0) {
 		dma = ltpc_probe_dma(io);
 		if (!dma) {  /* no dma channel */
-			printk("No DMA channel found on ltpc card.\n");
-			restore_flags(flags);
+			printk(KERN_ERR "No DMA channel found on ltpc card.\n");
 			return -1;
 		}
 	}
@@ -1174,9 +1163,9 @@
 	/* print out friendly message */
 
 	if(irq)
-		printk("Apple/Farallon LocalTalk-PC card at %03x, IR%d, DMA%d.\n",io,irq,dma);
+		printk(KERN_INFO "Apple/Farallon LocalTalk-PC card at %03x, IR%d, DMA%d.\n",io,irq,dma);
 	else
-		printk("Apple/Farallon LocalTalk-PC card at %03x, DMA%d.  Using polled mode.\n",io,dma);
+		printk(KERN_INFO "Apple/Farallon LocalTalk-PC card at %03x, DMA%d.  Using polled mode.\n",io,dma);
 
 	/* seems more logical to do this *after* probing the card... */
 	err = ltpc_init(dev);
@@ -1202,20 +1191,25 @@
 	(void) inb_p(io+3);
 	(void) inb_p(io+2);
 	timeout = jiffies+100*HZ/100;
+
 	while(time_before(jiffies, timeout)) {
-		if( 0xf9 == inb_p(io+6)) break;
+		if( 0xf9 == inb_p(io+6))
+			break;
+		schedule();
 	}
 
-	if(debug&DEBUG_VERBOSE) {
+	if(debug & DEBUG_VERBOSE) {
 		printk("setting up timer and irq\n");
 	}
 
-	if (irq) {
-		/* grab it and don't let go :-) */
-		(void) request_irq( irq, &ltpc_interrupt, 0, "ltpc", dev);
+	/* grab it and don't let go :-) */
+	if (irq && request_irq( irq, &ltpc_interrupt, 0, "ltpc", dev) >= 0)
+	{
 		(void) inb_p(io+7);  /* enable interrupts from board */
 		(void) inb_p(io+7);  /* and reset irq line */
 	} else {
+		if( irq )
+			printk(KERN_ERR "ltpc: IRQ already in use, using polled mode.\n");
 		/* polled mode -- 20 times per second */
 		/* this is really, really slow... should it poll more often? */
 		init_timer(&ltpc_timer);
@@ -1224,7 +1218,6 @@
 
 		ltpc_timer.expires = jiffies + 5;
 		add_timer(&ltpc_timer);
-		restore_flags(flags); 
 	}
 
 	return 0;
@@ -1294,7 +1287,7 @@
 		printk(KERN_DEBUG "could not register Localtalk-PC device\n");
 		return result;
 	} else {
-		if(debug&DEBUG_VERBOSE) printk("0 from register_netdev\n");
+		if(debug & DEBUG_VERBOSE) printk("0 from register_netdev\n");
 		return 0;
 	}
 }
@@ -1306,7 +1299,7 @@
 
 	ltpc_timer.data = 0;  /* signal the poll routine that we're done */
 
-	if(debug&DEBUG_VERBOSE) printk("freeing irq\n");
+	if(debug & DEBUG_VERBOSE) printk("freeing irq\n");
 
 	if(dev_ltpc.irq) {
 		free_irq(dev_ltpc.irq,&dev_ltpc);
@@ -1316,7 +1309,7 @@
 	if(del_timer(&ltpc_timer)) 
 	{
 		/* either the poll was never started, or a poll is in process */
-		if(debug&DEBUG_VERBOSE) printk("waiting\n");
+		if(debug & DEBUG_VERBOSE) printk("waiting\n");
 		/* if it's in process, wait a bit for it to finish */
 		timeout = jiffies+HZ; 
 		add_timer(&ltpc_timer);
@@ -1327,31 +1320,31 @@
 		}
 	}
 
-	if(debug&DEBUG_VERBOSE) printk("freeing dma\n");
+	if(debug & DEBUG_VERBOSE) printk("freeing dma\n");
 
 	if(dev_ltpc.dma) {
 		free_dma(dev_ltpc.dma);
 		dev_ltpc.dma = 0;
 	}
 
-	if(debug&DEBUG_VERBOSE) printk("freeing ioaddr\n");
+	if(debug & DEBUG_VERBOSE) printk("freeing ioaddr\n");
 
 	if(dev_ltpc.base_addr) {
 		release_region(dev_ltpc.base_addr,8);
 		dev_ltpc.base_addr = 0;
 	}
 
-	if(debug&DEBUG_VERBOSE) printk("free_pages\n");
+	if(debug & DEBUG_VERBOSE) printk("free_pages\n");
 
 	free_pages( (unsigned long) ltdmabuf, get_order(1000));
 	ltdmabuf=NULL;
 	ltdmacbuf=NULL;
 
-	if(debug&DEBUG_VERBOSE) printk("unregister_netdev\n");
+	if(debug & DEBUG_VERBOSE) printk("unregister_netdev\n");
 
 	unregister_netdev(&dev_ltpc);
 
-	if(debug&DEBUG_VERBOSE) printk("returning from cleanup_module\n");
+	if(debug & DEBUG_VERBOSE) printk("returning from cleanup_module\n");
 }
 
 module_exit(ltpc_cleanup);
