Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264583AbUBQKdR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 05:33:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264586AbUBQKdR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 05:33:17 -0500
Received: from gprs155-60.eurotel.cz ([160.218.155.60]:12161 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S264583AbUBQKdL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 05:33:11 -0500
Date: Tue, 17 Feb 2004 11:31:49 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Amit S. Kale" <akale@users.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Cleanups for latest kgdb
Message-ID: <20040217103148.GA428@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Some small cleanups... Relative to latest kgdb:

hexToLong is named strange and unlike anything else. Renamed to
hex2long.

Whitespace in kgdb_8250.c is "interesting". Fixed.

In asm-i386/processor.h you insert blank line. This kills it.

Please apply,

								Pavel

--- clean-mm/arch/i386/kernel/i386-stub.c	2004-02-16 23:00:15.000000000 +0100
+++ linux-mm/arch/i386/kernel/i386-stub.c	2004-02-16 23:09:06.000000000 +0100
@@ -304,7 +304,7 @@
 
 		/* try to read optional parameter, pc unchanged if no parm */
 		ptr = &remcomInBuffer[1];
-		if (kgdb_hexToLong(&ptr, &addr)) {
+		if (kgdb_hex2long(&ptr, &addr)) {
 			linux_regs->eip = addr;
 		} 
 		newPC = linux_regs->eip;
@@ -337,13 +337,13 @@
 
 	case 'Y':
 		ptr = &remcomInBuffer[1];
-		kgdb_hexToLong(&ptr, &breakno);
+		kgdb_hex2long(&ptr, &breakno);
 		ptr++;
-		kgdb_hexToLong(&ptr, &breaktype);
+		kgdb_hex2long(&ptr, &breaktype);
 		ptr++;
-		kgdb_hexToLong(&ptr, &length);
+		kgdb_hex2long(&ptr, &length);
 		ptr++;
-		kgdb_hexToLong(&ptr, &addr);
+		kgdb_hex2long(&ptr, &addr);
 		if (set_hw_break(breakno & 0x3, breaktype & 0x3, 
 				 length & 0x3, addr) == 0) {
 			strcpy(remcomOutBuffer, "OK");
@@ -355,7 +355,7 @@
 		/* Remove hardware breakpoint */
 	case 'y':
 		ptr = &remcomInBuffer[1];
-		kgdb_hexToLong(&ptr, &breakno);
+		kgdb_hex2long(&ptr, &breakno);
 		if (remove_hw_break(breakno & 0x3) == 0) {
 			strcpy(remcomOutBuffer, "OK");
 		} else {
--- clean-mm/drivers/serial/kgdb_8250.c	2004-02-16 23:00:15.000000000 +0100
+++ linux-mm/drivers/serial/kgdb_8250.c	2004-02-16 23:32:39.000000000 +0100
@@ -40,10 +40,10 @@
 
 #define	GDB_BUF_SIZE	512		/* power of 2, please */
 
-static char	kgdb8250_buf[GDB_BUF_SIZE] ;
-static int	kgdb8250_buf_in_inx ;
-static atomic_t	kgdb8250_buf_in_cnt ;
-static int	kgdb8250_buf_out_inx ;
+static char	kgdb8250_buf[GDB_BUF_SIZE];
+static int	kgdb8250_buf_in_inx;
+static atomic_t	kgdb8250_buf_in_cnt;
+static int	kgdb8250_buf_out_inx;
 
 
 static int kgdb8250_got_dollar = -3, kgdb8250_got_H = -3,
@@ -63,7 +63,7 @@
 int serial8250_release_irq(int irq);
 
 int kgdb8250_irq;
-unsigned long  kgdb8250_port;
+unsigned long kgdb8250_port;
 
 int kgdb8250_baud = 115200;
 int kgdb8250_ttyS;
@@ -317,7 +317,7 @@
         return 0;
 }
 
-int     kgdb8250_hook(void)
+int kgdb8250_hook(void)
 {
 	int retval;
 
--- clean-mm/include/asm-i386/processor.h	2004-02-16 23:00:15.000000000 +0100
+++ linux-mm/include/asm-i386/processor.h	2004-02-16 23:09:06.000000000 +0100
@@ -393,7 +393,6 @@
 	 * be within the limit.
 	 */
 	unsigned long	io_bitmap[IO_BITMAP_LONGS + 1];
-
 	/*
 	 * pads the TSS to be cacheline-aligned (size is 0x100)
 	 */
--- clean-mm/include/linux/kgdb.h	2004-02-16 23:00:15.000000000 +0100
+++ linux-mm/include/linux/kgdb.h	2004-02-16 23:09:06.000000000 +0100
@@ -105,7 +105,7 @@
 
 extern void kgdb8250_add_port(int i, struct uart_port *serial_req);
 
-int kgdb_hexToLong(char **ptr, long *longValue);
+int kgdb_hex2long(char **ptr, long *longValue);
 char *kgdb_mem2hex(char *mem, char *buf, int count);
 char *kgdb_hex2mem(char *buf, char *mem, int count);
 
--- clean-mm/kernel/kgdbstub.c	2004-02-16 23:00:15.000000000 +0100
+++ linux-mm/kernel/kgdbstub.c	2004-02-16 23:09:06.000000000 +0100
@@ -399,7 +399,7 @@
  * While we find nice hex chars, build a longValue.
  * Return number of chars processed.
  */
-int kgdb_hexToLong(char **ptr, long *longValue)
+int kgdb_hex2long(char **ptr, long *longValue)
 {
 	int numChars = 0;
 	int hexValue;
@@ -804,8 +804,8 @@
 			/* mAA..AA,LLLL  Read LLLL bytes at address AA..AA */
 		case 'm':
 			ptr = &remcomInBuffer[1];
-			if (kgdb_hexToLong(&ptr, &addr) > 0 && *ptr++ == ',' &&
-			    kgdb_hexToLong(&ptr, &length) > 0) {
+			if (kgdb_hex2long(&ptr, &addr) > 0 && *ptr++ == ',' &&
+			    kgdb_hex2long(&ptr, &length) > 0) {
 				if (IS_ERR(ptr = kgdb_mem2hex((char *) addr,
 							remcomOutBuffer,
 							length)))
@@ -818,8 +818,8 @@
 		/* MAA..AA,LLLL: Write LLLL bytes at address AA.AA return OK */
 		case 'M':
 			ptr = &remcomInBuffer[1];
-			if (kgdb_hexToLong(&ptr, &addr) > 0 && *(ptr++) == ','
-				&& kgdb_hexToLong(&ptr, &length) > 0 &&
+			if (kgdb_hex2long(&ptr, &addr) > 0 && *(ptr++) == ','
+				&& kgdb_hex2long(&ptr, &length) > 0 &&
 				*(ptr++) == ':') {
 				if (IS_ERR(ptr = kgdb_hex2mem(ptr, (char *)addr,
 							length)))
@@ -903,7 +903,7 @@
 				}
 				threadid = 0;
 				ptr = remcomInBuffer+17;
-				kgdb_hexToLong(&ptr, &threadid);
+				kgdb_hex2long(&ptr, &threadid);
 				if (!getthread(linux_regs, threadid)) {
 					error_packet(remcomOutBuffer, -EINVAL);
 					break;
@@ -934,7 +934,7 @@
 			switch (remcomInBuffer[1]) {
 			case 'g':
 				ptr = &remcomInBuffer[2];
-				kgdb_hexToLong(&ptr, &threadid);
+				kgdb_hex2long(&ptr, &threadid);
 				thread = getthread(linux_regs, threadid);
 				if (!thread && threadid > 0) {
 					error_packet(remcomOutBuffer, -EINVAL);
@@ -948,7 +948,7 @@
 			case 'c':
 				atomic_set(&kgdb_killed_or_detached, 0);
 				ptr = &remcomInBuffer[2];
-				kgdb_hexToLong(&ptr, &threadid);
+				kgdb_hex2long(&ptr, &threadid);
 				if (!threadid) {
 					kgdb_contthread = 0;
 				} else {
@@ -968,7 +968,7 @@
 			/* Query thread status */
 		case 'T':
 			ptr = &remcomInBuffer[1];
-			kgdb_hexToLong(&ptr, &threadid);
+			kgdb_hex2long(&ptr, &threadid);
 			thread = getthread(linux_regs, threadid);
 			if (thread)
 				ok_packet(remcomOutBuffer);
@@ -982,7 +982,7 @@
 				error_packet(remcomOutBuffer, -EINVAL);
 				break;
 			}
-			kgdb_hexToLong(&ptr, &addr);
+			kgdb_hex2long(&ptr, &addr);
 			
 			bpt_type = remcomInBuffer[1];
 			if (bpt_type != bp_breakpoint) {

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
