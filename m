Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261201AbULMWTU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261201AbULMWTU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 17:19:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261215AbULMWSa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 17:18:30 -0500
Received: from atlrel8.hp.com ([156.153.255.206]:59820 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S261201AbULMWPU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 17:15:20 -0500
Subject: Re: Exar ST16C2550 rev A2 bug
From: Alex Williamson <alex.williamson@hp.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, michael.knight@exar.com
In-Reply-To: <1102107971.7078.34.camel@tdi>
References: <1100716008.32679.55.camel@tdi>
	 <20041128111047.A10807@flint.arm.linux.org.uk>
	 <1101659181.2838.41.camel@mythbox>  <1102107971.7078.34.camel@tdi>
Content-Type: text/plain
Organization: LOSL
Date: Mon, 13 Dec 2004 15:15:11 -0700
Message-Id: <1102976111.9999.17.camel@tdi>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

   I received a system with one of these misidentified UARTs we were
discussing.  The proposed addition to your solution works almost as
advertised.  The only trick is that size_fifo() doesn't like coming in
with 0xBF in the LCR.  I added a simple save/clear/restore and all seems
well.  This probably needs to be checked since I have a very limited
assortment of UARTs to test.  The complete patch is attached below.  I'd
be more than happy to run any additional test cases on this system.
Please let me know if this looks reasonable.  Thanks,

	Alex

-- 
Alex Williamson                             HP Linux & Open Source Lab

===== drivers/serial/8250.c 1.92 vs edited =====
--- 1.92/drivers/serial/8250.c	2004-11-19 00:03:10 -07:00
+++ edited/drivers/serial/8250.c	2004-12-13 14:57:48 -07:00
@@ -449,9 +449,11 @@
  */
 static int size_fifo(struct uart_8250_port *up)
 {
-	unsigned char old_fcr, old_mcr, old_dll, old_dlm;
+	unsigned char old_fcr, old_mcr, old_dll, old_dlm, old_lcr;
 	int count;
 
+	old_lcr = serial_inp(up, UART_LCR);
+	serial_outp(up, UART_LCR, 0);
 	old_fcr = serial_inp(up, UART_FCR);
 	old_mcr = serial_inp(up, UART_MCR);
 	serial_outp(up, UART_FCR, UART_FCR_ENABLE_FIFO |
@@ -474,11 +476,40 @@
 	serial_outp(up, UART_LCR, UART_LCR_DLAB);
 	serial_outp(up, UART_DLL, old_dll);
 	serial_outp(up, UART_DLM, old_dlm);
+	serial_outp(up, UART_LCR, old_lcr);
 
 	return count;
 }
 
 /*
+ * Read UART ID using the divisor method - set DLL and DLM to zero
+ * and the revision will be in DLL and device type in DLM.  We
+ * preserve the device state across this.
+ */
+static unsigned int autoconfig_read_divisor_id(struct uart_8250_port *p)
+{
+	unsigned char old_dll, old_dlm, old_lcr;
+	unsigned int id;
+
+	old_lcr = serial_inp(p, UART_LCR);
+	serial_outp(p, UART_LCR, UART_LCR_DLAB);
+
+	old_dll = serial_inp(p, UART_DLL);
+	old_dlm = serial_inp(p, UART_DLM);
+
+	serial_outp(p, UART_DLL, 0);
+	serial_outp(p, UART_DLM, 0);
+
+	id = serial_inp(p, UART_DLL) | serial_inp(p, UART_DLM) << 8;
+
+	serial_outp(p, UART_DLL, old_dll);
+	serial_outp(p, UART_DLM, old_dlm);
+	serial_outp(p, UART_LCR, old_lcr);
+
+	return id;
+}
+
+/*
  * This is a helper routine to autodetect StarTech/Exar/Oxsemi UART's.
  * When this function is called we know it is at least a StarTech
  * 16650 V2, but it might be one of several StarTech UARTs, or one of
@@ -490,7 +521,7 @@
  */
 static void autoconfig_has_efr(struct uart_8250_port *up)
 {
-	unsigned char id1, id2, id3, rev, saved_dll, saved_dlm;
+	unsigned int id1, id2, id3, rev;
 
 	/*
 	 * Everything with an EFR has SLEEP
@@ -540,21 +571,13 @@
 	 *  0x12 - XR16C2850.
 	 *  0x14 - XR16C854.
 	 */
-	serial_outp(up, UART_LCR, UART_LCR_DLAB);
-	saved_dll = serial_inp(up, UART_DLL);
-	saved_dlm = serial_inp(up, UART_DLM);
-	serial_outp(up, UART_DLL, 0);
-	serial_outp(up, UART_DLM, 0);
-	id2 = serial_inp(up, UART_DLL);
-	id1 = serial_inp(up, UART_DLM);
-	serial_outp(up, UART_DLL, saved_dll);
-	serial_outp(up, UART_DLM, saved_dlm);
-
-	DEBUG_AUTOCONF("850id=%02x:%02x ", id1, id2);
-
-	if (id1 == 0x10 || id1 == 0x12 || id1 == 0x14) {
-		if (id1 == 0x10)
-			up->rev = id2;
+	id1 = autoconfig_read_divisor_id(up);
+	DEBUG_AUTOCONF("850id=%04x ", id1);
+
+	id2 = id1 >> 8;
+	if (id2 == 0x10 || id2 == 0x12 || id2 == 0x14) {
+		if (id2 == 0x10)
+			up->rev = id1 & 255;
 		up->port.type = PORT_16850;
 		return;
 	}
@@ -596,6 +619,19 @@
 		up->port.type = PORT_16450;
 }
 
+static int broken_efr(struct uart_8250_port *up)
+{
+	/*
+	 * Exar ST16C2550 "A2" devices incorrectly detect as
+	 * having an EFR, and report an ID of 0x0201.  See
+	 * http://www.exar.com/info.php?pdf=dan180_oct2004.pdf
+	 */
+	if (autoconfig_read_divisor_id(up) == 0x0201 && size_fifo(up) == 16)
+		return 1;
+
+	return 0;
+}
+
 /*
  * We know that the chip has FIFOs.  Does it have an EFR?  The
  * EFR is located in the same register position as the IIR and
@@ -632,7 +668,7 @@
 	 * (other ST16C650V2 UARTs, TI16C752A, etc)
 	 */
 	serial_outp(up, UART_LCR, 0xBF);
-	if (serial_in(up, UART_EFR) == 0) {
+	if (serial_in(up, UART_EFR) == 0 && !broken_efr(up)) {
 		DEBUG_AUTOCONF("EFRv2 ");
 		autoconfig_has_efr(up);
 		return;


