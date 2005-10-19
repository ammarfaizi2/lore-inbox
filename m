Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964774AbVJSKAr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964774AbVJSKAr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 06:00:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964776AbVJSKAr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 06:00:47 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:3013 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S964774AbVJSKAq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 06:00:46 -0400
Message-ID: <4356194C.7050402@vc.cvut.cz>
Date: Wed, 19 Oct 2005 12:00:44 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Clemens Ladisch <clemens@ladisch.de>
CC: "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] more HPET fixes and enhancements
References: <Pine.HPX.4.33n.0510190910390.13768-100000@studcom.urz.uni-halle.de>
In-Reply-To: <Pine.HPX.4.33n.0510190910390.13768-100000@studcom.urz.uni-halle.de>
Content-Type: multipart/mixed;
 boundary="------------030005000203010904090203"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030005000203010904090203
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Clemens Ladisch wrote:
> Randy.Dunlap wrote:

> However, I've patched my kernel to initialize the HPET manually
> because my BIOS doesn't bother to do it at all.  A quick Google search
> shows that in most cases where the BIOS _does_ bother, the third timer
> (which is the only free one after system timer and RTC have grabbed
> theirs) didn't get initialized and is still set to interrupt 0 (which
> isn't actually supported by most HPET hardware).
> 
> This means that hpet.c must initialize the interrupt routing register
> in this case.  I'll write a patch for this.

I'm using attached diff.  But I gave up on HPET.  On VIA periodic mode
is hopelessly broken, on AMD HPET read takes about 1500ns (23 HPET cycles),
and current Linux RTC emulation has problem that when interrupt is delayed
it stops until counter rollover.  And fixing this would add at least 1.5us
to the interrupt handler, and it seems quite lot to me...
								Petr

--------------030005000203010904090203
Content-Type: text/x-patch;
 name="hpet.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hpet.diff"

diff -urdN linux/drivers/char/hpet.c linux/drivers/char/hpet.c
--- linux/drivers/char/hpet.c	2005-10-08 16:26:51.000000000 +0200
+++ linux/drivers/char/hpet.c	2005-10-08 22:32:43.000000000 +0200
@@ -70,6 +70,7 @@
 	unsigned int hd_flags;
 	unsigned int hd_irq;
 	unsigned int hd_hdwirq;
+	int hd_levelirq;
 	char hd_name[HPET_DEV_NAME];
 };
 
@@ -120,6 +121,15 @@
 	unsigned long isr;
 
 	devp = data;
+	isr = (1 << (devp - devp->hd_hpets->hp_dev));
+	if (devp->hd_levelirq) {
+		unsigned long v;
+		
+		v = readl(&devp->hd_hpet->hpet_isr);
+		if (!(v & isr)) {
+			return IRQ_NONE;
+		}
+	}	
 
 	spin_lock(&hpet_lock);
 	devp->hd_irqdata++;
@@ -137,7 +147,7 @@
 			      &devp->hd_timer->hpet_compare);
 	}
 
-	isr = (1 << (devp - devp->hd_hpets->hp_dev));
+	/* Spec says that only 0 may be written to status bit when corresponding timer is in edge mode! */
 	writeq(isr, &devp->hd_hpet->hpet_isr);
 	spin_unlock(&hpet_lock);
 
@@ -351,6 +361,44 @@
 	return hpet_ioctl_common(devp, cmd, arg, 0);
 }
 
+static unsigned int hpet_find_irq(struct hpet_dev *devp)
+{
+	unsigned long long v;
+	unsigned int irqmask;
+	struct hpet_timer __iomem *timer;
+	unsigned int irq;
+	unsigned int hpet_id;
+
+	irq = devp->hd_hdwirq;
+	if (irq)
+		return irq;
+
+	hpet_id = devp - devp->hd_hpets->hp_dev;
+	timer = devp->hd_timer;
+	v = readq(&timer->hpet_config);
+	irq = (v & Tn_INT_ROUTE_CNF_MASK) >> Tn_INT_ROUTE_CNF_SHIFT;
+	irqmask = (v & Tn_INT_ROUTE_CAP_MASK) >> Tn_INI_ROUTE_CAP_SHIFT;
+	/* Try already assigned irq first?! */
+	for (irq = 0; irq < 32; irq++) {
+		int acpiirq = acpi_register_gsi(irq, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW);
+//		printk(KERN_ERR "Mapping %u => %u\n", irq, acpiirq);
+		/* Skip 0 (no such APIC pin), 2 (8254) and 8 (RTC) */
+		if (irq == 0 || irq == 2 || irq == 8)
+			continue;
+		if (can_request_irq(acpiirq, SA_INTERRUPT)) {
+			devp->hd_levelirq = 1;
+			v = (v & ~Tn_INT_ROUTE_CNF_MASK) | (irq << Tn_INT_ROUTE_CNF_SHIFT) | Tn_INT_TYPE_CNF_MASK;
+			writeq(v, &timer->hpet_config);
+			printk(KERN_DEBUG "hpet%u.%u: Reserved IRQ %u\n", devp->hd_hpets->hp_which, hpet_id, acpiirq);
+			return acpiirq;
+		} else {
+			printk(KERN_DEBUG "hpet%u.%u: IRQ %u is busy\n", devp->hd_hpets->hp_which, hpet_id, acpiirq);
+		}
+	}
+	printk(KERN_DEBUG "hpet%u.%u: No free IRQ found\n", devp->hd_hpets->hp_which, hpet_id);
+	return 0;
+}
+
 static int hpet_ioctl_ieon(struct hpet_dev *devp)
 {
 	struct hpet_timer __iomem *timer;
@@ -375,14 +422,14 @@
 	devp->hd_flags |= HPET_IE;
 	spin_unlock_irq(&hpet_lock);
 
 	t = readq(&timer->hpet_config);
-	irq = devp->hd_hdwirq;
+	irq = hpet_find_irq(devp);
 
 	if (irq) {
-		sprintf(devp->hd_name, "hpet%d", (int)(devp - hpetp->hp_dev));
+		sprintf(devp->hd_name, "hpet%d.%d", hpetp->hp_which, (int)(devp - hpetp->hp_dev));
 
 		if (request_irq
-		    (irq, hpet_interrupt, SA_INTERRUPT, devp->hd_name, (void *)devp)) {
+		    (irq, hpet_interrupt, (devp->hd_levelirq ? SA_SHIRQ : 0) | SA_INTERRUPT, devp->hd_name, (void *)devp)) {
 			printk(KERN_ERR "hpet: IRQ %d is not free\n", irq);
 			irq = 0;
 		}
@@ -477,8 +527,12 @@
 		{
 			struct hpet_info info;
 
-			info.hi_ireqfreq = hpet_time_div(hpetp->hp_period *
-							 devp->hd_ireqfreq);
+			if (devp->hd_ireqfreq)
+				info.hi_ireqfreq = hpet_time_div(hpetp->hp_period *
+								 devp->hd_ireqfreq);
+			else
+				info.hi_ireqfreq = ~0UL;
+
 			info.hi_flags =
 			    readq(&timer->hpet_config) & Tn_PER_INT_CAP_MASK;
 			info.hi_hpet = devp->hd_hpets->hp_which;
@@ -516,7 +570,7 @@
 			break;
 		}
 
-		if (arg & (arg - 1)) {
+		if (!arg) {
 			err = -EINVAL;
 			break;
 		}

--------------030005000203010904090203--

