Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290744AbSA3XcV>; Wed, 30 Jan 2002 18:32:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290743AbSA3XcL>; Wed, 30 Jan 2002 18:32:11 -0500
Received: from mailout08.sul.t-online.com ([194.25.134.20]:54212 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S290742AbSA3Xbz>; Wed, 30 Jan 2002 18:31:55 -0500
Date: Thu, 31 Jan 2002 00:31:30 +0100
From: Andi Kleen <ak@muc.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, davej@suse.de
Subject: [PATCH] Fix rocket port driver
Message-ID: <20020131003130.A1413@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch fixes the rocketport serial driver to compile again
(after the kdev_t changes) and also adds support for a rocketport 
card I managed to buy second hand with a non standard pci ID. 

Patch for 2.5.3. Please apply.

-Andi


--- linux-2.5.3-work/drivers/char/rocket.c-o	Fri Sep 21 19:55:22 2001
+++ linux-2.5.3-work/drivers/char/rocket.c	Wed Jan 30 23:00:48 2002
@@ -227,7 +227,7 @@
 	if (!info)
 		return 1;
 	if (info->magic != RPORT_MAGIC) {
-		printk(badmagic, MAJOR(device), MINOR(device), routine);
+		printk(badmagic, major(device), minor(device), routine);
 		return 1;
 	}
 #endif
@@ -896,7 +896,7 @@
 	CHANNEL_t	*cp;
 	unsigned long page;
 	
-	line = MINOR(tty->device) - tty->driver.minor_start;
+	line = minor(tty->device) - tty->driver.minor_start;
 	if ((line < 0) || (line >= MAX_RP_PORTS))
 		return -ENODEV;
 	if (!tmp_buf) {
@@ -1467,7 +1467,7 @@
 {
 	if (tty)
 		sprintf(buf, "%s%d", tty->driver.name,
-			MINOR(tty->device) - tty->driver.minor_start +
+			minor(tty->device) - tty->driver.minor_start +
 			tty->driver.name_base);
 	else
 		strcpy(buf, "NULL tty");
@@ -1964,6 +1964,10 @@
 		str = "8-port Modem";
 		max_num_aiops = 1;
 		break;
+	case 0x8:
+		str = "mysterious 8 port"; 
+		max_num_aiops = 1; 
+		break;
 	default:
 		str = "(unknown/unsupported)";
 		max_num_aiops = 0;
@@ -2042,6 +2046,10 @@
 			PCI_DEVICE_ID_RP8M, i, &bus, &device_fn)) 
 			if(register_PCI(count+boards_found, bus, device_fn))
 				count++;
+		if(!pcibios_find_device(PCI_VENDOR_ID_RP,
+			0x8, i, &bus, &device_fn)) 
+			if(register_PCI(count+boards_found, bus, device_fn))
+				count++;	
 	}
 	return(count);
 }

