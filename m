Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319522AbSH2Www>; Thu, 29 Aug 2002 18:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319520AbSH2Wvz>; Thu, 29 Aug 2002 18:51:55 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:64965 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S319500AbSH2Wra>;
	Thu, 29 Aug 2002 18:47:30 -0400
Date: Thu, 29 Aug 2002 15:50:12 -0700
To: Linus Torvalds <torvalds@transmeta.com>,
       Jeff Garzik <jgarzik@mandrakesoft.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       irda-users@lists.sourceforge.net
Subject: [PATCH 2.5] : ir252_ircomm_locking_fixes-4.diff
Message-ID: <20020829225012.GF14118@bougret.hpl.hp.com>
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

ir252_ircomm_locking_fixes-4.diff :
---------------------------------
	o [FEATURE] Do the hashbin locking fixes for IrCOMM and IrLAN
	o [CORRECT] Remove all "save_flags(flags);cli();" in IrCOMM/IrLAN
	o [CORRECT] Fix other locking issues in IrCOMM


diff -u -p linux/include/net/irda/ircomm_tty.d6.h linux/include/net/irda/ircomm_tty.h
--- linux/include/net/irda/ircomm_tty.d6.h	Wed Aug 21 18:08:37 2002
+++ linux/include/net/irda/ircomm_tty.h	Fri Aug 23 10:48:19 2002
@@ -104,6 +104,14 @@ struct ircomm_tty_cb {
 	long pgrp;		/* pgrp of opening process */
 	int  open_count;
 	int  blocked_open;	/* # of blocked opens */
+
+	/* Protect concurent access to :
+	 *	o self->open_count
+	 *	o self->ctrl_skb
+	 *	o self->tx_skb
+	 * Maybe other things may gain to be protected as well...
+	 * Jean II */
+	spinlock_t spinlock;
 };
 
 void ircomm_tty_start(struct tty_struct *tty);
diff -u -p -r linux/net/irda/ircomm-d5/ircomm_core.c linux/net/irda/ircomm/ircomm_core.c
--- linux/net/irda/ircomm-d5/ircomm_core.c	Mon Aug 19 14:41:05 2002
+++ linux/net/irda/ircomm/ircomm_core.c	Wed Aug 21 16:45:30 2002
@@ -61,7 +61,7 @@ hashbin_t *ircomm = NULL;
 
 int __init ircomm_init(void)
 {
-	ircomm = hashbin_new(HB_LOCAL); 
+	ircomm = hashbin_new(HB_LOCK); 
 	if (ircomm == NULL) {
 		ERROR(__FUNCTION__ "(), can't allocate hashbin!\n");
 		return -ENOMEM;
@@ -505,11 +505,10 @@ int ircomm_proc_read(char *buf, char **s
 	struct ircomm_cb *self;
 	unsigned long flags;
 	
-	save_flags(flags);
-	cli();
-
 	len = 0;
 
+	spin_lock_irqsave(&ircomm->hb_spinlock, flags);
+
 	self = (struct ircomm_cb *) hashbin_get_first(ircomm);
 	while (self != NULL) {
 		ASSERT(self->magic == IRCOMM_MAGIC, break;);
@@ -535,7 +534,7 @@ int ircomm_proc_read(char *buf, char **s
 
 		self = (struct ircomm_cb *) hashbin_get_next(ircomm);
  	} 
-	restore_flags(flags);
+	spin_unlock_irqrestore(&ircomm->hb_spinlock, flags);
 
 	return len;
 }
diff -u -p -r linux/net/irda/ircomm-d5/ircomm_lmp.c linux/net/irda/ircomm/ircomm_lmp.c
--- linux/net/irda/ircomm-d5/ircomm_lmp.c	Mon Aug 19 14:41:05 2002
+++ linux/net/irda/ircomm/ircomm_lmp.c	Wed Aug 21 16:44:18 2002
@@ -177,7 +177,7 @@ void ircomm_lmp_flow_control(struct sk_b
  
         line = cb->line;
 
-	self = (struct ircomm_cb *) hashbin_find(ircomm, line, NULL);
+	self = (struct ircomm_cb *) hashbin_lock_find(ircomm, line, NULL);
         if (!self) {
 		IRDA_DEBUG(2, __FUNCTION__ "(), didn't find myself\n");
                 return;
diff -u -p -r linux/net/irda/ircomm-d5/ircomm_param.c linux/net/irda/ircomm/ircomm_param.c
--- linux/net/irda/ircomm-d5/ircomm_param.c	Mon Aug 19 14:41:05 2002
+++ linux/net/irda/ircomm/ircomm_param.c	Wed Aug 21 18:41:13 2002
@@ -99,6 +99,8 @@ pi_param_info_t ircomm_param_info = { pi
  */
 int ircomm_param_flush(struct ircomm_tty_cb *self)
 {
+	/* we should lock here, but I guess this function is unused...
+	 * Jean II */
 	if (self->ctrl_skb) {
 		ircomm_control_request(self->ircomm, self->ctrl_skb);
 		self->ctrl_skb = NULL;	
@@ -132,14 +134,13 @@ int ircomm_param_request(struct ircomm_t
 	if (self->service_type == IRCOMM_3_WIRE_RAW)
 		return 0;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&self->spinlock, flags);
 
 	skb = self->ctrl_skb;	
 	if (!skb) {
 		skb = dev_alloc_skb(256);
 		if (!skb) {
-			restore_flags(flags);
+			spin_unlock_irqrestore(&self->spinlock, flags);
 			return -ENOMEM;
 		}
 		
@@ -154,12 +155,12 @@ int ircomm_param_request(struct ircomm_t
 				  &ircomm_param_info);
 	if (count < 0) {
 		WARNING(__FUNCTION__ "(), no room for parameter!\n");
-		restore_flags(flags);
+		spin_unlock_irqrestore(&self->spinlock, flags);
 		return -1;
 	}
 	skb_put(skb, count);
 
-	restore_flags(flags);
+	spin_unlock_irqrestore(&self->spinlock, flags);
 
 	IRDA_DEBUG(2, __FUNCTION__ "(), skb->len=%d\n", skb->len);
 
diff -u -p -r linux/net/irda/ircomm-d5/ircomm_tty.c linux/net/irda/ircomm/ircomm_tty.c
--- linux/net/irda/ircomm-d5/ircomm_tty.c	Mon Aug 19 14:41:05 2002
+++ linux/net/irda/ircomm/ircomm_tty.c	Fri Aug 23 10:39:34 2002
@@ -90,7 +90,7 @@ hashbin_t *ircomm_tty = NULL;
  */
 int __init ircomm_tty_init(void)
 {	
-	ircomm_tty = hashbin_new(HB_LOCAL); 
+	ircomm_tty = hashbin_new(HB_LOCK); 
 	if (ircomm_tty == NULL) {
 		ERROR(__FUNCTION__ "(), can't allocate hashbin!\n");
 		return -ENOMEM;
@@ -308,22 +308,25 @@ static int ircomm_tty_block_til_ready(st
 	IRDA_DEBUG(2, "%s(%d):block_til_ready before block on %s open_count=%d\n",
 	      __FILE__,__LINE__, tty->driver.name, self->open_count );
 
-	save_flags(flags); cli();
+	/* As far as I can see, we protect open_count - Jean II */
+	spin_lock_irqsave(&self->spinlock, flags);
 	if (!tty_hung_up_p(filp)) {
 		extra_count = 1;
 		self->open_count--;
 	}
-	restore_flags(flags);
+	spin_unlock_irqrestore(&self->spinlock, flags);
 	self->blocked_open++;
 	
 	while (1) {
 		if (!(self->flags & ASYNC_CALLOUT_ACTIVE) &&
  		    (tty->termios->c_cflag & CBAUD)) {
-			save_flags(flags); cli();
+			/* Here, we use to lock those two guys, but
+			 * as ircomm_param_request() does it itself,
+			 * I don't see the point (and I see the deadlock).
+			 * Jean II */
 			self->settings.dte |= IRCOMM_RTS + IRCOMM_DTR;
 		 	
 			ircomm_param_request(self, IRCOMM_DTE, TRUE);
-			restore_flags(flags);
 		}
 		
 		current->state = TASK_INTERRUPTIBLE;
@@ -361,8 +364,12 @@ static int ircomm_tty_block_til_ready(st
 	__set_current_state(TASK_RUNNING);
 	remove_wait_queue(&self->open_wait, &wait);
 	
-	if (extra_count)
+	if (extra_count) {
+		/* ++ is not atomic, so this should be protected - Jean II */
+		spin_lock_irqsave(&self->spinlock, flags);
 		self->open_count++;
+		spin_unlock_irqrestore(&self->spinlock, flags);
+	}
 	self->blocked_open--;
 	
 	IRDA_DEBUG(1, "%s(%d):block_til_ready after blocking on %s open_count=%d\n",
@@ -385,6 +392,7 @@ static int ircomm_tty_open(struct tty_st
 {
 	struct ircomm_tty_cb *self;
 	unsigned int line;
+	unsigned long	flags;
 	int ret;
 
 	IRDA_DEBUG(2, __FUNCTION__ "()\n");
@@ -397,7 +405,7 @@ static int ircomm_tty_open(struct tty_st
 	}
 
 	/* Check if instance already exists */
-	self = hashbin_find(ircomm_tty, line, NULL);
+	self = hashbin_lock_find(ircomm_tty, line, NULL);
 	if (!self) {
 		/* No, so make new instance */
 		self = kmalloc(sizeof(struct ircomm_tty_cb), GFP_KERNEL);
@@ -423,6 +431,7 @@ static int ircomm_tty_open(struct tty_st
 		init_timer(&self->watchdog_timer);
 		init_waitqueue_head(&self->open_wait);
  		init_waitqueue_head(&self->close_wait);
+		spin_lock_init(&self->spinlock);
 
 		/* 
 		 * Force TTY into raw mode by default which is usually what
@@ -435,10 +444,13 @@ static int ircomm_tty_open(struct tty_st
 		/* Insert into hash */
 		hashbin_insert(ircomm_tty, (irda_queue_t *) self, line, NULL);
 	}
+	/* ++ is not atomic, so this should be protected - Jean II */
+	spin_lock_irqsave(&self->spinlock, flags);
 	self->open_count++;
 
 	tty->driver_data = self;
 	self->tty = tty;
+	spin_unlock_irqrestore(&self->spinlock, flags);
 
 	IRDA_DEBUG(1, __FUNCTION__"(), %s%d, count = %d\n", tty->driver.name, 
 		   self->line, self->open_count);
@@ -526,12 +538,11 @@ static void ircomm_tty_close(struct tty_
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == IRCOMM_TTY_MAGIC, return;);
 
-	save_flags(flags); 
-	cli();
+	spin_lock_irqsave(&self->spinlock, flags);
 
 	if (tty_hung_up_p(filp)) {
 		MOD_DEC_USE_COUNT;
-		restore_flags(flags);
+		spin_unlock_irqrestore(&self->spinlock, flags);
 
 		IRDA_DEBUG(0, __FUNCTION__ "(), returning 1\n");
 		return;
@@ -559,13 +570,19 @@ static void ircomm_tty_close(struct tty_
 	}
 	if (self->open_count) {
 		MOD_DEC_USE_COUNT;
-		restore_flags(flags);
+		spin_unlock_irqrestore(&self->spinlock, flags);
 
 		IRDA_DEBUG(0, __FUNCTION__ "(), open count > 0\n");
 		return;
 	}
 	self->flags |= ASYNC_CLOSING;
 
+	/* We need to unlock here (we were unlocking at the end of this
+	 * function), because tty_wait_until_sent() may schedule.
+	 * I don't know if the rest should be locked somehow,
+	 * so someone should check. - Jean II */
+	spin_unlock_irqrestore(&self->spinlock, flags);
+
 	/*
 	 * Now we wait for the transmit buffer to clear; and we notify 
 	 * the line discipline to only process XON/XOFF characters.
@@ -597,7 +614,6 @@ static void ircomm_tty_close(struct tty_
 	wake_up_interruptible(&self->close_wait);
 
 	MOD_DEC_USE_COUNT;
-	restore_flags(flags);
 }
 
 /*
@@ -645,13 +661,12 @@ static void ircomm_tty_do_softint(void *
 		return;
 
 	/* Unlink control buffer */
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&self->spinlock, flags);
 
 	ctrl_skb = self->ctrl_skb;
 	self->ctrl_skb = NULL;
 
-	restore_flags(flags);
+	spin_unlock_irqrestore(&self->spinlock, flags);
 
 	/* Flush control buffer if any */
 	if (ctrl_skb && self->flow == FLOW_START)
@@ -661,13 +676,12 @@ static void ircomm_tty_do_softint(void *
 		return;
 
 	/* Unlink transmit buffer */
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&self->spinlock, flags);
 	
 	skb = self->tx_skb;
 	self->tx_skb = NULL;
 
-	restore_flags(flags);	
+	spin_unlock_irqrestore(&self->spinlock, flags);
 
 	/* Flush transmit buffer if any */
 	if (skb)
@@ -720,8 +734,7 @@ static int ircomm_tty_write(struct tty_s
 		return len;
 	}
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&self->spinlock, flags);
 
 	/* Fetch current transmit buffer */
 	skb = self->tx_skb;
@@ -768,7 +781,7 @@ static int ircomm_tty_write(struct tty_s
 			skb = dev_alloc_skb(self->max_data_size+
 					    self->max_header_size);
 			if (!skb) {
-				restore_flags(flags);
+				spin_unlock_irqrestore(&self->spinlock, flags);
 				return -ENOBUFS;
 			}
 			skb_reserve(skb, self->max_header_size);
@@ -785,7 +798,7 @@ static int ircomm_tty_write(struct tty_s
 		len += size;
 	}
 
-	restore_flags(flags);
+	spin_unlock_irqrestore(&self->spinlock, flags);
 
 	/*     
 	 * Schedule a new thread which will transmit the frame as soon
@@ -824,13 +837,12 @@ static int ircomm_tty_write_room(struct 
 	    (self->max_header_size == IRCOMM_TTY_HDR_UNITIALISED))
 		ret = 0;
 	else {
-		save_flags(flags);
-		cli();
+		spin_lock_irqsave(&self->spinlock, flags);
 		if (self->tx_skb)
 			ret = self->max_data_size - self->tx_skb->len;
 		else
 			ret = self->max_data_size;
-		restore_flags(flags);
+		spin_unlock_irqrestore(&self->spinlock, flags);
 	}
 	IRDA_DEBUG(2, __FUNCTION__ "(), ret=%d\n", ret);
 
@@ -946,13 +958,12 @@ static int ircomm_tty_chars_in_buffer(st
 	ASSERT(self != NULL, return -1;);
 	ASSERT(self->magic == IRCOMM_TTY_MAGIC, return -1;);
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&self->spinlock, flags);
 
 	if (self->tx_skb)
 		len = self->tx_skb->len;
 
-	restore_flags(flags);
+	spin_unlock_irqrestore(&self->spinlock, flags);
 
 	return len;
 }
@@ -969,8 +980,7 @@ static void ircomm_tty_shutdown(struct i
 	if (!(self->flags & ASYNC_INITIALIZED))
 		return;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&self->spinlock, flags);
 
 	del_timer(&self->watchdog_timer);
 	
@@ -994,7 +1004,7 @@ static void ircomm_tty_shutdown(struct i
 	}
 	self->flags &= ~ASYNC_INITIALIZED;
 
-	restore_flags(flags);
+	spin_unlock_irqrestore(&self->spinlock, flags);
 }
 
 /*
@@ -1007,6 +1017,7 @@ static void ircomm_tty_shutdown(struct i
 static void ircomm_tty_hangup(struct tty_struct *tty)
 {
 	struct ircomm_tty_cb *self = (struct ircomm_tty_cb *) tty->driver_data;
+	unsigned long	flags;
 
 	IRDA_DEBUG(0, __FUNCTION__"()\n");
 
@@ -1019,9 +1030,13 @@ static void ircomm_tty_hangup(struct tty
 	/* ircomm_tty_flush_buffer(tty); */
 	ircomm_tty_shutdown(self);
 
+	/* I guess we need to lock here - Jean II */
+	spin_lock_irqsave(&self->spinlock, flags);
 	self->flags &= ~(ASYNC_NORMAL_ACTIVE|ASYNC_CALLOUT_ACTIVE);
 	self->tty = 0;
 	self->open_count = 0;
+	spin_unlock_irqrestore(&self->spinlock, flags);
+
 	wake_up_interruptible(&self->open_wait);
 }
 
@@ -1362,11 +1377,14 @@ static int ircomm_tty_read_proc(char *bu
 	struct ircomm_tty_cb *self;
         int count = 0, l;
         off_t begin = 0;
+	unsigned long flags;
+
+	spin_lock_irqsave(&ircomm_tty->hb_spinlock, flags);
 
 	self = (struct ircomm_tty_cb *) hashbin_get_first(ircomm_tty);
 	while ((self != NULL) && (count < 4000)) {
 		if (self->magic != IRCOMM_TTY_MAGIC)
-			return 0;
+			break;
 
                 l = ircomm_tty_line_info(self, buf + count);
                 count += l;
@@ -1381,6 +1399,8 @@ static int ircomm_tty_read_proc(char *bu
         }
         *eof = 1;
 done:
+	spin_unlock_irqrestore(&ircomm_tty->hb_spinlock, flags);
+
         if (offset >= count+begin)
                 return 0;
         *start = buf + (offset-begin);
diff -u -p -r linux/net/irda/ircomm-d5/ircomm_tty_attach.c linux/net/irda/ircomm/ircomm_tty_attach.c
--- linux/net/irda/ircomm-d5/ircomm_tty_attach.c	Sat Jun  8 22:28:53 2002
+++ linux/net/irda/ircomm/ircomm_tty_attach.c	Wed Aug 21 16:56:09 2002
@@ -331,6 +331,8 @@ static void ircomm_tty_discovery_indicat
 	info.daddr = discovery->daddr;
 	info.saddr = discovery->saddr;
 
+	/* FIXME. We probably need to use hashbin_find_next(), but we first
+	 * need to ensure that "line" is unique. - Jean II */
 	self = (struct ircomm_tty_cb *) hashbin_get_first(ircomm_tty);
 	while (self != NULL) {
 		ASSERT(self->magic == IRCOMM_TTY_MAGIC, return;);
diff -u -p -r linux/net/irda/irlan-d5/irlan_common.c linux/net/irda/irlan/irlan_common.c
--- linux/net/irda/irlan-d5/irlan_common.c	Mon Aug 19 15:59:28 2002
+++ linux/net/irda/irlan/irlan_common.c	Wed Aug 21 16:42:21 2002
@@ -125,7 +125,7 @@ int __init irlan_init(void)
 
 	IRDA_DEBUG(0, __FUNCTION__ "()\n");
 	/* Allocate master structure */
-	irlan = hashbin_new(HB_LOCAL); 
+	irlan = hashbin_new(HB_LOCK);	/* protect from /proc */
 	if (irlan == NULL) {
 		printk(KERN_WARNING "IrLAN: Can't allocate hashbin!\n");
 		return -ENOMEM;
@@ -1090,11 +1090,10 @@ static int irlan_proc_read(char *buf, ch
 	unsigned long flags;
 	ASSERT(irlan != NULL, return 0;);
      
-	save_flags(flags);
-	cli();
-
 	len = 0;
 	
+	spin_lock_irqsave(&irlan->hb_spinlock, flags);
+
 	len += sprintf(buf+len, "IrLAN instances:\n");
 	
 	self = (struct irlan_cb *) hashbin_get_first(irlan);
@@ -1130,7 +1129,7 @@ static int irlan_proc_read(char *buf, ch
 
 		self = (struct irlan_cb *) hashbin_get_next(irlan);
  	} 
-	restore_flags(flags);
+	spin_unlock_irqrestore(&irlan->hb_spinlock, flags);
 
 	return len;
 }
