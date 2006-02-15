Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751346AbWBOWnw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346AbWBOWnw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 17:43:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751129AbWBOWnw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 17:43:52 -0500
Received: from [203.2.177.25] ([203.2.177.25]:40746 "EHLO pfeiffer.tusc.com.au")
	by vger.kernel.org with ESMTP id S1750720AbWBOWnu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 17:43:50 -0500
Subject: [PATCH 5/6] x25: Allow 32 bit socket ioctl in 64 bit kernel
From: Shaun Pereira <spereira@tusc.com.au>
Reply-To: spereira@tusc.com.au
To: linux-kenel <linux-kernel@vger.kernel.org>,
       netdev <netdev@vger.kernel.org>,
       "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain
Date: Thu, 16 Feb 2006 09:41:53 +1100
Message-Id: <1140043313.8745.49.camel@spereira05.tusc.com.au>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

32 bit modular socket ioctl emulation for 64 bit kernel

This patch is a re-submit of an earlier patch submitted by Andrew Hendry
that did not make it into the Linux Kernel. Here is some more information 
about this patch. 

This patch allows use of the optional user facility to insert ITU-T 
(http://www.itu.int/ITU-T/) specified DTE facilities in call set-up x25 packets.
This feature is optional; no facilities will be added if the ioctl is not used,
and call setup packet remains the same as before.

If the ioctls provided by the patch are used, then a facility marker will be 
added to the x25 packet header so that the called dte address extension 
facility can be differentiated from other types of facilities (as described 
in the ITU-T X.25 recommendation) that are also allowed in the x25 packet header.

Facility markers are made up of two octets, and may be present in the x25 packet 
headers of call-request, incoming call, call accepted, clear request, 
and clear indication packets. The first of the two octets represents the 
facility code field and is set to zero by this patch. The second octet of the
marker represents the facility parameter field and is set to 0x0F because the
marker will be inserted before ITU-T type DTE facilities. 

Since according to ITU-T X.25 Recommendation X.25(10/96)- 7.1 "All networks
will support the facility markers with a facility parameter field set to
all ones or to 00001111", therefore this patch should work with all x.25
networks.

While there are many ITU-T DTE facilities, this patch implements only the
called and calling address extension, with placeholders in the x25_dte_facilities
structure for the rest of the facilities. 

Testing
This patch was tested using a cisco xot router connected on its serial ports
to an X.25 network, and on its lan ports to a host running an xotd daemon.

It is also possible to test this patch using an xotd daemon and an x25tap patch,
where the xotd daemons work back-to-back without actually using an x.25 network.
See www.fyonne.net for details on how to do this. 

Signed-off-by:Shaun Pereira <spereira@tusc.com.au>

diff -uprN -X dontdiff linux-2.6.16-rc3-vanilla/include/linux/x25.h linux-2.6.16-rc3/include/linux/x25.h
--- linux-2.6.16-rc3-vanilla/include/linux/x25.h	2006-02-15 10:58:02.000000000 +1100
+++ linux-2.6.16-rc3/include/linux/x25.h	2006-02-15 11:15:32.000000000 +1100
@@ -11,6 +11,8 @@
 #ifndef	X25_KERNEL_H
 #define	X25_KERNEL_H
 
+#include <linux/types.h>
+
 #define	SIOCX25GSUBSCRIP	(SIOCPROTOPRIVATE + 0)
 #define	SIOCX25SSUBSCRIP	(SIOCPROTOPRIVATE + 1)
 #define	SIOCX25GFACILITIES	(SIOCPROTOPRIVATE + 2)
@@ -21,6 +23,8 @@
 #define SIOCX25SCUDMATCHLEN	(SIOCPROTOPRIVATE + 7)
 #define SIOCX25CALLACCPTAPPRV   (SIOCPROTOPRIVATE + 8)
 #define SIOCX25SENDCALLACCPT    (SIOCPROTOPRIVATE + 9)
+#define SIOCX25GDTEFACILITIES (SIOCPROTOPRIVATE + 10)
+#define SIOCX25SDTEFACILITIES (SIOCPROTOPRIVATE + 11)
 
 /*
  *	Values for {get,set}sockopt.
@@ -77,6 +81,8 @@ struct x25_subscrip_struct {
 #define	X25_MASK_PACKET_SIZE	0x04
 #define	X25_MASK_WINDOW_SIZE	0x08
 
+#define X25_MASK_CALLING_AE 0x10
+#define X25_MASK_CALLED_AE 0x20
 
 
 /*
@@ -99,6 +105,26 @@ struct x25_facilities {
 };
 
 /*
+* ITU DTE facilities
+* Only the called and calling address
+* extension are currently implemented.
+* The rest are in place to avoid the struct
+* changing size if someone needs them later
+*/
+
+struct x25_dte_facilities {
+	__u16 delay_cumul;
+	__u16 delay_target;
+	__u16 delay_max;
+	__u8 min_throughput;
+	__u8 expedited;
+	__u8 calling_len;
+	__u8 called_len;
+	__u8 calling_ae[20];
+	__u8 called_ae[20];
+};
+
+/*
  *	Call User Data structure.
  */
 struct x25_calluserdata {
diff -uprN -X dontdiff linux-2.6.16-rc3-vanilla/include/net/x25.h linux-2.6.16-rc3/include/net/x25.h
--- linux-2.6.16-rc3-vanilla/include/net/x25.h	2006-02-15 10:58:03.000000000 +1100
+++ linux-2.6.16-rc3/include/net/x25.h	2006-02-15 11:15:32.000000000 +1100
@@ -101,9 +101,16 @@ enum {
 #define	X25_FAC_PACKET_SIZE	0x42
 #define	X25_FAC_WINDOW_SIZE	0x43
 
-#define	X25_MAX_FAC_LEN		20		/* Plenty to spare */
+#define X25_MAX_FAC_LEN 	60
 #define	X25_MAX_CUD_LEN		128
 
+#define X25_FAC_CALLING_AE 	0xCB
+#define X25_FAC_CALLED_AE 	0xC9
+
+#define X25_MARKER 		0x00
+#define X25_DTE_SERVICES 	0x0F
+#define X25_MAX_AE_LEN 		32
+
 /**
  *	struct x25_route - x25 routing entry
  *	@node - entry in x25_list_lock
@@ -148,6 +155,7 @@ struct x25_sock {
 	struct timer_list	timer;
 	struct x25_causediag	causediag;
 	struct x25_facilities	facilities;
+	struct x25_dte_facilities dte_facilities;
 	struct x25_calluserdata	calluserdata;
 	unsigned long 		vc_facil_mask;	/* inc_call facilities mask */
 };
@@ -180,9 +188,9 @@ extern void x25_establish_link(struct x2
 extern void x25_terminate_link(struct x25_neigh *);
 
 /* x25_facilities.c */
-extern int  x25_parse_facilities(struct sk_buff *, struct x25_facilities *, unsigned long *);
-extern int  x25_create_facilities(unsigned char *, struct x25_facilities *, unsigned long);
-extern int  x25_negotiate_facilities(struct sk_buff *, struct sock *, struct x25_facilities *);
+extern int x25_parse_facilities(struct sk_buff *, struct x25_facilities *, struct x25_dte_facilities *, unsigned long *);
+extern int x25_create_facilities(unsigned char *, struct x25_facilities *, struct x25_dte_facilities *, unsigned long);
+extern int x25_negotiate_facilities(struct sk_buff *, struct sock *, struct x25_facilities *, struct x25_dte_facilities *);
 extern void x25_limit_facilities(struct x25_facilities *, struct x25_neigh *);
 
 /* x25_in.c */
diff -uprN -X dontdiff linux-2.6.16-rc3-vanilla/net/x25/af_x25.c linux-2.6.16-rc3/net/x25/af_x25.c
--- linux-2.6.16-rc3-vanilla/net/x25/af_x25.c	2006-02-15 11:15:10.000000000 +1100
+++ linux-2.6.16-rc3/net/x25/af_x25.c	2006-02-15 11:15:32.000000000 +1100
@@ -524,6 +524,13 @@ static int x25_create(struct socket *soc
 	x25->facilities.pacsize_out = X25_DEFAULT_PACKET_SIZE;
 	x25->facilities.throughput  = X25_DEFAULT_THROUGHPUT;
 	x25->facilities.reverse     = X25_DEFAULT_REVERSE;
+ 	x25->dte_facilities.calling_len = 0;
+ 	x25->dte_facilities.called_len = 0;
+ 	memset(x25->dte_facilities.called_ae, '\0',
+ 	sizeof(x25->dte_facilities.called_ae));
+ 	memset(x25->dte_facilities.calling_ae, '\0',
+ 	sizeof(x25->dte_facilities.calling_ae));
+
 	rc = 0;
 out:
 	return rc;
@@ -560,6 +567,7 @@ static struct sock *x25_make_new(struct 
 	x25->t2         = ox25->t2;
 	x25->facilities = ox25->facilities;
 	x25->qbitincl   = ox25->qbitincl;
+	x25->dte_facilities = ox25->dte_facilities;
 	x25->cudmatchlength = ox25->cudmatchlength;
 	x25->accptapprv = ox25->accptapprv;
 
@@ -839,6 +847,7 @@ int x25_rx_call_request(struct sk_buff *
 	struct x25_sock *makex25;
 	struct x25_address source_addr, dest_addr;
 	struct x25_facilities facilities;
+	struct x25_dte_facilities dte_facilities;
 	int len, rc;
 
 	/*
@@ -875,7 +884,8 @@ int x25_rx_call_request(struct sk_buff *
 	/*
 	 *	Try to reach a compromise on the requested facilities.
 	 */
-	if ((len = x25_negotiate_facilities(skb, sk, &facilities)) == -1)
+	 if ((len = x25_negotiate_facilities(skb, sk, &facilities,
+		 &dte_facilities)) == -1)
 		goto out_sock_put;
 
 	/*
@@ -906,9 +916,12 @@ int x25_rx_call_request(struct sk_buff *
 	makex25->source_addr   = source_addr;
 	makex25->neighbour     = nb;
 	makex25->facilities    = facilities;
+	makex25->dte_facilities= dte_facilities;
 	makex25->vc_facil_mask = x25_sk(sk)->vc_facil_mask;
 	/* ensure no reverse facil on accept */
 	makex25->vc_facil_mask &= ~X25_MASK_REVERSE;
+	/* ensure no calling address extension on accept */
+	makex25->vc_facil_mask &= ~X25_MASK_CALLING_AE;
 	makex25->cudmatchlength = x25_sk(sk)->cudmatchlength;
 
 	/* Normally all calls are accepted immediatly */
@@ -1315,6 +1328,34 @@ static int x25_ioctl(struct socket *sock
 			break;
 		}
 
+		case SIOCX25GDTEFACILITIES: {
+ 			rc = copy_to_user(argp, &x25->dte_facilities,
+ 			sizeof(x25->dte_facilities)) ? -EFAULT : 0;
+ 			break;
+ 		}
+
+	 	case SIOCX25SDTEFACILITIES: {
+	 		struct x25_dte_facilities dtefacs;
+	 		rc = -EFAULT;
+		 	if (copy_from_user(&dtefacs, argp, sizeof(dtefacs)))
+			break;
+			rc = -EINVAL;
+			if (sk->sk_state != TCP_LISTEN &&
+			sk->sk_state != TCP_CLOSE)
+			break;
+			if (dtefacs.calling_len > X25_MAX_AE_LEN)
+			break;
+			if (dtefacs.calling_ae == NULL)
+			break;
+			if (dtefacs.called_len > X25_MAX_AE_LEN)
+			break;
+			if (dtefacs.called_ae == NULL)
+			break;
+			x25->dte_facilities = dtefacs;
+			rc = 0;
+			break;
+		}
+
 		case SIOCX25GCALLUSERDATA: {
 			struct x25_calluserdata cud = x25->calluserdata;
 			rc = copy_to_user(argp, &cud,
diff -uprN -X dontdiff linux-2.6.16-rc3-vanilla/net/x25/x25_facilities.c linux-2.6.16-rc3/net/x25/x25_facilities.c
--- linux-2.6.16-rc3-vanilla/net/x25/x25_facilities.c	2006-02-15 10:58:03.000000000 +1100
+++ linux-2.6.16-rc3/net/x25/x25_facilities.c	2006-02-15 11:15:32.000000000 +1100
@@ -28,11 +28,12 @@
 #include <net/x25.h>
 
 /*
- *	Parse a set of facilities into the facilities structure. Unrecognised
+ * Parse a set of facilities into the facilities structures. Unrecognised
  *	facilities are written to the debug log file.
  */
 int x25_parse_facilities(struct sk_buff *skb,
 			 struct x25_facilities *facilities,
+ struct x25_dte_facilities *dte_facs,
 			 unsigned long *vc_fac_mask)
 {
 	unsigned char *p = skb->data;
@@ -40,6 +41,16 @@ int x25_parse_facilities(struct sk_buff 
 
 	*vc_fac_mask = 0;
 
+ /* The kernel knows which facilities were set on an incoming call
+ * but currently this information is not available to userspace.
+ * Here we give userspace who read incoming call facilities
+ * 0 length to indicate it wasn't set.
+ */
+	dte_facs->calling_len = 0;
+	dte_facs->called_len = 0;
+	memset(dte_facs->called_ae, '\0', sizeof(dte_facs->called_ae));
+	memset(dte_facs->calling_ae, '\0', sizeof(dte_facs->calling_ae));
+
 	while (len > 0) {
 		switch (*p & X25_FAC_CLASS_MASK) {
 		case X25_FAC_CLASS_A:
@@ -74,6 +85,10 @@ int x25_parse_facilities(struct sk_buff 
 				facilities->throughput = p[1];
 				*vc_fac_mask |= X25_MASK_THROUGHPUT;
 				break;
+
+			case X25_MARKER:
+				break;
+
 			default:
 				printk(KERN_DEBUG "X.25: unknown facility "
 				       "%02X, value %02X\n",
@@ -112,9 +127,30 @@ int x25_parse_facilities(struct sk_buff 
 			len -= 4;
 			break;
 		case X25_FAC_CLASS_D:
-			printk(KERN_DEBUG "X.25: unknown facility %02X, "
-			       "length %d, values %02X, %02X, %02X, %02X\n",
-			       p[0], p[1], p[2], p[3], p[4], p[5]);
+		switch (*p) {
+	 		case X25_FAC_CALLING_AE:
+	 			if (p[1] > 33)
+				break;
+				dte_facs->calling_len = p[2];
+				memcpy(dte_facs->calling_ae, &p[3], p[1] - 1);
+				*vc_fac_mask |= X25_MASK_CALLING_AE;
+				break;
+
+			case X25_FAC_CALLED_AE:
+				if (p[1] > 33)
+				break;
+				dte_facs->called_len = p[2];
+				memcpy(dte_facs->called_ae, &p[3], p[1] - 1);
+				*vc_fac_mask |= X25_MASK_CALLED_AE;
+				break;
+
+			default:
+				printk(KERN_DEBUG "X.25: unknown facility %02X,"
+				"length %d, values %02X, %02X, %02X, %02X\n",
+				p[0], p[1], p[2], p[3], p[4], p[5]);
+				break;
+			}
+
 			len -= p[1] + 2;
 			p   += p[1] + 2;
 			break;
@@ -129,6 +165,7 @@ int x25_parse_facilities(struct sk_buff 
  */
 int x25_create_facilities(unsigned char *buffer,
 			  struct x25_facilities *facilities,
+ struct x25_dte_facilities *dte_facs,
 			  unsigned long facil_mask)
 {
 	unsigned char *p = buffer + 1;
@@ -168,6 +205,34 @@ int x25_create_facilities(unsigned char 
 		*p++ = facilities->winsize_out ? : facilities->winsize_in;
 	}
 
+	if ((facil_mask & X25_MASK_CALLING_AE) ||
+	    (facil_mask & X25_MASK_CALLED_AE)) {
+		*p++ = X25_MARKER;
+		*p++ = X25_DTE_SERVICES;
+	}
+
+	if (dte_facs->calling_len && (facil_mask & X25_MASK_CALLING_AE)) {
+		unsigned bytecount = (dte_facs->calling_len % 2) ?
+		dte_facs->calling_len / 2 + 1 :
+		dte_facs->calling_len / 2;
+		*p++ = X25_FAC_CALLING_AE;
+		*p++ = 1 + bytecount;
+		*p++ = dte_facs->calling_len;
+		memcpy(p, dte_facs->calling_ae, bytecount);
+		p+=bytecount;
+	}
+
+	if (dte_facs->called_len && (facil_mask & X25_MASK_CALLED_AE)) {
+		unsigned bytecount = (dte_facs->called_len % 2) ?
+		dte_facs->called_len / 2 + 1 :
+		dte_facs->called_len / 2;
+		*p++ = X25_FAC_CALLED_AE;
+		*p++ = 1 + bytecount;
+		*p++ = dte_facs->called_len;
+		memcpy(p, dte_facs->called_ae, bytecount);
+		p+=bytecount;
+	}
+
 	len       = p - buffer;
 	buffer[0] = len - 1;
 
@@ -180,7 +245,8 @@ int x25_create_facilities(unsigned char 
  *	The only real problem is with reverse charging.
  */
 int x25_negotiate_facilities(struct sk_buff *skb, struct sock *sk,
-			     struct x25_facilities *new)
+		struct x25_facilities *new,
+		struct x25_dte_facilities *dte)
 {
 	struct x25_sock *x25 = x25_sk(sk);
 	struct x25_facilities *ours = &x25->facilities;
@@ -190,7 +256,7 @@ int x25_negotiate_facilities(struct sk_b
 	memset(&theirs, 0, sizeof(theirs));
 	memcpy(new, ours, sizeof(*new));
 
-	len = x25_parse_facilities(skb, &theirs, &x25->vc_facil_mask);
+	len = x25_parse_facilities(skb, &theirs, dte, &x25->vc_facil_mask);
 
 	/*
 	 *	They want reverse charging, we won't accept it.
diff -uprN -X dontdiff linux-2.6.16-rc3-vanilla/net/x25/x25_in.c linux-2.6.16-rc3/net/x25/x25_in.c
--- linux-2.6.16-rc3-vanilla/net/x25/x25_in.c	2006-02-15 10:58:03.000000000 +1100
+++ linux-2.6.16-rc3/net/x25/x25_in.c	2006-02-15 11:15:32.000000000 +1100
@@ -106,7 +106,8 @@ static int x25_state1_machine(struct soc
 			skb_pull(skb, x25_addr_ntoa(skb->data, &source_addr, &dest_addr));
 			skb_pull(skb,
 				 x25_parse_facilities(skb, &x25->facilities,
-						      &x25->vc_facil_mask));
+						&x25->dte_facilities,
+						&x25->vc_facil_mask));
 			/*
 			 *	Copy any Call User Data.
 			 */
diff -uprN -X dontdiff linux-2.6.16-rc3-vanilla/net/x25/x25_subr.c linux-2.6.16-rc3/net/x25/x25_subr.c
--- linux-2.6.16-rc3-vanilla/net/x25/x25_subr.c	2006-02-15 10:58:03.000000000 +1100
+++ linux-2.6.16-rc3/net/x25/x25_subr.c	2006-02-15 11:15:32.000000000 +1100
@@ -191,7 +191,8 @@ void x25_write_internal(struct sock *sk,
 			memcpy(dptr, addresses, len);
 			len     = x25_create_facilities(facilities,
 							&x25->facilities,
-					     x25->neighbour->global_facil_mask);
+						 	&x25->dte_facilities,
+					     		x25->neighbour->global_facil_mask);
 			dptr    = skb_put(skb, len);
 			memcpy(dptr, facilities, len);
 			dptr = skb_put(skb, x25->calluserdata.cudlength);
@@ -206,6 +207,7 @@ void x25_write_internal(struct sock *sk,
 			*dptr++ = 0x00;		/* Address lengths */
 			len     = x25_create_facilities(facilities,
 							&x25->facilities,
+							&x25->dte_facilities,
 							x25->vc_facil_mask);
 			dptr    = skb_put(skb, len);
 			memcpy(dptr, facilities, len);

