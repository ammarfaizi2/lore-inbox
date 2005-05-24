Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262127AbVEXP7U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262127AbVEXP7U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 11:59:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262125AbVEXP5o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 11:57:44 -0400
Received: from p-mail1.rd.francetelecom.com ([195.101.245.15]:33554 "EHLO
	p-mail1.rd.francetelecom.com") by vger.kernel.org with ESMTP
	id S262134AbVEXPqc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 11:46:32 -0400
Message-ID: <42934C4D.2040501@cr0.org>
Date: Tue, 24 May 2005 17:46:21 +0200
From: Julien TINNES <julien-lkml@cr0.org>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: tytso@mit.edu
CC: linux-kernel@vger.kernel.org
Subject: Potential null pointer dereference in serial driver (2.4) and amiga
 serial driver (2.6)
Content-Type: multipart/mixed;
 boundary="------------030402060204090806030608"
X-OriginalArrivalTime: 24 May 2005 15:46:21.0683 (UTC) FILETIME=[BBB9FC30:01C56077]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030402060204090806030608
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

This is an example of a pointer which is dereferenced (two times),
before beeing null checked.

Patches are attached.

Signed-off-by: Julien TINNES <julien@cr0.org>

--------------030402060204090806030608
Content-Type: text/x-patch;
 name="2.4-serial.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4-serial.patch"

--- linux-2.4.30.orig/drivers/char/serial.c	2005-01-19 15:09:50.000000000 +0100
+++ linux-2.4.30/drivers/char/serial.c	2005-05-24 17:23:26.000000000 +0200
@@ -1827,13 +1827,18 @@
 
 static void rs_put_char(struct tty_struct *tty, unsigned char ch)
 {
-	struct async_struct *info = (struct async_struct *)tty->driver_data;
+	struct async_struct *info;
 	unsigned long flags;
 
+	if (!tty)
+		return;
+	
+	info =  (struct async_struct *)tty->driver_data;
+	
 	if (serial_paranoia_check(info, tty->device, "rs_put_char"))
 		return;
 
-	if (!tty || !info->xmit.buf)
+	if (!info->xmit.buf)
 		return;
 
 	save_flags(flags); cli();
@@ -1873,13 +1878,18 @@
 		    const unsigned char *buf, int count)
 {
 	int	c, ret = 0;
-	struct async_struct *info = (struct async_struct *)tty->driver_data;
+	struct async_struct *info;
 	unsigned long flags;
 				
+	if (!tty)
+		return 0;
+
+	info = (struct async_struct *)tty->driver_data;
+	
 	if (serial_paranoia_check(info, tty->device, "rs_write"))
 		return 0;
 
-	if (!tty || !info->xmit.buf || !tmp_buf)
+	if (!info->xmit.buf || !tmp_buf)
 		return 0;
 
 	save_flags(flags);

--------------030402060204090806030608
Content-Type: text/x-patch;
 name="2.6-amiserial.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.6-amiserial.patch"

--- linux-2.6.11.orig/drivers/char/amiserial.c	2005-05-17 10:55:03.000000000 +0200
+++ linux-2.6.11/drivers/char/amiserial.c	2005-05-24 17:10:16.000000000 +0200
@@ -861,13 +861,18 @@
 
 static void rs_put_char(struct tty_struct *tty, unsigned char ch)
 {
-	struct async_struct *info = (struct async_struct *)tty->driver_data;
+	struct async_struct *info;
 	unsigned long flags;
 
+	if(!tty)
+		return;
+	
+	info = (struct async_struct *)tty->driver_data;
+	
 	if (serial_paranoia_check(info, tty->name, "rs_put_char"))
 		return;
 
-	if (!tty || !info->xmit.buf)
+	if (!info->xmit.buf)
 		return;
 
 	local_irq_save(flags);
@@ -910,13 +915,18 @@
 static int rs_write(struct tty_struct * tty, const unsigned char *buf, int count)
 {
 	int	c, ret = 0;
-	struct async_struct *info = (struct async_struct *)tty->driver_data;
+	struct async_struct *info;
 	unsigned long flags;
 
+	if(!tty)
+		return 0;
+
+	info = (struct async_struct *)tty->driver_data;
+	
 	if (serial_paranoia_check(info, tty->name, "rs_write"))
 		return 0;
 
-	if (!tty || !info->xmit.buf || !tmp_buf)
+	if (!info->xmit.buf || !tmp_buf)
 		return 0;
 
 	local_save_flags(flags);

--------------030402060204090806030608--
