Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272856AbRIMXUR>; Thu, 13 Sep 2001 19:20:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272847AbRIMXUF>; Thu, 13 Sep 2001 19:20:05 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:30656 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S272848AbRIMXTZ>;
	Thu, 13 Sep 2001 19:19:25 -0400
Date: Thu, 13 Sep 2001 16:19:44 -0700
To: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Dag Brattli <dag@brattli.net>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        linux-irda@pasta.cs.uit.no
Subject: [IrDA patch] ir248_irnet_nodelay.diff
Message-ID: <20010913161944.E7470@bougret.hpl.hp.com>
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

ir248_irnet_nodelay.diff :
------------------------
	o [FEATURE] Use DEV_ADDR_ANY instead of 0
	o [FEATURE] Remove the 3 second delay from connection setup

diff -u -p linux/net/irda/irnet/irnet.l2.h linux/net/irda/irnet/irnet.h
--- linux/net/irda/irnet/irnet.l2.h	Thu Sep 13 11:59:06 2001
+++ linux/net/irda/irnet/irnet.h	Thu Sep 13 11:59:58 2001
@@ -185,6 +185,13 @@
  *	  is transparently controlled from pppd lcp-max-configure.
  *	o Add ttp_connect flag to prevent rentry on the connect procedure
  *	o Test and fixups to eliminate side effects of retries
+ *
+ * v7 - 22/08/01 - Jean II
+ *	o Cleanup : Change "saddr = 0x0" to "saddr = DEV_ADDR_ANY"
+ *	o Fix bug in BLOCK_WHEN_CONNECT introduced in v6 : due to the
+ *	  asynchronous IAS query, self->tsap is NULL when PPP send the
+ *	  first packet.  This was preventing "connect-delay 0" to work.
+ *	  Change the test in ppp_irnet_send() to self->ttp_connect.
  */
 
 /***************************** INCLUDES *****************************/
diff -u -p linux/net/irda/irnet/irnet_irda.l2.c linux/net/irda/irnet/irnet_irda.c
--- linux/net/irda/irnet/irnet_irda.l2.c	Thu Sep 13 11:59:16 2001
+++ linux/net/irda/irnet/irnet_irda.c	Thu Sep 13 11:59:58 2001
@@ -478,9 +478,9 @@ irda_irnet_create(irnet_socket *	self)
   self->ttp_connect = 0;	/* Not connecting yet */
   self->rname[0] = '\0';	/* May be set via control channel */
   self->rdaddr = DEV_ADDR_ANY;	/* May be set via control channel */
-  self->rsaddr = 0x0;		/* May be set via control channel */
+  self->rsaddr = DEV_ADDR_ANY;	/* May be set via control channel */
   self->daddr = DEV_ADDR_ANY;	/* Until we get connected */
-  self->saddr = 0x0;		/* Until we get connected */
+  self->saddr = DEV_ADDR_ANY;	/* Until we get connected */
   self->max_sdu_size_rx = TTP_SAR_UNBOUND;
 
   /* Register as a client with IrLMP */
diff -u -p linux/net/irda/irnet/irnet_ppp.l2.c linux/net/irda/irnet/irnet_ppp.c
--- linux/net/irda/irnet/irnet_ppp.l2.c	Thu Sep 13 11:59:25 2001
+++ linux/net/irda/irnet/irnet_ppp.c	Thu Sep 13 11:59:58 2001
@@ -858,8 +858,8 @@ ppp_irnet_send(struct ppp_channel *	chan
       irda_irnet_connect(self);
 #endif /* CONNECT_IN_SEND */
 
-      DEBUG(PPP_INFO, "IrTTP not ready ! (%d-0x%X)\n",
-	    self->ttp_open, (unsigned int) self->tsap);
+      DEBUG(PPP_INFO, "IrTTP not ready ! (%d-%d)\n",
+	    self->ttp_open, self->ttp_connect);
 
       /* Note : we can either drop the packet or block the packet.
        *
@@ -882,7 +882,7 @@ ppp_irnet_send(struct ppp_channel *	chan
        */
 #ifdef BLOCK_WHEN_CONNECT
       /* If we are attempting to connect */
-      if(self->tsap)
+      if(self->ttp_connect)
 	{
 	  /* Blocking packet, ppp_generic will retry later */
 	  return 0;
