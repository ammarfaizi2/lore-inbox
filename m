Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261602AbVCYLTb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbVCYLTb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 06:19:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261614AbVCYLTb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 06:19:31 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:64147 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261602AbVCYLTS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 06:19:18 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Li Shaohua <shaohua.li@intel.com>
Subject: Re: 2.6.12-rc1-mm1: resume regression [update] (was: Re:2.6.12-rc1-mm1: Kernel BUG at pci:389)
Date: Fri, 25 Mar 2005 12:19:23 +0100
User-Agent: KMail/1.7.1
References: <1111626180.17317.921.camel@d845pe> <200503241442.14604.rjw@sisk.pl> <1111711799.23113.4.camel@sli10-desk.sh.intel.com>
In-Reply-To: <1111711799.23113.4.camel@sli10-desk.sh.intel.com>
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       lkml <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503251219.24202.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Friday, 25 of March 2005 01:49, you wrote:
]--snip--[
> > > I actually added such calls in uhci, ehci and yenta. It's ok for S3 (and
> > > definitely required for S3). Unclear if it's ok for S4, so please try
> > > revert the patch.
> > 
> > 2.6.11-rc1-mm1 with the patch reverted works fine. :-)
> So just remove the pci_enable/disable_device call in the driver makes
> the system work?

I'm a bit confused. :-)  I'm not sure if the patch that I have reverted is related
to pci_enable/disable_device.  It's this one:

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


Greets,
Rafael 


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
