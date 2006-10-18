Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161238AbWJRQsj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161238AbWJRQsj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 12:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161240AbWJRQsj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 12:48:39 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:26920 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1161239AbWJRQsh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 12:48:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:user-agent;
        b=cKfVFykxohiRvb5X8eVtj3K9gU6Ywa+e7WqK2g3ox5gki9dRbT/FbSwpdTTWimoBuy/WaUCKLCQhG+s5MNSKib5+Z1lhZd/lQONzjHqzI+fhnj7vOY61gHimcac0C9SvSNOOjxIXO8JHVJ8KrZEwaF0Xoj+UdF1uWghAn3D5rfw=
Date: Thu, 19 Oct 2006 01:49:05 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Chas Williams <linux-atm-general@lists.sourceforge.net>,
       Giuliano Procida at Madge Networks <gprocida@madge.com>
Subject: [PATCH 6/6] atm/ambassador: use bitrev8
Message-ID: <20061018164905.GF21820@localhost>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	linux-kernel@vger.kernel.org,
	Chas Williams <linux-atm-general@lists.sourceforge.net>,
	Giuliano Procida at Madge Networks <gprocida@madge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use bitrev8 for ambassador driver.

Cc: Chas Williams <linux-atm-general@lists.sourceforge.net>
Cc: Giuliano Procida at Madge Networks <gprocida@madge.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

 drivers/atm/Kconfig      |    1 +
 drivers/atm/ambassador.c |   17 +++--------------
 2 files changed, 4 insertions(+), 14 deletions(-)

Index: work-fault-inject/drivers/atm/ambassador.c
===================================================================
--- work-fault-inject.orig/drivers/atm/ambassador.c
+++ work-fault-inject/drivers/atm/ambassador.c
@@ -32,6 +32,7 @@
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/poison.h>
+#include <linux/bitrev.h>
 
 #include <asm/atomic.h>
 #include <asm/io.h>
@@ -2068,18 +2069,6 @@ static void __devinit amb_ucode_version 
   PRINTK (KERN_INFO, "microcode version is %u.%u", major, minor);
 }
   
-// swap bits within byte to get Ethernet ordering
-static u8 bit_swap (u8 byte)
-{
-    const u8 swap[] = {
-      0x0, 0x8, 0x4, 0xc,
-      0x2, 0xa, 0x6, 0xe,
-      0x1, 0x9, 0x5, 0xd,
-      0x3, 0xb, 0x7, 0xf
-    };
-    return ((swap[byte & 0xf]<<4) | swap[byte>>4]);
-}
-
 // get end station address
 static void __devinit amb_esi (amb_dev * dev, u8 * esi) {
   u32 lower4;
@@ -2101,9 +2090,9 @@ static void __devinit amb_esi (amb_dev *
     PRINTDB (DBG_INIT, "ESI:");
     for (i = 0; i < ESI_LEN; ++i) {
       if (i < 4)
-	  esi[i] = bit_swap (lower4>>(8*i));
+	  esi[i] = bitrev8(lower4>>(8*i));
       else
-	  esi[i] = bit_swap (upper2>>(8*(i-4)));
+	  esi[i] = bitrev8(upper2>>(8*(i-4)));
       PRINTDM (DBG_INIT, " %02x", esi[i]);
     }
     
Index: work-fault-inject/drivers/atm/Kconfig
===================================================================
--- work-fault-inject.orig/drivers/atm/Kconfig
+++ work-fault-inject/drivers/atm/Kconfig
@@ -242,6 +242,7 @@ config ATM_IDT77252_USE_SUNI
 config ATM_AMBASSADOR
 	tristate "Madge Ambassador (Collage PCI 155 Server)"
 	depends on PCI && ATM
+	select BITREVERSE
 	help
 	  This is a driver for ATMizer based ATM card produced by Madge
 	  Networks Ltd. Say Y (or M to compile as a module named ambassador)
