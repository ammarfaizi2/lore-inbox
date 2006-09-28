Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751888AbWI1Nbe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751888AbWI1Nbe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 09:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751891AbWI1Nbe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 09:31:34 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:48863 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1751888AbWI1Nbd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 09:31:33 -0400
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: Andrew Victor <andrew@sanpeople.com>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org,
       Haavard Skinnemoen <hskinnemoen@atmel.com>
Subject: [PATCH 4/4] atmel_serial: Fix roundoff error in atmel_console_get_options
Reply-To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Date: Thu, 28 Sep 2006 15:31:42 +0200
Message-Id: <11594503023165-git-send-email-hskinnemoen@atmel.com>
X-Mailer: git-send-email 1.4.1.1
In-Reply-To: <1159450302567-git-send-email-hskinnemoen@atmel.com>
References: <11594503023218-git-send-email-hskinnemoen@atmel.com> <11594503023213-git-send-email-hskinnemoen@atmel.com> <11594503023619-git-send-email-hskinnemoen@atmel.com> <1159450302567-git-send-email-hskinnemoen@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The atmel_console_get_options() function initializes the baud,
parity and bits settings from the actual hardware setup, in
case it has been initialized by a e.g. boot loader.

The baud rate, however, is not necessarily exactly equal to one of
the standard baud rates (115200, etc.) This means that the baud rate
calculated by this function may be slightly higher or slightly lower
than one of the standard baud rates.

If the baud rate is slightly lower than the target, this causes
problems when uart_set_option() tries to match the detected baud rate
against the standard baud rate, as it will always select a baud rate
that is lower or equal to the target rate. For example if the
detected baud rate is slightly lower than 115200, usart_set_options()
will select 57600.

This patch fixes the problem by subtracting 1 from the value in BRGR
when calculating the baud rate. The detected baud rate will thus
always be higher than the nearest standard baud rate, and
uart_set_options() will end up doing the right thing.

Tested on ATSTK1000 and AT91RM9200-EK boards. Both are broken without
this patch.

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
---
 drivers/serial/atmel_serial.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/drivers/serial/atmel_serial.c b/drivers/serial/atmel_serial.c
index 6f1f4ea..2613a7e 100644
--- a/drivers/serial/atmel_serial.c
+++ b/drivers/serial/atmel_serial.c
@@ -793,8 +793,14 @@ static void __init atmel_console_get_opt
 	else if (mr == ATMEL_US_PAR_ODD)
 		*parity = 'o';
 
+	/*
+	 * The serial core only rounds down when matching this to a
+	 * supported baud rate. Make sure we don't end up slightly
+	 * lower than one of those, as it would make us fall through
+	 * to a much lower baud rate than we really want.
+	 */
 	quot = UART_GET_BRGR(port);
-	*baud = port->uartclk / (16 * (quot));
+	*baud = port->uartclk / (16 * (quot - 1));
 }
 
 static int __init atmel_console_setup(struct console *co, char *options)
-- 
1.4.1.1

