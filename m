Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265979AbUBJSEC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 13:04:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265935AbUBJSCg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 13:02:36 -0500
Received: from ns.suse.de ([195.135.220.2]:27792 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266194AbUBJR7w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 12:59:52 -0500
Date: Tue, 10 Feb 2004 18:59:47 +0100
From: Karsten Keil <kkeil@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.3-rc1-mm1
Message-ID: <20040210175947.GA27945@pingi3.kke.suse.de>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20040209014035.251b26d1.akpm@osdl.org> <1076320225.671.7.camel@chevrolet.hybel> <20040209022453.44e7f453.akpm@osdl.org> <20040209115618.GA7639@pingi3.kke.suse.de> <20040209112207.4e7d97c9.akpm@osdl.org> <20040210022510.GA17364@pingi3.kke.suse.de> <20040210022343.4ebbc186.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040210022343.4ebbc186.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Organization: SuSE Linux AG
X-Operating-System: Linux 2.4.21-166-default i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Tue, Feb 10, 2004 at 02:23:43AM -0800, Andrew Morton wrote:
> 
> I've added a couple of fixups to get everything working with older versions
> of gcc.  I'll send those through for review.  We do have the below problem
> though.  These drivers should be fixed up or marked BROKEN_ON_SMP.
> 


This is a incremental patch for the mm tree and the big ISDN patch.

It fix:

- SMP in act2000 and pcbit driver
- remove check_region in act2000
- mark hysdn, isdnloop and divert as BROKEN_ON_SMP


diff -urN linux-2.6.3-rc1-mm1.ref/drivers/isdn/act2000/act2000.h linux-2.6.3-rc1-mm1.i4l/drivers/isdn/act2000/act2000.h
--- linux-2.6.3-rc1-mm1.ref/drivers/isdn/act2000/act2000.h	2003-12-18 03:58:56.000000000 +0100
+++ linux-2.6.3-rc1-mm1.i4l/drivers/isdn/act2000/act2000.h	2004-02-10 18:22:22.000000000 +0100
@@ -147,34 +147,36 @@
  * Per card driver data
  */
 typedef struct act2000_card {
-        unsigned short port;             /* Base-port-address                */
-        unsigned short irq;              /* Interrupt                        */
-        u_char ptype;                    /* Protocol type (1TR6 or Euro)     */
-        u_char bus;                      /* Cardtype (ISA, MCA, PCMCIA)      */
-        struct act2000_card *next;	 /* Pointer to next device struct    */
-        int myid;                        /* Driver-Nr. assigned by linklevel */
-        unsigned long flags;             /* Statusflags                      */
-        unsigned long ilock;             /* Semaphores for IRQ-Routines      */
-	struct sk_buff_head rcvq;        /* Receive-Message queue            */
-	struct sk_buff_head sndq;        /* Send-Message queue               */
-	struct sk_buff_head ackq;        /* Data-Ack-Message queue           */
-	u_char *ack_msg;                 /* Ptr to User Data in User skb     */
-	__u16 need_b3ack;                /* Flag: Need ACK for current skb   */
-	struct sk_buff *sbuf;            /* skb which is currently sent      */
-	struct timer_list ptimer;        /* Poll timer                       */
-	struct work_struct snd_tq;         /* Task struct for xmit bh          */
-	struct work_struct rcv_tq;         /* Task struct for rcv bh           */
-	struct work_struct poll_tq;        /* Task struct for polled rcv bh    */
+	unsigned short port;		/* Base-port-address                */
+	unsigned short irq;		/* Interrupt                        */
+	u_char ptype;			/* Protocol type (1TR6 or Euro)     */
+	u_char bus;			/* Cardtype (ISA, MCA, PCMCIA)      */
+	struct act2000_card *next;	/* Pointer to next device struct    */
+	spinlock_t lock;		/* protect critical operations      */
+	int myid;			/* Driver-Nr. assigned by linklevel */
+	unsigned long flags;		/* Statusflags                      */
+	unsigned long ilock;		/* Semaphores for IRQ-Routines      */
+	struct sk_buff_head rcvq;	/* Receive-Message queue            */
+	struct sk_buff_head sndq;	/* Send-Message queue               */
+	struct sk_buff_head ackq;	/* Data-Ack-Message queue           */
+	u_char *ack_msg;		/* Ptr to User Data in User skb     */
+	__u16 need_b3ack;		/* Flag: Need ACK for current skb   */
+	struct sk_buff *sbuf;		/* skb which is currently sent      */
+	struct timer_list ptimer;	/* Poll timer                       */
+	struct work_struct snd_tq;	/* Task struct for xmit bh          */
+	struct work_struct rcv_tq;	/* Task struct for rcv bh           */
+	struct work_struct poll_tq;	/* Task struct for polled rcv bh    */
 	msn_entry *msn_list;
-	unsigned short msgnum;           /* Message number fur sending       */
-	act2000_chan bch[ACT2000_BCH];   /* B-Channel status/control         */
-	char   status_buf[256];          /* Buffer for status messages       */
+	unsigned short msgnum;		/* Message number for sending       */
+	spinlock_t mnlock;		/* lock for msgnum                  */
+	act2000_chan bch[ACT2000_BCH];	/* B-Channel status/control         */
+	char   status_buf[256];		/* Buffer for status messages       */
 	char   *status_buf_read;
 	char   *status_buf_write;
 	char   *status_buf_end;
-	irq_data idat;                   /* Data used for IRQ handler        */
-        isdn_if interface;               /* Interface to upper layer         */
-        char regname[35];                /* Name used for request_region     */
+	irq_data idat;			/* Data used for IRQ handler        */
+	isdn_if interface;		/* Interface to upper layer         */
+	char regname[35];		/* Name used for request_region     */
 } act2000_card;
 
 extern __inline__ void act2000_schedule_tx(act2000_card *card)
diff -urN linux-2.6.3-rc1-mm1.ref/drivers/isdn/act2000/act2000_isa.c linux-2.6.3-rc1-mm1.i4l/drivers/isdn/act2000/act2000_isa.c
--- linux-2.6.3-rc1-mm1.ref/drivers/isdn/act2000/act2000_isa.c	2003-12-18 03:58:46.000000000 +0100
+++ linux-2.6.3-rc1-mm1.i4l/drivers/isdn/act2000/act2000_isa.c	2004-02-10 18:22:22.000000000 +0100
@@ -21,10 +21,8 @@
 static void
 act2000_isa_delay(long t)
 {
-        sti();
         set_current_state(TASK_INTERRUPTIBLE);
         schedule_timeout(t);
-        sti();
 }
 
 /*
@@ -64,8 +62,10 @@
 {
         int ret = 0;
 
-        if (!check_region(portbase, ISA_REGION))
+	if (request_region(portbase, ACT2000_PORTLEN, "act2000isa")) {
                 ret = act2000_isa_reset(portbase);
+		release_region(portbase, ISA_REGION);                
+	}
         return ret;
 }
 
@@ -177,14 +177,13 @@
                 release_region(card->port, ISA_REGION);
                 card->flags &= ~ACT2000_FLAGS_PVALID;
         }
-        if (!check_region(portbase, ISA_REGION)) {
-                if (request_region(portbase, ACT2000_PORTLEN, card->regname) == NULL)
-			return -EIO;
+	if (request_region(portbase, ACT2000_PORTLEN, card->regname) == NULL)
+		return -EBUSY;
+	else {
                 card->port = portbase;
                 card->flags |= ACT2000_FLAGS_PVALID;
                 return 0;
         }
-        return -EBUSY;
 }
 
 /*
@@ -195,8 +194,7 @@
 {
         unsigned long flags;
 
-        save_flags(flags);
-        cli();
+        spin_lock_irqsave(&card->lock, flags);
         if (card->flags & ACT2000_FLAGS_IVALID) {
                 free_irq(card->irq, NULL);
                 irq2card_map[card->irq] = NULL;
@@ -205,7 +203,7 @@
         if (card->flags & ACT2000_FLAGS_PVALID)
                 release_region(card->port, ISA_REGION);
         card->flags &= ~ACT2000_FLAGS_PVALID;
-        restore_flags(flags);
+        spin_unlock_irqrestore(&card->lock, flags);
 }
 
 static int
@@ -316,8 +314,7 @@
         if (test_and_set_bit(ACT2000_LOCK_TX, (void *) &card->ilock) != 0)
 		return;
 	while (1) {
-		save_flags(flags);
-		cli();
+		spin_lock_irqsave(&card->lock, flags);
 		if (!(card->sbuf)) {
 			if ((card->sbuf = skb_dequeue(&card->sndq))) {
 				card->ack_msg = card->sbuf->data;
@@ -330,7 +327,7 @@
 				}
 			}
 		}
-		restore_flags(flags);
+		spin_unlock_irqrestore(&card->lock, flags);
 		if (!(card->sbuf)) {
 			/* No more data to send */
 			test_and_clear_bit(ACT2000_LOCK_TX, (void *) &card->ilock);
diff -urN linux-2.6.3-rc1-mm1.ref/drivers/isdn/act2000/capi.c linux-2.6.3-rc1-mm1.i4l/drivers/isdn/act2000/capi.c
--- linux-2.6.3-rc1-mm1.ref/drivers/isdn/act2000/capi.c	2003-12-18 03:59:39.000000000 +0100
+++ linux-2.6.3-rc1-mm1.i4l/drivers/isdn/act2000/capi.c	2004-02-10 18:22:22.000000000 +0100
@@ -591,10 +591,9 @@
 	struct actcapi_msg *m;
 	int ret = 0;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&card->lock, flags);
 	skb = skb_peek(&card->ackq);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&card->lock, flags);
         if (!skb) {
 		printk(KERN_WARNING "act2000: handle_ack nothing found!\n");
 		return 0;
@@ -614,10 +613,9 @@
 				chan->queued = 0;
                         return ret;
                 }
-		save_flags(flags);
-		cli();
+                spin_lock_irqsave(&card->lock, flags);
                 tmp = skb_peek((struct sk_buff_head *)tmp);
-		restore_flags(flags);
+                spin_unlock_irqrestore(&card->lock, flags);
                 if ((tmp == skb) || (tmp == NULL)) {
 			/* reached end of queue */
 			printk(KERN_WARNING "act2000: handle_ack nothing found!\n");
diff -urN linux-2.6.3-rc1-mm1.ref/drivers/isdn/act2000/capi.h linux-2.6.3-rc1-mm1.i4l/drivers/isdn/act2000/capi.h
--- linux-2.6.3-rc1-mm1.ref/drivers/isdn/act2000/capi.h	2003-12-18 03:59:42.000000000 +0100
+++ linux-2.6.3-rc1-mm1.i4l/drivers/isdn/act2000/capi.h	2004-02-10 18:22:22.000000000 +0100
@@ -336,12 +336,11 @@
 	unsigned long flags;
 	unsigned short n;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&card->mnlock, flags);
 	n = card->msgnum;
 	card->msgnum++;
 	card->msgnum &= 0x7fff;
-	restore_flags(flags);
+	spin_unlock_irqrestore(&card->mnlock, flags);
 	return n;
 }
 #define DEBUG_MSG
diff -urN linux-2.6.3-rc1-mm1.ref/drivers/isdn/act2000/module.c linux-2.6.3-rc1-mm1.i4l/drivers/isdn/act2000/module.c
--- linux-2.6.3-rc1-mm1.ref/drivers/isdn/act2000/module.c	2003-12-18 03:59:15.000000000 +0100
+++ linux-2.6.3-rc1-mm1.i4l/drivers/isdn/act2000/module.c	2004-02-10 18:22:22.000000000 +0100
@@ -62,19 +62,18 @@
 static void
 act2000_clear_msn(act2000_card *card)
 {
-        struct msn_entry *p = card->msn_list;
-        struct msn_entry *q;
+	struct msn_entry *p = card->msn_list;
+	struct msn_entry *q;
 	unsigned long flags;
 
-	save_flags(flags);
-	cli();
-        card->msn_list = NULL;
-	restore_flags(flags);
-        while (p) {
-                q  = p->next;
-                kfree(p);
-                p = q;
-        }
+	spin_lock_irqsave(&card->lock, flags);
+	card->msn_list = NULL;
+	spin_unlock_irqrestore(&card->lock, flags);
+	while (p) {
+		q  = p->next;
+		kfree(p);
+		p = q;
+	}
 }
 
 /*
@@ -143,13 +142,12 @@
 		/* Delete a single MSN */
 		while (p) {
 			if (p->eaz == eazmsn[0]) {
-				save_flags(flags);
-				cli();
+				spin_lock_irqsave(&card->lock, flags);
 				if (q)
 					q->next = p->next;
 				else
 					card->msn_list = p->next;
-				restore_flags(flags);
+				spin_unlock_irqrestore(&card->lock, flags);
 				kfree(p);
 				printk(KERN_DEBUG
 				       "Mapping for EAZ %c deleted\n",
@@ -165,10 +163,9 @@
 	while (p) {
 		/* Found in list, replace MSN */
 		if (p->eaz == eazmsn[0]) {
-			save_flags(flags);
-			cli();
+			spin_lock_irqsave(&card->lock, flags);
 			strcpy(p->msn, &eazmsn[1]);
-			restore_flags(flags);
+			spin_unlock_irqrestore(&card->lock, flags);
 			printk(KERN_DEBUG
 			       "Mapping for EAZ %c changed to %s\n",
 			       eazmsn[0],
@@ -184,10 +181,9 @@
 	p->eaz = eazmsn[0];
 	strcpy(p->msn, &eazmsn[1]);
 	p->next = card->msn_list;
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&card->lock, flags);
 	card->msn_list = p;
-	restore_flags(flags);
+	spin_unlock_irqrestore(&card->lock, flags);
 	printk(KERN_DEBUG
 	       "Mapping %c -> %s added\n",
 	       eazmsn[0],
@@ -232,10 +228,9 @@
 	unsigned long flags;
 
 	act2000_receive(card);
-        save_flags(flags);
-        cli();
-        mod_timer(&card->ptimer, jiffies+3);
-        restore_flags(flags);
+	spin_lock_irqsave(&card->lock, flags);
+	mod_timer(&card->ptimer, jiffies+3);
+	spin_unlock_irqrestore(&card->lock, flags);
 }
 
 static int
@@ -311,10 +306,9 @@
 				return -ENODEV;
 			if (!(chan = find_channel(card, c->arg & 0x0f)))
 				break;
-			save_flags(flags);
-			cli();
+			spin_lock_irqsave(&card->lock, flags);
 			if (chan->fsm_state != ACT2000_STATE_NULL) {
-				restore_flags(flags);
+				spin_unlock_irqrestore(&card->lock, flags);
 				printk(KERN_WARNING "Dial on channel with state %d\n",
 					chan->fsm_state);
 				return -EBUSY;
@@ -325,7 +319,7 @@
 				tmp[0] = c->parm.setup.eazmsn[0];
 			chan->fsm_state = ACT2000_STATE_OCALL;
 			chan->callref = 0xffff;
-			restore_flags(flags);
+			spin_unlock_irqrestore(&card->lock, flags);
 			ret = actcapi_connect_req(card, chan, c->parm.setup.phone,
 						  tmp[0], c->parm.setup.si1,
 						  c->parm.setup.si2);
@@ -580,6 +574,8 @@
                 return;
         }
         memset((char *) card, 0, sizeof(act2000_card));
+        spin_lock_init(&card->lock);
+        spin_lock_init(&card->mnlock);
 	skb_queue_head_init(&card->sndq);
 	skb_queue_head_init(&card->rcvq);
 	skb_queue_head_init(&card->ackq);
diff -urN linux-2.6.3-rc1-mm1.ref/drivers/isdn/hysdn/Kconfig linux-2.6.3-rc1-mm1.i4l/drivers/isdn/hysdn/Kconfig
--- linux-2.6.3-rc1-mm1.ref/drivers/isdn/hysdn/Kconfig	2003-12-18 03:59:27.000000000 +0100
+++ linux-2.6.3-rc1-mm1.i4l/drivers/isdn/hysdn/Kconfig	2004-02-10 18:22:21.000000000 +0100
@@ -3,7 +3,7 @@
 #
 config HYSDN
 	tristate "Hypercope HYSDN cards (Champ, Ergo, Metro) support (module only)"
-	depends on m && PROC_FS
+	depends on m && PROC_FS && BROKEN_ON_SMP
 	help
 	  Say Y here if you have one of Hypercope's active PCI ISDN cards
 	  Champ, Ergo and Metro. You will then get a module called hysdn.
diff -urN linux-2.6.3-rc1-mm1.ref/drivers/isdn/i4l/Kconfig linux-2.6.3-rc1-mm1.i4l/drivers/isdn/i4l/Kconfig
--- linux-2.6.3-rc1-mm1.ref/drivers/isdn/i4l/Kconfig	2004-02-09 22:25:57.000000000 +0100
+++ linux-2.6.3-rc1-mm1.i4l/drivers/isdn/i4l/Kconfig	2004-02-10 18:22:20.000000000 +0100
@@ -78,6 +78,7 @@
 
 config ISDN_DRV_LOOP
 	tristate "isdnloop support"
+	depends on BROKEN_ON_SMP
 	help
 	  This driver provides a virtual ISDN card. Its primary purpose is
 	  testing of linklevel features or configuration without getting
@@ -87,7 +88,7 @@
 
 config ISDN_DIVERSION
 	tristate "Support isdn diversion services"
-	depends on BROKEN
+	depends on BROKEN && BROKEN_ON_SMP
 	help
 	  This option allows you to use some supplementary diversion
 	  services in conjunction with the HiSax driver on an EURO/DSS1
diff -urN linux-2.6.3-rc1-mm1.ref/drivers/isdn/pcbit/drv.c linux-2.6.3-rc1-mm1.i4l/drivers/isdn/pcbit/drv.c
--- linux-2.6.3-rc1-mm1.ref/drivers/isdn/pcbit/drv.c	2003-12-18 03:59:06.000000000 +0100
+++ linux-2.6.3-rc1-mm1.i4l/drivers/isdn/pcbit/drv.c	2004-02-10 18:22:21.000000000 +0100
@@ -84,6 +84,7 @@
 	dev_pcbit[board] = dev;
 	memset(dev, 0, sizeof(struct pcbit_dev));
 	init_waitqueue_head(&dev->set_running_wq);
+	spin_lock_init(&dev->lock);
 
 	if (mem_base >= 0xA0000 && mem_base <= 0xFFFFF ) {
 		dev->ph_mem = mem_base;
diff -urN linux-2.6.3-rc1-mm1.ref/drivers/isdn/pcbit/edss1.c linux-2.6.3-rc1-mm1.i4l/drivers/isdn/pcbit/edss1.c
--- linux-2.6.3-rc1-mm1.ref/drivers/isdn/pcbit/edss1.c	2003-12-18 03:58:08.000000000 +0100
+++ linux-2.6.3-rc1-mm1.i4l/drivers/isdn/pcbit/edss1.c	2004-02-10 18:22:21.000000000 +0100
@@ -278,9 +278,7 @@
 	struct fsm_timer_entry *tentry;
 	unsigned long flags;
 
-	save_flags(flags);
-	cli();
-
+	spin_lock_irqsave(&dev->lock, flags);
 
         for (action = fsm_table; action->init != 0xff; action++)
                 if (action->init == chan->fsm_state && action->event == event)
@@ -288,9 +286,9 @@
   
 	if (action->init == 0xff) {
 		
+		spin_unlock_irqrestore(&dev->lock, flags);
 		printk(KERN_DEBUG "fsm error: event %x on state %x\n", 
                        event, chan->fsm_state);
-		restore_flags(flags);
 		return;
 	}
 
@@ -315,7 +313,7 @@
                 add_timer(&chan->fsm_timer);
         }
 
-	restore_flags(flags);
+	spin_unlock_irqrestore(&dev->lock, flags);
 
 	if (action->callb)
 		action->callb(dev, chan, data);
diff -urN linux-2.6.3-rc1-mm1.ref/drivers/isdn/pcbit/layer2.c linux-2.6.3-rc1-mm1.i4l/drivers/isdn/pcbit/layer2.c
--- linux-2.6.3-rc1-mm1.ref/drivers/isdn/pcbit/layer2.c	2003-12-18 03:59:16.000000000 +0100
+++ linux-2.6.3-rc1-mm1.i4l/drivers/isdn/pcbit/layer2.c	2004-02-10 18:22:21.000000000 +0100
@@ -121,18 +121,17 @@
 
 	frame->next = NULL;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&dev->lock, flags);
 
 	if (dev->write_queue == NULL) {
 		dev->write_queue = frame;
-		restore_flags(flags);
+		spin_unlock_irqrestore(&dev->lock, flags);
 		pcbit_transmit(dev);
 	} else {
 		for (ptr = dev->write_queue; ptr->next; ptr = ptr->next);
 		ptr->next = frame;
 
-		restore_flags(flags);
+		spin_unlock_irqrestore(&dev->lock, flags);
 	}
 	return 0;
 }
@@ -174,15 +173,14 @@
 
 	unacked = (dev->send_seq + (8 - dev->unack_seq)) & 0x07;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&dev->lock, flags);
 
 	if (dev->free > 16 && dev->write_queue && unacked < 7) {
 
 		if (!dev->w_busy)
 			dev->w_busy = 1;
 		else {
-			restore_flags(flags);
+			spin_unlock_irqrestore(&dev->lock, flags);
 			return;
 		}
 
@@ -190,7 +188,7 @@
 		frame = dev->write_queue;
 		free = dev->free;
 
-		restore_flags(flags);
+		spin_unlock_irqrestore(&dev->lock, flags);
 
 		if (frame->copied == 0) {
 
@@ -271,9 +269,7 @@
 		dev->free -= flen;
 		pcbit_tx_update(dev, flen);
 
-		save_flags(flags);
-		cli();
-
+		spin_lock_irqsave(&dev->lock, flags);
 
 		if (frame->skb == NULL || frame->copied == frame->skb->len) {
 
@@ -286,9 +282,9 @@
 			kfree(frame);
 		}
 		dev->w_busy = 0;
-		restore_flags(flags);
+		spin_unlock_irqrestore(&dev->lock, flags);
 	} else {
-		restore_flags(flags);
+		spin_unlock_irqrestore(&dev->lock, flags);
 #ifdef DEBUG
 		printk(KERN_DEBUG "unacked %d free %d write_queue %s\n",
 		     unacked, dev->free, dev->write_queue ? "not empty" :
@@ -309,12 +305,11 @@
 	unsigned long flags, msg;
 	struct pcbit_dev *dev = (struct pcbit_dev *) data;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&dev->lock, flags);
 
 	while ((frame = dev->read_queue)) {
 		dev->read_queue = frame->next;
-		restore_flags(flags);
+		spin_unlock_irqrestore(&dev->lock, flags);
 
 		SET_MSG_CPU(msg, 0);
 		SET_MSG_PROC(msg, 0);
@@ -331,11 +326,10 @@
 
 		kfree(frame);
 
-		save_flags(flags);
-		cli();
+		spin_lock_irqsave(&dev->lock, flags);
 	}
 
-	restore_flags(flags);
+	spin_unlock_irqrestore(&dev->lock, flags);
 }
 
 /*
@@ -460,12 +454,9 @@
 	memcpy_frompcbit(dev, skb_put(frame->skb, tt), tt);
 
 	frame->copied += tt;
-
+	spin_lock_irqsave(&dev->lock, flags);
 	if (frame->copied == frame->hdr_len + frame->dt_len) {
 
-		save_flags(flags);
-		cli();
-
 		if (type1) {
 			dev->read_frame = NULL;
 		}
@@ -476,14 +467,10 @@
 		} else
 			dev->read_queue = frame;
 
-		restore_flags(flags);
-
 	} else {
-		save_flags(flags);
-		cli();
 		dev->read_frame = frame;
-		restore_flags(flags);
 	}
+	spin_unlock_irqrestore(&dev->lock, flags);
 }
 
 /*
diff -urN linux-2.6.3-rc1-mm1.ref/drivers/isdn/pcbit/pcbit.h linux-2.6.3-rc1-mm1.i4l/drivers/isdn/pcbit/pcbit.h
--- linux-2.6.3-rc1-mm1.ref/drivers/isdn/pcbit/pcbit.h	2003-12-18 03:58:15.000000000 +0100
+++ linux-2.6.3-rc1-mm1.i4l/drivers/isdn/pcbit/pcbit.h	2004-02-10 18:22:21.000000000 +0100
@@ -51,7 +51,7 @@
 	unsigned int id;
 	unsigned int interrupt;			/* set during interrupt 
 						   processing */
-	
+	spinlock_t lock;
 	/* isdn4linux */
 
 	struct msn_entry * msn_list;		/* ISDN address list */

-- 
Karsten Keil
SuSE Labs
ISDN development
