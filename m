Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262885AbVDAUZz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262885AbVDAUZz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 15:25:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262882AbVDAUXK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 15:23:10 -0500
Received: from [212.91.234.123] ([212.91.234.123]:16294 "EHLO
	webbox180.server-home.org") by vger.kernel.org with ESMTP
	id S262881AbVDAUVw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 15:21:52 -0500
Message-ID: <424DAD58.6080807@clagi.de>
Date: Fri, 01 Apr 2005 22:21:44 +0200
From: Guido Classen <classeng@clagi.de>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jgarzik@pobox.com, tulip-users@lists.sourceforge.net,
       linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/net/tulip/: fix for Lite-On 82c168 PNIC (2.6.11)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this small patch fixes two issues with the Lite-On 82c168 PNIC adapters.
I've tested it with two cards in different machines both chip rev 17

The first is the wrong register address CSR6 for writing the MII register
which instead is 0xB8 (this may get a symbol too?) (see similar exisiting code
at line 437) in tulip_core.c

At least by my cards, the the bit 31 from the MII register seems to be
somewhat unstable. This results in reading wrong values from the Phy-Registers
und prevents the card from correct initialization. I've added a litte delay
and an second test of the bit. If the bit is stil cleared the read/write
process has definitely finished.

Cheers
   Guido

Signed-off-by: Guido Classen <classeng@clagi.de>

diff -ru linux-2.6.11-org/drivers/net/tulip/tulip_core.c 
linux-2.6.11.2-pentium/drivers/net/tulip/tulip_core.c
--- linux-2.6.11-org/drivers/net/tulip/tulip_core.c	2005-04-01 
22:10:03.000000000 +0200
+++ linux-2.6.11.2-pentium/drivers/net/tulip/tulip_core.c	2005-03-31 
23:14:11.000000000 +0200
@@ -1701,8 +1701,8 @@
  			tp->nwayset = 0;
  			iowrite32(csr6_ttm | csr6_ca, ioaddr + CSR6);
  			iowrite32(0x30, ioaddr + CSR12);
-			iowrite32(0x0001F078, ioaddr + CSR6);
-			iowrite32(0x0201F078, ioaddr + CSR6); /* Turn on autonegotiation. */
+			iowrite32(0x0001F078, ioaddr + 0xB8);
+			iowrite32(0x0201F078, ioaddr + 0xB8); /* Turn on autonegotiation. */
  		}
  		break;
  	case MX98713:
diff -ru linux-2.6.11-org/drivers/net/tulip/media.c 
linux-2.6.11.2-pentium/drivers/net/tulip/media.c
--- linux-2.6.11-org/drivers/net/tulip/media.c	2005-04-01 22:10:03.000000000 
+0200
+++ linux-2.6.11.2-pentium/drivers/net/tulip/media.c	2005-04-01 
22:05:31.000000000 +0200
@@ -74,8 +74,17 @@
  		ioread32(ioaddr + 0xA0);
  		while (--i > 0) {
  			barrier();
-			if ( ! ((retval = ioread32(ioaddr + 0xA0)) & 0x80000000))
-				break;
+			if ( ! ((retval = ioread32(ioaddr + 0xA0))
+                                & 0x80000000)) {
+                                /* bug in 82c168 rev 17?
+                                 * wait a little while and check if
+                                 * bit 31 is still cleared */
+                                udelay(10);
+                                if ( ! ((retval = ioread32(ioaddr + 0xA0))
+                                        & 0x80000000)) {
+                                        break;
+                                }
+                        }
  		}
  		spin_unlock_irqrestore(&tp->mii_lock, flags);
  		return retval & 0xffff;
@@ -153,8 +162,16 @@
  		iowrite32(cmd, ioaddr + 0xA0);
  		do {
  			barrier();
-			if ( ! (ioread32(ioaddr + 0xA0) & 0x80000000))
-				break;
+			if ( ! (ioread32(ioaddr + 0xA0) & 0x80000000)) {
+                                /* bug in 82c168 rev 17?
+                                 * wait a little while and check if
+                                 * bit 31 is still cleared */
+                                udelay(10);
+                                if ( ! (ioread32(ioaddr + 0xA0)
+                                        & 0x80000000)) {
+                                        break;
+                                }
+                        }
  		} while (--i > 0);
  		spin_unlock_irqrestore(&tp->mii_lock, flags);
  		return;
