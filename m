Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264173AbTKSXBU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 18:01:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264174AbTKSXBU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 18:01:20 -0500
Received: from adsl-67-120-62-187.dsl.lsan03.pacbell.net ([67.120.62.187]:27552
	"EHLO exchange.macrolink.com") by vger.kernel.org with ESMTP
	id S264173AbTKSXBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 18:01:19 -0500
Message-ID: <11E89240C407D311958800A0C9ACF7D1A34046@EXCHANGE>
From: Ed Vance <EdV@macrolink.com>
To: "'Marcelo Tosatti'" <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org,
       "Dan Christian (E-mail)" <Daniel.A.Christian@NASA.gov>
Subject: RE: Linux 2.4.23-rc2 [PATCH]
Date: Wed, 19 Nov 2003 15:01:43 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

There is still a chunk of the "ELAN versus ST16C654" bug in the generic
serial driver. The previous attempt to patch it missed a spot. Please apply
the following patch to fix the second spot the same way as the first was
fixed (at line 845). This bug was the ELAN UART work-around that broke
ST16C654 UART support. Let's finish it. 

Thanks,
Ed Vance

diff -Naur -X dontdiff.txt linux-2.4.23-rc2/drivers/char/serial.c
linux-2.4.23-rc2-ml/drivers/char/serial.c
--- linux-2.4.23-rc2/drivers/char/serial.c	Mon Aug 25 04:44:41 2003
+++ linux-2.4.23-rc2-ml/drivers/char/serial.c	Wed Nov 19 14:40:05 2003
@@ -914,10 +914,15 @@
 		if (status & UART_LSR_DR)
 			receive_chars(info, &status, regs);
 		check_modem_status(info);
+#ifdef CONFIG_MELAN
 		if ((status & UART_LSR_THRE) ||
 		    /* For buggy ELAN processors */
 		    ((iir & UART_IIR_ID) == UART_IIR_THRI))
 			transmit_chars(info, 0);
+#else
+		if (status & UART_LSR_THRE)
+			transmit_chars(info, 0);
+#endif
 		if (pass_counter++ > RS_ISR_PASS_LIMIT) {
 #if SERIAL_DEBUG_INTR
 			printk("rs_single loop break.\n");
