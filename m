Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270243AbTHLMb0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 08:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270295AbTHLMb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 08:31:26 -0400
Received: from 015.atlasinternet.net ([212.9.93.15]:27843 "EHLO
	antoli.gallimedina.net") by vger.kernel.org with ESMTP
	id S270243AbTHLMbY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 08:31:24 -0400
From: Ricardo Galli <gallir@uib.es>
Organization: UIB
To: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
Subject: PATCH: Re: 2.6.0-test3+sk98lin driver with hardware bug make eth unusable
Date: Tue, 12 Aug 2003 14:31:22 +0200
User-Agent: KMail/1.5.3
References: <200308121154.h7CBsEA32675@devserv.devel.redhat.com>
In-Reply-To: <200308121154.h7CBsEA32675@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308121431.22226.gallir@uib.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 12 August 2003 13:54, Alan Cox shaped the electrons to shout:
> > There is a ASIC bug in several popular motherboards (including ASUS ones)
> > related to TX hardware checksum.
>
> The checksum comes off the SK hardware
>
> > For packets smaller that 56 bytes (payload), as UDP dns queries, the asic
> > generates a bad checksum making the drivers unusable for "normal"
> > Internet usage:
>
> Sounds like broken padding handling for small frames, if so let the sw
> checksum handle them.

Find enclosed the patch to make it a Kconfig option. Just tested, 
at least it works as a workaround.

Regards,

-- 
  ricardo galli       GPG id C8114D34
  http://mnm.uib.es/~gallir/


Patch against 2.6.0-test3

diff -r -u linux-2.6.0-test3/drivers/net/Kconfig linux-2.6.0-test3-new/drivers/net/Kconfig
--- linux-2.6.0-test3/drivers/net/Kconfig	2003-08-10 17:34:29.000000000 +0200
+++ linux-2.6.0-test3-new/drivers/net/Kconfig	2003-08-12 13:47:50.000000000 +0200
@@ -2107,6 +2107,13 @@
 	  say M here and read Documentation/modules.txt. This is recommended.
 	  The module will be called sk98lin.o.

+config SK98LIN_TX_CHECKSUM
+	bool "Use hardware TX checksum"
+	depends on SK98LIN
+	help
+	  Some chips have a hardware bugs that generate wrong
+	  checksums in small packets. If unsure, say No.
+
 config CONFIG_SK98LIN_T1
 	bool "3Com 3C940/3C941 Gigabit Ethernet Adapter"
 	depends on SK98LIN
diff -r -u linux-2.6.0-test3/drivers/net/sk98lin/skge.c linux-2.6.0-test3-new/drivers/net/sk98lin/skge.c
--- linux-2.6.0-test3/drivers/net/sk98lin/skge.c	2003-08-10 17:33:18.000000000 +0200
+++ linux-2.6.0-test3-new/drivers/net/sk98lin/skge.c	2003-08-12 13:50:41.000000000 +0200
@@ -422,8 +422,12 @@
 /* for debuging on x86 only */
 /* #define BREAKPOINT() asm(" int $3"); */

+#ifdef CONFIG_SK98LIN_TX_CHECKSUM
 /* use the transmit hw checksum driver functionality */
-#define USE_SK_TX_CHECKSUM
+ #define USE_SK_TX_CHECKSUM
+#else
+ #undef USE_SK_TX_CHECKSUM
+#endif

 /* use the receive hw checksum driver functionality */
 #define USE_SK_RX_CHECKSUM

