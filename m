Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261754AbTJHUZe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 16:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261768AbTJHUZe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 16:25:34 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:22433 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S261754AbTJHUZd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 16:25:33 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH] ACPI serial fix
Date: Wed, 8 Oct 2003 14:25:30 -0600
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
References: <200310081241.41825.bjorn.helgaas@hp.com>
In-Reply-To: <200310081241.41825.bjorn.helgaas@hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310081425.30578.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 08 October 2003 12:41 pm, Bjorn Helgaas wrote:
> Here's another little fix for ACPI serial discovery in 2.6.

Rats.  Ignore the previous patch and use this, which I've actually
tested with the next step (removal of all the stuff in asm-ia64/serial.h):

Intel 870 firmware reports an extra zero-length IO port range, which
is bogus, as far as I can tell.  Ignore it.

===== drivers/serial/8250_acpi.c 1.4 vs edited =====
--- 1.4/drivers/serial/8250_acpi.c	Mon Oct  6 15:57:02 2003
+++ edited/drivers/serial/8250_acpi.c	Wed Oct  8 14:12:46 2003
@@ -38,8 +38,11 @@
 static acpi_status acpi_serial_port(struct serial_struct *req,
 				    struct acpi_resource_io *io)
 {
-	req->port = io->min_base_address;
-	req->io_type = SERIAL_IO_PORT;
+	if (io->range_length) {
+		req->port = io->min_base_address;
+		req->io_type = SERIAL_IO_PORT;
+	} else
+		printk(KERN_ERR "%s: zero-length IO port range?\n", __FUNCTION__);
 	return AE_OK;
 }
 

