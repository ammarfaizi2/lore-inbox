Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263619AbTEMWJr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 18:09:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263628AbTEMWJr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 18:09:47 -0400
Received: from palrel10.hp.com ([156.153.255.245]:50384 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S263619AbTEMWIJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 18:08:09 -0400
Date: Tue, 13 May 2003 15:20:55 -0700
To: Jeff Garzik <jgarzik@pobox.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5] IrNET crasher
Message-ID: <20030513222055.GC2634@bougret.hpl.hp.com>
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

ir257_irnet_bh.diff :
	o [CRITICA] Replace spin_lock_irqsave() with spin_lock_bh()
		to be compatible with ppp_generic locking
	o [CRITICA] Disable call to ppp_unregister_channel()


diff -u -p linux/net/irda/irnet/irnet.d9.h linux/net/irda/irnet/irnet.h
--- linux/net/irda/irnet/irnet.d9.h	Mon Apr  7 17:40:20 2003
+++ linux/net/irda/irnet/irnet.h	Mon Apr  7 18:36:34 2003
@@ -229,6 +229,11 @@
  * v14 - 20.2.03 - Jean II
  *	o Add discovery hint bits in the control channel.
  *	o Remove obsolete MOD_INC/DEC_USE_COUNT in favor of .owner
+ *
+ * v15 - 7.4.03 - Jean II
+ *	o Replace spin_lock_irqsave() with spin_lock_bh() so that we can
+ *	  use ppp_unit_number(). It's probably also better overall...
+ *	o Disable call to ppp_unregister_channel(), because we can't do it.
  */
 
 /***************************** INCLUDES *****************************/
@@ -276,6 +281,7 @@
 #undef CONNECT_INDIC_KICK	/* Might mess IrDA, not needed */
 #undef FAIL_SEND_DISCONNECT	/* Might mess IrDA, not needed */
 #undef PASS_CONNECT_PACKETS	/* Not needed ? Safe */
+#undef MISSING_PPP_API		/* Stuff I wish I could do */
 
 /* PPP side of the business */
 #define BLOCK_WHEN_CONNECT	/* Block packets when connecting */
diff -u -p linux/net/irda/irnet/irnet_irda.d9.c linux/net/irda/irnet/irnet_irda.c
--- linux/net/irda/irnet/irnet_irda.d9.c	Mon Apr  7 15:09:34 2003
+++ linux/net/irda/irnet/irnet_irda.c	Mon Apr  7 18:35:52 2003
@@ -31,7 +31,6 @@ irnet_post_event(irnet_socket *	ap,
 		 char *		name,
 		 __u16		hints)
 {
-  unsigned long		flags;		/* For spinlock */
   int			index;		/* In the log */
 
   DENTER(CTRL_TRACE, "(ap=0x%X, event=%d, daddr=%08x, name=``%s'')\n",
@@ -41,7 +40,7 @@ irnet_post_event(irnet_socket *	ap,
    * Note : as we are the only event producer, we only need to exclude
    * ourself when touching the log, which is nice and easy.
    */
-  spin_lock_irqsave(&irnet_events.spinlock, flags);
+  spin_lock_bh(&irnet_events.spinlock);
 
   /* Copy the event in the log */
   index = irnet_events.index;
@@ -69,7 +68,7 @@ irnet_post_event(irnet_socket *	ap,
   DEBUG(CTRL_INFO, "New event index is %d\n", irnet_events.index);
 
   /* Spin lock end */
-  spin_unlock_irqrestore(&irnet_events.spinlock, flags);
+  spin_unlock_bh(&irnet_events.spinlock);
 
   /* Now : wake up everybody waiting for events... */
   wake_up_interruptible_all(&irnet_events.rwait);
@@ -536,10 +535,9 @@ irda_irnet_connect(irnet_socket *	self)
    *	     Can't re-insert (MUST remove first) so check for that... */
   if((irnet_server.running) && (self->q.q_next == NULL))
     {
-      unsigned long		flags;
-      spin_lock_irqsave(&irnet_server.spinlock, flags);
+      spin_lock_bh(&irnet_server.spinlock);
       hashbin_insert(irnet_server.list, (irda_queue_t *) self, 0, self->rname);
-      spin_unlock_irqrestore(&irnet_server.spinlock, flags);
+      spin_unlock_bh(&irnet_server.spinlock);
       DEBUG(IRDA_SOCK_INFO, "Inserted ``%s'' in hashbin...\n", self->rname);
     }
 
@@ -596,12 +594,11 @@ irda_irnet_destroy(irnet_socket *	self)
   if((irnet_server.running) && (self->q.q_next != NULL))
     {
       struct irnet_socket *	entry;
-      unsigned long		flags;
       DEBUG(IRDA_SOCK_INFO, "Removing from hash..\n");
-      spin_lock_irqsave(&irnet_server.spinlock, flags);
+      spin_lock_bh(&irnet_server.spinlock);
       entry = hashbin_remove_this(irnet_server.list, (irda_queue_t *) self);
       self->q.q_next = NULL;
-      spin_unlock_irqrestore(&irnet_server.spinlock, flags);
+      spin_unlock_bh(&irnet_server.spinlock);
       DASSERT(entry == self, , IRDA_SOCK_ERROR, "Can't remove from hash.\n");
     }
 
@@ -723,7 +720,6 @@ static inline irnet_socket *
 irnet_find_socket(irnet_socket *	self)
 {
   irnet_socket *	new = (irnet_socket *) NULL;
-  unsigned long		flags;
   int			err;
 
   DENTER(IRDA_SERV_TRACE, "(self=0x%X)\n", (unsigned int) self);
@@ -736,7 +732,7 @@ irnet_find_socket(irnet_socket *	self)
   err = irnet_daddr_to_dname(self);
 
   /* Protect access to the instance list */
-  spin_lock_irqsave(&irnet_server.spinlock, flags);
+  spin_lock_bh(&irnet_server.spinlock);
 
   /* So now, try to get an socket having specifically
    * requested that nickname */
@@ -790,7 +786,7 @@ irnet_find_socket(irnet_socket *	self)
     }
 
   /* Spin lock end */
-  spin_unlock_irqrestore(&irnet_server.spinlock, flags);
+  spin_unlock_bh(&irnet_server.spinlock);
 
   DEXIT(IRDA_SERV_TRACE, " - new = 0x%X\n", (unsigned int) new);
   return new;
@@ -1135,10 +1131,15 @@ irnet_disconnect_indication(void *	insta
     {
       if(test_open)
 	{
+#ifdef MISSING_PPP_API
+	  /* ppp_unregister_channel() wants a user context, which we
+	   * are guaranteed to NOT have here. What are we supposed
+	   * to do here ? Jean II */
 	  /* If we were connected, cleanup & close the PPP channel,
 	   * which will kill pppd (hangup) and the rest */
 	  ppp_unregister_channel(&self->chan);
 	  self->ppp_open = 0;
+#endif
 	}
       else
 	{
@@ -1711,7 +1712,6 @@ irnet_proc_read(char *	buf,
 {
   irnet_socket *	self;
   char *		state;
-  unsigned long		flags;
   int			i = 0;
 
   len = 0;
@@ -1728,7 +1728,7 @@ irnet_proc_read(char *	buf,
     return len;
 
   /* Protect access to the instance list */
-  spin_lock_irqsave(&irnet_server.spinlock, flags);
+  spin_lock_bh(&irnet_server.spinlock);
 
   /* Get the sockets one by one... */
   self = (irnet_socket *) hashbin_get_first(irnet_server.list);
@@ -1780,7 +1780,7 @@ irnet_proc_read(char *	buf,
     }
 
   /* Spin lock end */
-  spin_unlock_irqrestore(&irnet_server.spinlock, flags);
+  spin_unlock_bh(&irnet_server.spinlock);
 
   return len;
 }
