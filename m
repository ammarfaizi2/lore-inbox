Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261777AbVBOUpu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261777AbVBOUpu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 15:45:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261879AbVBOUpt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 15:45:49 -0500
Received: from atlrel9.hp.com ([156.153.255.214]:58518 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S261881AbVBOUnK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 15:43:10 -0500
Subject: [PATCH] resend, 8250 woraround for buggy uart
From: Alex Williamson <alex.williamson@hp.com>
To: rmk+serial@arm.linux.org.uk
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: LOSL
Date: Tue, 15 Feb 2005 13:43:08 -0700
Message-Id: <1108500188.7373.46.camel@tdi>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

   This is a resend of a patch I sent back in December[1] re-diffed to
remove fuzz.  The patch adds support for detecting and working around a
bug in the A2 rev of the Exar ST16C2550 UART.  The chip incorrectly
advertises an EFR and mis-detects as having the wrong size FIFO.  Much
of the patch below is your proposed solution to the problem.  The only
changes I've made are to check the FIFO size on the part (because there
is a real part with the same divisor ID and larger FIFO) and save and
restore the LCR register around the size_fifo() routine (it doesn't work
correctly with a LCR value of 0xBF).  Can we get this into the queue
once 2.6.12 opens?  I'd be happy to test any modifications on this
solution.  Thanks,

	Alex

[1] http://marc.theaimsgroup.com/?l=linux-kernel&m=110297697227569

-- 
Signed-off-by: Alex Williamson <alex.williamson@hp.com>

===== drivers/serial/8250.c 1.94 vs edited =====
--- 1.94/drivers/serial/8250.c	2005-02-07 19:25:11 -07:00
+++ edited/drivers/serial/8250.c	2005-02-15 13:14:14 -07:00
@@ -450,9 +450,11 @@
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
@@ -475,11 +477,40 @@
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
@@ -491,7 +522,7 @@
  */
 static void autoconfig_has_efr(struct uart_8250_port *up)
 {
-	unsigned char id1, id2, id3, rev, saved_dll, saved_dlm;
+	unsigned int id1, id2, id3, rev;
 
 	/*
 	 * Everything with an EFR has SLEEP
@@ -541,21 +572,13 @@
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
@@ -597,6 +620,19 @@
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
@@ -633,7 +669,7 @@
 	 * (other ST16C650V2 UARTs, TI16C752A, etc)
 	 */
 	serial_outp(up, UART_LCR, 0xBF);
-	if (serial_in(up, UART_EFR) == 0) {
+	if (serial_in(up, UART_EFR) == 0 && !broken_efr(up)) {
 		DEBUG_AUTOCONF("EFRv2 ");
 		autoconfig_has_efr(up);
 		return;


