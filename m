Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265619AbUBJBJm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 20:09:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265621AbUBJBJm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 20:09:42 -0500
Received: from palrel11.hp.com ([156.153.255.246]:24459 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S265619AbUBJBJd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 20:09:33 -0500
Date: Mon, 9 Feb 2004 17:09:31 -0800
To: "David S. Miller" <davem@redhat.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6 IrDA] Ultra sendto support
Message-ID: <20040210010931.GB673@bougret.hpl.hp.com>
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

ir262_ultra_sendto.diff :
~~~~~~~~~~~~~~~~~~~~~~~
		<Original patch from Stephen Hemminger>
	o [CORRECT] Always initialise Ultra packet/header size.
	o [CORRECT] Don't allow Ultra send on unbound sockets if no
		dest address is given.
	o [FEATURE] Properly support Ultra sendto on unbound sockets.


diff -u -p linux/include/net/irda/irlmp.d7.h linux/include/net/irda/irlmp.h
--- linux/include/net/irda/irlmp.d7.h	Mon Feb  9 14:51:20 2004
+++ linux/include/net/irda/irlmp.h	Mon Feb  9 14:54:09 2004
@@ -237,7 +237,7 @@ int  irlmp_udata_request(struct lsap_cb 
 void irlmp_udata_indication(struct lsap_cb *, struct sk_buff *);
 
 #ifdef CONFIG_IRDA_ULTRA
-int  irlmp_connless_data_request(struct lsap_cb *, struct sk_buff *);
+int  irlmp_connless_data_request(struct lsap_cb *, struct sk_buff *, __u8);
 void irlmp_connless_data_indication(struct lsap_cb *, struct sk_buff *);
 #endif /* CONFIG_IRDA_ULTRA */
 
diff -u -p linux/net/irda/irlmp.d7.c linux/net/irda/irlmp.c
--- linux/net/irda/irlmp.d7.c	Mon Feb  9 14:50:57 2004
+++ linux/net/irda/irlmp.c	Mon Feb  9 14:54:48 2004
@@ -1193,7 +1193,8 @@ void irlmp_udata_indication(struct lsap_
  * Function irlmp_connless_data_request (self, skb)
  */
 #ifdef CONFIG_IRDA_ULTRA
-int irlmp_connless_data_request(struct lsap_cb *self, struct sk_buff *userdata)
+int irlmp_connless_data_request(struct lsap_cb *self, struct sk_buff *userdata,
+				__u8 pid)
 {
 	struct sk_buff *clone_skb;
 	struct lap_cb *lap;
@@ -1208,7 +1209,10 @@ int irlmp_connless_data_request(struct l
 
 	/* Insert protocol identifier */
 	skb_push(userdata, LMP_PID_HEADER);
-	userdata->data[0] = self->pid;
+	if(self != NULL)
+	  userdata->data[0] = self->pid;
+	else
+	  userdata->data[0] = pid;
 
 	/* Connectionless sockets must use 0x70 */
 	skb_push(userdata, LMP_HEADER);
diff -u -p linux/net/irda/af_irda.d7.c linux/net/irda/af_irda.c
--- linux/net/irda/af_irda.d7.c	Mon Feb  9 15:13:47 2004
+++ linux/net/irda/af_irda.c	Mon Feb  9 15:26:52 2004
@@ -802,9 +802,6 @@ static int irda_bind(struct socket *sock
 		if (err < 0)
 			return err;
 
-		self->max_data_size = ULTRA_MAX_DATA - LMP_PID_HEADER;
-		self->max_header_size = IRDA_MAX_HEADER + LMP_PID_HEADER;
-
 		/* Pretend we are connected */
 		sock->state = SS_CONNECTED;
 		sk->sk_state   = TCP_ESTABLISHED;
@@ -1122,6 +1119,10 @@ static int irda_create(struct socket *so
 #ifdef CONFIG_IRDA_ULTRA
 		case IRDAPROTO_ULTRA:
 			sock->ops = &irda_ultra_ops;
+			/* Initialise now, because we may send on unbound
+			 * sockets. Jean II */
+			self->max_data_size = ULTRA_MAX_DATA - LMP_PID_HEADER;
+			self->max_header_size = IRDA_MAX_HEADER + LMP_PID_HEADER;
 			break;
 #endif /* CONFIG_IRDA_ULTRA */
 		case IRDAPROTO_UNITDATA:
@@ -1584,6 +1585,8 @@ static int irda_sendmsg_ultra(struct kio
 {
 	struct sock *sk = sock->sk;
 	struct irda_sock *self;
+	__u8 pid = 0;
+	int bound = 0;
 	struct sk_buff *skb;
 	unsigned char *asmptr;
 	int err;
@@ -1601,6 +1604,33 @@ static int irda_sendmsg_ultra(struct kio
 	self = irda_sk(sk);
 	ASSERT(self != NULL, return -1;);
 
+	/* Check if an address was specified with sendto. Jean II */
+	if (msg->msg_name) {
+		struct sockaddr_irda *addr = (struct sockaddr_irda *) msg->msg_name;
+		/* Check address, extract pid. Jean II */
+		if (msg->msg_namelen < sizeof(*addr))
+			return -EINVAL;
+		if (addr->sir_family != AF_IRDA)
+			return -EINVAL;
+
+		pid = addr->sir_lsap_sel;
+		if (pid & 0x80) {
+			IRDA_DEBUG(0, "%s(), extension in PID not supp!\n", __FUNCTION__);
+			return -EOPNOTSUPP;
+		}
+	} else {
+		/* Check that the socket is properly bound to an Ultra
+		 * port. Jean II */
+		if ((self->lsap == NULL) ||
+		    (sk->sk_state != TCP_ESTABLISHED)) {
+			IRDA_DEBUG(0, "%s(), socket not bound to Ultra PID.\n",
+				   __FUNCTION__);
+			return -ENOTCONN;
+		}
+		/* Use PID from socket */
+		bound = 1;
+	}
+
 	/*
 	 * Check that we don't send out to big frames. This is an unreliable
 	 * service, so we have no fragmentation and no coalescence
@@ -1627,7 +1657,8 @@ static int irda_sendmsg_ultra(struct kio
 		return err;
 	}
 
-	err = irlmp_connless_data_request(self->lsap, skb);
+	err = irlmp_connless_data_request((bound ? self->lsap : NULL),
+					  skb, pid);
 	if (err) {
 		IRDA_DEBUG(0, "%s(), err=%d\n", __FUNCTION__, err);
 		return err;
