Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314092AbSDKPXx>; Thu, 11 Apr 2002 11:23:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314093AbSDKPXw>; Thu, 11 Apr 2002 11:23:52 -0400
Received: from stingr.net ([212.193.32.15]:16512 "HELO hq.stingr.net")
	by vger.kernel.org with SMTP id <S314092AbSDKPXv>;
	Thu, 11 Apr 2002 11:23:51 -0400
Date: Thu, 11 Apr 2002 19:23:27 +0400
From: Paul P Komkoff Jr <i@stingr.net>
To: linux-kernel@vger.kernel.org
Cc: Marc Haber <mh+linux-kernel@zugschlus.de>
Subject: Re: tulip and VLAN tagging - accepting larger frames without affecting higher layers?
Message-ID: <20020411152327.GA600@stingr.net>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Marc Haber <mh+linux-kernel@zugschlus.de>
In-Reply-To: <E16veWm-00052F-00@janet.int.toplink-plannet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Agent Tanya
X-Mailer: Roxio Easy CD Creator 5.0
X-RealName: Stingray Greatest Jr
Organization: Bedleham International
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replying to Marc Haber:
> Hi,
> 
> VLAN-Tagging on Linux seems still to be problematic, despite the dot1q
> patch being in the kernel since a few months. Problems arise when a
> system running on an untagged switch port sends a frame using full MTU
> to a system that runs VLAN tagging. The switch adds the VLAN tag to
> the frame which then exceeds the MTU and is then dropped by the
> receiving Linux system.

You can take latest stable linux-stingr kernel from
bk://linux-stingr.bkbits.net/stable4

It contains (following) (rediffed) working tulip mtu patch :)

diff -urN linux-2.4.9-ac10-novlan/drivers/net/tulip/interrupt.c linux-2.4.9-ac10/drivers/net/tulip/interrupt.c
--- linux-2.4.9-ac10-novlan/drivers/net/tulip/interrupt.c	Wed Jun 20 22:15:44 2001
+++ linux-2.4.9-ac10/drivers/net/tulip/interrupt.c	Mon Sep 10 18:44:12 2001
@@ -128,8 +128,8 @@
 				   dev->name, entry, status);
 		if (--rx_work_limit < 0)
 			break;
-		if ((status & 0x38008300) != 0x0300) {
-			if ((status & 0x38000300) != 0x0300) {
+		if ((status & (0x38000000 | RxDescFatalErr | RxWholePkt)) != RxWholePkt) {
+			if ((status & (0x38000000 | RxWholePkt)) != RxWholePkt) {
 				/* Ingore earlier buffers. */
 				if ((status & 0xffff) != 0x7fff) {
 					if (tulip_debug > 1)
@@ -155,10 +155,10 @@
 			struct sk_buff *skb;
 
 #ifndef final_version
-			if (pkt_len > 1518) {
+			if (pkt_len > 1522) {
 				printk(KERN_WARNING "%s: Bogus packet size of %d (%#x).\n",
 					   dev->name, pkt_len, pkt_len);
-				pkt_len = 1518;
+				pkt_len = 1522;
 				tp->stats.rx_length_errors++;
 			}
 #endif
diff -urN linux-2.4.9-ac10-novlan/drivers/net/tulip/tulip.h linux-2.4.9-ac10/drivers/net/tulip/tulip.h
--- linux-2.4.9-ac10-novlan/drivers/net/tulip/tulip.h	Wed Jun 20 22:19:02 2001
+++ linux-2.4.9-ac10/drivers/net/tulip/tulip.h	Mon Sep 10 18:42:27 2001
@@ -186,7 +186,7 @@
 
 enum desc_status_bits {
 	DescOwned = 0x80000000,
-	RxDescFatalErr = 0x8000,
+	RxDescFatalErr = 0x4842,
 	RxWholePkt = 0x0300,
 };
 
@@ -264,7 +264,7 @@
 
 #define MEDIA_MASK     31
 
-#define PKT_BUF_SZ		1536	/* Size of each temporary Rx buffer. */
+#define PKT_BUF_SZ		1540	/* Size of each temporary Rx buffer. */
 
 #define TULIP_MIN_CACHE_LINE	8	/* in units of 32-bit words */
 
diff -urN linux-2.4.9-ac10-novlan/drivers/net/tulip/tulip_core.c linux-2.4.9-ac10/drivers/net/tulip/tulip_core.c
--- linux-2.4.9-ac10-novlan/drivers/net/tulip/tulip_core.c	Mon Sep 10 18:50:47 2001
+++ linux-2.4.9-ac10/drivers/net/tulip/tulip_core.c	Mon Sep 10 18:39:59 2001
@@ -59,7 +59,7 @@
 #if defined(__alpha__) || defined(__arm__) || defined(__hppa__) \
 	|| defined(__sparc_) || defined(__ia64__) \
 	|| defined(__sh__) || defined(__mips__)
-static int rx_copybreak = 1518;
+static int rx_copybreak = 1522;
 #else
 static int rx_copybreak = 100;
 #endif

-- 
Paul P 'Stingray' Komkoff 'Greatest' Jr // (icq)23200764 // (irc)Spacebar
  PPKJ1-RIPE // (smtp)i@stingr.net // (http)stingr.net // (pgp)0xA4B4ECA4
