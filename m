Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288086AbSCGAJO>; Wed, 6 Mar 2002 19:09:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288012AbSCGAIz>; Wed, 6 Mar 2002 19:08:55 -0500
Received: from exchange.macrolink.com ([64.173.88.99]:3596 "EHLO
	exchange.macrolink.com") by vger.kernel.org with ESMTP
	id <S288058AbSCGAIm>; Wed, 6 Mar 2002 19:08:42 -0500
Message-ID: <11E89240C407D311958800A0C9ACF7D13A76DA@EXCHANGE>
From: Ed Vance <EdV@macrolink.com>
To: "'linux-serial'" <linux-serial@vger.kernel.org>
Cc: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
        "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: [PATCH] serial driver - add missing I/O memory logic
Date: Wed, 6 Mar 2002 16:08:35 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Submitted for further discussion:

On Wed Mar 06 2002, Russell King wrote:
> The patch does fine for the most part, but I have two worries:
> 
> 1. the possibilities of pushing through changes in the IO or memory space
>    by changing the other space at the same time. (ie, port = 1, iomem =
>    0xfe007c00 and you already have a line at port = 0, iomem =
0xfe007c00).
>    I dealt with this properly using the resource management subsystem.
> 
> 2. there seems to be a lack of security considerations for changing the
>    iomem address.  (ie, changing the iomem address without CAP_SYS_ADMIN.
>    I added this as an extra check for change_port)

This patch adds code to function set_serial_info() to fix test
for port already in use. Previously, the test compared only the
I/O port field with each port in the table. This field is always
zero for I/O memory mapped cards. An additional compare with the
iomem_base field was added so that both the I/O port and I/O mem
always get compared. This works because the field not in use is 
always zero. This patch makes the function work with I/O memory 
cards as well or as badly as it did before with I/O port cards.

Created from kernel files rev 2.4.19-pre2

Contributor: Roman Kurakin <rik@cronyx.ru>


 Subject: Serial.c Bug
 Date: Wed, 14 Nov 2001 13:02:47 +0300
 From: Roman Kurakin <rik@cronyx.ru>
 To: linux-kernel@vger.kernel.org

   I have found a bug. It is in support of serial cards which uses 
   memory for I/O instead of ports. I made a patch for serial.c and
   fix one place, but probably the problem like this one could be
   somewhere else.
  
   If you try to use setserial with such cards you will get "Address in use"
   (-EADDRINUSE)
     
   Best regards,
   Roman Kurakin

diff -urN -X dontdiff.txt linux-2.4.19-pre2/drivers/char/serial.c
patched/drivers/char/serial.c
--- linux-2.4.19-pre2/drivers/char/serial.c	Sat Mar  2 10:38:11 2002
+++ patched/drivers/char/serial.c	Wed Mar  6 14:44:04 2002
@@ -2095,6 +2095,7 @@
 	unsigned int		i,change_irq,change_port;
 	int 			retval = 0;
 	unsigned long		new_port;
+	unsigned long           new_mem;
 
 	if (copy_from_user(&new_serial,new_info,sizeof(new_serial)))
 		return -EFAULT;
@@ -2105,6 +2106,8 @@
 	if (HIGH_BITS_OFFSET)
 		new_port += (unsigned long) new_serial.port_high <<
HIGH_BITS_OFFSET;
 
+	new_mem = new_serial.iomem_base;
+
 	change_irq = new_serial.irq != state->irq;
 	change_port = (new_port != ((int) state->port)) ||
 		(new_serial.hub6 != state->hub6);
@@ -2145,6 +2148,7 @@
 		for (i = 0 ; i < NR_PORTS; i++)
 			if ((state != &rs_table[i]) &&
 			    (rs_table[i].port == new_port) &&
+			    (rs_table[i].iomem_base == new_mem) &&
 			    rs_table[i].type)
 				return -EADDRINUSE;
 	}


---------------------------------------------------------------- 
Ed Vance              serial24@macrolink.com
Macrolink, Inc.       1500 N. Kellogg Dr  Anaheim, CA  92807
PH 714.777.8800 x335  Fax 714.777.8807  http://www.macrolink.com 
----------------------------------------------------------------


