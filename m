Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132507AbQKKVFG>; Sat, 11 Nov 2000 16:05:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132547AbQKKVE4>; Sat, 11 Nov 2000 16:04:56 -0500
Received: from tepid.osl.fast.no ([213.188.9.130]:33289 "EHLO
	tepid.osl.fast.no") by vger.kernel.org with ESMTP
	id <S132546AbQKKVEw>; Sat, 11 Nov 2000 16:04:52 -0500
Date: Sat, 11 Nov 2000 21:05:53 GMT
Message-Id: <200011112105.VAA31859@tepid.osl.fast.no>
Subject: [patch] patch-2.4.0-test10-irda8 (was: Re: The IrDA patches)
X-Mailer: Pygmy (v0.4.4pre)
Subject: [patch] patch-2.4.0-test10-irda8 (was: Re: The IrDA patches)
Cc: linux-kernel@vger.kernel.org
From: Dag Brattli <dagb@fast.no>
To: torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Here are the new IrDA patches for Linux-2.4.0-test10. Please apply them to
your latest 2.4 code. If you decide to apply them, then I suggest you start
with the first one (irda1.diff) and work your way to the last one 
(irda24.diff) since most of them are not commutative. 

The name of this patch is irda8.diff. 

(Many thanks to Jean Tourrilhes for splitting up the big patch)

[FEATURE] : Add a new feature to the IrDA stack
[CORRECT] : Fix to have the correct/expected behaviour
[CRITICA] : Fix potential kernel crash
[OUPS   ] : Error that will be fixed in a later patch

irda8.diff :
----------------
	o [CRITICA] Preserve irda device name (better fix later on)
	o [CORRECT] Use timer_pending when possible

diff -urpN linux/drivers/net/irda/irtty.c old-linux/drivers/net/irda/irtty.c
--- linux/drivers/net/irda/irtty.c	Thu Nov  9 14:29:59 2000
+++ old-linux/drivers/net/irda/irtty.c	Thu Nov  9 13:48:34 2000
@@ -233,8 +233,14 @@ static int irtty_open(struct tty_struct 
 		ERROR(__FUNCTION__ "(), dev_alloc() failed!\n");
 		return -ENOMEM;
 	}
+
+#if LINUX_VERSION_CODE >= 0x020362	/* 2.3.99-pre7 */
+	/* dev_alloc doesn't clear the struct (Yuck !!!) */
+	memset(((__u8*)dev)+IFNAMSIZ,0,sizeof(struct net_device)-IFNAMSIZ);
+#else
 	/* dev_alloc doesn't clear the struct */
 	memset(((__u8*)dev)+sizeof(char*),0,sizeof(struct net_device)-sizeof(char*));
+#endif /* LINUX_VERSION_CODE >= 0x020362 */
 
 	dev->priv = (void *) self;
 	self->netdev = dev;
diff -urpN linux/net/irda/af_irda.c old-linux/net/irda/af_irda.c
--- linux/net/irda/af_irda.c	Thu Nov  9 14:37:46 2000
+++ old-linux/net/irda/af_irda.c	Thu Nov  9 13:48:34 2000
@@ -2195,7 +2195,7 @@ static int irda_getsockopt(struct socket
 			interruptible_sleep_on(&self->query_wait);
 
 			/* If watchdog is still activated, kill it! */
-			if(self->watchdog.prev != (struct timer_list *) NULL)
+			if(timer_pending(&(self->watchdog)))
 				del_timer(&(self->watchdog));
 
 			IRDA_DEBUG(1, __FUNCTION__ 
diff -urpN linux/net/irda/irlmp_frame.c old-linux/net/irda/irlmp_frame.c
--- linux/net/irda/irlmp_frame.c	Thu Nov  9 14:37:38 2000
+++ old-linux/net/irda/irlmp_frame.c	Thu Nov  9 13:48:34 2000
@@ -395,7 +395,7 @@ void irlmp_link_discovery_indication(str
 	irlmp_add_discovery(irlmp->cachelog, discovery);
 	
 	/* If delay was activated, kill it! */
-	if(disco_delay.prev != (struct timer_list *) NULL)
+	if(timer_pending(&disco_delay))
 		del_timer(&disco_delay);
 	/* Set delay timer to expire in 0.5s. */
 	disco_delay.expires = jiffies + (DISCO_SMALL_DELAY * HZ/1000);
@@ -422,7 +422,7 @@ void irlmp_link_discovery_confirm(struct
 	irlmp_add_discovery_log(irlmp->cachelog, log);
       
 	/* If delay was activated, kill it! */
-	if(disco_delay.prev != (struct timer_list *) NULL)
+	if(timer_pending(&disco_delay))
 		del_timer(&disco_delay);
 
 	/* Propagate event to the state machine */
diff -urpN linux/net/irda/timer.c old-linux/net/irda/timer.c
--- linux/net/irda/timer.c	Thu Nov  9 14:37:38 2000
+++ old-linux/net/irda/timer.c	Thu Nov  9 13:48:34 2000
@@ -120,7 +120,7 @@ void irlmp_start_idle_timer(struct lap_c
 void irlmp_stop_idle_timer(struct lap_cb *self) 
 {
 	/* If timer is activated, kill it! */
-	if(self->idle_timer.prev != (struct timer_list *) NULL)
+	if(timer_pending(&self->idle_timer))
 		del_timer(&self->idle_timer);
 }
 


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
