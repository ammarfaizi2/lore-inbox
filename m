Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261305AbTFJJuf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 05:50:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261352AbTFJJuf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 05:50:35 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:8929 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261305AbTFJJuP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 05:50:15 -0400
Date: Tue, 10 Jun 2003 15:36:43 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Misc 2.5 Fixes: arcnet-oops-fix
Message-ID: <20030610100643.GB2194@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20030610100527.GA2194@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030610100527.GA2194@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Fix arcnet oopses with raw socket


 drivers/net/arcnet/arc-rawmode.c |    9 ++++-----
 drivers/net/arcnet/arcnet.c      |   15 ++++++++-------
 drivers/net/arcnet/rfc1051.c     |    9 ++++-----
 drivers/net/arcnet/rfc1201.c     |    9 ++++-----
 include/linux/arcdevice.h        |    4 ++--
 5 files changed, 22 insertions(+), 24 deletions(-)

diff -puN drivers/net/arcnet/arcnet.c~arcnet-oops-fix drivers/net/arcnet/arcnet.c
--- linux-2.5.70-ds/drivers/net/arcnet/arcnet.c~arcnet-oops-fix	2003-06-08 02:09:38.000000000 +0530
+++ linux-2.5.70-ds-dipankar/drivers/net/arcnet/arcnet.c	2003-06-08 02:09:38.000000000 +0530
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
 
@@ -479,7 +479,7 @@ static int arcnet_header(struct sk_buff 
 		       arc_bcast_proto->suffix);
 		proto = arc_bcast_proto;
 	}
-	return proto->build_header(skb, type, _daddr);
+	return proto->build_header(skb, dev, type, _daddr);
 }
 
 
@@ -495,6 +495,7 @@ static int arcnet_rebuild_header(struct 
 	int status = 0;		/* default is failure */
 	unsigned short type;
 	uint8_t daddr=0;
+	struct ArcProto *proto;
 
 	if (skb->nh.raw - skb->mac.raw != 2) {
 		BUGMSG(D_NORMAL,
@@ -523,7 +524,8 @@ static int arcnet_rebuild_header(struct 
 		return 0;
 
 	/* add the _real_ header this time! */
-	arc_proto_map[lp->default_proto[daddr]]->build_header(skb, type, daddr);
+	proto = arc_proto_map[lp->default_proto[daddr]];
+	proto->build_header(skb, dev, type, daddr);
 
 	return 1;		/* success */
 }
@@ -952,10 +954,9 @@ static void null_rx(struct net_device *d
 }
 
 
-static int null_build_header(struct sk_buff *skb, unsigned short type,
-			     uint8_t daddr)
+static int null_build_header(struct sk_buff *skb, struct net_device *dev,
+			     unsigned short type, uint8_t daddr)
 {
-	struct net_device *dev = skb->dev;
 	struct arcnet_local *lp = (struct arcnet_local *) dev->priv;
 
 	BUGMSG(D_PROTO,
diff -puN drivers/net/arcnet/arc-rawmode.c~arcnet-oops-fix drivers/net/arcnet/arc-rawmode.c
--- linux-2.5.70-ds/drivers/net/arcnet/arc-rawmode.c~arcnet-oops-fix	2003-06-08 02:09:38.000000000 +0530
+++ linux-2.5.70-ds-dipankar/drivers/net/arcnet/arc-rawmode.c	2003-06-08 02:09:38.000000000 +0530
@@ -37,8 +37,8 @@
 
 static void rx(struct net_device *dev, int bufnum,
 	       struct archdr *pkthdr, int length);
-static int build_header(struct sk_buff *skb, unsigned short type,
-			uint8_t daddr);
+static int build_header(struct sk_buff *skb, struct net_device *dev,
+			unsigned short type, uint8_t daddr);
 static int prepare_tx(struct net_device *dev, struct archdr *pkt, int length,
 		      int bufnum);
 
@@ -131,10 +131,9 @@ static void rx(struct net_device *dev, i
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
 
diff -puN drivers/net/arcnet/rfc1051.c~arcnet-oops-fix drivers/net/arcnet/rfc1051.c
--- linux-2.5.70-ds/drivers/net/arcnet/rfc1051.c~arcnet-oops-fix	2003-06-08 02:09:38.000000000 +0530
+++ linux-2.5.70-ds-dipankar/drivers/net/arcnet/rfc1051.c	2003-06-08 02:09:38.000000000 +0530
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
 
@@ -163,10 +163,9 @@ static void rx(struct net_device *dev, i
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
diff -puN drivers/net/arcnet/rfc1201.c~arcnet-oops-fix drivers/net/arcnet/rfc1201.c
--- linux-2.5.70-ds/drivers/net/arcnet/rfc1201.c~arcnet-oops-fix	2003-06-08 02:09:38.000000000 +0530
+++ linux-2.5.70-ds-dipankar/drivers/net/arcnet/rfc1201.c	2003-06-08 02:09:38.000000000 +0530
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
@@ -370,10 +370,9 @@ static void rx(struct net_device *dev, i
 
 
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
diff -puN include/linux/arcdevice.h~arcnet-oops-fix include/linux/arcdevice.h
--- linux-2.5.70-ds/include/linux/arcdevice.h~arcnet-oops-fix	2003-06-08 02:09:38.000000000 +0530
+++ linux-2.5.70-ds-dipankar/include/linux/arcdevice.h	2003-06-08 02:09:38.000000000 +0530
@@ -190,8 +190,8 @@ struct ArcProto {
 
 	void (*rx) (struct net_device * dev, int bufnum,
 		    struct archdr * pkthdr, int length);
-	int (*build_header) (struct sk_buff * skb, unsigned short ethproto,
-			     uint8_t daddr);
+	int (*build_header) (struct sk_buff * skb, struct net_device *dev,
+			     unsigned short ethproto, uint8_t daddr);
 
 	/* these functions return '1' if the skb can now be freed */
 	int (*prepare_tx) (struct net_device * dev, struct archdr * pkt, int length,

_
