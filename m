Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287591AbSBKJIJ>; Mon, 11 Feb 2002 04:08:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287632AbSBKJH6>; Mon, 11 Feb 2002 04:07:58 -0500
Received: from hanoi.cronyx.ru ([144.206.181.53]:26640 "EHLO hanoi.cronyx.ru")
	by vger.kernel.org with ESMTP id <S287591AbSBKJHs>;
	Mon, 11 Feb 2002 04:07:48 -0500
Message-ID: <3C6789F7.902@cronyx.ru>
Date: Mon, 11 Feb 2002 12:08:07 +0300
From: Roman Kurakin <rik@cronyx.ru>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Patch 2.4.18-pre9-SERIAL:Address in use error, mem based cards
Content-Type: multipart/mixed;
 boundary="------------050302070601090403040801"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050302070601090403040801
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

  I have found a bug. It is in support of serial cards which uses memory 
for I/O
insted of ports. I made a patch for serial.c and fix one place, but 
probably the
problem like this one could be somewhere else.

Description:
  If you try to use setserial with such cards you will get "Address in 
use" (-EADDRINUSE)

Best regards,
                      Kurakin Roman

--------------050302070601090403040801
Content-Type: text/plain;
 name="serial-2.4.18.pch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="serial-2.4.18.pch"

--- serial.c.orig	Mon Feb 11 11:54:21 2002
+++ serial.c	Mon Feb 11 11:55:44 2002
@@ -2084,6 +2084,7 @@
 	unsigned int		i,change_irq,change_port;
 	int 			retval = 0;
 	unsigned long		new_port;
+	unsigned long           new_mem;
 
 	if (copy_from_user(&new_serial,new_info,sizeof(new_serial)))
 		return -EFAULT;
@@ -2094,6 +2095,8 @@
 	if (HIGH_BITS_OFFSET)
 		new_port += (unsigned long) new_serial.port_high << HIGH_BITS_OFFSET;
 
+	new_mem = new_serial.iomem_base;
+
 	change_irq = new_serial.irq != state->irq;
 	change_port = (new_port != ((int) state->port)) ||
 		(new_serial.hub6 != state->hub6);
@@ -2134,6 +2137,7 @@
 		for (i = 0 ; i < NR_PORTS; i++)
 			if ((state != &rs_table[i]) &&
 			    (rs_table[i].port == new_port) &&
+			    (rs_table[i].iomem_base == new_mem) &&
 			    rs_table[i].type)
 				return -EADDRINUSE;
 	}

--------------050302070601090403040801--

