Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314521AbSDSCgV>; Thu, 18 Apr 2002 22:36:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314522AbSDSCfW>; Thu, 18 Apr 2002 22:35:22 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:26598 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S314521AbSDSCe3>;
	Thu, 18 Apr 2002 22:34:29 -0400
Date: Thu, 18 Apr 2002 19:32:57 -0700
To: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        irda-users@lists.sourceforge.net
Subject: [PATCH] : ir258_irnet_simult_race-2.diff
Message-ID: <20020418193257.H988@bougret.hpl.hp.com>
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

ir258_irnet_simult_race-2.diff :
------------------------------
	o [CORRECT] Prevent dealock on simultaneous peer IrNET connections
		Only the primary peer will accept the IrNET connection

--------------------------------------

diff -u -p linux/include/net/irda/irlap.d7.h linux/include/net/irda/irlap.h
--- linux/include/net/irda/irlap.d7.h	Wed Apr 10 18:36:27 2002
+++ linux/include/net/irda/irlap.h	Wed Apr 10 19:36:28 2002
@@ -31,8 +31,6 @@
 #include <linux/types.h>
 #include <linux/skbuff.h>
 #include <linux/netdevice.h>
-#include <linux/ppp_defs.h>
-#include <linux/ppp-comp.h>
 #include <linux/timer.h>
 
 #include <net/irda/irlap_event.h>
@@ -239,5 +237,25 @@ void irlap_apply_connection_parameters(s
 
 #define IRLAP_GET_HEADER_SIZE(self) (LAP_MAX_HEADER)
 #define IRLAP_GET_TX_QUEUE_LEN(self) skb_queue_len(&self->txq)
+
+/* Return TRUE if the node is in primary mode (i.e. master)
+ * - Jean II */
+static inline int irlap_is_primary(struct irlap_cb *self)
+{
+	int ret;
+	switch(self->state) {
+	case LAP_XMIT_P:
+	case LAP_NRM_P:
+		ret = 1;
+		break;
+	case LAP_XMIT_S:
+	case LAP_NRM_S:
+		ret = 0;
+		break;
+	default:
+		ret = -1;
+	}
+	return(ret);
+}
 
 #endif
diff -u -p linux/include/net/irda/irttp.d7.h linux/include/net/irda/irttp.h
--- linux/include/net/irda/irttp.d7.h	Wed Apr 10 18:45:50 2002
+++ linux/include/net/irda/irttp.h	Fri Apr 12 09:57:29 2002
@@ -197,6 +197,18 @@ static inline void irttp_listen(struct t
 	self->dtsap_sel = LSAP_ANY;
 }
 
+/* Return TRUE if the node is in primary mode (i.e. master)
+ * - Jean II */
+static inline int irttp_is_primary(struct tsap_cb *self)
+{
+	if ((self == NULL) ||
+	    (self->lsap == NULL) ||
+	    (self->lsap->lap == NULL) ||
+	    (self->lsap->lap->irlap == NULL))
+		return -2;
+	return(irlap_is_primary(self->lsap->lap->irlap));
+}
+
 extern struct irttp_cb *irttp;
 
 #endif /* IRTTP_H */
diff -u -p linux/net/irda/irnet/irnet.d7.h linux/net/irda/irnet/irnet.h
--- linux/net/irda/irnet/irnet.d7.h	Wed Apr 10 18:53:59 2002
+++ linux/net/irda/irnet/irnet.h	Fri Apr 12 14:22:36 2002
@@ -217,6 +217,11 @@
  *	  Better fix in irnet_disconnect_indication() :
  *	  - if connected, kill pppd via hangup.
  *	  - if not connected, reenable ppp Tx, which trigger IrNET retry.
+ *
+ * v12 - 10.4.02 - Jean II
+ *	o Fix race condition in irnet_connect_indication().
+ *	  If the socket was already trying to connect, drop old connection
+ *	  and use new one only if acting as primary. See comments.
  */
 
 /***************************** INCLUDES *****************************/
diff -u -p linux/net/irda/irnet/irnet_irda.d7.c linux/net/irda/irnet/irnet_irda.c
--- linux/net/irda/irnet/irnet_irda.d7.c	Wed Apr 10 18:53:52 2002
+++ linux/net/irda/irnet/irnet_irda.c	Fri Apr 12 14:20:35 2002
@@ -1340,46 +1340,80 @@ irnet_connect_indication(void *		instanc
       return;
     }
 
-  /* Socket connecting ?
-   * Clear up flag : prevent irnet_disconnect_indication() to mess up tsap */
-  if(test_and_clear_bit(0, &new->ttp_connect))
-    {
-      /* The socket is trying to connect to the other end and may have sent
-       * a IrTTP connection request and is waiting for a connection response
-       * (that may never come).
-       * Now, the pain is that the socket may have opened a tsap and is
-       * waiting on it, while the other end is trying to connect to it on
-       * another tsap.
-       */
-      DERROR(IRDA_CB_ERROR, "Socket already connecting. Ouch !\n");
+  /* The following code is a bit tricky, so need comments ;-)
+   */
+  /* If ttp_connect is set, the socket is trying to connect to the other
+   * end and may have sent a IrTTP connection request and is waiting for
+   * a connection response (that may never come).
+   * Now, the pain is that the socket may have opened a tsap and is
+   * waiting on it, while the other end is trying to connect to it on
+   * another tsap.
+   * Because IrNET can be peer to peer, we need to workaround this.
+   * Furthermore, the way the irnetd script is implemented, the
+   * target will create a second IrNET connection back to the
+   * originator and expect the originator to bind this new connection
+   * to the original PPPD instance.
+   * And of course, if we don't use irnetd, we can have a race when
+   * both side try to connect simultaneously, which could leave both
+   * connections half closed (yuck).
+   * Conclusions :
+   *	1) The "originator" must accept the new connection and get rid
+   *	   of the old one so that irnetd works
+   *	2) One side must deny the new connection to avoid races,
+   *	   but both side must agree on which side it is...
+   * Most often, the originator is primary at the LAP layer.
+   * Jean II
+   */
+  /* Now, let's look at the way I wrote the test...
+   * We need to clear up the ttp_connect flag atomically to prevent
+   * irnet_disconnect_indication() to mess up the tsap we are going to close.
+   * We want to clear the ttp_connect flag only if we close the tsap,
+   * otherwise we will never close it, so we need to check for primary
+   * *before* doing the test on the flag.
+   * And of course, ALLOW_SIMULT_CONNECT can disable this entirely...
+   * Jean II
+   */
+
+  /* Socket already connecting ? On primary ? */
+  if(0
 #ifdef ALLOW_SIMULT_CONNECT
-      /* Cleanup the TSAP if necessary - IrIAP will be cleaned up later */
+     || ((irttp_is_primary(server->tsap) == 1)	/* primary */
+	 && (test_and_clear_bit(0, &new->ttp_connect)))
+#endif /* ALLOW_SIMULT_CONNECT */
+     )
+    {
+      DERROR(IRDA_CB_ERROR, "Socket already connecting, but going to reuse it !\n");
+
+      /* Cleanup the old TSAP if necessary - IrIAP will be cleaned up later */
       if(new->tsap != NULL)
 	{
-	  /* Close the connection the new socket was attempting.
-	   * This seems to be safe... */
+	  /* Close the old connection the new socket was attempting,
+	   * so that we can hook it up to the new connection.
+	   * It's now safe to do it... */
 	  irttp_close_tsap(new->tsap);
 	  new->tsap = NULL;
 	}
-      /* Note : no return, fall through... */
-#else /* ALLOW_SIMULT_CONNECT */
-      irnet_disconnect_server(server, skb);
-      return;
-#endif /* ALLOW_SIMULT_CONNECT */
     }
   else
-    /* If socket is not connecting or connected, tsap should be NULL */
-    if(new->tsap != NULL)
-      {
-	/* If we are here, we are also in irnet_disconnect_indication(),
-	 * and it's a nice race condition... On the other hand, we can't be
-	 * in irda_irnet_destroy() otherwise we would not have found the
-	 * socket in the hashbin. */
-	/* Better get out of here, otherwise we will mess up tsaps ! */
-	DERROR(IRDA_CB_ERROR, "Race condition detected, abort connect...\n");
-	irnet_disconnect_server(server, skb);
-	return;
-      }
+    {
+      /* Three options :
+       * 1) socket was not connecting or connected : ttp_connect should be 0.
+       * 2) we don't want to connect the socket because we are secondary or
+       * ALLOW_SIMULT_CONNECT is undefined. ttp_connect should be 1.
+       * 3) we are half way in irnet_disconnect_indication(), and it's a
+       * nice race condition... Fortunately, we can detect that by checking
+       * if tsap is still alive. On the other hand, we can't be in
+       * irda_irnet_destroy() otherwise we would not have found this
+       * socket in the hashbin.
+       * Jean II */
+      if((test_bit(0, &new->ttp_connect)) || (new->tsap != NULL))
+	{
+	  /* Don't mess this socket, somebody else in in charge... */
+	  DERROR(IRDA_CB_ERROR, "Race condition detected, socket in use, abort connect...\n");
+	  irnet_disconnect_server(server, skb);
+	  return;
+	}
+    }
 
   /* So : at this point, we have a socket, and it is idle. Good ! */
   irnet_connect_socket(server, new, qos, max_sdu_size, max_header_size);
