Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265377AbUFWMok@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265377AbUFWMok (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 08:44:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266055AbUFWMok
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 08:44:40 -0400
Received: from mail.donpac.ru ([80.254.111.2]:46217 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S265377AbUFWMof (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 08:44:35 -0400
Subject: [PATCH 0/6] 2.6.7-mm1, port Acer laptop irq routing workaround to new DMI probing
In-Reply-To: 
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Wed, 23 Jun 2004 16:44:31 +0400
Message-Id: <10879946711727@donpac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Andrey Panin <pazke@donpac.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch moves PCI IRQ routing workaround for Acer TravelMate 360
laptop to arch/i386/pci/irq.c and makes acer_tm360_irqrouting
variable static. It also fixes VisWs build error caused by this
workaround code.

Signed-off-by: Andrey Panin <pazke@donpac.ru>

 arch/i386/kernel/dmi_scan.c |   23 -----------------------
 arch/i386/pci/irq.c         |   23 ++++++++++++++++++++++-
 2 files changed, 22 insertions(+), 24 deletions(-)

diff -urpN -X /usr/share/dontdiff linux-2.6.7-mm1.vanilla/arch/i386/kernel/dmi_scan.c linux-2.6.7-mm1/arch/i386/kernel/dmi_scan.c
--- linux-2.6.7-mm1.vanilla/arch/i386/kernel/dmi_scan.c	Sun May 23 21:51:28 2004
+++ linux-2.6.7-mm1/arch/i386/kernel/dmi_scan.c	Sun May 23 21:51:34 2004
@@ -317,21 +317,6 @@ static __init int disable_smbus(struct d
 }
 
 /*
- * Work around broken Acer TravelMate 360 Notebooks which assign Cardbus to
- * IRQ 11 even though it is actually wired to IRQ 10
- */
-static __init int fix_acer_tm360_irqrouting(struct dmi_blacklist *d)
-{
-#ifdef CONFIG_PCI
-	extern int acer_tm360_irqrouting;
-	if (acer_tm360_irqrouting == 0) {
-		acer_tm360_irqrouting = 1;
-		printk(KERN_INFO "%s detected - fixing broken IRQ routing\n", d->ident);
-	}
-#endif
-	return 0;
-}
-/*
  *  Check for clue free BIOS implementations who use
  *  the following QA technique
  *
@@ -827,14 +812,6 @@ static __initdata struct dmi_blacklist d
 			MATCH(DMI_BIOS_VERSION, "1AET38WW (1.01b)"),
 			NO_MATCH, NO_MATCH
 			} },
-	 
-	{ fix_acer_tm360_irqrouting, "Acer TravelMate 36x Laptop", {
-			MATCH(DMI_SYS_VENDOR, "Acer"),
-			MATCH(DMI_PRODUCT_NAME, "TravelMate 360"),
-			NO_MATCH, NO_MATCH
-			} },
-
- 
 
 	/*
 	 *	Generic per vendor APM settings
diff -urpN -X /usr/share/dontdiff linux-2.6.7-mm1.vanilla/arch/i386/pci/irq.c linux-2.6.7-mm1/arch/i386/pci/irq.c
--- linux-2.6.7-mm1.vanilla/arch/i386/pci/irq.c	Sun May 23 21:51:28 2004
+++ linux-2.6.7-mm1/arch/i386/pci/irq.c	Sun May 23 21:51:34 2004
@@ -24,7 +24,7 @@
 #define PIRQ_VERSION 0x0100
 
 static int broken_hp_bios_irq9;
-int acer_tm360_irqrouting;
+static int acer_tm360_irqrouting;
 
 static struct irq_routing_table *pirq_table;
 
@@ -916,6 +916,19 @@ static int __init fix_broken_hp_bios_irq
 	return 0;
 }
 
+/*
+ * Work around broken Acer TravelMate 360 Notebooks which assign
+ * Cardbus to IRQ 11 even though it is actually wired to IRQ 10
+ */
+static int __init fix_acer_tm360_irqrouting(struct dmi_system_id *d)
+{
+	if (!acer_tm360_irqrouting) {
+		acer_tm360_irqrouting = 1;
+		printk(KERN_INFO "%s detected - fixing broken IRQ routing\n", d->ident);
+	}
+	return 0;
+}
+
 static struct dmi_system_id __initdata pciirq_dmi_table[] = {
 	{
 		.callback = fix_broken_hp_bios_irq9,
@@ -925,6 +938,14 @@ static struct dmi_system_id __initdata p
 			DMI_MATCH(DMI_BIOS_VERSION, "GE.M1.03"),
 			DMI_MATCH(DMI_PRODUCT_VERSION, "HP Pavilion Notebook Model GE"),
 			DMI_MATCH(DMI_BOARD_VERSION, "OmniBook N32N-736"),
+		},
+	},
+	{
+		.callback = fix_acer_tm360_irqrouting,
+		.ident = "Acer TravelMate 36x Laptop",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate 360"),
 		},
 	},
 	{ }

