Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269309AbTCDHdZ>; Tue, 4 Mar 2003 02:33:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269310AbTCDHdZ>; Tue, 4 Mar 2003 02:33:25 -0500
Received: from natsmtp01.webmailer.de ([192.67.198.81]:31687 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S269309AbTCDHdX>; Tue, 4 Mar 2003 02:33:23 -0500
Date: Tue, 4 Mar 2003 08:39:15 +0100
From: Dominik Brodowski <linux@brodo.de>
To: torvalds@transmeta.com, jt@hpl.hp.com
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>
Subject: [PATCH] pcmcia: get initialization ordering right [Was: [PATCH 2.5] : i82365 & platform_bus_type]
Message-ID: <20030304073915.GA5545@brodo.de>
References: <20030304013020.GC11349@bougret.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030304013020.GC11349@bougret.hpl.hp.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Mar 03, 2003 at 05:30:20PM -0800, Jean Tourrilhes wrote:
> 	Hi,
> 
> 	I'm trying to get i82365 to work again, because I need to test
<snip>
> Intel PCIC probe: 
>   Vadem VG-469 ISA-to-PCMCIA at port 0x3e0 ofs 0x00, 2 sockets
>     host opts [0]: none
>     host opts [1]: none
>     ISA irqs (scanned) = 4,5 polling interval = 1000 ms
> ds: no socket drivers loaded!

Sorry about that -- I mixed up the ordering of initializing the class data
and registering the platform device. Here's a bugfix for the three pcmcia
socket drivers that are platform devices.

Please apply,
	Dominik

diff -ruN linux-original/drivers/pcmcia/hd64465_ss.c linux/drivers/pcmcia/hd64465_ss.c
--- linux-original/drivers/pcmcia/hd64465_ss.c	2003-03-04 08:27:06.000000000 +0100
+++ linux/drivers/pcmcia/hd64465_ss.c	2003-03-04 08:30:37.000000000 +0100
@@ -1070,8 +1070,8 @@
 	}
 
 /*	hd64465_io_debug = 0; */
-	platform_device_register(&hd64465_device);
 	hd64465_device.dev.class_data = &hd64465_data;
+	platform_device_register(&hd64465_device);
 
 	return 0;
 }
diff -ruN linux-original/drivers/pcmcia/i82365.c linux/drivers/pcmcia/i82365.c
--- linux-original/drivers/pcmcia/i82365.c	2003-03-04 08:27:06.000000000 +0100
+++ linux/drivers/pcmcia/i82365.c	2003-03-04 08:28:28.000000000 +0100
@@ -1628,11 +1628,11 @@
 	request_irq(cs_irq, pcic_interrupt, 0, "i82365", pcic_interrupt);
 #endif
     
-    platform_device_register(&i82365_device);
-
     i82365_data.nsock = sockets;
     i82365_device.dev.class_data = &i82365_data;
     
+    platform_device_register(&i82365_device);
+
     /* Finally, schedule a polling interrupt */
     if (poll_interval != 0) {
 	poll_timer.function = pcic_interrupt_wrapper;
diff -ruN linux-original/drivers/pcmcia/tcic.c linux/drivers/pcmcia/tcic.c
--- linux-original/drivers/pcmcia/tcic.c	2003-03-04 08:27:06.000000000 +0100
+++ linux/drivers/pcmcia/tcic.c	2003-03-04 08:30:03.000000000 +0100
@@ -452,8 +452,6 @@
 	sockets++;
     }
 
-    platform_device_register(&tcic_device);
-
     switch (socket_table[0].id) {
     case TCIC_ID_DB86082:
 	printk("DB86082"); break;
@@ -527,6 +525,8 @@
     tcic_data.nsock = sockets;
     tcic_device.dev.class_data = &tcic_data;
 
+    platform_device_register(&tcic_device);
+
     return 0;
     
 } /* init_tcic */
