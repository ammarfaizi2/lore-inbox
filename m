Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267766AbUIUPgG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267766AbUIUPgG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 11:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267760AbUIUPgF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 11:36:05 -0400
Received: from web53505.mail.yahoo.com ([206.190.37.66]:36488 "HELO
	web53505.mail.yahoo.com") by vger.kernel.org with SMTP
	id S267749AbUIUPfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 11:35:50 -0400
Message-ID: <20040921153415.73737.qmail@web53505.mail.yahoo.com>
Date: Tue, 21 Sep 2004 08:34:15 -0700 (PDT)
From: roger blofeld <blofeldus@yahoo.com>
Subject: [PATCH] serial: 2.6.9rc1 pick nearest baud rate divider
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch modifies uart_get_divisor to select the nearest baud rate
divider rather than the lowest. It minimizes baud rate errors.

For example, if uartclk is 33000000 and baud is 115200 the ratio is
about 17.9
The current code selects 17 (5% error) but should select 18 (0.5%
error)

-roger

===== drivers/serial/serial_core.c 1.87 vs edited =====
--- 1.87/drivers/serial/serial_core.c   2004-06-29 09:43:58 -05:00
+++ edited/drivers/serial/serial_core.c 2004-09-15 14:04:34 -05:00
@@ -403,7 +403,7 @@
        if (baud == 38400 && (port->flags & UPF_SPD_MASK) ==
UPF_SPD_CUST)
                quot = port->custom_divisor;
        else
-               quot = port->uartclk / (16 * baud);
+               quot = (port->uartclk + (8 * baud)) / (16 * baud);
 
        return quot;
 }


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
