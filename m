Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261886AbVEaNRb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261886AbVEaNRb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 09:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261887AbVEaNRb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 09:17:31 -0400
Received: from mail.renesas.com ([202.234.163.13]:35222 "EHLO
	mail01.idc.renesas.com") by vger.kernel.org with ESMTP
	id S261886AbVEaNRK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 09:17:10 -0400
Date: Tue, 31 May 2005 22:17:02 +0900 (JST)
Message-Id: <20050531.221702.1044949015.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-pcmcia@lists.infradead.org,
       sakugawa@linux-m32r.org, takata@linux-m32r.org
Subject: [PATCH 2.6.12-rc5] m32r: Update m32r_cfc.[ch] to support Mappi-III
 platform
From: Hirokazu Takata <takata@linux-m32r.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.17 (Jumbo Shrimp)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patch is for the M32R CF/PCMCIA drivers to support a new platform,
Mappi-III evaluation board.

Regards,

Signed-off-by: Mamoru Sakugawa <sakugawa@linux-m32r.org>
Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 drivers/pcmcia/Kconfig    |    4 +--
 drivers/pcmcia/m32r_cfc.c |   57 ++++++++++++++++++----------------------------
 drivers/pcmcia/m32r_cfc.h |    8 ++++--
 3 files changed, 31 insertions(+), 38 deletions(-)


diff -ruNp a/drivers/pcmcia/Kconfig b/drivers/pcmcia/Kconfig
--- a/drivers/pcmcia/Kconfig	2005-05-26 18:54:43.000000000 +0900
+++ b/drivers/pcmcia/Kconfig	2005-05-26 21:27:15.000000000 +0900
@@ -176,14 +176,14 @@ config M32R_PCC
 
 config M32R_CFC
 	bool "M32R CF I/F Controller"
-	depends on M32R && (PLAT_USRV || PLAT_M32700UT || PLAT_MAPPI2 || PLAT_OPSPUT)
+	depends on M32R && (PLAT_USRV || PLAT_M32700UT || PLAT_MAPPI2 || PLAT_MAPPI3 || PLAT_OPSPUT)
 	help
 	  Say Y here to use the M32R CompactFlash controller.
 
 config M32R_CFC_NUM
 	int "M32R CF I/F number"
 	depends on M32R_CFC
-	default "1" if PLAT_USRV || PLAT_M32700UT || PLAT_MAPPI2 || PLAT_OPSPUT
+	default "1" if PLAT_USRV || PLAT_M32700UT || PLAT_MAPPI2 || PLAT_MAPPI3 || PLAT_OPSPUT
 	help
 	  Set the number of M32R CF slots.
 
diff -ruNp a/drivers/pcmcia/m32r_cfc.c b/drivers/pcmcia/m32r_cfc.c
--- a/drivers/pcmcia/m32r_cfc.c	2005-05-26 18:54:43.000000000 +0900
+++ b/drivers/pcmcia/m32r_cfc.c	2005-05-26 20:38:13.000000000 +0900
@@ -24,9 +24,9 @@
 #include <linux/workqueue.h>
 #include <linux/interrupt.h>
 #include <linux/device.h>
+#include <linux/bitops.h>
 #include <asm/irq.h>
 #include <asm/io.h>
-#include <asm/bitops.h>
 #include <asm/system.h>
 
 #include <pcmcia/version.h>
@@ -444,7 +444,7 @@ static int _pcc_get_status(u_short sock,
 		debug(3, "m32r_cfc: _pcc_get_status: "
 			 "power off (CPCR=0x%08x)\n", status);
 	}
-#elif defined(CONFIG_PLAT_MAPPI2)
+#elif defined(CONFIG_PLAT_MAPPI2) || defined(CONFIG_PLAT_MAPPI3)
 	if ( status ) {
 		status = pcc_get(sock, (unsigned int)PLD_CPCR);
 		if (status == 0) { /* power off */
@@ -452,18 +452,23 @@ static int _pcc_get_status(u_short sock,
 			pcc_set(sock, (unsigned int)PLD_CFBUFCR,0); /* force buffer off for ZA-36 */
 			udelay(50);
 		}
-		status = pcc_get(sock, (unsigned int)PLD_CFBUFCR);
-		if (status != 0) { /* buffer off */
-			pcc_set(sock, (unsigned int)PLD_CFBUFCR,0);
-			udelay(50);
-			pcc_set(sock, (unsigned int)PLD_CFRSTCR, 0x0101);
-			udelay(25); /* for IDE reset */
-			pcc_set(sock, (unsigned int)PLD_CFRSTCR, 0x0100);
-			mdelay(2);  /* for IDE reset */
-		} else {
-			*value |= SS_POWERON;
-			*value |= SS_READY;
-		}
+		*value |= SS_POWERON;
+
+		pcc_set(sock, (unsigned int)PLD_CFBUFCR,0);
+		udelay(50);
+		pcc_set(sock, (unsigned int)PLD_CFRSTCR, 0x0101);
+		udelay(25); /* for IDE reset */
+		pcc_set(sock, (unsigned int)PLD_CFRSTCR, 0x0100);
+		mdelay(2);  /* for IDE reset */
+
+		*value |= SS_READY;
+		*value |= SS_3VCARD;
+	} else {
+		/* disable CF power */
+	        pcc_set(sock, (unsigned int)PLD_CPCR, 0);
+		udelay(100);
+		debug(3, "m32r_cfc: _pcc_get_status: "
+			 "power off (CPCR=0x%08x)\n", status);
 	}
 #else
 #error no platform configuration
@@ -479,14 +484,13 @@ static int _pcc_get_socket(u_short sock,
 {
 //	pcc_socket_t *t = &socket[sock];
 
-#if defined(CONFIG_PLAT_M32700UT) || defined(CONFIG_PLAT_USRV) || defined(CONFIG_PLAT_OPSPUT)
 	state->flags = 0;
 	state->csc_mask = SS_DETECT;
 	state->csc_mask |= SS_READY;
 	state->io_irq = 0;
 	state->Vcc = 33;	/* 3.3V fixed */
 	state->Vpp = 33;
-#endif
+
 	debug(3, "m32r_cfc: GetSocket(%d) = flags %#3.3x, Vcc %d, Vpp %d, "
 		  "io_irq %d, csc_mask %#2.2x\n", sock, state->flags,
 		  state->Vcc, state->Vpp, state->io_irq, state->csc_mask);
@@ -497,32 +501,17 @@ static int _pcc_get_socket(u_short sock,
 
 static int _pcc_set_socket(u_short sock, socket_state_t *state)
 {
-#if defined(CONFIG_PLAT_MAPPI2)
-	u_long reg = 0;
-#endif
 	debug(3, "m32r_cfc: SetSocket(%d, flags %#3.3x, Vcc %d, Vpp %d, "
 		  "io_irq %d, csc_mask %#2.2x)\n", sock, state->flags,
 		  state->Vcc, state->Vpp, state->io_irq, state->csc_mask);
 
-#if defined(CONFIG_PLAT_M32700UT) || defined(CONFIG_PLAT_USRV) || defined(CONFIG_PLAT_OPSPUT)
+#if defined(CONFIG_PLAT_M32700UT) || defined(CONFIG_PLAT_USRV) || defined(CONFIG_PLAT_OPSPUT) || defined(CONFIG_PLAT_MAPPI2) || defined(CONFIG_PLAT_MAPPI3)
 	if (state->Vcc) {
 		if ((state->Vcc != 50) && (state->Vcc != 33))
 			return -EINVAL;
 		/* accept 5V and 3.3V */
 	}
-#elif defined(CONFIG_PLAT_MAPPI2)
-	if (state->Vcc) {
-		/*
-		 * 5V only
-		 */
-		if (state->Vcc == 50) {
-			reg |= PCCSIGCR_VEN;
-		} else {
-			return -EINVAL;
-		}
-	}
 #endif
-
 	if (state->flags & SS_RESET) {
 		debug(3, ":RESET\n");
 		pcc_set(sock,(unsigned int)PLD_CFRSTCR,0x101);
@@ -788,7 +777,7 @@ static int __init init_m32r_pcc(void)
 		return ret;
 	}
 
-#if defined(CONFIG_PLAT_MAPPI2)
+#if defined(CONFIG_PLAT_MAPPI2) || defined(CONFIG_PLAT_MAPPI3)
 	pcc_set(0, (unsigned int)PLD_CFCR0, 0x0f0f);
 	pcc_set(0, (unsigned int)PLD_CFCR1, 0x0200);
 #endif
@@ -825,7 +814,7 @@ static int __init init_m32r_pcc(void)
 	for (i = 0 ; i < pcc_sockets ; i++) {
 		socket[i].socket.dev.dev = &pcc_device.dev;
 		socket[i].socket.ops = &pcc_operations;
-		socket[i].socket.resource_ops = &pccard_static_ops;
+		socket[i].socket.resource_ops = &pccard_nonstatic_ops;
 		socket[i].socket.owner = THIS_MODULE;
 		socket[i].number = i;
 		ret = pcmcia_register_socket(&socket[i].socket);
diff -ruNp a/drivers/pcmcia/m32r_cfc.h b/drivers/pcmcia/m32r_cfc.h
--- a/drivers/pcmcia/m32r_cfc.h	2004-12-25 06:34:26.000000000 +0900
+++ b/drivers/pcmcia/m32r_cfc.h	2005-05-26 21:17:46.000000000 +0900
@@ -71,11 +71,15 @@
 
 #define CFC_IOPORT_BASE		0x1000
 
-#if !defined(CONFIG_PLAT_USRV)
+#if defined(CONFIG_PLAT_MAPPI3)
+#define CFC_ATTR_MAPBASE	0x14014000
+#define CFC_IO_MAPBASE_BYTE	0xb4012000
+#define CFC_IO_MAPBASE_WORD	0xb4002000
+#elif !defined(CONFIG_PLAT_USRV)
 #define CFC_ATTR_MAPBASE        0x0c014000
 #define CFC_IO_MAPBASE_BYTE     0xac012000
 #define CFC_IO_MAPBASE_WORD     0xac002000
-#else	/* CONFIG_PLAT_USRV */
+#else	
 #define CFC_ATTR_MAPBASE	0x04014000
 #define CFC_IO_MAPBASE_BYTE	0xa4012000
 #define CFC_IO_MAPBASE_WORD	0xa4002000

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/

