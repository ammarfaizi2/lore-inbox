Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313505AbSD0M1S>; Sat, 27 Apr 2002 08:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313698AbSD0M1R>; Sat, 27 Apr 2002 08:27:17 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:26009 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S313505AbSD0M1P>;
	Sat, 27 Apr 2002 08:27:15 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15562.38536.785666.690953@argo.ozlabs.ibm.com>
Date: Sat, 27 Apr 2002 22:16:08 +1000 (EST)
To: jt@hpl.hp.com
Cc: linux-kernel@vger.kernel.org
Subject: set_bit takes a long in irda
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There were a couple of places in the irda code where set_bit and
friends were being used on int variables.  This is bad because some
architectures require long alignment for atomic operations, and also
because it now gives a compile error in 2.5.x.

Here is a patch to fix the problems for 2.5.11.

Thanks,
Paul.

diff -urN linux-2.5/include/net/irda/irlmp.h pmac-2.5/include/net/irda/irlmp.h
--- linux-2.5/include/net/irda/irlmp.h	Sat Apr 27 20:51:23 2002
+++ pmac-2.5/include/net/irda/irlmp.h	Sat Apr 27 15:18:05 2002
@@ -100,7 +100,7 @@
 	irda_queue_t queue;      /* Must be first */
 	magic_t magic;
 
-	int  connected;
+	unsigned long connected;	/* set_bit used on this */
 	int  persistent;
 
 	__u8 slsap_sel;   /* Source (this) LSAP address */
diff -urN linux-2.5/include/net/irda/irttp.h pmac-2.5/include/net/irda/irttp.h
--- linux-2.5/include/net/irda/irttp.h	Sat Apr 27 20:51:34 2002
+++ pmac-2.5/include/net/irda/irttp.h	Sat Apr 27 15:21:33 2002
@@ -102,7 +102,7 @@
 	__u32 tx_max_sdu_size; /* Max transmit user data size */
 
 	int close_pend;        /* Close, but disconnect_pend */
-	int disconnect_pend;   /* Disconnect, but still data to send */
+	unsigned long disconnect_pend; /* Disconnect, but still data to send */
 	struct sk_buff *disconnect_skb;
 };
 
diff -urN linux-2.5/net/irda/irnet/irnet.h pmac-2.5/net/irda/irnet/irnet.h
--- linux-2.5/net/irda/irnet/irnet.h	Sat Apr 27 20:52:03 2002
+++ pmac-2.5/net/irda/irnet/irnet.h	Sat Apr 27 15:23:57 2002
@@ -404,8 +404,8 @@
 
   /* ------------------------ IrTTP part ------------------------ */
   /* We create a pseudo "socket" over the IrDA tranport */
-  int			ttp_open;	/* Set when IrTTP is ready */
-  int			ttp_connect;	/* Set when IrTTP is connecting */
+  unsigned long		ttp_open;	/* Set when IrTTP is ready */
+  unsigned long		ttp_connect;	/* Set when IrTTP is connecting */
   struct tsap_cb *	tsap;		/* IrTTP instance (the connection) */
 
   char			rname[NICKNAME_MAX_LEN + 1];
diff -urN linux-2.5/net/irda/irnet/irnet_ppp.c pmac-2.5/net/irda/irnet/irnet_ppp.c
--- linux-2.5/net/irda/irnet/irnet_ppp.c	Sat Apr 27 20:52:04 2002
+++ pmac-2.5/net/irda/irnet/irnet_ppp.c	Sat Apr 27 15:25:07 2002
@@ -860,7 +860,7 @@
       irda_irnet_connect(self);
 #endif /* CONNECT_IN_SEND */
 
-      DEBUG(PPP_INFO, "IrTTP not ready ! (%d-%d)\n",
+      DEBUG(PPP_INFO, "IrTTP not ready ! (%ld-%ld)\n",
 	    self->ttp_open, self->ttp_connect);
 
       /* Note : we can either drop the packet or block the packet.
