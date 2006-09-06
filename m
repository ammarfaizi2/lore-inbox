Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751639AbWIFVV6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751639AbWIFVV6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 17:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751644AbWIFVV6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 17:21:58 -0400
Received: from mx1.redhat.com ([66.187.233.31]:36818 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751636AbWIFVV4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 17:21:56 -0400
Date: Wed, 6 Sep 2006 17:22:37 -0400
From: Josef Whiter <jwhiter@redhat.com>
To: linux-serial@vger.kernel.org
Cc: rmk+serial@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: [PATCH] RFE: add io= option to 8250 serial console
Message-ID: <20060906212236.GC6841@korben.rdu.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patch is against a recent git clone of Linus's tree.  This patch adds the
ability to set the iobase for the serial port being used when you specify a
serial device for the console on bootup, ie

console=ttyS0,io=0x3f8

this is requested because boxes that use HP's iLo interface will usually
redirect any output to ttyS0 to the iLo interface, which has a certain amount of
latency associated with it.  This option allows users to set the iobase for the
port to the iLo's iobase which removes the need for the bios to do it's
indirection.  This has been tested by myself and HP and it works.  Thank you,

Josef


--- linux-2.6/drivers/serial/8250.c.josef	2006-09-04 11:44:48.000000000 -0400
+++ linux-2.6/drivers/serial/8250.c	2006-09-06 14:22:26.000000000 -0400
@@ -2304,6 +2304,31 @@ static int serial8250_console_setup(stru
 	if (!port->iobase && !port->membase)
 		return -ENODEV;
 
+	/*
+	 * if an io address is specified set the port's iobase to the 
+	 * specified port.  Parses the following option setups
+	 *	console=ttyS0,io=0x3f8
+	 *	console=ttyS0,115200n8,io=0x3f8
+	 *	console=ttyS0,io=0x3f8,115200n8
+	 */
+	if (options) {
+		char *ioptr;
+		unsigned long iobase = 0;
+		if ((ioptr = strstr(options, "io=")) != NULL) {
+			iobase = simple_strtoul(ioptr+3, NULL, 16);
+			if (ioptr == options) {
+				if((ioptr = strstr(options, ",")) != NULL)
+					options = ioptr+1;
+				else
+					options = (char *)0;
+			} else
+				*(ioptr-1) = '\0';
+		}
+
+		if (iobase)
+			port->iobase = iobase;
+	}
+
 	if (options)
 		uart_parse_options(options, &baud, &parity, &bits, &flow);
 
