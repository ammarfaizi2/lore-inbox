Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286365AbRLJT65>; Mon, 10 Dec 2001 14:58:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286367AbRLJT6i>; Mon, 10 Dec 2001 14:58:38 -0500
Received: from stingr.net ([212.193.33.37]:49678 "EHLO stingr.net")
	by vger.kernel.org with ESMTP id <S286365AbRLJT6W>;
	Mon, 10 Dec 2001 14:58:22 -0500
Date: Mon, 10 Dec 2001 22:57:59 +0300
From: Paul P Komkoff Jr <i@stingr.net>
To: linux-kernel@vger.kernel.org, jgarzik@mandrakesoft.com
Subject: [PATCH] MTU vlan-related patch for tulip (2.4.x)
Message-ID: <20011210225759.B11450@stingr.net>
Mail-Followup-To: linux-kernel@vger.kernel.org, jgarzik@mandrakesoft.com
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Agent Tanya
X-Mailer: Roxio Easy CD Creator 5.0
X-RealName: Stingray Greatest Jr
Organization: Bedleham International
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tired of patching everytime ... since vlan are now in official kernel

I hope it will not break any things er ? should apply cleanly to latest 2.4
...



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
  
