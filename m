Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261416AbVDNCCw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261416AbVDNCCw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 22:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261411AbVDNCCw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 22:02:52 -0400
Received: from [203.2.177.22] ([203.2.177.22]:27919 "EHLO pinot.tusc.com.au")
	by vger.kernel.org with ESMTP id S261399AbVDNCCJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 22:02:09 -0400
Subject: [PATCH 1/2 - 2.6.11.7] x25 : Selective subaddress matching with
	call user data
From: Shaun Pereira <spereira@tusc.com.au>
Reply-To: spereira@tusc.com.au
To: linux-x25@vger.kernel.org, eis@baty.hanse.de
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: TUSC
Date: Thu, 14 Apr 2005 12:01:16 +1000
Message-Id: <1113444076.9061.64.camel@spereira05.tusc.com.au>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Apr 2005 02:01:17.0906 (UTC) FILETIME=[D8A71320:01C54095]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
This is the first (independent of the second) patch of two that I am
working on with x25 on linux (tested with xot on a cisco router).
Details are as follows.

Current state of module:
A server using the current implementation (2.6.11.7) of the x25 module will accept 
a call request/ incoming call packet at the listening x.25 address, from all callers
to that address, as long as NO call user data is present in the packet header.

If the server needs to choose to accept a particular call request/ incoming call 
packet arriving at its listening x25 address, then the kernel has to allow a match of 
call user data present in the call request packet with its own. This is required
when multiple servers listen at the same x25 address and device interface. The
kernel currently matches ALL call user data, if present.

Current Changes:
This patch is a follow up to the patch submitted previously by Andrew Hendry, and
allows the user to selectively control the number of octets of call user data in the 
call request packet, that the kernel will match. By default no call user data 
is matched, even if call user data is present. To allow call user data matching, 
a  cudmatchlength > 0 has to be passed into the kernel after which the passed 
number of octets will be matched. Otherwise the kernel behavior is exactly as 
the original implementation.

This patch also ensures that as is normally the case, no call user data will
be present in the Call accepted / call connected packet sent back to the caller. 

Future Changes on next patch:
There are cases however when call user data may be present in the call accepted
packet. According to the X.25 recommendation (ITU-T 10/96) section 5.2.3.2 
call user data may be present in the call accepted packet provided the fast select
facility is used. My next patch will include this fast select utility and the ability
to send up to 128 octets call user data in the call accepted packet provided the
fast select facility is used. I am currently testing this, again with xot on linux 
and cisco. 
Regards
Shaun

Signed-off-by: Shaun Pereira <spereira@tusc.com.au>

diff -uprN -X dontdiff linux-2.6.11.7-vanilla/include/linux/x25.h linux-2.6.11.7/include/linux/x25.h
--- linux-2.6.11.7-vanilla/include/linux/x25.h	2005-04-08 04:58:01.000000000 +1000
+++ linux-2.6.11.7/include/linux/x25.h	2005-04-14 09:07:43.000000000 +1000
@@ -4,6 +4,8 @@
  * 	History
  *	mar/20/00	Daniela Squassoni Disabling/enabling of facilities 
  *					  negotiation.
+ *	apr/02/05	Shaun Pereira Selective sub address matching with
+ *					call user data
  */
 
 #ifndef	X25_KERNEL_H
@@ -16,6 +18,7 @@
 #define	SIOCX25GCALLUSERDATA	(SIOCPROTOPRIVATE + 4)
 #define	SIOCX25SCALLUSERDATA	(SIOCPROTOPRIVATE + 5)
 #define	SIOCX25GCAUSEDIAG	(SIOCPROTOPRIVATE + 6)
+#define SIOCX25SCUDMATCHLEN	(SIOCPROTOPRIVATE + 7)
 
 /*
  *	Values for {get,set}sockopt.
@@ -109,4 +112,11 @@ struct x25_causediag {
 	unsigned char	diagnostic;
 };
 
+/*
+ *	Further optional call user data match length selection
+ */
+struct x25_subaddr {
+	unsigned int cudmatchlength;
+};
+
 #endif
diff -uprN -X dontdiff linux-2.6.11.7-vanilla/include/net/x25.h linux-2.6.11.7/include/net/x25.h
--- linux-2.6.11.7-vanilla/include/net/x25.h	2005-04-08 04:57:45.000000000 +1000
+++ linux-2.6.11.7/include/net/x25.h	2005-04-14 09:07:43.000000000 +1000
@@ -132,7 +132,7 @@ struct x25_neigh {
 struct x25_opt {
 	struct x25_address	source_addr, dest_addr;
 	struct x25_neigh	*neighbour;
-	unsigned int		lci;
+	unsigned int		lci, cudmatchlength;
 	unsigned char		state, condition, qbitincl, intflag;
 	unsigned short		vs, vr, va, vl;
 	unsigned long		t2, t21, t22, t23;
@@ -238,7 +238,6 @@ extern int  x25_validate_nr(struct sock 
 extern void x25_write_internal(struct sock *, int);
 extern int  x25_decode(struct sock *, struct sk_buff *, int *, int *, int *, int *, int *);
 extern void x25_disconnect(struct sock *, int, unsigned char, unsigned char);
-extern int x25_check_calluserdata(struct x25_calluserdata *,struct x25_calluserdata *);
 
 /* x25_timer.c */
 extern void x25_start_heartbeat(struct sock *);
diff -uprN -X dontdiff linux-2.6.11.7-vanilla/net/x25/af_x25.c linux-2.6.11.7/net/x25/af_x25.c
--- linux-2.6.11.7-vanilla/net/x25/af_x25.c	2005-04-08 04:58:30.000000000 +1000
+++ linux-2.6.11.7/net/x25/af_x25.c	2005-04-14 09:18:36.000000000 +1000
@@ -29,6 +29,7 @@
  *	2000-11-14	Henner Eisen    Closing datalink from NETDEV_GOING_DOWN
  *	2002-10-06	Arnaldo C. Melo Get rid of cli/sti, move proc stuff to
  *					x25_proc.c, using seq_file
+ *	2005-04-02	Shaun Pereira	Selective sub address matching with call user data
  */
 
 #include <linux/config.h>
@@ -219,7 +220,8 @@ static void x25_insert_socket(struct soc
  *	Note: if a listening socket has cud set it must only get calls
  *	with matching cud.
  */
-static struct sock *x25_find_listener(struct x25_address *addr, struct x25_calluserdata *calluserdata)
+static struct sock *x25_find_listener(struct x25_address *addr,
+				      struct sk_buff *skb)
 {
 	struct sock *s;
 	struct sock *next_best;
@@ -230,22 +232,23 @@ static struct sock *x25_find_listener(st
 
 	sk_for_each(s, node, &x25_list)
 		if ((!strcmp(addr->x25_addr,
-			     x25_sk(s)->source_addr.x25_addr) ||
-		     !strcmp(addr->x25_addr,
-			     null_x25_address.x25_addr)) &&
-		     s->sk_state == TCP_LISTEN) {
-
+			x25_sk(s)->source_addr.x25_addr) ||
+				!strcmp(addr->x25_addr,
+					null_x25_address.x25_addr)) &&
+					s->sk_state == TCP_LISTEN) {
 			/*
 			 * Found a listening socket, now check the incoming
 			 * call user data vs this sockets call user data
 			 */
-			if (x25_check_calluserdata(&x25_sk(s)->calluserdata, calluserdata)) {
-				sock_hold(s);
-				goto found;
-			}
-			if (x25_sk(s)->calluserdata.cudlength == 0) {
+			 if(skb->len > 0 && x25_sk(s)->cudmatchlength > 0) {
+			 	if((memcmp(x25_sk(s)->calluserdata.cuddata,
+			 		skb->data,
+					x25_sk(s)->cudmatchlength)) == 0) {
+					sock_hold(s);
+					goto found;
+				 }
+			} else
 				next_best = s;
-			}
 		}
 	if (next_best) {
 		s = next_best;
@@ -504,6 +507,7 @@ static int x25_create(struct socket *soc
 	x25->t23   = sysctl_x25_clear_request_timeout;
 	x25->t2    = sysctl_x25_ack_holdback_timeout;
 	x25->state = X25_STATE_0;
+	x25->cudmatchlength = 0;
 
 	x25->facilities.winsize_in  = X25_DEFAULT_WINDOW_SIZE;
 	x25->facilities.winsize_out = X25_DEFAULT_WINDOW_SIZE;
@@ -548,6 +552,7 @@ static struct sock *x25_make_new(struct 
 	x25->t2         = ox25->t2;
 	x25->facilities = ox25->facilities;
 	x25->qbitincl   = ox25->qbitincl;
+	x25->cudmatchlength = ox25->cudmatchlength;
 
 	x25_init_timers(sk);
 out:
@@ -825,7 +830,6 @@ int x25_rx_call_request(struct sk_buff *
 	struct x25_opt *makex25;
 	struct x25_address source_addr, dest_addr;
 	struct x25_facilities facilities;
-	struct x25_calluserdata calluserdata;
 	int len, rc;
 
 	/*
@@ -848,19 +852,10 @@ int x25_rx_call_request(struct sk_buff *
 	skb_pull(skb,len);
 
 	/*
-	 *	Incoming Call User Data.
-	 */
-	if (skb->len >= 0) {
-		memcpy(calluserdata.cuddata, skb->data, skb->len);
-		calluserdata.cudlength = skb->len;
-	}
-
-	skb_push(skb,len);
-
-	/*
 	 *	Find a listener for the particular address/cud pair.
 	 */
-	sk = x25_find_listener(&source_addr,&calluserdata);
+	sk = x25_find_listener(&source_addr,skb);
+	skb_push(skb,len);
 
 	/*
 	 *	We can't accept the Call Request.
@@ -903,12 +898,22 @@ int x25_rx_call_request(struct sk_buff *
 	makex25->neighbour     = nb;
 	makex25->facilities    = facilities;
 	makex25->vc_facil_mask = x25_sk(sk)->vc_facil_mask;
-	makex25->calluserdata  = calluserdata;
+	/* ensure no reverse facil on accept */
+	makex25->vc_facil_mask &= ~X25_MASK_REVERSE;
+	makex25->cudmatchlength = x25_sk(sk)->cudmatchlength;
 
 	x25_write_internal(make, X25_CALL_ACCEPTED);
 
 	makex25->state = X25_STATE_3;
 
+	/*
+	 *	Incoming Call User Data.
+	 */
+	if (skb->len >= 0) {
+		memcpy(makex25->calluserdata.cuddata, skb->data, skb->len);
+		makex25->calluserdata.cudlength = skb->len;
+	}
+
 	sk->sk_ack_backlog++;
 
 	x25_insert_socket(make);
@@ -1328,6 +1333,23 @@ static int x25_ioctl(struct socket *sock
 			break;
 		}
 
+		case SIOCX25SCUDMATCHLEN: {
+			struct x25_subaddr sub_addr;
+			rc = -EINVAL;
+			if(sk->sk_state != TCP_CLOSE)
+				break;
+			rc = -EFAULT;
+			if (copy_from_user(&sub_addr, argp,
+					sizeof(&sub_addr)))
+				break;
+		 	rc = -EINVAL;
+			if(sub_addr.cudmatchlength > X25_MAX_CUD_LEN)
+				break;
+			x25->cudmatchlength = sub_addr.cudmatchlength;
+			rc = 0;
+			break;
+		}
+
  		default:
 			rc = dev_ioctl(cmd, argp);
 			break;
diff -uprN -X dontdiff linux-2.6.11.7-vanilla/net/x25/x25_subr.c linux-2.6.11.7/net/x25/x25_subr.c
--- linux-2.6.11.7-vanilla/net/x25/x25_subr.c	2005-04-08 04:57:26.000000000 +1000
+++ linux-2.6.11.7/net/x25/x25_subr.c	2005-04-14 09:07:43.000000000 +1000
@@ -354,21 +354,3 @@ void x25_check_rbuf(struct sock *sk)
 	}
 }
 
-/*
- * Compare 2 calluserdata structures, used to find correct listening sockets
- * when call user data is used.
- */
-int x25_check_calluserdata(struct x25_calluserdata *ours, struct x25_calluserdata *theirs)
-{
-	int i;
-	if (ours->cudlength != theirs->cudlength)
-		return 0;
-
-	for (i=0;i<ours->cudlength;i++) {
-		if (ours->cuddata[i] != theirs->cuddata[i]) {
-			return 0;
-		}
-	}
-	return 1;
-}
-






