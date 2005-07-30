Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263138AbVG3WY3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263138AbVG3WY3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 18:24:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263161AbVG3WY2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 18:24:28 -0400
Received: from grendel.sisk.pl ([217.67.200.140]:25275 "HELO mail.sisk.pl")
	by vger.kernel.org with SMTP id S263138AbVG3WXN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 18:23:13 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: revert yenta free_irq on suspend
Date: Sun, 31 Jul 2005 00:28:19 +0200
User-Agent: KMail/1.8.1
Cc: Linus Torvalds <torvalds@osdl.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       Daniel Ritz <daniel.ritz@gmx.ch>, Len Brown <len.brown@intel.com>
References: <Pine.LNX.4.61.0507301952350.3319@goblin.wat.veritas.com> <20050730215403.J26592@flint.arm.linux.org.uk> <Pine.LNX.4.58.0507301404240.29650@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507301404240.29650@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507310028.20699.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, 30 of July 2005 23:10, Linus Torvalds wrote:
> 
> On Sat, 30 Jul 2005, Russell King wrote:
> > 
> > I don't think so - I believe one of the problem cases is where you
> > have a screaming interrupt caused by an improperly setup device.
> 
> Not a problem.
> 
> The thing is, this is trivially solved by
>  - disable irq controller last on shutdown
>  - re-enable irq controller last on resume
> 
> Think about it. Even if you have screaming irq's (and thus we'll shut
> things down somewhere during the resume), when we then get to re-enable
> the irq controller thing, we'll have them all back again at that point.
> Problem solved.
> 
> You can have variations on this, of course - you can enable the irq
> controller early _and_ late in the resume process. Ie do a minimal "get
> the basics working" early - you might want to make sure that timers etc
> work early on, for example, and then a "fix up the details" thing late.
> 
> An interrupt controller is clearly a special case, so it's worth spending 
> some effort on handling it.
> 
> In contrast, what is _not_ worth doing is screweing over every single
> driver we have.

Well, they have _already_ been screwed by the following patch that went
to your tree with the ACPI update.  If you drop it, all problems related to
freeing/requesting IRQs on suspend/resume will be gone.

Please note, however, that what it does is to get rid of unconditional setting
ACPI PCI links on resume in hope that someone will take care of them later,
which is not quite right, so to speak.

In my opinion the time for introducing this change is not the best, to put it
lightly, but it looks like it will have to be made at some point.    Still I'm not
an ACPI expert, so Len could you please advise?

Greets,
Rafael


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
 
 

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
