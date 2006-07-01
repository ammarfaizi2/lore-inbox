Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751434AbWGAU5h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751434AbWGAU5h (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 16:57:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751803AbWGAU5h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 16:57:37 -0400
Received: from smtp-vbr5.xs4all.nl ([194.109.24.25]:54021 "EHLO
	smtp-vbr5.xs4all.nl") by vger.kernel.org with ESMTP
	id S1751434AbWGAU5g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 16:57:36 -0400
To: linux-kernel@vger.kernel.org
Subject: SMBus access
From: Johan Vromans <jvromans@squirrel.nl>
Date: Sat, 01 Jul 2006 22:57:34 +0200
Message-ID: <m2irmhjb5t.fsf@phoenix.squirrel.nl>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To get battery readings on some laptops it is necessary to interface
with the SMBus that hangs of the EC. However, the current
implementation of the EC driver does not permit other modules 
read/write access. 

A trivial solution is to change acpi_ec_read/write from static to
nonstatic, and export the symbols so other modules can use them.

Would there be any objections to apply this change?

-- Johan

--- drivers/acpi/ec.c~	2006-04-17 13:40:49.000000000 +0200
+++ drivers/acpi/ec.c	2006-04-22 17:49:13.000000000 +0200
@@ -305,20 +305,22 @@
 }
 #endif /* ACPI_FUTURE_USAGE */
 
-static int acpi_ec_read(union acpi_ec *ec, u8 address, u32 * data)
+int acpi_ec_read(union acpi_ec *ec, u8 address, u32 * data)
 {
 	if (acpi_ec_poll_mode)
 		return acpi_ec_poll_read(ec, address, data);
 	else
 		return acpi_ec_intr_read(ec, address, data);
 }
-static int acpi_ec_write(union acpi_ec *ec, u8 address, u8 data)
+EXPORT_SYMBOL(acpi_ec_read);
+int acpi_ec_write(union acpi_ec *ec, u8 address, u8 data)
 {
 	if (acpi_ec_poll_mode)
 		return acpi_ec_poll_write(ec, address, data);
 	else
 		return acpi_ec_intr_write(ec, address, data);
 }
+EXPORT_SYMBOL(acpi_ec_write);
 static int acpi_ec_poll_read(union acpi_ec *ec, u8 address, u32 * data)
 {
 	acpi_status status = AE_OK;
