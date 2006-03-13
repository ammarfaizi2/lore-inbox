Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751603AbWCMSl4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751603AbWCMSl4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 13:41:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751469AbWCMSlz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 13:41:55 -0500
Received: from smtp1.exar.com ([204.154.183.10]:4536 "EHLO smtp1.exar.com")
	by vger.kernel.org with ESMTP id S1750960AbWCMSly (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 13:41:54 -0500
X-IronPort-AV: i="4.02,187,1139212800"; 
   d="scan'208"; a="2120761:sNHT304628588"
Message-ID: <4415BD47.6070404@exar.com>
Date: Mon, 13 Mar 2006 10:43:19 -0800
From: Ravi Reddy <ravi.reddy@exar.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: rmk+serial@arm.linux.org.uk
CC: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Serial: proper support for Exar 16L580/16L2550/16L2552/16V2550/16V2552
 UARTs
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russel,

In the last couple of years, Exar Corporation has introduced new UART 
products, with additional features:

16L580 - 16 Byte FIFO with EFR
16L2550/52/ & 16V2550/52 - 16 Byte FIFO with EFR (2 channel UARTs)

All these devices have uniquw device ids.
16L580 has Device ID =  0x01; Both 16L2550/52 and 16V2550/52 has Device 
IDs = 0x02

Due to existing logic in the serial driver's 8250.c, the above products 
default to 16650V2 UART type (32 byte FIFO UART), causing some potential 
problems. In this regard, please verify this patch, which fixes those 
issues.

--- /usr/src/linux-2.6.13-15/drivers/serial/8250_orig.c    2006-03-07 
10:48:22.000000000 -0800
+++ /usr/src/linux-2.6.13-15/drivers/serial/8250.c    2006-03-07 
11:12:37.000000000 -0800
@@ -191,6 +191,13 @@ static const struct serial8250_config ua
        .fcr        = UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10,
        .flags        = UART_CAP_FIFO,
    },
+    [PORT_16580] = {
+        .name        = "XR16580",
+        .fifo_size    = 16,
+        .tx_loadsz    = 16,
+        .fcr        = UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10,
+        .flags        = UART_CAP_FIFO | UART_CAP_EFR | UART_CAP_SLEEP,
+    },
    [PORT_CIRRUS] = {
        .name        = "Cirrus",
        .fifo_size    = 1,
@@ -590,9 +597,20 @@ static void autoconfig_has_efr(struct ua
        up->port.type = PORT_16850;
        return;
    }
+ 
 +    /*
+     * 0x01 - XR16L580
+     * 0x02 - XR16L2550/52 and XR16V2550/52
+     * All the above UARTs have 16 byte FIFO with EFR
+     * and are of UART type PORT_16580
+     */
+    if (id2 == 0x01 || id2 == 0x02) {
+        up->port.type = PORT_16580;
+        return;
+    }
   /*
-     * It wasn't an XR16C850.
+     * It wasn't an XR16C850 or XR16L580 or XR16x2550/52.
     *
     * We distinguish between the '654 and the '650 by counting
     * how many bytes are in the FIFO.  I'm using this for now,


Thanks and regards,
Ravi Reddy...
