Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280402AbRKNKIQ>; Wed, 14 Nov 2001 05:08:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280415AbRKNKIH>; Wed, 14 Nov 2001 05:08:07 -0500
Received: from hanoi.cronyx.ru ([144.206.181.53]:32019 "EHLO hanoi.cronyx.ru")
	by vger.kernel.org with ESMTP id <S280402AbRKNKHy>;
	Wed, 14 Nov 2001 05:07:54 -0500
Message-ID: <3BF24147.9030508@cronyx.ru>
Date: Wed, 14 Nov 2001 13:02:47 +0300
From: Roman Kurakin <rik@cronyx.ru>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.2) Gecko/20010726 Netscape6/6.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Serial.c Bug
Content-Type: multipart/mixed;
 boundary="------------060403040604090801080900"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060403040604090801080900
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

  Hi,

    I have found a bug. It is in support of serial cards which uses 
memory for I/O
insted of ports. I made a patch for serial.c and fix one place, but 
probably the
problem like this one could be somewhere else.

    If you try to use setserial with such cards you will get "Address in 
use" (-EADDRINUSE)

Best regards,
                        Kurakin Roman


--------------060403040604090801080900
Content-Type: text/plain;
 name="serial.pch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="serial.pch"

--- serial.c.orig	Tue Nov 13 20:50:16 2001
+++ serial.c	Tue Nov 13 20:52:28 2001
@@ -2077,6 +2077,7 @@
 	unsigned int		i,change_irq,change_port;
 	int 			retval = 0;
 	unsigned long		new_port;
+	unsigned long           new_mem;
 
 	if (copy_from_user(&new_serial,new_info,sizeof(new_serial)))
 		return -EFAULT;
@@ -2087,6 +2088,8 @@
 	if (HIGH_BITS_OFFSET)
 		new_port += (unsigned long) new_serial.port_high << HIGH_BITS_OFFSET;
 
+	new_mem = new_serial.iomem_base;
+
 	change_irq = new_serial.irq != state->irq;
 	change_port = (new_port != ((int) state->port)) ||
 		(new_serial.hub6 != state->hub6);
@@ -2127,6 +2130,7 @@
 		for (i = 0 ; i < NR_PORTS; i++)
 			if ((state != &rs_table[i]) &&
 			    (rs_table[i].port == new_port) &&
+			    (rs_table[i].iomem_base == new_mem) &&
 			    rs_table[i].type)
 				return -EADDRINUSE;
 	}

--------------060403040604090801080900--

