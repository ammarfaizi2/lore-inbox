Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313010AbSDCCWW>; Tue, 2 Apr 2002 21:22:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313012AbSDCCWT>; Tue, 2 Apr 2002 21:22:19 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:12798 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S313010AbSDCCVx>;
	Tue, 2 Apr 2002 21:21:53 -0500
Date: Tue, 2 Apr 2002 18:21:49 -0800
To: Linus Torvalds <torvalds@transmeta.com>, irda-users@lists.sourceforge.net,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: [PATCH] : ir256_irnet_disc_ind_again.diff
Message-ID: <20020402182149.E24912@bougret.hpl.hp.com>
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

ir256_irnet_disc_ind_again.diff :
-------------------------------
	o [CORRECT] Correct fix for IrNET disconnect indication :
	  if socket is not connected, don't hangup, to allow passive operation

diff -u -p linux/net/irda/irnet/irnet.d5.h linux/net/irda/irnet/irnet.h
--- linux/net/irda/irnet/irnet.d5.h	Wed Mar 20 13:26:06 2002
+++ linux/net/irda/irnet/irnet.h	Wed Mar 20 13:30:25 2002
@@ -211,6 +211,12 @@
  *	o When receiving a disconnect indication, don't reenable the
  *	  PPP Tx queue, this will trigger a reconnect. Instead, close
  *	  the channel, which will kill pppd...
+ *
+ * v11 - 20.3.02 - Jean II
+ *	o Oops ! v10 fix disabled IrNET retries and passive behaviour.
+ *	  Better fix in irnet_disconnect_indication() :
+ *	  - if connected, kill pppd via hangup.
+ *	  - if not connected, reenable ppp Tx, which trigger IrNET retry.
  */
 
 /***************************** INCLUDES *****************************/
diff -u -p linux/net/irda/irnet/irnet_irda.d5.c linux/net/irda/irnet/irnet_irda.c
--- linux/net/irda/irnet/irnet_irda.d5.c	Wed Mar 20 13:11:42 2002
+++ linux/net/irda/irnet/irnet_irda.c	Wed Mar 20 13:34:09 2002
@@ -1070,7 +1070,7 @@ irnet_data_indication(void *	instance,
  *	o attempted to connect, timeout
  *	o connected, link is broken, LAP has timeout
  *	o connected, other side close the link
- *	o connection request on the server no handled
+ *	o connection request on the server not handled
  */
 static void
 irnet_disconnect_indication(void *	instance,
@@ -1121,20 +1121,31 @@ irnet_disconnect_indication(void *	insta
       DEBUG(IRDA_CB_INFO, "Closing our TTP connection.\n");
       irttp_close_tsap(self->tsap);
       self->tsap = NULL;
-
-      /* Cleanup & close the PPP channel, which will kill pppd and the rest */
-      if(self->ppp_open)
-	ppp_unregister_channel(&self->chan);
-      self->ppp_open = 0;
     }
-  /* Cleanup the socket in case we want to reconnect */
+  /* Cleanup the socket in case we want to reconnect in ppp_output_wakeup() */
   self->stsap_sel = 0;
   self->daddr = DEV_ADDR_ANY;
   self->tx_flow = FLOW_START;
 
-  /* Note : what should we say to ppp ?
-   * It seem the ppp_generic and pppd are happy that way and will eventually
-   * timeout gracefully, so don't bother them... */
+  /* Deal with the ppp instance if it's still alive */
+  if(self->ppp_open)
+    {
+      if(test_open)
+	{
+	  /* If we were connected, cleanup & close the PPP channel,
+	   * which will kill pppd (hangup) and the rest */
+	  ppp_unregister_channel(&self->chan);
+	  self->ppp_open = 0;
+	}
+      else
+	{
+	  /* If we were trying to connect, flush (drain) ppp_generic
+	   * Tx queue (most often we have blocked it), which will
+	   * trigger an other attempt to connect. If we are passive,
+	   * this will empty the Tx queue after last try. */
+	  ppp_output_wakeup(&self->chan);
+	}
+    }
 
   DEXIT(IRDA_TCB_TRACE, "\n");
 }
