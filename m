Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261759AbVGaRJk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261759AbVGaRJk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 13:09:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261783AbVGaRJk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 13:09:40 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60329 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261759AbVGaRJj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 13:09:39 -0400
Date: Sun, 31 Jul 2005 10:09:27 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       Daniel Ritz <daniel.ritz@gmx.ch>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Len Brown <len.brown@intel.com>
Subject: Re: revert yenta free_irq on suspend
In-Reply-To: <Pine.LNX.4.58.0507310847560.29650@g5.osdl.org>
Message-ID: <Pine.LNX.4.58.0507311007240.29650@g5.osdl.org>
References: <Pine.LNX.4.61.0507301952350.3319@goblin.wat.veritas.com>
 <Pine.LNX.4.58.0507301331260.29650@g5.osdl.org> <20050731132958.GB14550@elf.ucw.cz>
 <Pine.LNX.4.58.0507310847560.29650@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 31 Jul 2005, Linus Torvalds wrote:
> 
> We'll revert to the behaviour that it has traditionally had, and start 
> working forwards in a more careful manner. Where we don't break working 
> setups.

Here's a suggested revert (a pure "patch -R" won't work, since there's 
been other differences since). It works for me, and suspends/resumes from 
RAM on my EVO with all the irq links getting re-programmed (dmesg is very 
clear about that ;).

It's pretty much the old 2.6.12 code, updated for the refcounting etc.

		Linus

----
diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -776,15 +776,25 @@ end:
 }
 
 static int
-irqrouter_suspend(
-	struct sys_device *dev,
-	u32	state)
+acpi_pci_link_resume(
+	struct acpi_pci_link *link)
+{
+	ACPI_FUNCTION_TRACE("acpi_pci_link_resume");
+
+	if (link->refcnt && link->irq.active && link->irq.initialized)
+		return_VALUE(acpi_pci_link_set(link, link->irq.active));
+	else
+		return_VALUE(0);
+}
+
+static int
+irqrouter_resume(
+	struct sys_device *dev)
 {
 	struct list_head        *node = NULL;
 	struct acpi_pci_link    *link = NULL;
-	int			ret = 0;
 
-	ACPI_FUNCTION_TRACE("irqrouter_suspend");
+	ACPI_FUNCTION_TRACE("irqrouter_resume");
 
 	list_for_each(node, &acpi_link.entries) {
 		link = list_entry(node, struct acpi_pci_link, node);
@@ -793,24 +803,11 @@ irqrouter_suspend(
 				"Invalid link context\n"));
 			continue;
 		}
-		if (link->irq.initialized && link->refcnt != 0
-			/* We ignore legacy IDE device irq */
-			&& link->irq.active != 14 && link->irq.active !=15) {
-			printk(KERN_WARNING PREFIX
-				"%d drivers with interrupt %d neglected to call"
-				" pci_disable_device at .suspend\n",
-				link->refcnt,
-				link->irq.active);
-			printk(KERN_WARNING PREFIX
-				"Fix the driver, or rmmod before suspend\n");
-			link->refcnt = 0;
-			ret = -EINVAL;
-		}
+		acpi_pci_link_resume(link);
 	}
-	return_VALUE(ret);
+	return_VALUE(0);
 }
 
-
 static int
 acpi_pci_link_remove (
 	struct acpi_device	*device,
@@ -922,7 +919,7 @@ __setup("acpi_irq_balance", acpi_irq_bal
 /* FIXME: we will remove this interface after all drivers call pci_disable_device */
 static struct sysdev_class irqrouter_sysdev_class = {
         set_kset_name("irqrouter"),
-        .suspend = irqrouter_suspend,
+        .resume = irqrouter_resume,
 };
 
 
