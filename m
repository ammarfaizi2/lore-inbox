Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261733AbTJHSlo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 14:41:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261740AbTJHSlo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 14:41:44 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:32135 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S261733AbTJHSln (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 14:41:43 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH] ACPI serial fix
Date: Wed, 8 Oct 2003 12:41:41 -0600
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310081241.41825.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's another little fix for ACPI serial discovery in 2.6.

Intel 870 firmware reports an extra zero-length IO port range, which
is bogus, as far as I can tell.  Ignore it.

===== drivers/serial/8250_acpi.c 1.4 vs edited =====
--- 1.4/drivers/serial/8250_acpi.c	Mon Oct  6 15:57:02 2003
+++ edited/drivers/serial/8250_acpi.c	Wed Oct  8 12:36:31 2003
@@ -38,6 +38,11 @@
 static acpi_status acpi_serial_port(struct serial_struct *req,
 				    struct acpi_resource_io *io)
 {
+	if (!io->range_length) {
+		printk(KERN_ERR "%s: zero-length IO port range?\n", __FUNCTION__);
+		return AE_ERROR;
+	}
+
 	req->port = io->min_base_address;
 	req->io_type = SERIAL_IO_PORT;
 	return AE_OK;

