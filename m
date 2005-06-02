Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261173AbVFBQJy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261173AbVFBQJy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 12:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261177AbVFBQJy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 12:09:54 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:44208 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S261173AbVFBQJs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 12:09:48 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] PCDP: handle tables that don't supply baud rate
Date: Thu, 2 Jun 2005 10:09:44 -0600
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506021009.44384.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The HCDP specs (i.e., PCDP revision < 3) allow zero as a default value
for baud rate and data bits.  So if firmware doesn't supply them, let
early_serial_console_init() probe for them rather than telling it the
baud rate is zero.

Also, update the URL for the PCDP spec.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: drivers/firmware/pcdp.c
===================================================================
--- 3c5e9440c6a37c3355b50608836a23c8fa4eec99/drivers/firmware/pcdp.c  (mode:100644)
+++ uncommitted/drivers/firmware/pcdp.c  (mode:100644)
@@ -23,12 +23,15 @@
 {
 #ifdef CONFIG_SERIAL_8250_CONSOLE
 	int mmio;
-	static char options[64];
+	static char options[64], *p = options;
 
 	mmio = (uart->addr.address_space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY);
-	snprintf(options, sizeof(options), "console=uart,%s,0x%lx,%lun%d",
-		mmio ? "mmio" : "io", uart->addr.address, uart->baud,
-		uart->bits ? uart->bits : 8);
+	p += sprintf(p, "console=uart,%s,0x%lx",
+		mmio ? "mmio" : "io", uart->addr.address);
+	if (uart->baud)
+		p += sprintf(p, ",%lu", uart->baud);
+	if (uart->bits)
+		p += sprintf(p, "n%d", uart->bits);
 
 	return early_serial_console_init(options);
 #else
Index: drivers/firmware/pcdp.h
===================================================================
--- 3c5e9440c6a37c3355b50608836a23c8fa4eec99/drivers/firmware/pcdp.h  (mode:100644)
+++ uncommitted/drivers/firmware/pcdp.h  (mode:100644)
@@ -2,7 +2,7 @@
  * Definitions for PCDP-defined console devices
  *
  * v1.0a: http://www.dig64.org/specifications/DIG64_HCDPv10a_01.pdf
- * v2.0:  http://www.dig64.org/specifications/DIG64_HCDPv20_042804.pdf
+ * v2.0:  http://www.dig64.org/specifications/DIG64_PCDPv20.pdf
  *
  * (c) Copyright 2002, 2004 Hewlett-Packard Development Company, L.P.
  *	Khalid Aziz <khalid.aziz@hp.com>
