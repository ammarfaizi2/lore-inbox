Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261336AbVCFJdx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261336AbVCFJdx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 04:33:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261285AbVCFJdx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 04:33:53 -0500
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:23452 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S261339AbVCFJdg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 04:33:36 -0500
Date: Sun, 6 Mar 2005 01:33:21 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix for 8250.c *wrongly* detecting XScale UART(s) on x86 PC
Message-ID: <20050306093321.GA3040@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell,

> 1.2073.10.1 05/03/04 21:19:20 gtj.member@com.rmk.(none)[rmk] +1 -0
> [ARM PATCH] 2472/1: Updates 8250.c to correctly detect XScale UARTs
>
> Patch from George Joseph
>
> Modifications to autoconfig_16550a to add a testcase
> to detect XScale UARTS.
>
> Signed-off-by: George Joseph
> Signed-off-by: Russell King

Breaks my UARTS.

I'm not thrilled with this patch but 8250.c has similar warts so I
guess it's not too bad.  Ideally we could refactor this a bit so if
this isn't acceptable let me know and I'll do that instead.



===== drivers/serial/8250.c 1.96 vs edited =====
Index: kernel-taniwha-2.6.11post-cw3/drivers/serial/8250.c
===================================================================
--- kernel-taniwha-2.6.11post-cw3.orig/drivers/serial/8250.c	2005-03-06 01:10:38.677251721 -0800
+++ kernel-taniwha-2.6.11post-cw3/drivers/serial/8250.c	2005-03-06 01:13:26.288802003 -0800
@@ -642,7 +642,9 @@
 static void autoconfig_16550a(struct uart_8250_port *up)
 {
 	unsigned char status1, status2;
+#ifdef CONFIG_ARM
 	unsigned int iersave;
+#endif /* CONFIG_ARM */
 
 	up->port.type = PORT_16550A;
 	up->capabilities |= UART_CAP_FIFO;
@@ -738,6 +740,11 @@
 		return;
 	}
 
+	/* We only do this check for ARM build because it seems to
+	 * falsely trigger on (some) PCs which breaks things.
+	 * Besides, if this is XScale specific why do all platforms
+	 * need this code and why is it here? */
+#ifdef CONFIG_ARM
 	/*
 	 * Try writing and reading the UART_IER_UUE bit (b6).
 	 * If it works, this is probably one of the Xscale platform's
@@ -771,6 +778,7 @@
 		DEBUG_AUTOCONF("Couldn't force IER_UUE to 0 ");
 	}
 	serial_outp(up, UART_IER, iersave);
+#endif /* CONFIG_ARM */
 }
 
 /*
