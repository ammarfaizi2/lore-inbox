Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319513AbSH2Wv0>; Thu, 29 Aug 2002 18:51:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319519AbSH2WvQ>; Thu, 29 Aug 2002 18:51:16 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:21191 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S319513AbSH2WsJ>;
	Thu, 29 Aug 2002 18:48:09 -0400
Date: Thu, 29 Aug 2002 15:50:50 -0700
To: Linus Torvalds <torvalds@transmeta.com>,
       Jeff Garzik <jgarzik@mandrakesoft.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       irda-users@lists.sourceforge.net
Subject: [PATCH 2.5] : ir252_drivers_locking_fixes-3.diff
Message-ID: <20020829225050.GG14118@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ir252_drivers_locking_fixes-3.diff :
----------------------------------
	o [CORRECT] Remove all "save_flags(flags);cli();" in IrDA driver
	o [FEATURE] Rework broken locking in irport
	o [FEATURE] Finish locking cleanup in nsc-ircc
	o [FEATURE] Improve locking in smc-ircc & w83977af_ir


diff -u -p -r linux/include/net/irda-d6/irtty.h linux/include/net/irda/irtty.h
--- linux/include/net/irda-d6/irtty.h	Sat Jun  8 22:31:17 2002
+++ linux/include/net/irda/irtty.h	Fri Aug 23 13:40:59 2002
@@ -62,6 +62,9 @@ struct irtty_cb {
 	struct qos_info qos;       /* QoS capabilities for this device */
 	dongle_t *dongle;          /* Dongle driver */
 
+
+	spinlock_t lock;           /* For serializing operations */
+
 	__u32 new_speed;
  	__u32 flags;               /* Interface flags */
 
diff -u -p -r linux/include/net/irda-d6/smc-ircc.h linux/include/net/irda/smc-ircc.h
--- linux/include/net/irda-d6/smc-ircc.h	Sat Jun  8 22:27:46 2002
+++ linux/include/net/irda/smc-ircc.h	Fri Aug 23 15:21:45 2002
@@ -165,7 +165,9 @@ struct ircc_cb {
 
 	struct irport_cb *irport;
 
-	spinlock_t lock;           /* For serializing operations */
+	/* Locking : half of our operations are done with irport, so we
+	 * use the irport spinlock to make sure *everything* is properly
+	 * synchronised - Jean II */
 	
 	__u32 new_speed;
 	__u32 flags;               /* Interface flags */
diff -u -p -r linux/include/net/irda-d6/w83977af_ir.h linux/include/net/irda/w83977af_ir.h
--- linux/include/net/irda-d6/w83977af_ir.h	Sat Jun  8 22:26:53 2002
+++ linux/include/net/irda/w83977af_ir.h	Fri Aug 23 11:56:39 2002
@@ -179,6 +179,11 @@ struct w83977af_ir {
 	chipio_t io;               /* IrDA controller information */
 	iobuff_t tx_buff;          /* Transmit buffer */
 	iobuff_t rx_buff;          /* Receive buffer */
+
+	/* Note : currently locking is *very* incomplete, but this
+	 * will get you started. Check in nsc-ircc.c for a proper
+	 * locking strategy. - Jean II */
+	spinlock_t lock;           /* For serializing operations */
 	
 	__u32 flags;               /* Interface flags */
 	__u32 new_speed;
diff -u -p -r linux/drivers/net/irda-d6/irda-usb.c linux/drivers/net/irda/irda-usb.c
--- linux/drivers/net/irda-d6/irda-usb.c	Mon Aug 19 14:43:27 2002
+++ linux/drivers/net/irda/irda-usb.c	Wed Aug 21 16:27:54 2002
@@ -1171,7 +1171,7 @@ static inline int irda_usb_open(struct i
 	irda_usb_init_qos(self);
 	
 	/* Initialise list of skb beeing curently transmitted */
-	self->tx_list = hashbin_new(HB_GLOBAL);
+	self->tx_list = hashbin_new(HB_NOLOCK);	/* unused */
 
 	/* Allocate the buffer for speed changes */
 	/* Don't change this buffer size and allocation without doing
diff -u -p -r linux/drivers/net/irda-d6/irport.c linux/drivers/net/irda/irport.c
--- linux/drivers/net/irda-d6/irport.c	Mon Aug 19 14:41:00 2002
+++ linux/drivers/net/irda/irport.c	Thu Aug 29 10:20:47 2002
@@ -140,7 +140,7 @@ irport_open(int i, unsigned int iobase, 
 	void *ret;
 	int err;
 
-	IRDA_DEBUG(0, __FUNCTION__ "()\n");
+	IRDA_DEBUG(1, __FUNCTION__ "()\n");
 
 	/*
 	 *  Allocate new instance of the driver
@@ -284,14 +284,13 @@ int irport_close(struct irport_cb *self)
 
 void irport_start(struct irport_cb *self)
 {
-	unsigned long flags;
 	int iobase;
 
 	iobase = self->io.sir_base;
 
 	irport_stop(self);
 	
-	spin_lock_irqsave(&self->lock, flags);
+	/* We can't lock, we may be called from a FIR driver - Jean II */
 
 	/* Initialize UART */
 	outb(UART_LCR_WLEN8, iobase+UART_LCR);  /* Reset DLAB */
@@ -299,26 +298,21 @@ void irport_start(struct irport_cb *self
 	
 	/* Turn on interrups */
 	outb(UART_IER_RLSI | UART_IER_RDI |UART_IER_THRI, iobase+UART_IER);
-
-	spin_unlock_irqrestore(&self->lock, flags);
 }
 
 void irport_stop(struct irport_cb *self)
 {
-	unsigned long flags;
 	int iobase;
 
 	iobase = self->io.sir_base;
 
-	spin_lock_irqsave(&self->lock, flags);
+	/* We can't lock, we may be called from a FIR driver - Jean II */
 
 	/* Reset UART */
 	outb(0, iobase+UART_MCR);
 	
 	/* Turn off interrupts */
 	outb(0, iobase+UART_IER);
-
-	spin_unlock_irqrestore(&self->lock, flags);
 }
 
 /*
@@ -339,27 +333,28 @@ int irport_probe(int iobase)
  *
  *    Set speed of IrDA port to specified baudrate
  *
+ * This function should be called with irq off and spin-lock.
  */
 void irport_change_speed(void *priv, __u32 speed)
 {
 	struct irport_cb *self = (struct irport_cb *) priv;
-	unsigned long flags;
 	int iobase; 
 	int fcr;    /* FIFO control reg */
 	int lcr;    /* Line control reg */
 	int divisor;
 
-	IRDA_DEBUG(0, __FUNCTION__ "(), Setting speed to: %d\n", speed);
-
 	ASSERT(self != NULL, return;);
 
+	IRDA_DEBUG(1, "%s(), Setting speed to: %d - iobase=%#x\n",
+		    __FUNCTION__, speed, self->io.sir_base);
+
+	/* We can't lock, we may be called from a FIR driver - Jean II */
+
 	iobase = self->io.sir_base;
 	
 	/* Update accounting for new speed */
 	self->io.speed = speed;
 
-	spin_lock_irqsave(&self->lock, flags);
-
 	/* Turn off interrupts */
 	outb(0, iobase+UART_IER); 
 
@@ -387,9 +382,9 @@ void irport_change_speed(void *priv, __u
 	outb(fcr,		  iobase+UART_FCR); /* Enable FIFO's */
 
 	/* Turn on interrups */
-	outb(/*UART_IER_RLSI|*/UART_IER_RDI/*|UART_IER_THRI*/, iobase+UART_IER);
-
-	spin_unlock_irqrestore(&self->lock, flags);
+	/* This will generate a fata interrupt storm.
+	 * People calling us will do that properly - Jean II */
+	//outb(/*UART_IER_RLSI|*/UART_IER_RDI/*|UART_IER_THRI*/, iobase+UART_IER);
 }
 
 /*
@@ -397,11 +392,14 @@ void irport_change_speed(void *priv, __u
  *
  *    State machine for changing speed of the device. We do it this way since
  *    we cannot use schedule_timeout() when we are in interrupt context
+ *
  */
 int __irport_change_speed(struct irda_task *task)
 {
 	struct irport_cb *self;
 	__u32 speed = (__u32) task->param;
+	unsigned long flags = 0;
+	int wasunlocked = 0;
 	int ret = 0;
 
 	IRDA_DEBUG(2, __FUNCTION__ "(), <%ld>\n", jiffies); 
@@ -410,6 +408,17 @@ int __irport_change_speed(struct irda_ta
 
 	ASSERT(self != NULL, return -1;);
 
+	/* Locking notes : this function may be called from irq context with
+	 * spinlock, via irport_write_wakeup(), or from non-interrupt without
+	 * spinlock (from the task timer). Yuck !
+	 * This is ugly, and unsafe is the spinlock is not already aquired.
+	 * This will be fixed when irda-task get rewritten.
+	 * Jean II */
+	if (!spin_is_locked(&self->lock)) {
+		spin_lock_irqsave(&self->lock, flags);
+		wasunlocked = 1;
+	}
+
 	switch (task->state) {
 	case IRDA_TASK_INIT:
 	case IRDA_TASK_WAIT:
@@ -462,6 +471,11 @@ int __irport_change_speed(struct irda_ta
 		ret = -1;
 		break;
 	}	
+	/* Put stuff in the sate we found them - Jean II */
+	if(wasunlocked) {
+		spin_unlock_irqrestore(&self->lock, flags);
+	}
+
 	return ret;
 }
 
@@ -491,6 +505,9 @@ static void irport_write_wakeup(struct i
 				      self->tx_buff.data, self->tx_buff.len);
 		self->tx_buff.data += actual;
 		self->tx_buff.len  -= actual;
+
+		/* Turn on transmit finished interrupt. */
+		outb(UART_IER_THRI, iobase+UART_IER); 
 	} else {
 		/* 
 		 *  Now serial buffer is almost free & we can start 
@@ -498,11 +515,12 @@ static void irport_write_wakeup(struct i
 		 *  if we need to change the speed of the hardware
 		 */
 		if (self->new_speed) {
-			IRDA_DEBUG(5, __FUNCTION__ "(), Changing speed!\n");
+			IRDA_DEBUG(5, "%s(), Changing speed!\n", __FUNCTION__);
 			irda_task_execute(self, __irport_change_speed, 
 					  irport_change_speed_complete, 
 					  NULL, (void *) self->new_speed);
 			self->new_speed = 0;
+			IRDA_DEBUG(5, "%s(), Speed changed!\n", __FUNCTION__ );
 		} else {
 			/* Tell network layer that we want more frames */
 			netif_wake_queue(self->netdev);
@@ -563,7 +581,7 @@ static int irport_change_speed_complete(
 {
 	struct irport_cb *self;
 
-	IRDA_DEBUG(0, __FUNCTION__ "()\n");
+	IRDA_DEBUG(1, __FUNCTION__ "()\n");
 
 	self = (struct irport_cb *) task->instance;
 
@@ -589,13 +607,19 @@ static void irport_timeout(struct net_de
 {
 	struct irport_cb *self;
 	int iobase;
+	unsigned long flags;
 
 	self = (struct irport_cb *) dev->priv;
 	iobase = self->io.sir_base;
 	
 	WARNING("%s: transmit timed out\n", dev->name);
+	spin_lock_irqsave(&self->lock, flags);
 	irport_start(self);
 	self->change_speed(self->priv, self->io.speed);
+	/* This will re-enable irqs */
+	outb(/*UART_IER_RLSI|*/UART_IER_RDI/*|UART_IER_THRI*/, iobase+UART_IER);
+	spin_unlock_irqrestore(&self->lock, flags);
+
 	dev->trans_start = jiffies;
 	netif_wake_queue(dev);
 }
@@ -614,7 +638,7 @@ int irport_hard_xmit(struct sk_buff *skb
 	int iobase;
 	s32 speed;
 
-	IRDA_DEBUG(0, __FUNCTION__ "()\n");
+	IRDA_DEBUG(1, __FUNCTION__ "()\n");
 
 	ASSERT(dev != NULL, return 0;);
 	
@@ -625,22 +649,25 @@ int irport_hard_xmit(struct sk_buff *skb
 
 	netif_stop_queue(dev);
 	
+	/* Make sure tests *& speed change are atomic */
+	spin_lock_irqsave(&self->lock, flags);
+
 	/* Check if we need to change the speed */
 	speed = irda_get_next_speed(skb);
 	if ((speed != self->io.speed) && (speed != -1)) {
 		/* Check for empty frame */
 		if (!skb->len) {
+			/* Better go there already locked - Jean II */
 			irda_task_execute(self, __irport_change_speed, 
 					  irport_change_speed_complete, 
 					  NULL, (void *) speed);
+			spin_unlock_irqrestore(&self->lock, flags);
 			dev_kfree_skb(skb);
 			return 0;
 		} else
 			self->new_speed = speed;
 	}
 
-	spin_lock_irqsave(&self->lock, flags);
-
 	/* Init tx buffer */
 	self->tx_buff.data = self->tx_buff.head;
 
@@ -771,8 +798,9 @@ int irport_net_open(struct net_device *d
 	struct irport_cb *self;
 	int iobase;
 	char hwname[16];
+	unsigned long flags;
 
-	IRDA_DEBUG(0, __FUNCTION__ "()\n");
+	IRDA_DEBUG(1, __FUNCTION__ "()\n");
 	
 	ASSERT(dev != NULL, return -1;);
 	self = (struct irport_cb *) dev->priv;
@@ -786,7 +814,9 @@ int irport_net_open(struct net_device *d
 		return -EAGAIN;
 	}
 
+	spin_lock_irqsave(&self->lock, flags);
 	irport_start(self);
+	spin_unlock_irqrestore(&self->lock, flags);
 
 
 	/* Give self a hardware name */
@@ -818,6 +848,7 @@ int irport_net_close(struct net_device *
 {
 	struct irport_cb *self;
 	int iobase;
+	unsigned long flags;
 
 	IRDA_DEBUG(4, __FUNCTION__ "()\n");
 
@@ -836,7 +867,9 @@ int irport_net_close(struct net_device *
 		irlap_close(self->irlap);
 	self->irlap = NULL;
 
+	spin_lock_irqsave(&self->lock, flags);
 	irport_stop(self);
+	spin_unlock_irqrestore(&self->lock, flags);
 
 	free_irq(self->io.irq, dev);
 
@@ -951,10 +984,6 @@ static int irport_net_ioctl(struct net_d
 
 	IRDA_DEBUG(2, __FUNCTION__ "(), %s, (cmd=0x%X)\n", dev->name, cmd);
 	
-	/* Disable interrupts & save flags */
-	save_flags(flags);
-	cli();
-	
 	switch (cmd) {
 	case SIOCSBANDWIDTH: /* Set bandwidth */
 		if (!capable(CAP_NET_ADMIN))
@@ -979,14 +1008,16 @@ static int irport_net_ioctl(struct net_d
 		dongle->write       = irport_raw_write;
 		dongle->set_dtr_rts = irport_set_dtr_rts;
 		
-		self->dongle = dongle;
-
 		/* Now initialize the dongle!  */
 		dongle->issue->open(dongle, &self->qos);
 		
 		/* Reset dongle */
 		irda_task_execute(dongle, dongle->issue->reset, NULL, NULL, 
 				  NULL);	
+
+		/* Make dongle available to driver only now to avoid
+		 * race conditions - Jean II */
+		self->dongle = dongle;
 		break;
 	case SIOCSMEDIABUSY: /* Set media busy */
 		if (!capable(CAP_NET_ADMIN)) {
@@ -1005,13 +1036,14 @@ static int irport_net_ioctl(struct net_d
 			break;
 		}
 
+		/* No real need to lock... */
+		spin_lock_irqsave(&self->lock, flags);
 		irport_set_dtr_rts(dev, irq->ifr_dtr, irq->ifr_rts);
+		spin_unlock_irqrestore(&self->lock, flags);
 		break;
 	default:
 		ret = -EOPNOTSUPP;
 	}
-	
-	restore_flags(flags);
 	
 	return ret;
 }
diff -u -p -r linux/drivers/net/irda-d6/irtty.c linux/drivers/net/irda/irtty.c
--- linux/drivers/net/irda-d6/irtty.c	Mon Aug 19 14:41:00 2002
+++ linux/drivers/net/irda/irtty.c	Thu Aug 29 10:12:38 2002
@@ -74,8 +74,10 @@ char *driver_name = "irtty";
 int __init irtty_init(void)
 {
 	int status;
-	
-	irtty = hashbin_new( HB_LOCAL);
+
+	/* Probably no need to lock here because all operations done in
+	 * open()/close() which are already safe - Jean II */
+	irtty = hashbin_new( HB_NOLOCK);
 	if ( irtty == NULL) {
 		printk( KERN_WARNING "IrDA: Can't allocate irtty hashbin!\n");
 		return -ENOMEM;
@@ -163,6 +165,7 @@ static int irtty_open(struct tty_struct 
 		return -ENOMEM;
 	}
 	memset(self, 0, sizeof(struct irtty_cb));
+	spin_lock_init(&self->lock);
 	
 	self->tty = tty;
 	tty->disc_data = self;
@@ -266,11 +269,12 @@ static int irtty_open(struct tty_struct 
 static void irtty_close(struct tty_struct *tty) 
 {
 	struct irtty_cb *self = (struct irtty_cb *) tty->disc_data;
+	unsigned long flags;
 	
 	/* First make sure we're connected. */
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == IRTTY_MAGIC, return;);
-	
+
 	/* Stop tty */
 	tty->flags &= ~(1 << TTY_DO_WRITE_WAKEUP);
 	tty->disc_data = 0;
@@ -287,6 +291,11 @@ static void irtty_close(struct tty_struc
 		rtnl_unlock();
 	}
 	
+	self = hashbin_remove(irtty, (int) self, NULL);
+
+	/* Protect access to self->task and self->?x_buff - Jean II */
+	spin_lock_irqsave(&self->lock, flags);
+
 	/* Remove speed changing task if any */
 	if (self->task)
 		irda_task_delete(self->task);
@@ -294,13 +303,12 @@ static void irtty_close(struct tty_struc
 	self->tty = NULL;
 	self->magic = 0;
 	
-	self = hashbin_remove(irtty, (int) self, NULL);
-
 	if (self->tx_buff.head)
 		kfree(self->tx_buff.head);
 	
 	if (self->rx_buff.head)
 		kfree(self->rx_buff.head);
+	spin_unlock_irqrestore(&self->lock, flags);
 	
 	kfree(self);
 	
@@ -326,6 +334,7 @@ static void irtty_stop_receiver(struct i
 	else
 		cflag |= CREAD;
 
+	/* This is unsafe, but currently under discussion - Jean II */
 	self->tty->termios->c_cflag = cflag;
 	self->tty->driver.set_termios(self->tty, &old_termios);
 }
@@ -378,6 +387,7 @@ static void __irtty_change_speed(struct 
 		break;
 	}	
 
+	/* This is unsafe, but currently under discussion - Jean II */
 	self->tty->termios->c_cflag = cflag;
 	self->tty->driver.set_termios(self->tty, &old_termios);
 
@@ -393,6 +403,7 @@ static void __irtty_change_speed(struct 
 static int irtty_change_speed(struct irda_task *task)
 {
 	struct irtty_cb *self;
+	unsigned long flags;
 	__u32 speed = (__u32) task->param;
 	int ret = 0;
 
@@ -401,12 +412,17 @@ static int irtty_change_speed(struct ird
 	self = (struct irtty_cb *) task->instance;
 	ASSERT(self != NULL, return -1;);
 
+	/* Protect access to self->task - Jean II */
+	spin_lock_irqsave(&self->lock, flags);
+
 	/* Check if busy */
 	if (self->task && self->task != task) {
 		IRDA_DEBUG(0, __FUNCTION__ "(), busy!\n");
+		spin_unlock_irqrestore(&self->lock, flags);
 		return MSECS_TO_JIFFIES(10);
 	} else
 		self->task = task;
+	spin_unlock_irqrestore(&self->lock, flags);
 
 	switch (task->state) {
 	case IRDA_TASK_INIT:
@@ -501,6 +517,7 @@ static int irtty_ioctl(struct tty_struct
 	switch (cmd) {
 	case TCGETS:
 	case TCGETA:
+		/* Unsure about locking here, to check - Jean II */
 		return n_tty_ioctl(tty, (struct file *) file, cmd, 
 				   (unsigned long) arg);
 		break;
@@ -516,15 +533,16 @@ static int irtty_ioctl(struct tty_struct
 		dongle->write       = irtty_raw_write;
 		dongle->set_dtr_rts = irtty_set_dtr_rts;
 		
-		/* Bind dongle */
-		self->dongle = dongle;
-		
 		/* Now initialize the dongle!  */
 		dongle->issue->open(dongle, &self->qos);
 		
 		/* Reset dongle */
 		irda_task_execute(dongle, dongle->issue->reset, NULL, NULL, 
 				  NULL);		
+
+		/* Make dongle available to driver only now to avoid
+		 * race conditions - Jean II */
+		self->dongle = dongle;
 		break;
 	case IRTTY_IOCGET:
 		ASSERT(self->netdev != NULL, return -1;);
@@ -559,6 +577,9 @@ static void irtty_receive_buf(struct tty
 		return;
 	}
 
+	// Are we in interrupt context ? What locking is done ? - Jean II
+	//spin_lock_irqsave(&self->lock, flags);
+
 	/* Read the characters out of the buffer */
  	while (count--) {
 		/* 
@@ -589,6 +610,7 @@ static void irtty_receive_buf(struct tty
 			break;
 		}
 	}
+	//spin_unlock_irqrestore(&self->lock, flags);
 }
 
 /*
@@ -626,11 +648,13 @@ static int irtty_hard_xmit(struct sk_buf
 	struct irtty_cb *self;
 	int actual = 0;
 	__s32 speed;
+	unsigned long flags;
 
 	self = (struct irtty_cb *) dev->priv;
 	ASSERT(self != NULL, return 0;);
 
-	/* Lock transmit buffer */
+	/* Lock transmit buffer
+	 * this serialise operations, no need to spinlock - Jean II */
 	netif_stop_queue(dev);
 	
 	/* Check if we need to change the speed */
@@ -647,6 +671,9 @@ static int irtty_hard_xmit(struct sk_buf
 			self->new_speed = speed;
 	}
 
+	/* Protect access to self->tx_buff - Jean II */
+	spin_lock_irqsave(&self->lock, flags);
+
 	/* Init tx buffer*/
 	self->tx_buff.data = self->tx_buff.head;
 	
@@ -667,6 +694,8 @@ static int irtty_hard_xmit(struct sk_buf
 	self->tx_buff.data += actual;
 	self->tx_buff.len -= actual;
 
+	spin_unlock_irqrestore(&self->lock, flags);
+
 	dev_kfree_skb(skb);
 
 	return 0;
@@ -695,6 +724,7 @@ static void irtty_write_wakeup(struct tt
 {
 	struct irtty_cb *self = (struct irtty_cb *) tty->disc_data;
 	int actual = 0;
+	unsigned long flags;
 	
 	/* 
 	 *  First make sure we're connected. 
@@ -702,6 +732,11 @@ static void irtty_write_wakeup(struct tt
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == IRTTY_MAGIC, return;);
 
+	/* Protected via netif_stop_queue(dev); - Jean II */
+
+	/* Protect access to self->tx_buff - Jean II */
+	spin_lock_irqsave(&self->lock, flags);
+
 	/* Finished with frame?  */
 	if (self->tx_buff.len > 0)  {
 		/* Write data left in transmit buffer */
@@ -710,6 +745,7 @@ static void irtty_write_wakeup(struct tt
 
 		self->tx_buff.data += actual;
 		self->tx_buff.len  -= actual;
+		spin_unlock_irqrestore(&self->lock, flags);
 	} else {		
 		/* 
 		 *  Now serial buffer is almost free & we can start 
@@ -721,6 +757,9 @@ static void irtty_write_wakeup(struct tt
 
 		tty->flags &= ~(1 << TTY_DO_WRITE_WAKEUP);
 
+		/* Don't change speed with irq off */
+		spin_unlock_irqrestore(&self->lock, flags);
+
 		if (self->new_speed) {
 			IRDA_DEBUG(5, __FUNCTION__ "(), Changing speed!\n");
 			irda_task_execute(self, irtty_change_speed, 
@@ -755,12 +794,17 @@ static int irtty_set_dtr_rts(struct net_
 {
 	struct irtty_cb *self;
 	struct tty_struct *tty;
+	//unsigned long flags;
 	mm_segment_t fs;
 	int arg = 0;
 
 	self = (struct irtty_cb *) dev->priv;
 	tty = self->tty;
 
+	/* Was protected in ioctl handler, but the serial driver doesn't
+	 * like it. This may need to change. - Jean II */
+	//spin_lock_irqsave(&self->lock, flags);
+
 #ifdef TIOCM_OUT2 /* Not defined for ARM */
 	arg = TIOCM_OUT2;
 #endif
@@ -780,11 +824,14 @@ static int irtty_set_dtr_rts(struct net_
 	fs = get_fs();
 	set_fs(get_ds());
 	
+	/* This is probably unsafe, but currently under discussion - Jean II */
 	if (tty->driver.ioctl(tty, NULL, TIOCMSET, (unsigned long) &arg)) { 
 		IRDA_DEBUG(2, __FUNCTION__ "(), error doing ioctl!\n");
 	}
 	set_fs(fs);
 
+	//spin_unlock_irqrestore(&self->lock, flags);
+
 	return 0;
 }
 
@@ -799,13 +846,17 @@ static int irtty_set_dtr_rts(struct net_
 int irtty_set_mode(struct net_device *dev, int mode)
 {
 	struct irtty_cb *self;
+	unsigned long flags;
 
 	self = (struct irtty_cb *) dev->priv;
 
 	ASSERT(self != NULL, return -1;);
 
 	IRDA_DEBUG(2, __FUNCTION__ "(), mode=%s\n", infrared_mode[mode]);
-	
+
+	/* Protect access to self->rx_buff - Jean II */
+	spin_lock_irqsave(&self->lock, flags);
+
 	/* save status for driver */
 	self->mode = mode;
 	
@@ -814,6 +865,8 @@ int irtty_set_mode(struct net_device *de
 	self->rx_buff.len = 0;
 	self->rx_buff.state = OUTSIDE_FRAME;
 
+	spin_unlock_irqrestore(&self->lock, flags);
+
 	return 0;
 }
 
@@ -955,7 +1008,6 @@ static int irtty_net_ioctl(struct net_de
 	struct if_irda_req *irq = (struct if_irda_req *) rq;
 	struct irtty_cb *self;
 	dongle_t *dongle;
-	unsigned long flags;
 	int ret = 0;
 
 	ASSERT(dev != NULL, return -1;);
@@ -971,8 +1023,7 @@ static int irtty_net_ioctl(struct net_de
 	 * irda_device_dongle_init() can't be locked.
 	 * irda_task_execute() doesn't need to be locked (but
 	 * irtty_change_speed() should protect itself).
-	 * As this driver doesn't have spinlock protection, keep
-	 * old fashion locking :-(
+	 * Other calls protect themselves.
 	 * Jean II
 	 */
 	
@@ -1025,20 +1076,14 @@ static int irtty_net_ioctl(struct net_de
 		if (!capable(CAP_NET_ADMIN))
 			ret = -EPERM;
 		else {
-			save_flags(flags);
-			cli();
 			irtty_set_dtr_rts(dev, irq->ifr_dtr, irq->ifr_rts);
-			restore_flags(flags);
 		}
 		break;
 	case SIOCSMODE:
 		if (!capable(CAP_NET_ADMIN))
 			ret = -EPERM;
 		else {
-			save_flags(flags);
-			cli();
 			irtty_set_mode(dev, irq->ifr_mode);
-			restore_flags(flags);
 		}
 		break;
 	default:
diff -u -p -r linux/drivers/net/irda-d6/nsc-ircc.c linux/drivers/net/irda/nsc-ircc.c
--- linux/drivers/net/irda-d6/nsc-ircc.c	Fri Aug 23 11:07:06 2002
+++ linux/drivers/net/irda/nsc-ircc.c	Fri Aug 23 11:42:23 2002
@@ -870,7 +870,6 @@ static void nsc_ircc_init_dongle_interfa
  */
 static void nsc_ircc_change_dongle_speed(int iobase, int speed, int dongle_id)
 {
-	unsigned long flags;
 	__u8 bank;
 
 	/* Save current bank */
@@ -916,11 +915,10 @@ static void nsc_ircc_change_dongle_speed
 		outb(0x01, iobase+4);
 
 		if (speed == 4000000) {
-			save_flags(flags);
-			cli();
+			/* There was a cli() there, but we now are already
+			 * under spin_lock_irqsave() - JeanII */
 			outb(0x81, iobase+4);
 			outb(0x80, iobase+4);
-			restore_flags(flags);
 		} else
 			outb(0x00, iobase+4);
 		break;
@@ -2013,33 +2011,30 @@ static int nsc_ircc_net_ioctl(struct net
 
 	IRDA_DEBUG(2, __FUNCTION__ "(), %s, (cmd=0x%X)\n", dev->name, cmd);
 	
-	/* Disable interrupts & save flags */
-	save_flags(flags);
-	cli();
-
 	switch (cmd) {
 	case SIOCSBANDWIDTH: /* Set bandwidth */
 		if (!capable(CAP_NET_ADMIN)) {
 			ret = -EPERM;
-			goto out;
+			break;
 		}
+		spin_lock_irqsave(&self->lock, flags);
 		nsc_ircc_change_speed(self, irq->ifr_baudrate);
+		spin_unlock_irqrestore(&self->lock, flags);
 		break;
 	case SIOCSMEDIABUSY: /* Set media busy */
 		if (!capable(CAP_NET_ADMIN)) {
 			ret = -EPERM;
-			goto out;
+			break;
 		}
 		irda_device_set_media_busy(self->netdev, TRUE);
 		break;
 	case SIOCGRECEIVING: /* Check if we are receiving right now */
+		/* This is already protected */
 		irq->ifr_receiving = nsc_ircc_is_receiving(self);
 		break;
 	default:
 		ret = -EOPNOTSUPP;
 	}
-out:
-	restore_flags(flags);
 	return ret;
 }
 
diff -u -p -r linux/drivers/net/irda-d6/smc-ircc.c linux/drivers/net/irda/smc-ircc.c
--- linux/drivers/net/irda-d6/smc-ircc.c	Mon Aug 19 14:41:00 2002
+++ linux/drivers/net/irda/smc-ircc.c	Fri Aug 23 15:46:03 2002
@@ -431,6 +431,7 @@ static int __init ircc_open(unsigned int
 	struct ircc_cb *self;
         struct irport_cb *irport;
 	unsigned char low, high, chip, config, dma, irq, version;
+	unsigned long flags;
 
 
 	IRDA_DEBUG(0, __FUNCTION__ "\n");
@@ -484,7 +485,6 @@ static int __init ircc_open(unsigned int
 		return -ENOMEM;
 	}
 	memset(self, 0, sizeof(struct ircc_cb));
-	spin_lock_init(&self->lock);
 
 	/* Max DMA buffer size needed = (data_size + 6) * (window_size) + 6; */
 	self->rx_buff.truesize = 4000; 
@@ -555,6 +555,9 @@ static int __init ircc_open(unsigned int
 
 	request_region(self->io->fir_base, CHIP_IO_EXTENT, driver_name);
 
+	/* Don't allow irport to change under us - Jean II */
+	spin_lock_irqsave(&self->irport->lock, flags);
+
 	/* Initialize QoS for this device */
 	irda_init_max_qos_capabilies(&irport->qos);
 	
@@ -581,6 +584,7 @@ static int __init ircc_open(unsigned int
 	self->netdev->stop   = &ircc_net_close;
 
 	irport_start(self->irport);
+	spin_unlock_irqrestore(&self->irport->lock, flags);
 
         self->pmdev = pm_register(PM_SYS_DEV, PM_SYS_IRDA, ircc_pmproc);
         if (self->pmdev)
@@ -598,6 +602,7 @@ static int __init ircc_open(unsigned int
  *
  *    Change the speed of the device
  *
+ * This function should be called with irq off and spin-lock.
  */
 static void ircc_change_speed(void *priv, u32 speed)
 {
@@ -658,6 +663,7 @@ static void ircc_change_speed(void *priv
 
 	/* Make special FIR init if necessary */
 	if (speed > 115200) {
+		/* No need to lock, already locked - Jean II */
 		irport_stop(self->irport);
 
 		/* Install FIR transmit handler */
@@ -674,6 +680,7 @@ static void ircc_change_speed(void *priv
 	} else {
 		/* Install SIR transmit handler */
 		dev->hard_start_xmit = &irport_hard_xmit;
+		/* No need to lock, already locked - Jean II */
 		irport_start(self->irport);
 		
 	        IRDA_DEBUG(0, __FUNCTION__ 
@@ -727,20 +734,26 @@ static int ircc_hard_xmit(struct sk_buff
 
 	netif_stop_queue(dev);
 
+	/* Make sure tests *& speed change are atomic */
+	spin_lock_irqsave(&self->irport->lock, flags);
+
+	/* Note : you should make sure that speed changes are not going
+	 * to corrupt any outgoing frame. Look at nsc-ircc for the gory
+	 * details - Jean II */
+
 	/* Check if we need to change the speed after this frame */
 	speed = irda_get_next_speed(skb);
 	if ((speed != self->io->speed) && (speed != -1)) {
 		/* Check for empty frame */
 		if (!skb->len) {
 			ircc_change_speed(self, speed); 
+			spin_unlock_irqrestore(&self->irport->lock, flags);
 			dev_kfree_skb(skb);
 			return 0;
 		} else
 			self->new_speed = speed;
 	}
 	
-	spin_lock_irqsave(&self->lock, flags);
-
 	memcpy(self->tx_buff.head, skb->data, skb->len);
 
 	self->tx_buff.len = skb->len;
@@ -763,7 +776,7 @@ static int ircc_hard_xmit(struct sk_buff
 		/* Transmit frame */
 		ircc_dma_xmit(self, iobase, 0);
 	}
-	spin_unlock_irqrestore(&self->lock, flags);
+	spin_unlock_irqrestore(&self->irport->lock, flags);
 	dev_kfree_skb(skb);
 
 	return 0;
@@ -985,12 +998,13 @@ static void ircc_interrupt(int irq, void
 
 	/* Check if we should use the SIR interrupt handler */
 	if (self->io->speed < 576000) {
+		/* Will spinlock itself - Jean II */
 		irport_interrupt(irq, dev_id, regs);
 		return;
 	}
 	iobase = self->io->fir_base;
 
-	spin_lock(&self->lock);	
+	spin_lock(&self->irport->lock);	
 
 	register_bank(iobase, 0);
 	iir = inb(iobase+IRCC_IIR);
@@ -1013,7 +1027,7 @@ static void ircc_interrupt(int irq, void
 	register_bank(iobase, 0);
 	outb(IRCC_IER_ACTIVE_FRAME|IRCC_IER_EOM, iobase+IRCC_IER);
 
-	spin_unlock(&self->lock);
+	spin_unlock(&self->irport->lock);
 }
 
 #if 0 /* unused */
@@ -1128,17 +1142,15 @@ static void ircc_suspend(struct ircc_cb 
 
 static void ircc_wakeup(struct ircc_cb *self)
 {
-	unsigned long flags;
-
 	if (!self->io->suspended)
 		return;
 
-	save_flags(flags);
-	cli();
+	/* The code was doing a "cli()" here, but this can't be right.
+	 * If you need protection, do it in net_open with a spinlock
+	 * or give a good reason. - Jean II */
 
 	ircc_net_open(self->netdev);
 	
-	restore_flags(flags);
 	MESSAGE("%s, Waking up\n", driver_name);
 }
 
@@ -1174,6 +1186,7 @@ static int __exit ircc_close(struct ircc
 
         iobase = self->irport->io.fir_base;
 
+	/* This will destroy irport */
 	irport_close(self->irport);
 
 	/* Stop interrupts */
@@ -1187,6 +1200,7 @@ static int __exit ircc_close(struct ircc
         outb(IRCC_CFGA_IRDA_SIR_A|IRCC_CFGA_TX_POLARITY, iobase+IRCC_SCE_CFGA);
         outb(IRCC_CFGB_IR, iobase+IRCC_SCE_CFGB);
 #endif
+
 	/* Release the PORT that this driver is using */
 	IRDA_DEBUG(0, __FUNCTION__ "(), releasing 0x%03x\n", iobase);
 
diff -u -p -r linux/drivers/net/irda-d6/w83977af_ir.c linux/drivers/net/irda/w83977af_ir.c
--- linux/drivers/net/irda-d6/w83977af_ir.c	Mon Aug 19 14:41:00 2002
+++ linux/drivers/net/irda/w83977af_ir.c	Fri Aug 23 12:00:44 2002
@@ -175,6 +175,7 @@ int w83977af_open(int i, unsigned int io
 		return -ENOMEM;
 	}
 	memset(self, 0, sizeof(struct w83977af_ir));
+	spin_lock_init(&self->lock);
    
 	/* Need to store self somewhere */
 	dev_self[i] = self;
@@ -603,8 +604,7 @@ static void w83977af_dma_write(struct w8
 	switch_bank(iobase, SET2);
 	outb(ADCR1_D_CHSW|/*ADCR1_DMA_F|*/ADCR1_ADV_SL, iobase+ADCR1);
 #ifdef CONFIG_NETWINDER_TX_DMA_PROBLEMS
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&self->lock, flags);
 
 	disable_dma(self->io.dma);
 	clear_dma_ff(self->io.dma);
@@ -623,7 +623,7 @@ static void w83977af_dma_write(struct w8
 	hcr = inb(iobase+HCR);
 	outb(hcr | HCR_EN_DMA, iobase+HCR);
 	enable_dma(self->io.dma);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&self->lock, flags);
 #else	
 	outb(inb(iobase+HCR) | HCR_EN_DMA | HCR_TX_WT, iobase+HCR);
 #endif
@@ -761,8 +761,7 @@ int w83977af_dma_receive(struct w83977af
 	self->rx_buff.data = self->rx_buff.head;
 
 #ifdef CONFIG_NETWINDER_RX_DMA_PROBLEMS
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&self->lock, flags);
 
 	disable_dma(self->io.dma);
 	clear_dma_ff(self->io.dma);
@@ -788,7 +787,7 @@ int w83977af_dma_receive(struct w83977af
 	hcr = inb(iobase+HCR);
 	outb(hcr | HCR_EN_DMA, iobase+HCR);
 	enable_dma(self->io.dma);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&self->lock, flags);
 #else	
 	outb(inb(iobase+HCR) | HCR_EN_DMA, iobase+HCR);
 #endif
@@ -1334,10 +1333,8 @@ static int w83977af_net_ioctl(struct net
 
 	IRDA_DEBUG(2, __FUNCTION__ "(), %s, (cmd=0x%X)\n", dev->name, cmd);
 	
-	/* Disable interrupts & save flags */
-	save_flags(flags);
-	cli();
-	
+	spin_lock_irqsave(&self->lock, flags);
+
 	switch (cmd) {
 	case SIOCSBANDWIDTH: /* Set bandwidth */
 		if (!capable(CAP_NET_ADMIN)) {
@@ -1360,7 +1357,7 @@ static int w83977af_net_ioctl(struct net
 		ret = -EOPNOTSUPP;
 	}
 out:
-	restore_flags(flags);
+	spin_unlock_irqrestore(&self->lock, flags);
 	return ret;
 }
 
