Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751155AbWJHNnS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbWJHNnS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 09:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbWJHNnS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 09:43:18 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:52706 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751155AbWJHNnR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 09:43:17 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Linus Torvalds <torvalds@osdl.org>
Cc: Muli Ben-Yehuda <muli@il.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>, Andi Kleen <ak@muc.de>,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] i386/x86_64: FIX pci_enable_irq to set dev->irq to the irq number
References: <20061005212216.GA10912@rhun.haifa.ibm.com>
	<m11wpl328i.fsf@ebiederm.dsl.xmission.com>
	<20061006155021.GE14186@rhun.haifa.ibm.com>
	<m1d5951gm7.fsf@ebiederm.dsl.xmission.com>
	<20061006202324.GJ14186@rhun.haifa.ibm.com>
	<m1y7rtxb7z.fsf@ebiederm.dsl.xmission.com>
	<20061007080315.GM14186@rhun.haifa.ibm.com>
	<m14pugxe47.fsf@ebiederm.dsl.xmission.com>
	<20061007175926.GN14186@rhun.haifa.ibm.com>
	<m1k63budt1.fsf_-_@ebiederm.dsl.xmission.com>
Date: Sun, 08 Oct 2006 07:41:19 -0600
In-Reply-To: <m1k63budt1.fsf_-_@ebiederm.dsl.xmission.com> (Eric
	W. Biederman's message of "Sun, 08 Oct 2006 07:39:38 -0600")
Message-ID: <m1fydzudq8.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In commit: ace80ab796ae30d2c9ee8a84ab6f608a61f8b87b  I removed
the weird logic that used the vector number as the irq number
when MSI was defined.  However pci_enable_irq was using a different test
in the io_apic_assign_irqs path and I missed it :(

This patch removes the wrong code so no one hits this problem.

This code is only active when a specific set of boot command line
parameters is specified which likely explains why no one has
notices this earlier.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/i386/pci/irq.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/i386/pci/irq.c b/arch/i386/pci/irq.c
index 47f02af..dbc4aae 100644
--- a/arch/i386/pci/irq.c
+++ b/arch/i386/pci/irq.c
@@ -1141,10 +1141,6 @@ static int pirq_enable_irq(struct pci_de
 			}
 			dev = temp_dev;
 			if (irq >= 0) {
-#ifdef CONFIG_PCI_MSI
-				if (!platform_legacy_irq(irq))
-					irq = IO_APIC_VECTOR(irq);
-#endif
 				printk(KERN_INFO "PCI->APIC IRQ transform: %s[%c] -> IRQ %d\n",
 					pci_name(dev), 'A' + pin, irq);
 				dev->irq = irq;
-- 
1.4.2.rc3.g7e18e-dirty

