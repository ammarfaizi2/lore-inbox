Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261604AbVCYL3p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261604AbVCYL3p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 06:29:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261608AbVCYL3p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 06:29:45 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:17556 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261604AbVCYL3i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 06:29:38 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.12-rc1-mm3: box hangs solid on resume from disk while resuming device drivers
Date: Fri, 25 Mar 2005 12:29:47 +0100
User-Agent: KMail/1.7.1
Cc: Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org,
       Li Shaohua <shaohua.li@intel.com>, Pavel Machek <pavel@suse.cz>
References: <20050325002154.335c6b0b.akpm@osdl.org>
In-Reply-To: <20050325002154.335c6b0b.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503251229.47705.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Friday, 25 of March 2005 09:21, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc1/2.6.12-rc1-mm3/
> 
> - Mainly a bunch of fixes relative to 2.6.12-rc1-mm2.

First, rmmod works again (thanks ;-)).

> - Again, we'd like people who have had recent DRM and USB resume problems to
>   test and report, please.

My box is still hanged solid on resume (swsusp) by the drivers:

ohci_hcd
ehci_hcd
yenta_socket

possibly others, too.  To avoid this, I had to revert the following patch from
the Len's tree:

diff -Naru a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
--- a/drivers/acpi/pci_link.c	2005-03-24 04:57:27 -08:00
+++ b/drivers/acpi/pci_link.c	2005-03-24 04:57:27 -08:00
@@ -72,10 +72,12 @@
 	u8			active;			/* Current IRQ */
 	u8			edge_level;		/* All IRQs */
 	u8			active_high_low;	/* All IRQs */
-	u8			initialized;
 	u8			resource_type;
 	u8			possible_count;
 	u8			possible[ACPI_PCI_LINK_MAX_POSSIBLE];
+	u8			initialized:1;
+	u8			suspend_resume:1;
+	u8			reserved:6;
 };
 
 struct acpi_pci_link {
@@ -530,6 +532,10 @@
 
 	ACPI_FUNCTION_TRACE("acpi_pci_link_allocate");
 
+	if (link->irq.suspend_resume) {
+		acpi_pci_link_set(link, link->irq.active);
+		link->irq.suspend_resume = 0;
+	}
 	if (link->irq.initialized)
 		return_VALUE(0);
 
@@ -713,38 +719,24 @@
 	return_VALUE(result);
 }
 
-
-static int
-acpi_pci_link_resume (
-	struct acpi_pci_link	*link)
-{
-	ACPI_FUNCTION_TRACE("acpi_pci_link_resume");
-	
-	if (link->irq.active && link->irq.initialized)
-		return_VALUE(acpi_pci_link_set(link, link->irq.active));
-	else
-		return_VALUE(0);
-}
-
-
 static int
-irqrouter_resume(
-	struct sys_device *dev)
+irqrouter_suspend(
+	struct sys_device *dev,
+	u32	state)
 {
 	struct list_head        *node = NULL;
 	struct acpi_pci_link    *link = NULL;
 
-	ACPI_FUNCTION_TRACE("irqrouter_resume");
+	ACPI_FUNCTION_TRACE("irqrouter_suspend");
 
 	list_for_each(node, &acpi_link.entries) {
-
 		link = list_entry(node, struct acpi_pci_link, node);
 		if (!link) {
 			ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid link context\n"));
 			continue;
 		}
-
-		acpi_pci_link_resume(link);
+		if (link->irq.active && link->irq.initialized)
+			link->irq.suspend_resume = 1;
 	}
 	return_VALUE(0);
 }
@@ -856,7 +848,7 @@
 
 static struct sysdev_class irqrouter_sysdev_class = {
         set_kset_name("irqrouter"),
-        .resume = irqrouter_resume,
+        .suspend = irqrouter_suspend,
 };
 
 
# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2005/03/18 16:30:29-05:00 len.brown@intel.com 
#   [ACPI] S3 Suspend to RAM: interrupt resume fix
#   
#   Delete PCI Interrupt Link Device .resume method --
#   it is the device driver's job to request interrupts,
#   not the Link's job to remember what the devices want.
#   
#   This addresses the issue of attempting to run
#   the ACPI interpreter too early in resume, when
#   interrupts are still disabled.
#   
#   http://bugzilla.kernel.org/show_bug.cgi?id=3469
#   
#   Signed-off-by: David Shaohua Li <shaohua.li@intel.com>
#   Signed-off-by: Len Brown <len.brown@intel.com>
# 
# drivers/acpi/pci_link.c
#   2005/03/02 22:23:50-05:00 len.brown@intel.com +14 -22
#   Delete PCI Interrupt Link .resume method
# 

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
