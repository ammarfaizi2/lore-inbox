Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268865AbRHBJpQ>; Thu, 2 Aug 2001 05:45:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268867AbRHBJo4>; Thu, 2 Aug 2001 05:44:56 -0400
Received: from [212.95.195.134] ([212.95.195.134]:57872 "EHLO correo.teldat.es")
	by vger.kernel.org with ESMTP id <S268865AbRHBJov>;
	Thu, 2 Aug 2001 05:44:51 -0400
Message-ID: <41FAD0CB3B6BD3118BE600C04F43DB20C0AF24@CORREO>
From: Cristian Alonso <CALONSO@teldat.es>
To: linux-kernel@vger.kernel.org
Subject: [PATCH]: KGDB patch for PPC boards with console in SMC2
Date: Thu, 2 Aug 2001 11:48:40 +0200 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello. 
I was testing KGDB yesterday on a Power PC embedded board, and found that it
did not work on boards with the console attached to SMC2 (instead of SMC1,
which is the usual thing) in kernel version 2.4.7. I enclose a copy of the
patch that worked for me between the 
=========BEGIN PATCH====== and =======END PATCH==== lines.

The problems seems to be that the KGDB source code in the kernel assumes
that console port is always SMC1, and sometimes it is not. This is the patch
of file arch/ppc/m8xx_io/uart.c that fixed the problem for me (just changed
a few lines with my_console_write(0, <xxxxx>) to
my_console_write(CONFIG_SERIAL_CONSOLE_PORT, <xxxxx>). After applying this
patch, i was able to connect and debug  the Linux Kernel 2.4.7 and 2.4.8pre8
without trouble.

DISCLAIMER: I know I should not be using KGDB. I know I should look at the
code, use the force, ask Santa Tecla for help (spanish Saint for Computer
Sciencists), but, hey!, you got me, I sometimes use KGDB and, IMHO is a nice
tools for people learning about the Linux kernel (like me).


================================BEGIN
PATCH=======================================
--- linux-2.4.7.orig/arch/ppc/8xx_io/uart.c	Mon Jul  2 23:34:57 2001
+++ linux/arch/ppc/8xx_io/uart.c	Thu Aug  2 11:06:50 2001
@@ -2303,7 +2303,7 @@
 int
 xmon_8xx_write(const char *s, unsigned count)
 {
-	my_console_write(0, s, count);
+	my_console_write(CONFIG_SERIAL_CONSOLE_PORT, s, count);
 	return(count);
 }
 #endif
@@ -2312,7 +2312,7 @@
 void
 putDebugChar(char ch)
 {
-	my_console_write(0, &ch, 1);
+	my_console_write(CONFIG_SERIAL_CONSOLE_PORT, &ch, 1);
 }
 #endif
 
@@ -2398,13 +2398,13 @@
 int
 xmon_8xx_read_poll(void)
 {
-	return(my_console_wait_key(0, 1, NULL));
+	return(my_console_wait_key(CONFIG_SERIAL_CONSOLE_PORT, 1, NULL));
 }
 
 int
 xmon_8xx_read_char(void)
 {
-	return(my_console_wait_key(0, 0, NULL));
+	return(my_console_wait_key(CONFIG_SERIAL_CONSOLE_PORT, 0, NULL));
 }
 #endif
 
@@ -2416,7 +2416,7 @@
 getDebugChar(void)
 {
 	if (kgdb_chars <= 0) {
-		kgdb_chars = my_console_wait_key(0, 0, kgdb_buf);
+		kgdb_chars = my_console_wait_key(CONFIG_SERIAL_CONSOLE_PORT,
0, kgdb_buf);
 		kgdp = kgdb_buf;
 	}
 	kgdb_chars--;
@@ -2444,7 +2444,7 @@
 	 * we do here is give it a different buffer and make it a FIFO.
 	 */
 
-	ser = rs_table;
+	ser = rs_table + CONFIG_SERIAL_CONSOLE_PORT;
 
 	/* Right now, assume we are using SMCs.
 	*/
================================END
PATCH=======================================

If you have any comments/suggestions/whatever, please e-mail them to me at 
calonso@teldat.es

Regards,
Cristian Alonso Aldama
Development Group Manager
R&D Department
e-mail: calonso@teldat.es 
http://www.teldat.es

