Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263398AbTGOGNB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 02:13:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263542AbTGOGNB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 02:13:01 -0400
Received: from auth22.inet.co.th ([203.150.14.104]:33031 "EHLO
	auth22.inet.co.th") by vger.kernel.org with ESMTP id S263398AbTGOGM6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 02:12:58 -0400
From: Michael Frank <mflt1@micrologica.com.hk>
To: Russell King <rmk@arm.linux.org.uk>
Subject: Re: 2.5.75-mm1 yenta-socket lsPCI IRQ reads incorrect
Date: Tue, 15 Jul 2003 14:08:33 +0800
User-Agent: KMail/1.5.2
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>,
       John Belmonte <jvb@prairienet.org>
References: <200307141333.03911.mflt1@micrologica.com.hk> <20030714155051.A31395@flint.arm.linux.org.uk> <200307151331.40428.mflt1@micrologica.com.hk>
In-Reply-To: <200307151331.40428.mflt1@micrologica.com.hk>
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307151408.34189.mflt1@micrologica.com.hk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This one fixes the order of printing the state info in yenta_suspend

diff -uN drivers/pcmcia/yenta_socket.c.orig drivers/pcmcia/yenta_socket.c
--- drivers/pcmcia/yenta_socket.c.orig  2003-07-15 12:39:52.000000000 +0800
+++ drivers/pcmcia/yenta_socket.c       2003-07-15 14:22:28.000000000 +0800
@@ -577,7 +577,9 @@
        struct yenta_socket *socket = container_of(sock, struct yenta_socket, socket);

        pci_set_power_state(socket->dev, 0);
-       pci_restore_state(socket->dev, socket->saved_state);
+
+	pci_restore_state(socket->dev, socket->saved_state);
+	printk("Yenta: init restored state %x\n",(u8)socket->saved_state[0xf]);

        yenta_config_init(socket);
        yenta_clear_maps(socket);
@@ -597,6 +599,7 @@
        cb_writel(socket, CB_SOCKET_MASK, 0x0);

        pci_save_state(socket->dev, socket->saved_state);
+	printk("Yenta: suspend saved state %x\n",(u8)socket->saved_state[0xf]);

        /*
         * This does not work currently. The controller
@@ -867,8 +870,6 @@
        /* Set up the bridge regions.. */
        yenta_allocate_resources(socket);

-       pci_save_state(dev, socket->saved_state);
-
        socket->cb_irq = dev->irq;

        /* Do we have special options for the device? */
@@ -897,6 +898,10 @@
        /* Figure out what the dang thing can do for the PCMCIA layer... */
        yenta_get_socket_capabilities(socket, isa_interrupts);
        printk("Socket status: %08x\n", cb_readl(socket, CB_SOCKET_STATE));
+	pci_save_state(dev, socket->saved_state);
+	printk("Yenta: probe saved state %x\n",(u8)socket->saved_state[0xf]);
+	(u8)socket->saved_state[0xf] = socket->cb_irq;
+	printk("Yenta: probe saved state irq fixed %x\n",(u8)socket->saved_state[0xf]);

        /* Register it with the pcmcia layer.. */
        return pcmcia_register_socket(&socket->socket);

Regards
Michael

-- 
Powered by linux-2.5.75-mm1. Compiled with gcc-2.95-3 - mature and rock solid

My current linux related activities:
- 2.5 yenta_socket testing
- Test development and testing of swsusp for 2.4/2.5 and ACPI S3 of 2.5 kernel 
- Everyday usage of 2.5 kernel

More info on 2.5 kernel: http://www.codemonkey.org.uk/post-halloween-2.5.txt
More info on swsusp: http://sourceforge.net/projects/swsusp/

