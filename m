Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273973AbRISAUl>; Tue, 18 Sep 2001 20:20:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273974AbRISAUW>; Tue, 18 Sep 2001 20:20:22 -0400
Received: from c1-ctn-76.dial-up.net ([196.34.157.76]:15369 "EHLO cericon")
	by vger.kernel.org with ESMTP id <S273973AbRISAUL>;
	Tue, 18 Sep 2001 20:20:11 -0400
Date: Wed, 19 Sep 2001 02:16:54 +0200
From: Paul Sheer <psheer@icon.co.za>
To: linux-kernel@vger.kernel.org, dahinds@users.sourceforge.net
Subject: PATCH to non-working xirc2ps_cs.c driver (kernel 2.4.9)
Message-ID: <20010919021654.G3768@cericon.cranzgot.co.za>
Reply-To: psheer@icon.co.za
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.1.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This driver tries to do media detection, failing
even if the media type is forced. This patch skips
media detection if the media type is forced, which,
I believe, is the correct behaviour for cards like
mine, where the media detection does not seem to
work.


--- drivers/net/pcmcia/xirc2ps_cs.c.orig	Wed Apr 18 23:40:05 2001
+++ drivers/net/pcmcia/xirc2ps_cs.c	Wed Sep 19 01:03:06 2001
@@ -5,6 +5,10 @@
  * This driver supports various Xircom CreditCard Ethernet adapters
  * including the CE2, CE IIps, RE-10, CEM28, CEM33, CE33, CEM56,
  * CE3-100, CE3B, RE-100, REM10BT, and REM56G-100.
+ *
+ * 19Sep2001 - The CE3B-100 has problems with media detection. Use the
+ * option if_port=1 or if_port=4 to force 10BaseT or 100BaseT
respectively.
+ * Change by psheer@icon.co.za
  * 
  * Written originally by Werner Koch based on David Hinds' skeleton of the
  * PCMCIA driver.
@@ -1925,6 +1929,17 @@
     ioaddr_t ioaddr = dev->base_addr;
     unsigned control, status, linkpartner;
     int i;
+
+    if (if_port == 1) {
+	dev->if_port = 1;
+	local->probe_port = 0;
+	return 1;	/* force to 10BaseT */
+    }
+    if (if_port == 4) {
+	dev->if_port = 4;
+	local->probe_port = 0;
+	return 1;	/* force to 100BaseT */
+    }
 
     status = mii_rd(ioaddr,  0, 1);
     if ((status & 0xff00) != 0x7800)



-- 
Paul Sheer Consulting IT Services . . . Tel . . . +27 21 761 7224
Email . . . psheer@icon.co.za . . . . . . Pager . . . 088 0057266
Linux development, cryptography, recruitment,  support,  training
http://www.icon.co.za/~psheer . . . . http://rute.sourceforge.net
L I N U X . . . . . . . . . . . .  The Choice of a GNU Generation
