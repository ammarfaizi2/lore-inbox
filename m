Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263736AbUJ3Ad0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263736AbUJ3Ad0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 20:33:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263751AbUJ3Aao
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 20:30:44 -0400
Received: from gate.crashing.org ([63.228.1.57]:35474 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263727AbUJ3ATt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 20:19:49 -0400
Subject: PCI changes kill USB PM
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Greg KH <greg@kroah.com>, David Brownell <david-b@pacbell.net>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Sat, 30 Oct 2004 10:14:04 +1000
Message-Id: <1099095245.29689.191.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

The recent PCI changes are killing USB Power Management, and maybe more.
The problem is that the common PCI code will now always call
pci_save_state() after calling the pci_driver->suspend().

The USB suspend() code does pci_save_state() then pci_disable_device(),
which clears PCI_COMMAND_MASTER in the PCI command register.

So when later on, the PCI core calls pci_save_state() again, it saves a
state that corresponds to a suspended device with the command register
"disabled".

On wakeup, USB does pci_set_mater() then pci_restore_state(). Now, what
happen is that the later "undos" the work done by pci_set_master(),
restoring a command register with PCI_COMMAND_MASTER clear. Bad bad bad.

This triggers a very funny behaviour on pmac laptops btw, for some
reason, the Apple IO ASIC that contains the 2 OHCI's along with a bunch
of other devices like IDE gets crazy of this situation (the controller
is enabled, tries to bus master, but isn't allowed to do so by it's
command reg) and the whole ASIC seem to lose all sense of PCI
arbitration, IDE throughput goes down to about 40Kb/sec for example...

There are 2 issues here. One is that USB should definitely call
pci_set_master() _after_ pci_resume_state(), though it shouldn't need to
call it at all ...

The other one is that I don't like the asymetry in the PCI core of one
side always calling pci_save_state() after the driver suspend() while
the other side only calls pci_restore_state() when there is no driver
resume()... I really prefer having save_state & restore_state 100% under
driver control when the driver has suspend & resume routines.

This patch takes cares of both, Andrew, do not apply before Ack from
Greg since the change in the PCI code may affect some other things (I
hope you didn't start removing calls to pci_save_state() from
drivers ? :)

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/drivers/usb/core/hcd-pci.c
===================================================================
--- linux-work.orig/drivers/usb/core/hcd-pci.c	2004-10-20 13:01:02.000000000 +1000
+++ linux-work/drivers/usb/core/hcd-pci.c	2004-10-29 17:57:52.027929064 +1000
@@ -366,7 +366,6 @@
 			"can't restore IRQ after resume!\n");
 		return retval;
 	}
-	pci_set_master (dev);
 	pci_restore_state (dev);
 #ifdef	CONFIG_USB_SUSPEND
 	pci_enable_wake (dev, dev->current_state, 0);
Index: linux-work/drivers/pci/pci-driver.c
===================================================================
--- linux-work.orig/drivers/pci/pci-driver.c	2004-10-20 13:01:02.000000000 +1000
+++ linux-work/drivers/pci/pci-driver.c	2004-10-29 17:57:44.202118768 +1000
@@ -308,8 +308,8 @@
 	dev_state = state_conversion[state];
 	if (drv && drv->suspend)
 		i = drv->suspend(pci_dev, dev_state);
-		
-	pci_save_state(pci_dev);
+	else
+		pci_save_state(pci_dev);
 	return i;
 }
 


