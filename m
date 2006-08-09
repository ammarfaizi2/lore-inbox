Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751347AbWHIULx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751347AbWHIULx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 16:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751349AbWHIULx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 16:11:53 -0400
Received: from the.earth.li ([193.201.200.66]:60121 "EHLO the.earth.li")
	by vger.kernel.org with ESMTP id S1751347AbWHIULw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 16:11:52 -0400
Date: Wed, 9 Aug 2006 21:11:46 +0100
From: Jonathan McDowell <noodles@earth.li>
To: linux-serial@vger.kernel.org, rmk+serial@arm.linux.org.uk
Cc: linux-omap-open-source@linux.omap.com, linux-kernel@vger.kernel.org
Subject: [PATCH] OMAP1510 serial fix for 115200 baud.
Message-ID: <20060809201146.GG27094@earth.li>
Mail-Followup-To: linux-serial@vger.kernel.org, rmk+serial@arm.linux.org.uk,
	linux-omap-open-source@linux.omap.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below is necessary for 115200 baud on an OMAP1510 internal
UART. It's been in the linux-omap tree for some time and with it applied
to a vanilla Linus git tree the serial console on the Amstrad Delta
(which is OMAP1510 based and whose initial bootloader runs at 115200)
works fine (it doesn't without it). Is there any possibility of getting
it accepted into mainline? It shouldn't affect any other platform due to
the ifdef/cpu_is guards.

Signed-Off-By: Jonathan McDowell <noodles@earth.li>

-----
diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index bbf78aa..76cd21d 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -1885,6 +1885,17 @@ #endif
 		serial_outp(up, UART_EFR, efr);
 	}
 
+#ifdef CONFIG_ARCH_OMAP15XX
+	/* Workaround to enable 115200 baud on OMAP1510 internal ports */
+	if (cpu_is_omap1510() && is_omap_port((unsigned int)up->port.membase)) {
+		if (baud == 115200) {
+			quot = 1;
+			serial_out(up, UART_OMAP_OSC_12M_SEL, 1);
+		} else
+			serial_out(up, UART_OMAP_OSC_12M_SEL, 0);
+	}
+#endif
+
 	if (up->capabilities & UART_NATSEMI) {
 		/* Switch to bank 2 not bank 1, to avoid resetting EXCR2 */
 		serial_outp(up, UART_LCR, 0xe0);
-----

J.

-- 
] http://www.earth.li/~noodles/ [] 101 things you can't have too much  [
]  PGP/GPG Key @ the.earth.li   []        of : 1 - Cable ties.         [
] via keyserver, web or email.  []                                     [
] RSA: 4DC4E7FD / DSA: 5B430367 []                                     [
