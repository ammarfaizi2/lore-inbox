Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263151AbTKETkv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 14:40:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263155AbTKETkv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 14:40:51 -0500
Received: from palrel13.hp.com ([156.153.255.238]:185 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S263151AbTKETkn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 14:40:43 -0500
Date: Wed, 5 Nov 2003 11:40:42 -0800
To: "David S. Miller" <davem@redhat.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6 IrDA] IrNET status event Oops
Message-ID: <20031105194042.GC24323@bougret.hpl.hp.com>
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

ir2609_irnet_ppp_open_race-2.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	o [CRITICA] Prevent sending status event to dead/kfree sockets
	o [CORRECT] Disable PPP access before deregistration
		PPP deregistration might sleep -> race condition


diff -u -p linux/net/irda/irnet.d4/irnet_ppp.c linux/net/irda/irnet/irnet_ppp.c
--- linux/net/irda/irnet.d4/irnet_ppp.c	Sat Sep 27 17:50:38 2003
+++ linux/net/irda/irnet/irnet_ppp.c	Mon Oct 20 18:46:44 2003
@@ -512,8 +512,8 @@ dev_irnet_close(struct inode *	inode,
   if(ap->ppp_open)
     {
       DERROR(FS_ERROR, "Channel still registered - deregistering !\n");
-      ppp_unregister_channel(&ap->chan);
       ap->ppp_open = 0;
+      ppp_unregister_channel(&ap->chan);
     }
 
   kfree(ap);
@@ -651,10 +651,12 @@ dev_irnet_ioctl(struct inode *	inode,
 	  DEBUG(FS_INFO, "Exiting PPP discipline.\n");
 	  /* Disconnect from the generic PPP layer */
 	  if(ap->ppp_open)
-	    ppp_unregister_channel(&ap->chan);
+	    {
+	      ap->ppp_open = 0;
+	      ppp_unregister_channel(&ap->chan);
+	    }
 	  else
 	    DERROR(FS_ERROR, "Channel not registered !\n");
-	  ap->ppp_open = 0;
 	  err = 0;
 	}
       break;
diff -u -p linux/net/irda/irttp.d4.c linux/net/irda/irttp.c
--- linux/net/irda/irttp.d4.c	Tue Oct 21 10:36:40 2003
+++ linux/net/irda/irttp.c	Tue Oct 21 11:01:52 2003
@@ -968,6 +968,10 @@ void irttp_status_indication(void *insta
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == TTP_TSAP_MAGIC, return;);
 
+	/* Check if client has already closed the TSAP and gone away */
+	if (self->close_pend)
+		return;
+
 	/*
 	 *  Inform service user if he has requested it
 	 */
@@ -1603,7 +1607,7 @@ void irttp_do_data_indication(struct tsa
 {
 	int err;
 
-	/* Check if client has already tried to close the TSAP */
+	/* Check if client has already closed the TSAP and gone away */
 	if (self->close_pend) {
 		dev_kfree_skb(skb);
 		return;
