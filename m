Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314517AbSDSCfF>; Thu, 18 Apr 2002 22:35:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314516AbSDSCdf>; Thu, 18 Apr 2002 22:33:35 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:48613 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S314517AbSDSCcw>;
	Thu, 18 Apr 2002 22:32:52 -0400
Date: Thu, 18 Apr 2002 19:31:21 -0700
To: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        irda-users@lists.sourceforge.net
Subject: [PATCH] : ir258_dongle_locking.diff
Message-ID: <20020418193121.F988@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ir258_dongle_locking.diff :
-------------------------
	o [CORRECT] Load dongle module with irq disabled in irtty
	<Same fix need to go in irport, but irport doesn't work for me>

---------------------------------------

diff -u -p linux/net/irda/irda_device.d7.c linux/net/irda/irda_device.c
--- linux/net/irda/irda_device.d7.c	Wed Apr 10 18:01:37 2002
+++ linux/net/irda/irda_device.c	Wed Apr 10 18:14:13 2002
@@ -368,6 +368,12 @@ int irda_task_kick(struct irda_task *tas
  *    time to complete. We do it this hairy way since we may have been
  *    called from interrupt context, so it's not possible to use
  *    schedule_timeout() 
+ * Two important notes :
+ *	o Make sure you irda_task_delete(task); in case you delete the
+ *	  calling instance.
+ *	o No real need to lock when calling this function, but you may
+ *	  want to lock within the task handler.
+ * Jean II
  */
 struct irda_task *irda_task_execute(void *instance, 
 				    IRDA_TASK_CALLBACK function, 
@@ -466,6 +472,9 @@ int irda_device_txqueue_empty(struct net
  * Function irda_device_init_dongle (self, type, qos)
  *
  *    Initialize attached dongle.
+ *
+ * Important : request_module require us to call this function with
+ * a process context and irq enabled. - Jean II
  */
 dongle_t *irda_device_dongle_init(struct net_device *dev, int type)
 {
@@ -477,6 +486,7 @@ dongle_t *irda_device_dongle_init(struct
 #ifdef CONFIG_KMOD
 	{
 	char modname[32];
+	ASSERT(!in_interrupt(), return NULL;);
 	/* Try to load the module needed */
 	sprintf(modname, "irda-dongle-%d", type);
 	request_module(modname);
diff -u -p linux/drivers/net/irda/irtty.d7.c linux/drivers/net/irda/irtty.c
--- linux/drivers/net/irda/irtty.d7.c	Wed Apr 10 18:01:51 2002
+++ linux/drivers/net/irda/irtty.c	Wed Apr 10 18:12:50 2002
@@ -970,9 +970,14 @@ static int irtty_net_ioctl(struct net_de
 
 	IRDA_DEBUG(3, __FUNCTION__ "(), %s, (cmd=0x%X)\n", dev->name, cmd);
 	
-	/* Disable interrupts & save flags */
-	save_flags(flags);
-	cli();
+	/* Locking :
+	 * irda_device_dongle_init() can't be locked.
+	 * irda_task_execute() doesn't need to be locked (but
+	 * irtty_change_speed() should protect itself).
+	 * As this driver doesn't have spinlock protection, keep
+	 * old fashion locking :-(
+	 * Jean II
+	 */
 	
 	switch (cmd) {
 	case SIOCSBANDWIDTH: /* Set bandwidth */
@@ -998,14 +1003,17 @@ static int irtty_net_ioctl(struct net_de
 		dongle->write       = irtty_raw_write;
 		dongle->set_dtr_rts = irtty_set_dtr_rts;
 		
-		self->dongle = dongle;
-
-		/* Now initialize the dongle!  */
+		/* Now initialize the dongle!
+		 * Safe to do unlocked : self->dongle is still NULL. */ 
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
 		if (!capable(CAP_NET_ADMIN))
@@ -1019,20 +1027,26 @@ static int irtty_net_ioctl(struct net_de
 	case SIOCSDTRRTS:
 		if (!capable(CAP_NET_ADMIN))
 			ret = -EPERM;
-		else
+		else {
+			save_flags(flags);
+			cli();
 			irtty_set_dtr_rts(dev, irq->ifr_dtr, irq->ifr_rts);
+			restore_flags(flags);
+		}
 		break;
 	case SIOCSMODE:
 		if (!capable(CAP_NET_ADMIN))
 			ret = -EPERM;
-		else
+		else {
+			save_flags(flags);
+			cli();
 			irtty_set_mode(dev, irq->ifr_mode);
+			restore_flags(flags);
+		}
 		break;
 	default:
 		ret = -EOPNOTSUPP;
 	}
-	
-	restore_flags(flags);
 	
 	return ret;
 }
