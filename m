Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263428AbVCEAgu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263428AbVCEAgu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 19:36:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263526AbVCEAci
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 19:32:38 -0500
Received: from palrel11.hp.com ([156.153.255.246]:53219 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S263370AbVCEAYh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 19:24:37 -0500
Date: Fri, 4 Mar 2005 16:24:37 -0800
To: "David S. Miller" <davem@davemloft.net>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6 IrDA] fix IrNET poll with empty disco log
Message-ID: <20050305002437.GB23895@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ir261_irnet_poll_fix-2.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~~
	o [CORRECT] poll would improperly exit when the discovery log was empty
Signed-off-by: Jean Tourrilhes <jt@hpl.hp.com>



diff -u -p linux/net/irda/irnet/irnet_irda.j1.c linux/net/irda/irnet/irnet_irda.c
--- linux/net/irda/irnet/irnet_irda.j1.c	Fri Feb  4 16:28:22 2005
+++ linux/net/irda/irnet/irnet_irda.c	Fri Feb  4 16:28:58 2005
@@ -632,7 +632,7 @@ irda_irnet_destroy(irnet_socket *	self)
       self->iriap = NULL;
     }
 
-  /* Cleanup eventual discoveries from connection attempt */
+  /* Cleanup eventual discoveries from connection attempt or control channel */
   if(self->discoveries != NULL)
     {
       /* Cleanup our copy of the discovery log */
diff -u -p linux/net/irda/irnet/irnet_ppp.j1.c linux/net/irda/irnet/irnet_ppp.c
--- linux/net/irda/irnet/irnet_ppp.j1.c	Fri Feb  4 16:28:30 2005
+++ linux/net/irda/irnet/irnet_ppp.c	Fri Feb  4 16:28:58 2005
@@ -171,18 +171,44 @@ irnet_ctrl_write(irnet_socket *	ap,
 #ifdef INITIAL_DISCOVERY
 /*------------------------------------------------------------------*/
 /*
- * Function irnet_read_discovery_log (self)
+ * Function irnet_get_discovery_log (self)
+ *
+ *    Query the content on the discovery log if not done
+ *
+ * This function query the current content of the discovery log
+ * at the startup of the event channel and save it in the internal struct.
+ */
+static void
+irnet_get_discovery_log(irnet_socket *	ap)
+{
+  __u16		mask = irlmp_service_to_hint(S_LAN);
+
+  /* Ask IrLMP for the current discovery log */
+  ap->discoveries = irlmp_get_discoveries(&ap->disco_number, mask,
+					  DISCOVERY_DEFAULT_SLOTS);
+
+  /* Check if the we got some results */
+  if(ap->discoveries == NULL)
+    ap->disco_number = -1;
+
+  DEBUG(CTRL_INFO, "Got the log (0x%p), size is %d\n",
+	ap->discoveries, ap->disco_number);
+}
+
+/*------------------------------------------------------------------*/
+/*
+ * Function irnet_read_discovery_log (self, event)
  *
  *    Read the content on the discovery log
  *
  * This function dump the current content of the discovery log
  * at the startup of the event channel.
- * Return 1 if written on the control channel...
+ * Return 1 if wrote an event on the control channel...
  *
  * State of the ap->disco_XXX variables :
- *	at socket creation :	disco_index = 0 ; disco_number = 0
- *	while reading :		disco_index = X ; disco_number = Y
- *	After reading :		disco_index = Y ; disco_number = -1
+ * Socket creation :  discoveries = NULL ; disco_index = 0 ; disco_number = 0
+ * While reading :    discoveries = ptr  ; disco_index = X ; disco_number = Y
+ * After reading :    discoveries = NULL ; disco_index = Y ; disco_number = -1
  */
 static inline int
 irnet_read_discovery_log(irnet_socket *	ap,
@@ -201,19 +227,8 @@ irnet_read_discovery_log(irnet_socket *	
     }
 
   /* Test if it's the first time and therefore we need to get the log */
-  if(ap->disco_index == 0)
-    {
-      __u16		mask = irlmp_service_to_hint(S_LAN);
-
-      /* Ask IrLMP for the current discovery log */
-      ap->discoveries = irlmp_get_discoveries(&ap->disco_number, mask,
-					      DISCOVERY_DEFAULT_SLOTS);
-      /* Check if the we got some results */
-      if(ap->discoveries == NULL)
-	ap->disco_number = -1;
-      DEBUG(CTRL_INFO, "Got the log (0x%p), size is %d\n",
-	    ap->discoveries, ap->disco_number);
-    }
+  if(ap->discoveries == NULL)
+    irnet_get_discovery_log(ap);
 
   /* Check if we have more item to dump */
   if(ap->disco_index < ap->disco_number)
@@ -417,7 +432,14 @@ irnet_ctrl_poll(irnet_socket *	ap,
     mask |= POLLIN | POLLRDNORM;
 #ifdef INITIAL_DISCOVERY
   if(ap->disco_number != -1)
-    mask |= POLLIN | POLLRDNORM;
+    {
+      /* Test if it's the first time and therefore we need to get the log */
+      if(ap->discoveries == NULL)
+	irnet_get_discovery_log(ap);
+      /* Recheck */
+      if(ap->disco_number != -1)
+	mask |= POLLIN | POLLRDNORM;
+    }
 #endif /* INITIAL_DISCOVERY */
 
   DEXIT(CTRL_TRACE, " - mask=0x%X\n", mask);
