Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262943AbUDFQha (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 12:37:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263900AbUDFQha
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 12:37:30 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:15512 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S262943AbUDFQh0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 12:37:26 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Ruud Linders <rkmp@xs4all.nl>
Subject: Re: 2.6.x kernels and ttyS45 for 6 serial ports ?
Date: Tue, 6 Apr 2004 10:37:23 -0600
User-Agent: KMail/1.6.1
Cc: linux-kernel@vger.kernel.org, Russell King <rmk+lkml@arm.linux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200404061037.23867.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The way this device numbering seems to work is that many device names
> are reserved in include/asm/serial.h for devices like fourport/boca/hub6.
> Anything else (=all PCI cards?) gets a number still unassigned.

Right.  Names for everything in SERIAL_PORT_DFNS get reserved.  For
boxes with ACPI, we don't need SERIAL_PORT_DFNS at all (assuming you
build with CONFIG_SERIAL_8250_ACPI).  ia64, for example, doesn't
define SERIAL_PORT_DFNS, so ports just get named sequentially in the
order they're discovered.

The following (untested) patch should give you the same behavior
when you supply the "noisaserial" argument.  Note that this probably
won't work if you're using a serial console, because early serial
registration will fill in the ISA ports before "noisaserial" gets
parsed.

===== Documentation/kernel-parameters.txt 1.44 vs edited =====
--- 1.44/Documentation/kernel-parameters.txt	Mon Mar 22 14:03:22 2004
+++ edited/Documentation/kernel-parameters.txt	Tue Apr  6 09:39:07 2004
@@ -714,6 +714,8 @@
 
 	noisapnp	[ISAPNP] Disables ISA PnP code.
 
+	noisaserial	[SERIAL] Disables probing for legacy ISA serial ports.
+
 	noinitrd	[RAM] Tells the kernel not to load any configured
 			initial RAM disk.
 
===== drivers/serial/8250.c 1.48 vs edited =====
--- 1.48/drivers/serial/8250.c	Mon Mar 15 15:16:26 2004
+++ edited/drivers/serial/8250.c	Tue Apr  6 09:41:16 2004
@@ -117,6 +117,15 @@
 
 #define UART_NR	(ARRAY_SIZE(old_serial_port) + CONFIG_SERIAL_8250_NR_UARTS)
 
+static int __init serial_probe_isa = 1;
+
+static int __init noisaserial(char *str)
+{
+	serial_probe_isa = 0;
+	return 1;
+}
+__setup("noisaserial", noisaserial);
+
 #if defined(CONFIG_SERIAL_8250_RSA) && defined(MODULE)
 
 #define PORT_RSA_MAX 4
@@ -1836,7 +1845,7 @@
 	static int first = 1;
 	int i;
 
-	if (!first)
+	if (!first || !serial_probe_isa)
 		return;
 	first = 0;
 
