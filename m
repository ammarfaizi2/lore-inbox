Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261794AbVEaFfn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261794AbVEaFfn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 01:35:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261207AbVEaFfn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 01:35:43 -0400
Received: from [203.2.177.24] ([203.2.177.24]:31761 "EHLO ricci.tusc.com.au")
	by vger.kernel.org with ESMTP id S261853AbVEaFeM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 01:34:12 -0400
Subject: [PATCH 2/2 2.6.12-rc5] x25: Fast select with no restriction on
	response
From: Shaun Pereira <spereira@tusc.com.au>
Reply-To: spereira@tusc.com.au
To: linux-kenel <linux-kernel@vger.kernel.org>
Cc: x25 maintainer <eis@baty.hanse.de>, Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 31 May 2005 15:31:28 +1000
Message-Id: <1117517488.9355.25.camel@spereira05.tusc.com.au>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is a follow up to patch 1 regarding "Selective Sub Address
matching with call user data". It allows use of the Fast-Select-Acceptance 
optional user facility for X.25. This patch just implements fast select with no 
restriction on response (NRR). What this means (according to ITU-T 
Recomendation 10/96 section 6.16) is that if in an incoming call packet, 
the relevant facility bits are set for fast-select-NRR, then the called DTE can
issue a direct response to the incoming packet using a call-accepted packet that
contains call-user-data. This patch allows such a response. 

The called DTE can also respond with a clear-request packet that contains 
call-user-data. However, this feature is currently not implemented by the patch.

How is Fast Select Accetance used?
By default, the system does not allow fast select acceptance (as before).
To enable a response to fast select acceptance,  
After a listen socket in created and bound as follows
	socket(AF_X25, SOCK_SEQPACKET, 0);
	bind(call_soc, (struct sockaddr *)&locl_addr, sizeof(locl_addr));
but before a listen system call is made, the following ioctl should be used.
	ioctl(call_soc,SIOCX25CALLACCPTAPPRV);
Now the listen system call can be made
	listen(call_soc, 4);
After this, an incoming-call packet will be accepted, but no call-accepted 
packet will be sent back until the following system call is made on the socket
that accepts the call
	ioctl(vc_soc,SIOCX25SENDCALLACCPT);
The network (or cisco xot router used for testing here) will allow the 
application server's call-user-data in the call-accepted packet, 
provided the call-request was made with Fast-select NRR.

Signed-off-by: Shaun Pereira <spereira@tusc.com.au>

diff -uprN -X dontdiff linux-2.6.12-rc5-vanilla/include/linux/x25.h linux-2.6.12-rc5/include/linux/x25.h
--- linux-2.6.12-rc5-vanilla/include/linux/x25.h	2005-05-31 13:09:23.000000000 +1000
+++ linux-2.6.12-rc5/include/linux/x25.h	2005-05-31 13:09:53.000000000 +1000
@@ -19,6 +19,8 @@
 #define	SIOCX25SCALLUSERDATA	(SIOCPROTOPRIVATE + 5)
 #define	SIOCX25GCAUSEDIAG	(SIOCPROTOPRIVATE + 6)
 #define SIOCX25SCUDMATCHLEN	(SIOCPROTOPRIVATE + 7)
+#define SIOCX25CALLACCPTAPPRV   (SIOCPROTOPRIVATE + 8)
+#define SIOCX25SENDCALLACCPT    (SIOCPROTOPRIVATE + 9)
 
 /*
  *	Values for {get,set}sockopt.
diff -uprN -X dontdiff linux-2.6.12-rc5-vanilla/include/net/x25.h linux-2.6.12-rc5/include/net/x25.h
--- linux-2.6.12-rc5-vanilla/include/net/x25.h	2005-05-31 13:09:23.000000000 +1000
+++ linux-2.6.12-rc5/include/net/x25.h	2005-05-31 13:09:53.000000000 +1000
@@ -79,6 +79,8 @@ enum {
 #define	X25_DEFAULT_PACKET_SIZE	X25_PS128		/* Default Packet Size */
 #define	X25_DEFAULT_THROUGHPUT	0x0A			/* Deafult Throughput */
 #define	X25_DEFAULT_REVERSE	0x00			/* Default Reverse Charging */
+#define X25_DENY_ACCPT_APPRV   0x01			/* Default value */
+#define X25_ALLOW_ACCPT_APPRV  0x00			/* Control enabled */
 
 #define X25_SMODULUS 		8
 #define	X25_EMODULUS		128
@@ -94,7 +96,7 @@ enum {
 #define	X25_FAC_CLASS_C		0x80
 #define	X25_FAC_CLASS_D		0xC0
 
-#define	X25_FAC_REVERSE		0x01
+#define	X25_FAC_REVERSE		0x01			/* also fast select */
 #define	X25_FAC_THROUGHPUT	0x02
 #define	X25_FAC_PACKET_SIZE	0x42
 #define	X25_FAC_WINDOW_SIZE	0x43
@@ -135,7 +137,7 @@ struct x25_sock {
 	struct x25_address	source_addr, dest_addr;
 	struct x25_neigh	*neighbour;
 	unsigned int		lci, cudmatchlength;
-	unsigned char		state, condition, qbitincl, intflag;
+	unsigned char		state, condition, qbitincl, intflag, accptapprv;
 	unsigned short		vs, vr, va, vl;
 	unsigned long		t2, t21, t22, t23;
 	unsigned short		fraglen;
diff -uprN -X dontdiff linux-2.6.12-rc5-vanilla/net/x25/af_x25.c linux-2.6.12-rc5/net/x25/af_x25.c
--- linux-2.6.12-rc5-vanilla/net/x25/af_x25.c	2005-05-31 13:09:23.000000000 +1000
+++ linux-2.6.12-rc5/net/x25/af_x25.c	2005-05-31 13:09:53.000000000 +1000
@@ -31,6 +31,8 @@
  *					x25_proc.c, using seq_file
  *	2005-04-02	Shaun Pereira	Selective sub address matching
  *					with call user data
+ *	2005-04-15	Shaun Pereira	Fast select with no restriction on
+ *					response
  */
 
 #include <linux/config.h>
@@ -502,6 +504,8 @@ static int x25_create(struct socket *soc
 	x25->t2    = sysctl_x25_ack_holdback_timeout;
 	x25->state = X25_STATE_0;
 	x25->cudmatchlength = 0;
+	x25->accptapprv = X25_DENY_ACCPT_APPRV;		/* normally no cud  */
+							/* on call accept   */
 
 	x25->facilities.winsize_in  = X25_DEFAULT_WINDOW_SIZE;
 	x25->facilities.winsize_out = X25_DEFAULT_WINDOW_SIZE;
@@ -551,6 +555,7 @@ static struct sock *x25_make_new(struct 
 	x25->facilities = ox25->facilities;
 	x25->qbitincl   = ox25->qbitincl;
 	x25->cudmatchlength = ox25->cudmatchlength;
+	x25->accptapprv = ox25->accptapprv;
 
 	x25_init_timers(sk);
 out:
@@ -900,9 +905,11 @@ int x25_rx_call_request(struct sk_buff *
 	makex25->vc_facil_mask &= ~X25_MASK_REVERSE;
 	makex25->cudmatchlength = x25_sk(sk)->cudmatchlength;
 
-	x25_write_internal(make, X25_CALL_ACCEPTED);
-
-	makex25->state = X25_STATE_3;
+	/* Normally all calls are accepted immediatly */
+	if(makex25->accptapprv & X25_DENY_ACCPT_APPRV) {
+		x25_write_internal(make, X25_CALL_ACCEPTED);
+		makex25->state = X25_STATE_3;
+	}
 
 	/*
 	 *	Incoming Call User Data.
@@ -1294,7 +1301,8 @@ static int x25_ioctl(struct socket *sock
 			if (facilities.throughput < 0x03 ||
 			    facilities.throughput > 0xDD)
 				break;
-			if (facilities.reverse && facilities.reverse != 1)
+			if (facilities.reverse &&
+				(facilities.reverse | 0x81)!= 0x81)
 				break;
 			x25->facilities = facilities;
 			rc = 0;
@@ -1348,6 +1356,27 @@ static int x25_ioctl(struct socket *sock
 			break;
 		}
 
+		case SIOCX25CALLACCPTAPPRV: {
+			rc = -EINVAL;
+			if (sk->sk_state != TCP_CLOSE)
+				break;
+			x25->accptapprv = X25_ALLOW_ACCPT_APPRV;
+			rc = 0;
+			break;
+		}
+
+		case SIOCX25SENDCALLACCPT:  {
+			rc = -EINVAL;
+			if (sk->sk_state != TCP_ESTABLISHED)
+				break;
+			if (x25->accptapprv)	/* must call accptapprv above */
+				break;
+			x25_write_internal(sk, X25_CALL_ACCEPTED);
+			x25->state = X25_STATE_3;
+			rc = 0;
+			break;
+		}
+
  		default:
 			rc = dev_ioctl(cmd, argp);
 			break;
diff -uprN -X dontdiff linux-2.6.12-rc5-vanilla/net/x25/x25_facilities.c linux-2.6.12-rc5/net/x25/x25_facilities.c
--- linux-2.6.12-rc5-vanilla/net/x25/x25_facilities.c	2005-05-25 13:31:20.000000000 +1000
+++ linux-2.6.12-rc5/net/x25/x25_facilities.c	2005-05-31 13:09:53.000000000 +1000
@@ -17,6 +17,8 @@
  *	X.25 001	Split from x25_subr.c
  *	mar/20/00	Daniela Squassoni Disabling/enabling of facilities 
  *					  negotiation.
+ *	apr/14/05	Shaun Pereira - Allow fast select with no restriction
+ *					on response.
  */
 
 #include <linux/kernel.h>
@@ -43,9 +45,31 @@ int x25_parse_facilities(struct sk_buff 
 		case X25_FAC_CLASS_A:
 			switch (*p) {
 			case X25_FAC_REVERSE:
-				facilities->reverse = p[1] & 0x01;
-				*vc_fac_mask |= X25_MASK_REVERSE;
-				break;
+				if((p[1] & 0x81) == 0x81) {
+					facilities->reverse = p[1] & 0x81;
+					*vc_fac_mask |= X25_MASK_REVERSE;
+					break;
+				}
+
+				if((p[1] & 0x01) == 0x01) {
+					facilities->reverse = p[1] & 0x01;
+					*vc_fac_mask |= X25_MASK_REVERSE;
+					break;
+				}
+
+				if((p[1] & 0x80) == 0x80) {
+					facilities->reverse = p[1] & 0x80;
+					*vc_fac_mask |= X25_MASK_REVERSE;
+					break;
+				}
+
+				if(p[1] == 0x00) {
+					facilities->reverse
+						= X25_DEFAULT_REVERSE;
+					*vc_fac_mask |= X25_MASK_REVERSE;
+					break;
+				}
+
 			case X25_FAC_THROUGHPUT:
 				facilities->throughput = p[1];
 				*vc_fac_mask |= X25_MASK_THROUGHPUT;
@@ -122,7 +146,7 @@ int x25_create_facilities(unsigned char 
 
 	if (facilities->reverse && (facil_mask & X25_MASK_REVERSE)) {
 		*p++ = X25_FAC_REVERSE;
-		*p++ = !!facilities->reverse;
+		*p++ = facilities->reverse;
 	}
 
 	if (facilities->throughput && (facil_mask & X25_MASK_THROUGHPUT)) {
@@ -171,7 +195,7 @@ int x25_negotiate_facilities(struct sk_b
 	/*
 	 *	They want reverse charging, we won't accept it.
 	 */
-	if (theirs.reverse && ours->reverse) {
+	if ((theirs.reverse & 0x01 ) && (ours->reverse & 0x01)) {
 		SOCK_DEBUG(sk, "X.25: rejecting reverse charging request");
 		return -1;
 	}
diff -uprN -X dontdiff linux-2.6.12-rc5-vanilla/net/x25/x25_subr.c linux-2.6.12-rc5/net/x25/x25_subr.c
--- linux-2.6.12-rc5-vanilla/net/x25/x25_subr.c	2005-05-31 13:09:23.000000000 +1000
+++ linux-2.6.12-rc5/net/x25/x25_subr.c	2005-05-31 13:09:53.000000000 +1000
@@ -19,6 +19,8 @@
  *	mar/20/00	Daniela Squassoni Disabling/enabling of facilities
  *					  negotiation.
  *	jun/24/01	Arnaldo C. Melo	  use skb_queue_purge, cleanups
+ *	apr/04/15	Shaun Pereira		Fast select with no
+ *						restriction on response.
  */
 
 #include <linux/kernel.h>
@@ -127,8 +129,12 @@ void x25_write_internal(struct sock *sk,
 			len += 1 + X25_ADDR_LEN + X25_MAX_FAC_LEN +
 			       X25_MAX_CUD_LEN;
 			break;
-		case X25_CALL_ACCEPTED:
-			len += 1 + X25_MAX_FAC_LEN + X25_MAX_CUD_LEN;
+		case X25_CALL_ACCEPTED: /* fast sel with no restr on resp */
+			if(x25->facilities.reverse & 0x80) {
+				len += 1 + X25_MAX_FAC_LEN + X25_MAX_CUD_LEN;
+			} else {
+				len += 1 + X25_MAX_FAC_LEN;
+			}
 			break;
 		case X25_CLEAR_REQUEST:
 		case X25_RESET_REQUEST:
@@ -203,9 +209,16 @@ void x25_write_internal(struct sock *sk,
 							x25->vc_facil_mask);
 			dptr    = skb_put(skb, len);
 			memcpy(dptr, facilities, len);
-			dptr = skb_put(skb, x25->calluserdata.cudlength);
-			memcpy(dptr, x25->calluserdata.cuddata,
-			       x25->calluserdata.cudlength);
+
+			/* fast select with no restriction on response
+				allows call user data. Userland must
+				ensure it is ours and not theirs */
+			if(x25->facilities.reverse & 0x80) {
+				dptr = skb_put(skb,
+					x25->calluserdata.cudlength);
+				memcpy(dptr, x25->calluserdata.cuddata,
+				       x25->calluserdata.cudlength);
+			}
 			x25->calluserdata.cudlength = 0;
 			break;
 



