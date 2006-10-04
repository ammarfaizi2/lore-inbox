Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751083AbWJDUaB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751083AbWJDUaB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 16:30:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751082AbWJDUaB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 16:30:01 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:25532 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751083AbWJDU37 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 16:29:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=MylFG05PD8cDVBky3ga2aK+/Pzi6NYGzoM77H4HfVB7KqfiRqKSvE6rKIQStdQKkb1ZA12LV3x2Ex2kGggjMtBh6LltqevuFMPgmKx5zMgIAReH8+8e5GtKMVYeOrwkkzsABdjWZj+Li3qR8yVd6JATuM0wAkwUqehZopxvZG7I=
Date: Wed, 4 Oct 2006 20:29:38 +0000
From: Frederik Deweerdt <deweerdt@free.fr>
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-kernel@vger.kernel.org, arjan@infradead.org, matthew@wil.cx,
       alan@lxorguk.ukuu.org.uk, akpm@osdl.org, rdunlap@xenotime.net,
       gregkh@suse.de
Subject: Re: [RFC PATCH] add pci_{request,free}_irq take #3
Message-ID: <20061004202938.GF352@slug>
References: <20061004193229.GA352@slug> <4524106C.8010807@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4524106C.8010807@garzik.org>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2006 at 03:50:04PM -0400, Jeff Garzik wrote:
> Frederik Deweerdt wrote:
> >--- 2.6.18-mm3.orig/include/linux/interrupt.h
> >+++ 2.6.18-mm3/include/linux/interrupt.h
> >@@ -75,6 +75,13 @@ struct irqaction {
> > 	struct proc_dir_entry *dir;
> > };
> > +#ifndef ARCH_VALIDATE_IRQ
> >+static inline int is_irq_valid(unsigned int irq)
> >+{
> >+	return irq ? 1 : 0;
> >+}
> >+#endif /* ARCH_VALIDATE_IRQ */
> 
> 
> I ACK everything except the above snippet.  I just don't think it's
> linux/interrupt.h material, sorry.
I see. Just to be sure that I got the matter right, does the issue boils
down to a choice between:

#
# 1: is_pci_irq_valid in include/linux/pci.h
#
diff --git a/arch/powerpc/kernel/pci_32.c b/arch/powerpc/kernel/pci_32.c
index 9b49f86..9d1bb1d 100644
--- a/arch/powerpc/kernel/pci_32.c
+++ b/arch/powerpc/kernel/pci_32.c
@@ -1445,7 +1445,7 @@ int pci_read_irq_line(struct pci_dev *pc
 		DBG(" -> no map ! Using irq line %d from PCI config\n", line);
 
 		virq = irq_create_mapping(NULL, line);
-		if (virq != NO_IRQ)
+		if (is_pci_irq_valid(virq))
 			set_irq_type(virq, IRQ_TYPE_LEVEL_LOW);
 	} else {
 		DBG(" -> got one, spec %d cells (0x%08x...) on %s\n",
@@ -1454,7 +1454,7 @@ int pci_read_irq_line(struct pci_dev *pc
 		virq = irq_create_of_mapping(oirq.controller, oirq.specifier,
 					     oirq.size);
 	}
-	if(virq == NO_IRQ) {
+	if(!is_pci_irq_valid(virq)) {
 		DBG(" -> failed to map !\n");
 		return -1;
 	}

and 


#
# 2: is_irq_valid in include/linux/interrupt.h
#
diff --git a/arch/powerpc/kernel/pci_32.c b/arch/powerpc/kernel/pci_32.c
index 9b49f86..68bd1fa 100644
--- a/arch/powerpc/kernel/pci_32.c
+++ b/arch/powerpc/kernel/pci_32.c
@@ -12,6 +12,7 @@ #include <linux/sched.h>
 #include <linux/errno.h>
 #include <linux/bootmem.h>
 #include <linux/irq.h>
+#include <linux/interrupt.h>
 
 #include <asm/processor.h>
 #include <asm/io.h>
@@ -1445,7 +1446,7 @@ int pci_read_irq_line(struct pci_dev *pc
 		DBG(" -> no map ! Using irq line %d from PCI config\n", line);
 
 		virq = irq_create_mapping(NULL, line);
-		if (virq != NO_IRQ)
+		if (is_irq_valid(virq))
 			set_irq_type(virq, IRQ_TYPE_LEVEL_LOW);
 	} else {
 		DBG(" -> got one, spec %d cells (0x%08x...) on %s\n",
@@ -1454,7 +1455,7 @@ int pci_read_irq_line(struct pci_dev *pc
 		virq = irq_create_of_mapping(oirq.controller, oirq.specifier,
 					     oirq.size);
 	}
-	if(virq == NO_IRQ) {
+	if(!is_irq_valid(virq)) {
 		DBG(" -> failed to map !\n");
 		return -1;
 	}

Which in turn boils down to:
- which naming does make more sense
- which include file should contain the code
 (this point is IMO a 1:1 mapping to the first one: is_pci_irq_valid()
 should go to pci.h and is_irq_valid() should go to interrupt.h)

I'm personally inclined for the second solution is_irq_valid() because
(a) there is some irq setting code outside the pci subsystem[1], (b)
the function name is easier to remember. But I'd happily concede that
these aren't that strong points. Also, only two arches seem to tweak the
irq behind the pci subsystem, so "a consensus of arch maintainers" may
be hard to get :).

Regards,
Frederik

[1] $ grep -r 'read.*PCI_INTERRUPT_LINE' *
arch/alpha/kernel/sys_dp264.c:  pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &irq8);
arch/alpha/kernel/sys_eiger.c:  pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &irq_orig);
arch/alpha/kernel/sys_marvel.c: pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &intline);
arch/alpha/kernel/sys_marvel.c:         pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &intline);
arch/alpha/kernel/sys_nautilus.c:       pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &irq);
arch/alpha/kernel/sys_titan.c:  pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &intline);
arch/arm/mach-footbridge/personal-pci.c:        pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &line);
arch/frv/mb93090-mb00/pci-irq.c:                pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &line);
arch/i386/pci/fixup.c:  pci_read_config_byte(dev, PCI_INTERRUPT_LINE, (u8 *)&dev->irq);
arch/powerpc/kernel/pci_32.c:           if (pci_read_config_byte(pci_dev, PCI_INTERRUPT_LINE, &line) ||
arch/powerpc/kernel/pci_64.c:           if (pci_read_config_byte(pci_dev, PCI_INTERRUPT_LINE, &line) ||
drivers/ide/pci/pdc202xx_old.c:         pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &irq);
drivers/ide/pci/pdc202xx_old.c:         pci_read_config_byte(dev, (PCI_INTERRUPT_LINE)|0x80, &irq2);
drivers/macintosh/via-pmu.c:            pci_read_config_word(pd, PCI_INTERRUPT_LINE, &ps->intr);
drivers/macintosh/via-pmu68k.c:         pci_read_config_word(pd, PCI_INTERRUPT_LINE, &ps->intr);
drivers/pci/hotplug/cpqphp_core.c:      pci_read_config_byte(pdev, PCI_INTERRUPT_LINE, &ctrl->cfgspc_irq);
drivers/pci/probe.c:            pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &irq);
drivers/pci/quirks.c:   pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &irq);
drivers/ata/sata_via.c: pci_read_config_byte(pdev, PCI_INTERRUPT_LINE, &tmp8);

