Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261826AbVEaFer@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261826AbVEaFer (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 01:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261794AbVEaFer
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 01:34:47 -0400
Received: from [203.2.177.24] ([203.2.177.24]:31505 "EHLO ricci.tusc.com.au")
	by vger.kernel.org with ESMTP id S261836AbVEaFeM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 01:34:12 -0400
Subject: [PATCH 1/2 2.6.12-rc5] x25: : Selective sub-address matching with
	call user data
From: Shaun Pereira <spereira@tusc.com.au>
Reply-To: spereira@tusc.com.au
To: linux-kenel <linux-kernel@vger.kernel.org>
Cc: x25 maintainer <eis@baty.hanse.de>, Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 31 May 2005 15:31:24 +1000
Message-Id: <1117517484.9355.24.camel@spereira05.tusc.com.au>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew
Thanks very much for your prompt reply. I have rebuilt 
the x25 module patches to apply to linux-2.6.12-rc5 
and tested as advised.

Unfortunately we have never heard from Henner Eisen with regard
to x25 module patch submissions since we began working on this part
of the linux kernel. We have one more patch to submit after these
and are currently testing in a telco environment. 
  
Here is the post, thanks once again for your help.
Regards
Shaun


Changlog

This is the first (independent of the second) patch of two that I am
working on with x25 on linux (tested with xot on a cisco router).
Details are as follows.

Current state of module:
A server using the current implementation (2.6.11.7) of the x25 module will
accept a call request/ incoming call packet at the listening x.25 address, 
from all callers to that address, as long as NO call user data is present 
in the packet header.

If the server needs to choose to accept a particular call request/ incoming
call packet arriving at its listening x25 address, then the kernel has to 
allow a match of call user data present in the call request packet with its 
own. This is required when multiple servers listen at the same x25 address 
and device interface. The kernel currently matches ALL call user data, 
if present.

Current Changes:
This patch is a follow up to the patch submitted previously by Andrew Hendry, 
and allows the user to selectively control the number of octets of call user 
data in the call request packet, that the kernel will match. By default no call 
user data is matched, even if call user data is present. To allow call user 
data matching, a  cudmatchlength > 0 has to be passed into the kernel after 
which the passed number of octets will be matched. Otherwise the kernel 
behavior is exactly as the original implementation.

This patch also ensures that as is normally the case, no call user data will
be present in the Call accepted / call connected packet sent back to the caller 

Future Changes on next patch:
There are cases however when call user data may be present in the call accepted
packet. According to the X.25 recommendation (ITU-T 10/96) section 5.2.3.2 
call user data may be present in the call accepted packet provided the fast 
select facility is used. My next patch will include this fast select utility 
and the ability to send up to 128 octets call user data in the call accepted 
packet provided the fast select facility is used. I am currently testing this,
again with xot on linux and cisco. 

Signed-off-by: Shaun Pereira <spereira@tusc.com.au>

diff -uprN -X dontdiff linux-2.6.12-rc5-vanilla/include/linux/x25.h linux-2.6.12-rc5/include/linux/x25.h
--- linux-2.6.12-rc5-vanilla/include/linux/x25.h	2005-05-25 13:31:20.000000000 +1000
+++ linux-2.6.12-rc5/include/linux/x25.h	2005-05-31 13:03:23.000000000 +1000
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
diff -uprN -X dontdiff linux-2.6.12-rc5-vanilla/include/net/x25.h linux-2.6.12-rc5/include/net/x25.h
--- linux-2.6.12-rc5-vanilla/include/net/x25.h	2005-05-25 13:31:20.000000000 +1000
+++ linux-2.6.12-rc5/include/net/x25.h	2005-05-31 13:03:23.000000000 +1000
@@ -134,7 +134,7 @@ struct x25_sock {
 	struct sock		sk;
 	struct x25_address	source_addr, dest_addr;
 	struct x25_neigh	*neighbour;
-	unsigned int		lci;
+	unsigned int		lci, cudmatchlength;
 	unsigned char		state, condition, qbitincl, intflag;
 	unsigned short		vs, vr, va, vl;
 	unsigned long		t2, t21, t22, t23;
@@ -242,7 +242,6 @@ extern int  x25_validate_nr(struct sock 
 extern void x25_write_internal(struct sock *, int);
 extern int  x25_decode(struct sock *, struct sk_buff *, int *, int *, int *, int *, int *);
 extern void x25_disconnect(struct sock *, int, unsigned char, unsigned char);
-extern int x25_check_calluserdata(struct x25_calluserdata *,struct x25_calluserdata *);
 
 /* x25_timer.c */
 extern void x25_start_heartbeat(struct sock *);
diff -uprN -X dontdiff linux-2.6.12-rc5-vanilla/net/x25/af_x25.c linux-2.6.12-rc5/net/x25/af_x25.c
--- linux-2.6.12-rc5-vanilla/net/x25/af_x25.c	2005-05-25 13:31:20.000000000 +1000
+++ linux-2.6.12-rc5/net/x25/af_x25.c	2005-05-31 13:03:23.000000000 +1000
@@ -29,6 +29,8 @@
  *	2000-11-14	Henner Eisen    Closing datalink from NETDEV_GOING_DOWN
  *	2002-10-06	Arnaldo C. Melo Get rid of cli/sti, move proc stuff to
  *					x25_proc.c, using seq_file
+ *	2005-04-02	Shaun Pereira	Selective sub address matching
+ *					with call user data
  */
 
 #include <linux/config.h>
@@ -219,7 +221,8 @@ static void x25_insert_socket(struct soc
  *	Note: if a listening socket has cud set it must only get calls
  *	with matching cud.
  */
-static struct sock *x25_find_listener(struct x25_address *addr, struct x25_calluserdata *calluserdata)
+static struct sock *x25_find_listener(struct x25_address *addr,
+					struct sk_buff *skb)
 {
 	struct sock *s;
 	struct sock *next_best;
@@ -230,22 +233,23 @@ static struct sock *x25_find_listener(st
 
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
+			if(skb->len > 0 && x25_sk(s)->cudmatchlength > 0) {
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
@@ -497,6 +501,7 @@ static int x25_create(struct socket *soc
 	x25->t23   = sysctl_x25_clear_request_timeout;
 	x25->t2    = sysctl_x25_ack_holdback_timeout;
 	x25->state = X25_STATE_0;
+	x25->cudmatchlength = 0;
 
 	x25->facilities.winsize_in  = X25_DEFAULT_WINDOW_SIZE;
 	x25->facilities.winsize_out = X25_DEFAULT_WINDOW_SIZE;
@@ -545,6 +550,7 @@ static struct sock *x25_make_new(struct 
 	x25->t2         = ox25->t2;
 	x25->facilities = ox25->facilities;
 	x25->qbitincl   = ox25->qbitincl;
+	x25->cudmatchlength = ox25->cudmatchlength;
 
 	x25_init_timers(sk);
 out:
@@ -822,7 +828,6 @@ int x25_rx_call_request(struct sk_buff *
 	struct x25_sock *makex25;
 	struct x25_address source_addr, dest_addr;
 	struct x25_facilities facilities;
-	struct x25_calluserdata calluserdata;
 	int len, rc;
 
 	/*
@@ -845,19 +850,10 @@ int x25_rx_call_request(struct sk_buff *
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
@@ -900,12 +896,22 @@ int x25_rx_call_request(struct sk_buff *
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
@@ -1325,6 +1331,23 @@ static int x25_ioctl(struct socket *sock
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
diff -uprN -X dontdiff linux-2.6.12-rc5-vanilla/net/x25/x25_subr.c linux-2.6.12-rc5/net/x25/x25_subr.c
--- linux-2.6.12-rc5-vanilla/net/x25/x25_subr.c	2005-05-25 13:31:20.000000000 +1000
+++ linux-2.6.12-rc5/net/x25/x25_subr.c	2005-05-31 13:03:23.000000000 +1000
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


