Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266678AbUG0Wyj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266678AbUG0Wyj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 18:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266689AbUG0Wyj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 18:54:39 -0400
Received: from mx1.redhat.com ([66.187.233.31]:7048 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266678AbUG0Wxw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 18:53:52 -0400
Date: Tue, 27 Jul 2004 18:53:07 -0400
From: Alan Cox <alan@redhat.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: PATCH: fix SMM failures on E750x systems
Message-ID: <20040727225307.GA20013@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fedora 2 showed up a pattern of failing SMP E750x chipset systems. Initial
investigation suggests that the SMM code for these fails on all but the boot
processor. Code inspection also found an apparent i8042 access delay violation.

This patch has been tested with Fedora users affected by the problem and
appears to do the trick. With this fixed the only clear keyboard problems
we see are in EMachines 680[57] (but not 9 it appears) AMD64 laptops.

The fix is fairly simple. On a box that fails to respond correctly we
disable SMM emulation for PS/2 ports via USB devices. Another approach
would be to disable it always or to load USB first. Both of these other
approaches broke other systems in different ways.

Alan

Patch-By: Alan Cox <alan@redhat.com>
OSDL Certificate Of Origin 1.0 included herein by reference


diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.7/drivers/input/serio/i8042.c 2.6.7-ac/drivers/input/serio/i8042.c
--- linux-2.6.7/drivers/input/serio/i8042.c	2004-06-16 21:11:35.000000000 +0100
+++ 2.6.7-ac/drivers/input/serio/i8042.c	2004-07-12 17:13:50.000000000 +0100
@@ -21,6 +21,7 @@
 #include <linux/sysdev.h>
 #include <linux/pm.h>
 #include <linux/serio.h>
+#include <linux/pci.h>
 
 #include <asm/io.h>
 
@@ -131,6 +132,7 @@
 	spin_lock_irqsave(&i8042_lock, flags);
 
 	while ((i8042_read_status() & I8042_STR_OBF) && (i++ < I8042_BUFFER_SIZE)) {
+		udelay(50);
 		data = i8042_read_data();
 		dbg("%02x <- i8042 (flush, %s)", data,
 			i8042_read_status() & I8042_STR_AUXDATA ? "aux" : "kbd");
@@ -669,6 +671,69 @@
 }
 
 
+static int i8042_spank_usb(void)
+{
+	struct pci_dev *usb = NULL;
+	int found = 0;
+	u16 word;
+	unsigned long addr;
+	unsigned long len;
+	int i;
+	
+	while((usb = pci_find_class((PCI_CLASS_SERIAL_USB << 8), usb)) != NULL)
+	{
+		/* UHCI controller not in legacy ? */
+		
+		pci_read_config_word(usb, 0xC0, &word);
+		if(word & 0x2000)
+			continue;
+			
+		/* Check it is enabled. If the port is active in legacy mode
+		   then this will be mapped already */
+		   
+		for(i = 0; i < PCI_ROM_RESOURCE; i++)
+		{
+			if (!(pci_resource_flags (usb, i) & IORESOURCE_IO))
+				continue;
+		}
+		if(i == PCI_ROM_RESOURCE)
+			continue;
+		
+		/*
+		 *	Retrieve the bits
+		 */
+		    
+		addr = pci_resource_start(usb, i);
+		len = pci_resource_len (usb, i);
+		
+		/*
+		 *	Check its configured and not in use
+		 */
+		if(addr == 0)
+			continue;
+		if (request_region(addr, len, "usb whackamole"))
+			continue;
+				
+		/*
+		 *	Kick the problem controller out of legacy mode
+		 *	so things like the E750x don't break
+		 */
+		
+		outw(0, addr + 4);		/* IRQ Mask */
+		outw(4, addr);			/* Reset */
+		msleep(20);
+		outw(0, addr);
+		
+		msleep(20);
+		/* Now take if off the BIOS */
+		pci_write_config_word(usb, 0xC0, 0x2000);
+		release_region(addr, len);
+
+		found = 1;
+	}
+	return found;
+}
+
 /*
  * i8042_controller init initializes the i8042 controller, and,
  * most importantly, sets it into non-xlated mode if that's
@@ -677,6 +742,7 @@
 
 static int i8042_controller_init(void)
 {
+	int tries = 0;
 
 /*
  * Test the i8042. We need to know if it thinks it's working correctly
@@ -705,9 +771,15 @@
  * Save the CTR for restoral on unload / reboot.
  */
 
-	if (i8042_command(&i8042_ctr, I8042_CMD_CTL_RCTR)) {
-		printk(KERN_ERR "i8042.c: Can't read CTR while initializing i8042.\n");
-		return -1;
+	while(i8042_command(&i8042_ctr, I8042_CMD_CTL_RCTR)) {
+		if(tries > 3 || !i8042_spank_usb())
+		{
+			printk(KERN_ERR "i8042.c: Can't read CTR while initializing i8042.\n");
+			return -1;
+		}
+		printk(KERN_WARNING "i8042.c: Can't read CTR, disabling USB legacy and retrying.\n");
+		i8042_flush();
+		tries++;
 	}
 
 	i8042_initial_ctr = i8042_ctr;




