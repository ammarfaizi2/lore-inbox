Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293022AbSCFBxI>; Tue, 5 Mar 2002 20:53:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293032AbSCFBwz>; Tue, 5 Mar 2002 20:52:55 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:13774 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S293027AbSCFBwf>;
	Tue, 5 Mar 2002 20:52:35 -0500
Date: Tue, 5 Mar 2002 17:52:33 -0800
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] : ir249_irnet_disc_ind.diff
Message-ID: <20020305175233.F1577@bougret.hpl.hp.com>
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

ir249_irnet_disc_ind.diff :
-------------------------
	o [CORRECT] Fix IrNET disconnection to not reconnect but
	  instead to hangup pppd


diff -u -p linux/net/irda/irnet/irnet.d4.h linux/net/irda/irnet/irnet.h
--- linux/net/irda/irnet/irnet.d4.h	Tue Mar  5 16:05:20 2002
+++ linux/net/irda/irnet/irnet.h	Tue Mar  5 16:43:09 2002
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
--- linux/net/irda/irnet/irnet_irda.d4.c	Tue Mar  5 16:05:30 2002
+++ linux/net/irda/irnet/irnet_irda.c	Tue Mar  5 16:43:09 2002
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
