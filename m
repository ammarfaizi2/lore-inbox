Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291148AbSBGO41>; Thu, 7 Feb 2002 09:56:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291150AbSBGO4T>; Thu, 7 Feb 2002 09:56:19 -0500
Received: from hanoi.cronyx.ru ([144.206.181.53]:56840 "EHLO hanoi.cronyx.ru")
	by vger.kernel.org with ESMTP id <S291148AbSBGO4O>;
	Thu, 7 Feb 2002 09:56:14 -0500
Message-ID: <3C629514.6080209@cronyx.ru>
Date: Thu, 07 Feb 2002 17:54:12 +0300
From: Roman Kurakin <rik@cronyx.ru>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Serial.c driver problem 2.4.17
Content-Type: multipart/mixed;
 boundary="------------090908010502060800080003"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090908010502060800080003
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

   I have found a bug. It is in support of serial cards which uses 
memory for I/O
insted of ports. I made a patch for serial.c and fix one place, but 
probably the
problem like this one could be somewhere else.

Description:
   If you try to use setserial with such cards you will get "Address in 
use" (-EADDRINUSE)

Best regards,
                       Kurakin Roman


--------------090908010502060800080003
Content-Type: text/plain;
 name="serial_2.4.17.pch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="serial_2.4.17.pch"

--- serial.c.orig	Fri Dec 21 20:41:54 2001
+++ serial.c	Fri Jan 25 15:00:20 2002
@@ -2084,6 +2084,7 @@
 	unsigned int		i,change_irq,change_port;
 	int 			retval = 0;
 	unsigned long		new_port;
+	unsigned long		new_mem;
 
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

--------------090908010502060800080003--

