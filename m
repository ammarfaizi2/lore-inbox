Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263899AbSJ3FSt>; Wed, 30 Oct 2002 00:18:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263979AbSJ3FSt>; Wed, 30 Oct 2002 00:18:49 -0500
Received: from adsl-63-197-69-248.dsl.snfc21.pacbell.net ([63.197.69.248]:55322
	"EHLO ipx.esperanza") by vger.kernel.org with ESMTP
	id <S263899AbSJ3FSr>; Wed, 30 Oct 2002 00:18:47 -0500
Date: Tue, 29 Oct 2002 21:19:45 -0800
From: "Nicolas S. Dade" <ndade@adsl-63-197-69-248.dsl.snfc21.pacbell.net>
To: linux-kernel@vger.kernel.org
Subject: BUG in 2.2.22 skb_realloc_headroom()
Message-ID: <20021029211945.A17657@ipx.esperanza>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Kernel: 2.2.22
File: net/core/skbuff.c

skb_realloc_headroom() panics when new headroom is smaller
than existing headroom. Specifically the skb_put() fails
and calls skb_over_panic() because the new buffer is too
small.

When skb_realloc_headroom() is called from skb_cow(), it
can be called when the existing headroom size is >=
the desired headroom but the packet in question is cloned.

Then skb_realloc_headroom() allocates

 skb_alloc( skb->truesize + new_headroom - old_headroom )

but if the old_headroom > new_headroom then the resulting
buffer is too small to hold new_headroom + skb->len.

I found this when running tethereal (thus causing the packets
to be cloned for libpcap) and passing data from an acenic,
which allocates 48 bytes of headroom in its skbuff's, to
another ethernet device, which needs only 14 (rounded to 16)
bytes of headroom for the ethernet header.

Here's how I think it should be fixed:

-- 
-- Nicolas Dade    http://nsd.dyndns.org/

--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="skb_realloc_headroom.diff"

--- linux-2.2.22/net/core/skbuff.c.orig	Tue Oct 29 21:13:24 2002
+++ linux-2.2.22/net/core/skbuff.c	Tue Oct 29 21:15:14 2002
@@ -7,6 +7,7 @@
  *	Version:	$Id: skbuff.c,v 1.55 1999/02/23 08:12:27 davem Exp $
  *
  *	Fixes:	
+ *              Nicolas Dade    :       Fixed skb_realloc_headroom to smaller headroom
  *		Alan Cox	:	Fixed the worst of the load balancer bugs.
  *		Dave Platt	:	Interrupt stacking fix.
  *	Richard Kooijman	:	Timestamp fixes.
@@ -316,13 +317,12 @@
 {
 	struct sk_buff *n;
 	unsigned long offset;
-	int headroom = skb_headroom(skb);
 
 	/*
 	 *	Allocate the copy buffer
 	 */
  	 
-	n=alloc_skb(skb->truesize+newheadroom-headroom, GFP_ATOMIC);
+	n=alloc_skb(skb->len+newheadroom, GFP_ATOMIC);
 	if(n==NULL)
 		return NULL;
 

--opJtzjQTFsWo+cga--
