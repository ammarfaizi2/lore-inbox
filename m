Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263011AbTDILue (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 07:50:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263012AbTDILue (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 07:50:34 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:9994 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S263011AbTDILua (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Apr 2003 07:50:30 -0400
Date: Wed, 9 Apr 2003 22:00:01 +1000
To: davem@redhat.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix arcnet/packet socket oops
Message-ID: <20030409120001.GA24477@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The arcnet build_header functions dereference skb->dev which is not
filled in by the packet socket sendmsg code.  This patch makes them
use the supplied dev argument instead.
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--huq684BweRXVnRxX
Content-Type: text/x-pascal; charset=us-ascii
Content-Disposition: attachment; filename=p

Index: include/linux/arcdevice.h
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.4/include/linux/arcdevice.h,v
retrieving revision 1.1.1.4
diff -u -r1.1.1.4 arcdevice.h
--- include/linux/arcdevice.h	17 Sep 2000 16:45:05 -0000	1.1.1.4
+++ include/linux/arcdevice.h	8 Apr 2003 11:38:07 -0000
@@ -190,8 +190,8 @@
 
 	void (*rx) (struct net_device * dev, int bufnum,
 		    struct archdr * pkthdr, int length);
-	int (*build_header) (struct sk_buff * skb, unsigned short ethproto,
-			     uint8_t daddr);
+	int (*build_header) (struct sk_buff * skb, struct net_device *dev,
+			     unsigned short ethproto, uint8_t daddr);
 
 	/* these functions return '1' if the skb can now be freed */
 	int (*prepare_tx) (struct net_device * dev, struct archdr * pkt, int length,
Index: drivers/net/arcnet/arc-rawmode.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.4/drivers/net/arcnet/arc-rawmode.c,v
retrieving revision 1.1.1.3
diff -u -r1.1.1.3 arc-rawmode.c
--- drivers/net/arcnet/arc-rawmode.c	3 Aug 2002 00:39:44 -0000	1.1.1.3
+++ drivers/net/arcnet/arc-rawmode.c	8 Apr 2003 11:38:52 -0000
@@ -37,8 +37,8 @@
 
 static void rx(struct net_device *dev, int bufnum,
 	       struct archdr *pkthdr, int length);
-static int build_header(struct sk_buff *skb, unsigned short type,
-			uint8_t daddr);
+static int build_header(struct sk_buff *skb, struct net_device *dev,
+			unsigned short type, uint8_t daddr);
 static int prepare_tx(struct net_device *dev, struct archdr *pkt, int length,
 		      int bufnum);
 
@@ -137,10 +137,9 @@
  * Create the ARCnet hard/soft headers for raw mode.
  * There aren't any soft headers in raw mode - not even the protocol id.
  */
-static int build_header(struct sk_buff *skb, unsigned short type,
-			uint8_t daddr)
+static int build_header(struct sk_buff *skb, struct net_device *dev,
+			unsigned short type, uint8_t daddr)
 {
-	struct net_device *dev = skb->dev;
 	int hdr_size = ARC_HDR_SIZE;
 	struct archdr *pkt = (struct archdr *) skb_push(skb, hdr_size);
 
Index: drivers/net/arcnet/arcnet.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.4/drivers/net/arcnet/arcnet.c,v
retrieving revision 1.1.1.9
diff -u -r1.1.1.9 arcnet.c
--- drivers/net/arcnet/arcnet.c	28 Nov 2002 23:53:13 -0000	1.1.1.9
+++ drivers/net/arcnet/arcnet.c	8 Apr 2003 11:37:35 -0000
@@ -57,8 +57,8 @@
 /* "do nothing" functions for protocol drivers */
 static void null_rx(struct net_device *dev, int bufnum,
 		    struct archdr *pkthdr, int length);
-static int null_build_header(struct sk_buff *skb, unsigned short type,
-			     uint8_t daddr);
+static int null_build_header(struct sk_buff *skb, struct net_device *dev,
+			     unsigned short type, uint8_t daddr);
 static int null_prepare_tx(struct net_device *dev, struct archdr *pkt,
 			   int length, int bufnum);
 
@@ -512,7 +512,7 @@
 		       arc_bcast_proto->suffix);
 		proto = arc_bcast_proto;
 	}
-	return proto->build_header(skb, type, _daddr);
+	return proto->build_header(skb, dev, type, _daddr);
 }
 
 
@@ -528,6 +528,7 @@
 	int status = 0;		/* default is failure */
 	unsigned short type;
 	uint8_t daddr=0;
+	struct ArcProto *proto;
 
 	if (skb->nh.raw - skb->mac.raw != 2) {
 		BUGMSG(D_NORMAL,
@@ -556,7 +557,8 @@
 		return 0;
 
 	/* add the _real_ header this time! */
-	arc_proto_map[lp->default_proto[daddr]]->build_header(skb, type, daddr);
+	proto = arc_proto_map[lp->default_proto[daddr]];
+	proto->build_header(skb, dev, type, daddr);
 
 	return 1;		/* success */
 }
@@ -986,10 +988,9 @@
 }
 
 
-static int null_build_header(struct sk_buff *skb, unsigned short type,
-			     uint8_t daddr)
+static int null_build_header(struct sk_buff *skb, struct net_device *dev,
+			     unsigned short type, uint8_t daddr)
 {
-	struct net_device *dev = skb->dev;
 	struct arcnet_local *lp = (struct arcnet_local *) dev->priv;
 
 	BUGMSG(D_PROTO,
Index: drivers/net/arcnet/rfc1051.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.4/drivers/net/arcnet/rfc1051.c,v
retrieving revision 1.1.1.3
diff -u -r1.1.1.3 rfc1051.c
--- drivers/net/arcnet/rfc1051.c	3 Aug 2002 00:39:44 -0000	1.1.1.3
+++ drivers/net/arcnet/rfc1051.c	8 Apr 2003 11:39:17 -0000
@@ -37,8 +37,8 @@
 static unsigned short type_trans(struct sk_buff *skb, struct net_device *dev);
 static void rx(struct net_device *dev, int bufnum,
 	       struct archdr *pkthdr, int length);
-static int build_header(struct sk_buff *skb, unsigned short type,
-			uint8_t daddr);
+static int build_header(struct sk_buff *skb, struct net_device *dev,
+			unsigned short type, uint8_t daddr);
 static int prepare_tx(struct net_device *dev, struct archdr *pkt, int length,
 		      int bufnum);
 
@@ -170,10 +170,9 @@
 /*
  * Create the ARCnet hard/soft headers for RFC1051.
  */
-static int build_header(struct sk_buff *skb, unsigned short type,
-			uint8_t daddr)
+static int build_header(struct sk_buff *skb, struct net_device *dev,
+			unsigned short type, uint8_t daddr)
 {
-	struct net_device *dev = skb->dev;
 	struct arcnet_local *lp = (struct arcnet_local *) dev->priv;
 	int hdr_size = ARC_HDR_SIZE + RFC1051_HDR_SIZE;
 	struct archdr *pkt = (struct archdr *) skb_push(skb, hdr_size);
Index: drivers/net/arcnet/rfc1201.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.4/drivers/net/arcnet/rfc1201.c,v
retrieving revision 1.1.1.3
diff -u -r1.1.1.3 rfc1201.c
--- drivers/net/arcnet/rfc1201.c	3 Aug 2002 00:39:44 -0000	1.1.1.3
+++ drivers/net/arcnet/rfc1201.c	8 Apr 2003 11:39:35 -0000
@@ -36,8 +36,8 @@
 static unsigned short type_trans(struct sk_buff *skb, struct net_device *dev);
 static void rx(struct net_device *dev, int bufnum,
 	       struct archdr *pkthdr, int length);
-static int build_header(struct sk_buff *skb, unsigned short type,
-			uint8_t daddr);
+static int build_header(struct sk_buff *skb, struct net_device *dev,
+			unsigned short type, uint8_t daddr);
 static int prepare_tx(struct net_device *dev, struct archdr *pkt, int length,
 		      int bufnum);
 static int continue_tx(struct net_device *dev, int bufnum);
@@ -375,10 +375,9 @@
 
 
 /* Create the ARCnet hard/soft headers for RFC1201. */
-static int build_header(struct sk_buff *skb, unsigned short type,
-			uint8_t daddr)
+static int build_header(struct sk_buff *skb, struct net_device *dev,
+			unsigned short type, uint8_t daddr)
 {
-	struct net_device *dev = skb->dev;
 	struct arcnet_local *lp = (struct arcnet_local *) dev->priv;
 	int hdr_size = ARC_HDR_SIZE + RFC1201_HDR_SIZE;
 	struct archdr *pkt = (struct archdr *) skb_push(skb, hdr_size);

--huq684BweRXVnRxX--
