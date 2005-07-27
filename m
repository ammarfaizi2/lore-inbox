Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261180AbVG0WEr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbVG0WEr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 18:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261179AbVG0WCo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 18:02:44 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:13968 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S261154AbVG0WBm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 18:01:42 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] PCDP: if PCDP contains parity information, use it
Date: Wed, 27 Jul 2005 16:01:36 -0600
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507271601.36836.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If the PCDP supplies parity, use it (only none/even/odd supported),
and don't append parity/stop bit arguments unless baud is present.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work/drivers/firmware/pcdp.c
===================================================================
--- work.orig/drivers/firmware/pcdp.c	2005-07-25 15:04:23.000000000 -0600
+++ work/drivers/firmware/pcdp.c	2005-07-25 15:08:05.000000000 -0600
@@ -25,14 +25,22 @@
 #ifdef CONFIG_SERIAL_8250_CONSOLE
 	int mmio;
 	static char options[64], *p = options;
+	char parity;
 
 	mmio = (uart->addr.address_space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY);
 	p += sprintf(p, "console=uart,%s,0x%lx",
 		mmio ? "mmio" : "io", uart->addr.address);
-	if (uart->baud)
+	if (uart->baud) {
 		p += sprintf(p, ",%lu", uart->baud);
-	if (uart->bits)
-		p += sprintf(p, "n%d", uart->bits);
+		if (uart->bits) {
+			switch (uart->parity) {
+			    case 0x2: parity = 'e'; break;
+			    case 0x3: parity = 'o'; break;
+			    default:  parity = 'n';
+			}
+			p += sprintf(p, "%c%d", parity, uart->bits);
+		}
+	}
 
 	return early_serial_console_init(options);
 #else
