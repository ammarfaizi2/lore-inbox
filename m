Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318259AbSHDWvB>; Sun, 4 Aug 2002 18:51:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318260AbSHDWvB>; Sun, 4 Aug 2002 18:51:01 -0400
Received: from mail1.qualcomm.com ([129.46.64.223]:14733 "EHLO
	mail1.qualcomm.com") by vger.kernel.org with ESMTP
	id <S318259AbSHDWu5>; Sun, 4 Aug 2002 18:50:57 -0400
Subject: [PATCH] 2.4.19 Bluetooth [2/5] L2CAP fixes
From: "Maksim (Max) " Krasnyanskiy <maxk@qualcomm.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, bluez-devel@usw-pr-web.sourceforge.net
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1028458420.5549.35.camel@champ.qualcomm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.5.99 
Date: 04 Aug 2002 03:53:45 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

L2CAP fixes and updates.

- Locking fixes

- Support for connectionless channels (datagram sockets)

- Support for shutdown() syscall

 l2cap.c |  220 ++++++++++++++++++++++++++++++++++++++++++----------------------
 1 files changed, 146 insertions(+), 74 deletions(-)

http://bluez.sourceforge.net/patches/patch-2.4.19-bluetooth-l2cap.gz

Please apply

Max


diff -urN -x 'hci*' -x 'sco*' -x 'af_*' linux.orig/net/bluetooth/l2cap.c linux/net/bluetooth/l2cap.c
--- linux.orig/net/bluetooth/l2cap.c	Sat Aug  3 11:59:47 2002
+++ linux/net/bluetooth/l2cap.c	Sat Aug  3 18:12:36 2002
@@ -25,9 +25,9 @@
 /*
  * BlueZ L2CAP core and sockets.
  *
- * $Id: l2cap.c,v 1.8 2002/04/19 00:01:39 maxk Exp $
+ * $Id: l2cap.c,v 1.13 2002/07/27 19:04:15 maxk Exp $
  */
-#define VERSION "2.0"
+#define VERSION "2.1"
 
 #include <linux/config.h>
 #include <linux/module.h>
@@ -51,6 +51,7 @@
 
 #include <asm/system.h>
 #include <asm/uaccess.h>
+#include <asm/unaligned.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -234,32 +235,26 @@
 }
 
 /* -------- Socket interface ---------- */
-static struct sock *__l2cap_get_sock_by_addr(struct sockaddr_l2 *addr)
+static struct sock *__l2cap_get_sock_by_addr(__u16 psm, bdaddr_t *src)
 {
-	bdaddr_t *src = &addr->l2_bdaddr;
-	__u16 psm = addr->l2_psm;
 	struct sock *sk;
-
 	for (sk = l2cap_sk_list.head; sk; sk = sk->next) {
 		if (l2cap_pi(sk)->psm == psm &&
-		    !bacmp(&bluez_pi(sk)->src, src))
+				!bacmp(&bluez_pi(sk)->src, src))
 			break;
 	}
-
 	return sk;
 }
 
-/* Find socket listening on psm and source bdaddr.
+/* Find socket with psm and source bdaddr.
  * Returns closest match.
  */
-static struct sock *l2cap_get_sock_listen(bdaddr_t *src, __u16 psm)
+static struct sock *__l2cap_get_sock_by_psm(int state, __u16 psm, bdaddr_t *src)
 {
 	struct sock *sk, *sk1 = NULL;
 
-	read_lock(&l2cap_sk_list.lock);
-
 	for (sk = l2cap_sk_list.head; sk; sk = sk->next) {
-		if (sk->state != BT_LISTEN)
+		if (state && sk->state != state)
 			continue;
 
 		if (l2cap_pi(sk)->psm == psm) {
@@ -272,9 +267,19 @@
 				sk1 = sk;
 		}
 	}
+	return sk ? sk : sk1;
+}
 
+/* Find socket with given address (psm, src).
+ * Returns locked socket */
+static inline struct sock *l2cap_get_sock_by_psm(int state, __u16 psm, bdaddr_t *src)
+{
+	struct sock *s;
+	read_lock(&l2cap_sk_list.lock);
+	s = __l2cap_get_sock_by_psm(state, psm, src);
+	if (s) bh_lock_sock(s);
 	read_unlock(&l2cap_sk_list.lock);
-	return sk ? sk : sk1;
+	return s;
 }
 
 static void l2cap_sock_destruct(struct sock *sk)
@@ -330,6 +335,7 @@
 
 	case BT_CONNECTED:
 	case BT_CONFIG:
+	case BT_CONNECT2:
 		if (sk->type == SOCK_SEQPACKET) {
 			struct l2cap_conn *conn = l2cap_pi(sk)->conn;
 			l2cap_disconn_req req;
@@ -346,7 +352,6 @@
 		break;
 
 	case BT_CONNECT:
-	case BT_CONNECT2:
 	case BT_DISCONN:
 		l2cap_chan_del(sk, reason);
 		break;
@@ -377,7 +382,6 @@
 
 	if (parent) {
 		sk->type = parent->type;
-
 		pi->imtu = l2cap_pi(parent)->imtu;
 		pi->omtu = l2cap_pi(parent)->omtu;
 		pi->link_mode = l2cap_pi(parent)->link_mode;
@@ -425,7 +429,7 @@
 
 	sock->state = SS_UNCONNECTED;
 
-	if (sock->type != SOCK_SEQPACKET && sock->type != SOCK_RAW)
+	if (sock->type != SOCK_SEQPACKET && sock->type != SOCK_DGRAM && sock->type != SOCK_RAW)
 		return -ESOCKTNOSUPPORT;
 
 	sock->ops = &l2cap_sock_ops;
@@ -455,20 +459,17 @@
 		goto done;
 	}
 
-	write_lock(&l2cap_sk_list.lock);
-
-	if (la->l2_psm && __l2cap_get_sock_by_addr(la)) {
+	write_lock_bh(&l2cap_sk_list.lock);
+	if (la->l2_psm && __l2cap_get_sock_by_addr(la->l2_psm, &la->l2_bdaddr)) {
 		err = -EADDRINUSE;
-		goto unlock;
+	} else {
+		/* Save source address */
+		bacpy(&bluez_pi(sk)->src, &la->l2_bdaddr);
+		l2cap_pi(sk)->psm = la->l2_psm;
+		sk->state = BT_BOUND;
 	}
 
-	/* Save source address */
-	bacpy(&bluez_pi(sk)->src, &la->l2_bdaddr);
-	l2cap_pi(sk)->psm = la->l2_psm;
-	sk->state = BT_BOUND;
-
-unlock:
-	write_unlock(&l2cap_sk_list.lock);
+	write_unlock_bh(&l2cap_sk_list.lock);
 
 done:
 	release_sock(sk);
@@ -631,7 +632,6 @@
 		bacpy(&la->l2_bdaddr, &bluez_pi(sk)->src);
 
 	la->l2_psm = l2cap_pi(sk)->psm;
-
 	return 0;
 }
 
@@ -648,6 +648,10 @@
 	if (msg->msg_flags & MSG_OOB)
 		return -EOPNOTSUPP;
 
+	/* Check outgoing MTU */
+	if (len > l2cap_pi(sk)->omtu)
+		return -EINVAL;
+
 	lock_sock(sk);
 
 	if (sk->state == BT_CONNECTED)
@@ -693,7 +697,7 @@
 	default:
 		err = -ENOPROTOOPT;
 		break;
-	};
+	}
 
 	release_sock(sk);
 	return err;
@@ -745,20 +749,37 @@
 	default:
 		err = -ENOPROTOOPT;
 		break;
-	};
+	}
 
 	release_sock(sk);
 	return err;
 }
 
+static int l2cap_sock_shutdown(struct socket *sock, int how)
+{
+	struct sock *sk = sock->sk;
+
+	BT_DBG("sock %p, sk %p", sock, sk);
+
+	if (!sk) return 0;
+
+	l2cap_sock_clear_timer(sk);
+
+	lock_sock(sk);
+	sk->shutdown = SHUTDOWN_MASK;
+	__l2cap_sock_close(sk, ECONNRESET);
+	release_sock(sk);
+
+	return 0;
+}
+
 static int l2cap_sock_release(struct socket *sock)
 {
 	struct sock *sk = sock->sk;
 
 	BT_DBG("sock %p, sk %p", sock, sk);
 
-	if (!sk)
-		return 0;
+	if (!sk) return 0;
 
 	sock_orphan(sk);
 	l2cap_sock_close(sk);
@@ -769,24 +790,20 @@
 static struct sock * __l2cap_get_chan_by_dcid(struct l2cap_chan_list *l, __u16 cid)
 {
 	struct sock *s;
-
 	for (s = l->head; s; s = l2cap_pi(s)->next_c) {
 		if (l2cap_pi(s)->dcid == cid)
 			break;
 	}
-
 	return s;
 }
 
 static struct sock *__l2cap_get_chan_by_scid(struct l2cap_chan_list *l, __u16 cid)
 {
 	struct sock *s;
-
 	for (s = l->head; s; s = l2cap_pi(s)->next_c) {
 		if (l2cap_pi(s)->scid == cid)
 			break;
 	}
-
 	return s;
 }
 
@@ -852,10 +869,15 @@
 	l2cap_pi(sk)->conn = conn;
 
 	if (sk->type == SOCK_SEQPACKET) {
-		/* Alloc CID for normal socket */
+		/* Alloc CID for connection-oriented socket */
 		l2cap_pi(sk)->scid = l2cap_alloc_cid(l);
+	} else if (sk->type == SOCK_DGRAM) {
+		/* Connectionless socket */
+		l2cap_pi(sk)->scid = 0x0002;
+		l2cap_pi(sk)->dcid = 0x0002;
+		l2cap_pi(sk)->omtu = L2CAP_DEFAULT_MTU;
 	} else {
-		/* Raw socket can send only signalling messages */
+		/* Raw socket can send/recv signalling messages only */
 		l2cap_pi(sk)->scid = 0x0001;
 		l2cap_pi(sk)->dcid = 0x0001;
 		l2cap_pi(sk)->omtu = L2CAP_DEFAULT_MTU;
@@ -986,25 +1008,31 @@
 {
 	struct l2cap_conn *conn = l2cap_pi(sk)->conn;
 	struct sk_buff *skb, **frag;
-	int err, size, count, sent=0;
+	int err, hlen, count, sent=0;
 	l2cap_hdr *lh;
 
-	/* Check outgoing MTU */
-	if (len > l2cap_pi(sk)->omtu)
-		return -EINVAL;
-
 	BT_DBG("sk %p len %d", sk, len);
 
 	/* First fragment (with L2CAP header) */
-	count = MIN(conn->mtu - L2CAP_HDR_SIZE, len);
-	size  = L2CAP_HDR_SIZE + count;
-	if (!(skb = bluez_skb_send_alloc(sk, size, msg->msg_flags & MSG_DONTWAIT, &err)))
+	if (sk->type == SOCK_DGRAM)
+		hlen = L2CAP_HDR_SIZE + 2;
+	else
+		hlen = L2CAP_HDR_SIZE;
+
+	count = MIN(conn->mtu - hlen, len);
+
+	skb = bluez_skb_send_alloc(sk, hlen + count,
+			msg->msg_flags & MSG_DONTWAIT, &err);
+	if (!skb)
 		return err;
 
 	/* Create L2CAP header */
 	lh = (l2cap_hdr *) skb_put(skb, L2CAP_HDR_SIZE);
-	lh->len = __cpu_to_le16(len);
 	lh->cid = __cpu_to_le16(l2cap_pi(sk)->dcid);
+	lh->len = __cpu_to_le16(len + (hlen - L2CAP_HDR_SIZE));
+
+	if (sk->type == SOCK_DGRAM)
+		put_unaligned(l2cap_pi(sk)->psm, (__u16 *) skb_put(skb, 2));
 
 	if (memcpy_fromiovec(skb_put(skb, count), msg->msg_iov, count)) {
 		err = -EFAULT;
@@ -1317,37 +1345,41 @@
 	BT_DBG("psm 0x%2.2x scid 0x%4.4x", psm, scid);
 
 	/* Check if we have socket listening on psm */
-	if (!(parent = l2cap_get_sock_listen(conn->src, psm))) {
+	parent = l2cap_get_sock_by_psm(BT_LISTEN, psm, conn->src);
+	if (!parent) {
 		result = L2CAP_CR_BAD_PSM;
-		goto resp;
+		goto sendresp;
 	}
 
-	write_lock(&list->lock);
-	bh_lock_sock(parent);
-
 	result = L2CAP_CR_NO_MEM;
 
-	/* Check if we already have channel with that dcid */
-	if (__l2cap_get_chan_by_dcid(list, scid))
-		goto unlock;
-
 	/* Check for backlog size */
 	if (parent->ack_backlog > parent->max_ack_backlog) {
 		BT_DBG("backlog full %d", parent->ack_backlog); 
-		goto unlock;
+		goto response;
 	}
 
-	if (!(sk = l2cap_sock_alloc(NULL, BTPROTO_L2CAP, GFP_ATOMIC)))
-		goto unlock;
+	sk = l2cap_sock_alloc(NULL, BTPROTO_L2CAP, GFP_ATOMIC);
+	if (!sk)
+		goto response;
 
-	l2cap_sock_init(sk, parent);
+	write_lock(&list->lock);
 
+	/* Check if we already have channel with that dcid */
+	if (__l2cap_get_chan_by_dcid(list, scid)) {
+		write_unlock(&list->lock);
+		sk->zapped = 1;
+		l2cap_sock_kill(sk);
+		goto response;
+	}
+
+	hci_conn_hold(conn->hcon);
+
+	l2cap_sock_init(sk, parent);
 	bacpy(&bluez_pi(sk)->src, conn->src);
 	bacpy(&bluez_pi(sk)->dst, conn->dst);
 	l2cap_pi(sk)->psm  = psm;
 	l2cap_pi(sk)->dcid = scid;
-	
-	hci_conn_hold(conn->hcon);
 
 	__l2cap_chan_add(conn, sk, parent);
 	dcid = l2cap_pi(sk)->scid;
@@ -1362,20 +1394,22 @@
 	
 	if (l2cap_pi(sk)->link_mode & L2CAP_LM_ENCRYPT) {
 		if (!hci_conn_encrypt(conn->hcon))
-			goto unlock;
+			goto done;
 	} else if (l2cap_pi(sk)->link_mode & L2CAP_LM_AUTH) {
 		if (!hci_conn_auth(conn->hcon))
-			goto unlock;
+			goto done;
 	}
 
 	sk->state = BT_CONFIG;
 	result = status = 0;
 
-unlock:
-	bh_unlock_sock(parent);
+done:
 	write_unlock(&list->lock);
 
-resp:
+response:
+	bh_unlock_sock(parent);
+
+sendresp:
 	rsp.scid   = __cpu_to_le16(scid);
 	rsp.dcid   = __cpu_to_le16(dcid);
 	rsp.result = __cpu_to_le16(result);
@@ -1680,10 +1714,37 @@
 	return 0;
 }
 
+static inline int l2cap_conless_channel(struct l2cap_conn *conn, __u16 psm, struct sk_buff *skb)
+{
+	struct sock *sk;
+
+	sk = l2cap_get_sock_by_psm(0, psm, conn->src);
+	if (!sk)
+		goto drop;
+
+	BT_DBG("sk %p, len %d", sk, skb->len);
+
+	if (sk->state != BT_BOUND && sk->state != BT_CONNECTED)
+		goto drop;
+
+	if (l2cap_pi(sk)->imtu < skb->len)
+		goto drop;
+
+	if (!sock_queue_rcv_skb(sk, skb))
+		goto done;
+
+drop:
+	kfree_skb(skb);
+
+done:
+	if (sk) bh_unlock_sock(sk);
+	return 0;
+}
+
 static void l2cap_recv_frame(struct l2cap_conn *conn, struct sk_buff *skb)
 {
 	l2cap_hdr *lh = (l2cap_hdr *) skb->data;
-	__u16 cid, len;
+	__u16 cid, psm, len;
 
 	skb_pull(skb, L2CAP_HDR_SIZE);
 	cid = __le16_to_cpu(lh->cid);
@@ -1691,10 +1752,21 @@
 
 	BT_DBG("len %d, cid 0x%4.4x", len, cid);
 
-	if (cid == 0x0001)
+	switch (cid) {
+	case 0x0001:
 		l2cap_sig_channel(conn, skb);
-	else	
+		break;
+
+	case 0x0002:
+		psm = get_unaligned((__u16 *) skb->data);
+		skb_pull(skb, 2);
+		l2cap_conless_channel(conn, psm, skb);
+		break;
+		
+	default:
 		l2cap_data_channel(conn, cid, skb);
+		break;
+	}
 }
 
 /* ------------ L2CAP interface with lower layer (HCI) ------------- */
@@ -1934,7 +2006,7 @@
 	struct sock *sk;
 	char *ptr = buf;
 
-	write_lock(&list->lock);
+	read_lock_bh(&list->lock);
 
 	for (sk = list->head; sk; sk = sk->next) {
 		pi = l2cap_pi(sk);
@@ -1944,7 +2016,7 @@
 				pi->link_mode);
 	}
 
-	write_unlock(&list->lock);
+	read_unlock_bh(&list->lock);
 
 	ptr += sprintf(ptr, "\n");
 	return ptr - buf;
@@ -1987,7 +2059,7 @@
 	poll:		bluez_sock_poll,
 	socketpair:	sock_no_socketpair,
 	ioctl:		sock_no_ioctl,
-	shutdown:	sock_no_shutdown,
+	shutdown:	l2cap_sock_shutdown,
 	setsockopt:	l2cap_sock_setsockopt,
 	getsockopt:	l2cap_sock_getsockopt,
 	mmap:		sock_no_mmap


