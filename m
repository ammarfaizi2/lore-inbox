Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292656AbSCEWh4>; Tue, 5 Mar 2002 17:37:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292767AbSCEWhS>; Tue, 5 Mar 2002 17:37:18 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:52685 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S292293AbSCEWfT>;
	Tue, 5 Mar 2002 17:35:19 -0500
Date: Tue, 5 Mar 2002 14:35:18 -0800
To: Linus Torvalds <torvalds@transmeta.com>, irda-users@lists.sourceforge.net,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] : ir256_irnet_disc_ind.diff
Message-ID: <20020305143518.D1254@bougret.hpl.hp.com>
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

ir256_irnet_disc_ind.diff :
-------------------------
	o [CORRECT] Fix IrNET disconnection to not reconnect but
	  instead to hangup pppd


diff -u -p linux/net/irda/irnet/irnet.d4.h linux/net/irda/irnet/irnet.h
--- linux/net/irda/irnet/irnet.d4.h	Mon Mar  4 16:48:49 2002
+++ linux/net/irda/irnet/irnet.h	Mon Mar  4 16:52:15 2002
@@ -206,6 +206,11 @@
  *	  just after clearing it. *blush*.
  *	o Use newly created irttp_listen() to fix potential crash when LAP
  *	  destroyed before irnet module removed.
+ *
+ * v10 - 4.3.2 - Jean II
+ *	o When receiving a disconnect indication, don't reenable the
+ *	  PPP Tx queue, this will trigger a reconnect. Instead, close
+ *	  the channel, which will kill pppd...
  */
 
 /***************************** INCLUDES *****************************/
diff -u -p linux/net/irda/irnet/irnet_irda.d4.c linux/net/irda/irnet/irnet_irda.c
--- linux/net/irda/irnet/irnet_irda.d4.c	Mon Mar  4 14:22:31 2002
+++ linux/net/irda/irnet/irnet_irda.c	Mon Mar  4 16:20:21 2002
@@ -1122,9 +1122,10 @@ irnet_disconnect_indication(void *	insta
       irttp_close_tsap(self->tsap);
       self->tsap = NULL;
 
-      /* Flush (drain) ppp_generic Tx queue (most often we have blocked it) */
+      /* Cleanup & close the PPP channel, which will kill pppd and the rest */
       if(self->ppp_open)
-	ppp_output_wakeup(&self->chan);
+	ppp_unregister_channel(&self->chan);
+      self->ppp_open = 0;
     }
   /* Cleanup the socket in case we want to reconnect */
   self->stsap_sel = 0;
