Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277151AbRJQUdZ>; Wed, 17 Oct 2001 16:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277152AbRJQUdQ>; Wed, 17 Oct 2001 16:33:16 -0400
Received: from mercury.is.co.za ([196.4.160.222]:10761 "HELO mercury.is.co.za")
	by vger.kernel.org with SMTP id <S277151AbRJQUdC>;
	Wed, 17 Oct 2001 16:33:02 -0400
Date: Wed, 17 Oct 2001 22:30:04 +0200
From: Paul Sheer <psheer@icon.co.za>
To: linux-kernel@vger.kernel.org, dahinds@users.sourceforge.net
Subject: PATCH to non-working xirc2ps_cs.c driver (kernel 2.4.12)
Message-ID: <20011017223004.M258@cericon.cranzgot.co.za>
Reply-To: psheer@icon.co.za
In-Reply-To: <20010919021654.G3768@cericon.cranzgot.co.za> <20010924154831.I28548@cericon.cranzgot.co.za>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20010924154831.I28548@cericon.cranzgot.co.za>; from psheer@icon.co.za on Mon, Sep 24, 2001 at 15:48:31 +0200
X-Mailer: Balsa 1.1.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This driver tries to do media detection, failing
even if the media type is forced. This patch skips
media detection if the media type is forced, which,
I believe, is the correct behaviour for cards like
mine, where the media detection does not seem to
work.


--- drivers/net/pcmcia/xirc2ps_cs.c.orig	Sun Sep 23 23:47:35 2001
+++ drivers/net/pcmcia/xirc2ps_cs.c	Mon Sep 24 14:43:05 2001
@@ -5,6 +5,11 @@
  * This driver supports various Xircom CreditCard Ethernet adapters
  * including the CE2, CE IIps, RE-10, CEM28, CEM33, CE33, CEM56,
  * CE3-100, CE3B, RE-100, REM10BT, and REM56G-100.
+ *
+ * 2000-09-24 <psheer@icon.co.za> The Xircom CE3B-100 may not
+ * autodetect the media properly. In this case use the
+ * if_port=1 (for 10BaseT) or if_port=4 (for 100BaseT) options
+ * to force the media type.
  * 
  * Written originally by Werner Koch based on David Hinds' skeleton of the
  * PCMCIA driver.
@@ -1925,6 +1930,12 @@
     ioaddr_t ioaddr = dev->base_addr;
     unsigned control, status, linkpartner;
     int i;
+
+    if (if_port == 4 || if_port == 1) { /* force 100BaseT or 10BaseT */
+	dev->if_port = if_port;
+	local->probe_port = 0;
+	return 1;
+    }
 
     status = mii_rd(ioaddr,  0, 1);
     if ((status & 0xff00) != 0x7800)


-- 
Paul Sheer Consulting IT Services . . . Tel . . . +27 21 761 7224
Email . . . psheer@icon.co.za . . . . . . Pager . . . 088 0057266
Linux development, cryptography, recruitment,  support,  training
http://www.icon.co.za/~psheer . . . . http://rute.sourceforge.net
L I N U X . . . . . . . . . . . .  The Choice of a GNU Generation
