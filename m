Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130084AbRBPLrU>; Fri, 16 Feb 2001 06:47:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129978AbRBPLrJ>; Fri, 16 Feb 2001 06:47:09 -0500
Received: from colorfullife.com ([216.156.138.34]:48142 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S130084AbRBPLqy>;
	Fri, 16 Feb 2001 06:46:54 -0500
Message-ID: <3A8D1338.27F9EFDF@colorfullife.com>
Date: Fri, 16 Feb 2001 12:47:04 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.1-ac15 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Stephen Thomas <stephen.thomas@insignia.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Tulip in 2.4.1-ac14 still poorly
In-Reply-To: <3A8D0C92.7060AABE@insignia.com>
Content-Type: multipart/mixed;
 boundary="------------8CBC08A162585B519EFB600A"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------8CBC08A162585B519EFB600A
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Stephen Thomas wrote:
> 
> On trying 2.4.1-ac13 I hit the tulip driver problems reported elsewhere,
> and ac14 does not seem to fix the problem on my machine.  Attached is an
> extract from my /var/log/messages.
>

Could you try the attached oneliner patches? 

patch-tulip-fix1 is integrated in -ac15, and I send patch-tulip-typo to
Alan a few seconds ago.

--
	Manfred
--------------8CBC08A162585B519EFB600A
Content-Type: text/plain; charset=us-ascii;
 name="patch-tulip-typo"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-tulip-typo"

diff -u 2.4/drivers/net/tulip/pnic.c build-2.4/drivers/net/tulip/pnic.c
--- 2.4/drivers/net/tulip/pnic.c	Fri Feb 16 11:17:03 2001
+++ build-2.4/drivers/net/tulip/pnic.c	Fri Feb 16 11:18:08 2001
@@ -84,7 +84,7 @@
 		tp->full_duplex_lock;
 
 	new_csr6 = tp->csr6;
-	if (negotiated & 0x038)	/* 100mbps. */
+	if (negotiated & 0x0380)	/* 100mbps. */
 		new_csr6 &= ~0x00400000;
 	 else
 		new_csr6 |= 0x00400000;


--------------8CBC08A162585B519EFB600A
Content-Type: text/plain; charset=us-ascii;
 name="patch-tulip-fix1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-tulip-fix1"

diff -u 2.4/drivers/net/tulip/pnic.c build-2.4/drivers/net/tulip/pnic.c
--- 2.4/drivers/net/tulip/pnic.c	Thu Feb 15 00:51:38 2001
+++ build-2.4/drivers/net/tulip/pnic.c	Thu Feb 15 01:05:59 2001
@@ -93,8 +93,6 @@
 	 else	
 		new_csr6 &= ~0x0200;
 	if (new_csr6 != tp->csr6) {
-		/* stop the transceiver*/
-		tulip_stop_rxtx(tp, tp->csr6);
 		tp->full_duplex = duplex;
 		tp->csr6 = new_csr6;
 		if (tulip_debug > 0)
@@ -102,10 +100,7 @@
 				   "#%d link partner capability of %4.4x.\n",
 				   dev->name, tp->full_duplex ? "full" : "half",
 				   tp->phys[0], mii_reg5);
-		/* When the transceiver is stopped it triggeres
-		 * a "Transmit stopped interrupt" (misnamed as TxDied).
-		 * The interrupt handler will restart the transceiver
-		 */
+		tulip_restart_rxtx(tp, tp->csr6);
 		return 1;
 	}
 	return 0;


--------------8CBC08A162585B519EFB600A--


