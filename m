Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268981AbUINFGv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268981AbUINFGv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 01:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268972AbUINFGh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 01:06:37 -0400
Received: from out006pub.verizon.net ([206.46.170.106]:43689 "EHLO
	out006.verizon.net") by vger.kernel.org with ESMTP id S268947AbUINFFf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 01:05:35 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm5, ehci stuff gone
Date: Tue, 14 Sep 2004 01:05:32 -0400
User-Agent: KMail/1.7
Cc: Greg KH <greg@kroah.com>
References: <200409132307.19242.gene.heskett@verizon.net> <20040914035606.GA14863@kroah.com>
In-Reply-To: <20040914035606.GA14863@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409140105.32221.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out006.verizon.net from [151.205.51.156] at Tue, 14 Sep 2004 00:05:33 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 September 2004 23:56, Greg KH wrote:
>On Mon, Sep 13, 2004 at 11:07:19PM -0400, Gene Heskett wrote:
>> Greetings;
>>
>> I've rebooted to 2.6.9-rc1-mm5, and found that my 2 printers,
>> usb-2.0 capable are not found.  Reverting to -mm4 brings them back
>> among the living.
>>
>> Here is an 'lsusb -v' while booted to -mm5:
>
>cat /proc/bus/usb/devices is much easier to read in the future :)
>
Ooops, sorry.  Getting late.

>Anyway, try the following patch from David Brownell, it fixed the
> ohci issues that I had in my laptop, and will show up in the next
> -mm patch.

ohci?  I thought usb2 was ehci...

>Let me know if this works or not for you.

Its building, but amanda is running, so I won't disturb her with a 
quick reboot.  And I'm about to hit the rack for a few hours of much 
needed shuteye.  Report tommorrow though.
>
>thanks,
>
>greg k-h
>
>-------------------
>
> From: david-b@pacbell.net
> Subject: [PATCH] USB: ohci init refactor
>
>Please merge, some recent changes made problems
>by making init take too long.  This also adds a bit of
>support for detecting the funky resume states that
>happen with suspend-to-disk (like swsusp, pmdisk).
>
>
>Refactor controller initialization ... this is most of the patch by
> volume.
>
> - A time-critical section now runs with IRQs blocked, rather than
> being split over two separate routines.  (I've recently seen init
> failures because of preemption in the middle of that 2msec timeout,
> presumably by khubd.)
>
> - Bus glue for PCI, LH7A404, OMAP, and SA-1100 now shares more init
> logic; that'll help shrink support for upcoming non-PCI patches
> too.
>
> - Move the root hub register macros to the header (for debug build
> issue)
>
> - More tweaks to the frame clock initialization, including slightly
> more helpful diagnostics on "init err".
>
>Better SWSUSP support.
>
> - Detects and handles some funky "resume after suspend-to-disk"
> cases.  These need to go through full driver re-init.
>
> - Restore root hub to CONFIGURED state on resume.
>
>Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
>Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>
>
>diff -Nru a/drivers/usb/host/ohci-hcd.c
> b/drivers/usb/host/ohci-hcd.c ---
> a/drivers/usb/host/ohci-hcd.c	2004-09-13 20:54:04 -07:00 +++
> b/drivers/usb/host/ohci-hcd.c	2004-09-13 20:54:04 -07:00 @@ -138,6
> +138,11 @@
>
> #include "ohci.h"
>
>+static void ohci_dump (struct ohci_hcd *ohci, int verbose);
>+static int ohci_init (struct ohci_hcd *ohci);
>+static int ohci_restart (struct ohci_hcd *ohci);
>+static void ohci_stop (struct usb_hcd *hcd);
>+
> #include "ohci-hub.c"
> #include "ohci-dbg.c"
> #include "ohci-mem.c"
>@@ -397,33 +402,27 @@
> 	return OHCI_FRAME_NO(ohci->hcca);
> }
>
>+static void ohci_usb_reset (struct ohci_hcd *ohci)
>+{
>+	ohci->hc_control = ohci_readl (&ohci->regs->control);
>+	ohci->hc_control &= OHCI_CTRL_RWC;
>+	writel (ohci->hc_control, &ohci->regs->control);
>+}
>+
> /*-----------------------------------------------------------------
>--------* * HC functions
> 
> *------------------------------------------------------------------
>-------*/
>
>-/* reset the HC and BUS */
>+/* init memory, and kick BIOS/SMM off */
>
>-static int hc_reset (struct ohci_hcd *ohci)
>+static int ohci_init (struct ohci_hcd *ohci)
> {
> 	u32 temp;
>+	int ret;
>
>-	/* boot firmware should have set this up (5.1.1.3.1) */
>-	if (!ohci->fminterval) {
>-		u32	t2;
>-
>-		temp = ohci_readl (&ohci->regs->fminterval);
>-		ohci->fminterval = temp & 0x3fff;
>-		if (ohci->fminterval != FI)
>-			ohci_dbg (ohci, "fminterval delta %d\n",
>-				ohci->fminterval - FI);
>-
>-		t2 = FSMP (ohci->fminterval);
>-		temp >>= 16;
>-		if ((t2/2) < temp || temp > t2)
>-			temp = t2;
>-		ohci->fminterval |= temp << 16;
>-		/* also: power/overcurrent flags in roothub.a */
>-	}
>+	disable (ohci);
>+	ohci->regs = ohci->hcd.regs;
>+	ohci->next_statechange = jiffies;
>
> #ifndef IR_DISABLE
> 	/* SMM owns the HC?  not for long! */
>@@ -442,14 +441,60 @@
> 			msleep (10);
> 			if (--temp == 0) {
> 				ohci_err (ohci, "USB HC TakeOver failed!\n");
>-				return -1;
>+				return -EBUSY;
> 			}
> 		}
>+		ohci_usb_reset (ohci);
> 	}
> #endif
>
> 	/* Disable HC interrupts */
> 	writel (OHCI_INTR_MIE, &ohci->regs->intrdisable);
>+	// flush the writes
>+	(void) ohci_readl (&ohci->regs->control);
>+
>+	if (ohci->hcca)
>+		return 0;
>+
>+	ohci->hcca = dma_alloc_coherent (ohci->hcd.self.controller,
>+			sizeof *ohci->hcca, &ohci->hcca_dma, 0);
>+	if (!ohci->hcca)
>+		return -ENOMEM;
>+
>+	if ((ret = ohci_mem_init (ohci)) < 0)
>+		ohci_stop (&ohci->hcd);
>+
>+	return ret;
>+
>+}
>+
>+/*-----------------------------------------------------------------
>--------*/ +
>+/* Start an OHCI controller, set the BUS operational
>+ * resets USB and controller
>+ * enable interrupts
>+ * connect the virtual root hub
>+ */
>+static int ohci_run (struct ohci_hcd *ohci)
>+{
>+  	u32			mask, temp;
>+  	struct usb_device	*udev;
>+  	struct usb_bus		*bus;
>+	int			first = ohci->fminterval == 0;
>+
>+	disable (ohci);
>+
>+	/* boot firmware should have set this up (5.1.1.3.1) */
>+	if (first) {
>+
>+		temp = ohci_readl (&ohci->regs->fminterval);
>+		ohci->fminterval = temp & 0x3fff;
>+		if (ohci->fminterval != FI)
>+			ohci_dbg (ohci, "fminterval delta %d\n",
>+				ohci->fminterval - FI);
>+		ohci->fminterval |= FSMP (ohci->fminterval) << 16;
>+		/* also: power/overcurrent flags in roothub.a */
>+	}
>
>   	/* Reset USB nearly "by the book".  RemoteWakeupConnected
> 	 * saved if boot firmware (BIOS/SMM/...) told us it's connected
>@@ -495,18 +540,22 @@
> 	}
> 	// flush those writes
> 	(void) ohci_readl (&ohci->regs->control);
>+	memset (ohci->hcca, 0, sizeof (struct ohci_hcca));
>+
>+	/* 2msec timelimit here means no irqs/preempt */
>+	spin_lock_irq (&ohci->lock);
>
> 	/* HC Reset requires max 10 us delay */
> 	writel (OHCI_HCR,  &ohci->regs->cmdstatus);
> 	temp = 30;	/* ... allow extra time */
> 	while ((ohci_readl (&ohci->regs->cmdstatus) & OHCI_HCR) != 0) {
> 		if (--temp == 0) {
>+			spin_unlock_irq (&ohci->lock);
> 			ohci_err (ohci, "USB HC reset timed out!\n");
> 			return -1;
> 		}
> 		udelay (1);
> 	}
>-	periodic_reinit (ohci);
>
> 	/* now we're in the SUSPEND state ... must go OPERATIONAL
> 	 * within 2msec else HC enters RESUME
>@@ -520,22 +569,7 @@
> 		// flush those writes
> 		(void) ohci_readl (&ohci->regs->control);
> 	}
>-	return 0;
>-}
>-
>-/*-----------------------------------------------------------------
>--------*/ -
>-/* Start an OHCI controller, set the BUS operational
>- * enable interrupts
>- * connect the virtual root hub
>- */
>-static int hc_start (struct ohci_hcd *ohci)
>-{
>-  	u32			mask, tmp;
>-  	struct usb_device	*udev;
>-  	struct usb_bus		*bus;
>-
>-	disable (ohci);
>+	writel (ohci->fminterval, &ohci->regs->fminterval);
>
> 	/* Tell the controller where the control and bulk lists are
> 	 * The lists are empty now. */
>@@ -545,12 +579,17 @@
> 	/* a reset clears this */
> 	writel ((u32) ohci->hcca_dma, &ohci->regs->hcca);
>
>+	periodic_reinit (ohci);
>+
> 	/* some OHCI implementations are finicky about how they init.
> 	 * bogus values here mean not even enumeration could work.
> 	 */
> 	if ((ohci_readl (&ohci->regs->fminterval) & 0x3fff0000) == 0
>
> 			|| !ohci_readl (&ohci->regs->periodicstart)) {
>
>-		ohci_err (ohci, "init err\n");
>+		spin_unlock_irq (&ohci->lock);
>+		ohci_err (ohci, "init err (%08x %04x)\n",
>+			ohci_readl (&ohci->regs->fminterval),
>+			ohci_readl (&ohci->regs->periodicstart));
> 		return -EOVERFLOW;
> 	}
>
>@@ -569,42 +608,48 @@
> 	writel (mask, &ohci->regs->intrenable);
>
> 	/* handle root hub init quirks ... */
>-	tmp = roothub_a (ohci);
>-	tmp &= ~(RH_A_PSM | RH_A_OCPM);
>+	temp = roothub_a (ohci);
>+	temp &= ~(RH_A_PSM | RH_A_OCPM);
> 	if (ohci->flags & OHCI_QUIRK_SUPERIO) {
> 		/* NSC 87560 and maybe others */
>-		tmp |= RH_A_NOCP;
>-		tmp &= ~(RH_A_POTPGT | RH_A_NPS);
>+		temp |= RH_A_NOCP;
>+		temp &= ~(RH_A_POTPGT | RH_A_NPS);
> 	} else if (power_switching) {
> 		/* act like most external hubs:  use per-port power
> 		 * switching and overcurrent reporting.
> 		 */
>-		tmp &= ~(RH_A_NPS | RH_A_NOCP);
>-		tmp |= RH_A_PSM | RH_A_OCPM;
>+		temp &= ~(RH_A_NPS | RH_A_NOCP);
>+		temp |= RH_A_PSM | RH_A_OCPM;
> 	} else {
> 		/* hub power always on; required for AMD-756 and some
> 		 * Mac platforms.  ganged overcurrent reporting, if any.
> 		 */
>-		tmp |= RH_A_NPS;
>+		temp |= RH_A_NPS;
> 	}
>-	writel (tmp, &ohci->regs->roothub.a);
>+	writel (temp, &ohci->regs->roothub.a);
> 	writel (RH_HS_LPSC, &ohci->regs->roothub.status);
> 	writel (power_switching ? RH_B_PPCM : 0, &ohci->regs->roothub.b);
> 	// flush those writes
> 	(void) ohci_readl (&ohci->regs->control);
>
>+	spin_unlock_irq (&ohci->lock);
>+
> 	// POTPGT delay is bits 24-31, in 2 ms units.
> 	mdelay ((roothub_a (ohci) >> 23) & 0x1fe);
> 	bus = hcd_to_bus (&ohci->hcd);
>+	ohci->hcd.state = USB_STATE_RUNNING;
>
>-	if (bus->root_hub) {
>-		ohci->hcd.state = USB_STATE_RUNNING;
>+	ohci_dump (ohci, 1);
>+
>+	udev = hcd_to_bus (&ohci->hcd)->root_hub;
>+	if (udev) {
>+		udev->dev.power.power_state = 0;
>+		usb_set_device_state (udev, USB_STATE_CONFIGURED);
> 		return 0;
> 	}
>
> 	/* connect the virtual root hub */
> 	udev = usb_alloc_dev (NULL, bus, 0);
>-	ohci->hcd.state = USB_STATE_RUNNING;
> 	if (!udev) {
> 		disable (ohci);
> 		ohci->hc_control &= ~OHCI_CTRL_HCFS;
>@@ -620,7 +665,10 @@
> 		writel (ohci->hc_control, &ohci->regs->control);
> 		return -ENODEV;
> 	}
>+	if (ohci->power_budget)
>+		hub_set_power_budget(udev, ohci->power_budget);
>
>+	create_debug_files (ohci);
> 	return 0;
> }
>
>@@ -657,8 +705,7 @@
> 		// e.g. due to PCI Master/Target Abort
>
> 		ohci_dump (ohci, 1);
>-		ohci->hc_control &= OHCI_CTRL_RWC;	/* hcfs 0 = RESET */
>-		writel (ohci->hc_control, &ohci->regs->control);
>+		ohci_usb_reset (ohci);
> 	}
>
> 	if (ints & OHCI_INTR_RD) {
>@@ -712,10 +759,9 @@
> 	ohci_dump (ohci, 1);
>
> 	flush_scheduled_work();
>-	if (HCD_IS_RUNNING(ohci->hcd.state))
>-		hc_reset (ohci);
>-	else
>-		writel (OHCI_INTR_MIE, &ohci->regs->intrdisable);
>+
>+	ohci_usb_reset (ohci);
>+	writel (OHCI_INTR_MIE, &ohci->regs->intrdisable);
>
> 	remove_debug_files (ohci);
> 	ohci_mem_cleanup (ohci);
>@@ -734,7 +780,7 @@
>
> #if	defined(CONFIG_USB_SUSPEND) || defined(CONFIG_PM)
>
>-static int hc_restart (struct ohci_hcd *ohci)
>+static int ohci_restart (struct ohci_hcd *ohci)
> {
> 	int temp;
> 	int i;
>@@ -791,7 +837,7 @@
> 	ohci->ed_controltail = NULL;
> 	ohci->ed_bulktail    = NULL;
>
>-	if ((temp = hc_reset (ohci)) < 0 || (temp = hc_start (ohci)) < 0)
> { +	if ((temp = ohci_run (ohci)) < 0) {
> 		ohci_err (ohci, "can't restart, %d\n", temp);
> 		return temp;
> 	} else {
>@@ -803,10 +849,7 @@
> 		while (i--)
> 			writel (RH_PS_PSS,
> 				&ohci->regs->roothub.portstatus [temp]);
>-		ohci->hcd.self.root_hub->dev.power.power_state = 0;
>-		ohci->hcd.state = USB_STATE_RUNNING;
> 		ohci_dbg (ohci, "restart complete\n");
>-		ohci_dump (ohci, 1);
> 	}
> 	return 0;
> }
>@@ -842,4 +885,14 @@
>
>       || defined (CONFIG_ARCH_LH7A404) \
>
> 	)
> #error "missing bus glue for ohci-hcd"
>+#endif
>+
>+#if	!defined(HAVE_HNP) && defined(CONFIG_USB_OTG)
>+
>+#warning non-OTG configuration, too many HCDs
>+
>+static void start_hnp(struct ohci_hcd *ohci)
>+{
>+	/* "can't happen" */
>+}
> #endif
>diff -Nru a/drivers/usb/host/ohci-hub.c
> b/drivers/usb/host/ohci-hub.c ---
> a/drivers/usb/host/ohci-hub.c	2004-09-13 20:54:04 -07:00 +++
> b/drivers/usb/host/ohci-hub.c	2004-09-13 20:54:04 -07:00 @@ -2,7
> +2,7 @@
>  * OHCI HCD (Host Controller Driver) for USB.
>  *
>  * (C) Copyright 1999 Roman Weissgaerber <weissg@vienna.at>
>- * (C) Copyright 2000-2002 David Brownell
> <dbrownell@users.sourceforge.net> + * (C) Copyright 2000-2004 David
> Brownell <dbrownell@users.sourceforge.net> *
>  * This file is licenced under GPL
>  */
>@@ -11,34 +11,8 @@
>
> /*
>  * OHCI Root Hub ... the nonsharable stuff
>- *
>- * Registers don't need cpu_to_le32, that happens transparently
>  */
>
>-/* AMD-756 (D2 rev) reports corrupt register contents in some
> cases. - * The erratum (#4) description is incorrect.  AMD's
> workaround waits - * till some bits (mostly reserved) are clear; ok
> for all revs. - */
>-#define read_roothub(hc, register, mask) ({ \
>-	u32 temp = ohci_readl (&hc->regs->roothub.register); \
>-	if (temp == -1) \
>-		disable (hc); \
>-	else if (hc->flags & OHCI_QUIRK_AMD756) \
>-		while (temp & mask) \
>-			temp = ohci_readl (&hc->regs->roothub.register); \
>-	temp; })
>-
>-static u32 roothub_a (struct ohci_hcd *hc)
>-	{ return read_roothub (hc, a, 0xfc0fe000); }
>-static inline u32 roothub_b (struct ohci_hcd *hc)
>-	{ return ohci_readl (&hc->regs->roothub.b); }
>-static inline u32 roothub_status (struct ohci_hcd *hc)
>-	{ return ohci_readl (&hc->regs->roothub.status); }
>-static u32 roothub_portstatus (struct ohci_hcd *hc, int i)
>-	{ return read_roothub (hc, portstatus [i], 0xffe0fce0); }
>-
>-/*-----------------------------------------------------------------
>--------*/ -
> #define dbg_port(hc,label,num,value) \
> 	ohci_dbg (hc, \
> 		"%s roothub.portstatus [%d] " \
>@@ -150,7 +124,7 @@
> 	 * hub from the non-usb side (PCI, SOC, etc) stopped
> 	 */
> 	root->dev.power.power_state = 3;
>-	root->state = USB_STATE_SUSPENDED;
>+	usb_set_device_state (root, USB_STATE_SUSPENDED);
> done:
> 	spin_unlock_irq (&ohci->lock);
> 	return status;
>@@ -164,8 +138,6 @@
> 	return ed;
> }
>
>-static int hc_restart (struct ohci_hcd *ohci);
>-
> /* caller owns root->serialize */
> static int ohci_hub_resume (struct usb_hcd *hcd)
> {
>@@ -181,7 +153,12 @@
>
> 	spin_lock_irq (&ohci->lock);
> 	ohci->hc_control = ohci_readl (&ohci->regs->control);
>-	switch (ohci->hc_control & OHCI_CTRL_HCFS) {
>+	if (ohci->hc_control & (OHCI_CTRL_IR | OHCI_SCHED_ENABLES)) {
>+		/* this can happen after suspend-to-disk */
>+		ohci_dbg (ohci, "BIOS/SMM active, control %03x\n",
>+				ohci->hc_control);
>+		status = -EBUSY;
>+	} else switch (ohci->hc_control & OHCI_CTRL_HCFS) {
> 	case OHCI_USB_SUSPEND:
> 		ohci->hc_control &= ~(OHCI_CTRL_HCFS|OHCI_SCHED_ENABLES);
> 		ohci->hc_control |= OHCI_USB_RESUME;
>@@ -203,8 +180,10 @@
> 		status = -EBUSY;
> 	}
> 	spin_unlock_irq (&ohci->lock);
>-	if (status == -EBUSY)
>-		return hc_restart (ohci);
>+	if (status == -EBUSY) {
>+		(void) ohci_init (ohci);
>+		return ohci_restart (ohci);
>+	}
> 	if (status != -EINPROGRESS)
> 		return status;
>
>@@ -261,6 +240,7 @@
> 	/* TRSMRCY */
> 	msleep (10);
> 	root->dev.power.power_state = 0;
>+	usb_set_device_state (root, USB_STATE_CONFIGURED);
>
> 	/* keep it alive for ~5x suspend + resume costs */
> 	ohci->next_statechange = jiffies + msecs_to_jiffies (250);
>diff -Nru a/drivers/usb/host/ohci-lh7a404.c
> b/drivers/usb/host/ohci-lh7a404.c ---
> a/drivers/usb/host/ohci-lh7a404.c	2004-09-13 20:54:04 -07:00 +++
> b/drivers/usb/host/ohci-lh7a404.c	2004-09-13 20:54:04 -07:00 @@
> -229,38 +229,14 @@
> 	int		ret;
>
> 	ohci_dbg (ohci, "ohci_lh7a404_start, ohci:%p", ohci);
>-
>-	ohci->hcca = dma_alloc_coherent (hcd->self.controller,
>-			sizeof *ohci->hcca, &ohci->hcca_dma, 0);
>-	if (!ohci->hcca)
>-		return -ENOMEM;
>-
>-	ohci_dbg (ohci, "ohci_lh7a404_start, ohci->hcca:%p",
>-			ohci->hcca);
>-
>-	memset (ohci->hcca, 0, sizeof (struct ohci_hcca));
>-
>-	if ((ret = ohci_mem_init (ohci)) < 0) {
>-		ohci_stop (hcd);
>+	if ((ret = ohci_init(ohci)) < 0)
> 		return ret;
>-	}
>-	ohci->regs = hcd->regs;
>
>-	if (hc_reset (ohci) < 0) {
>-		ohci_stop (hcd);
>-		return -ENODEV;
>-	}
>-
>-	if (hc_start (ohci) < 0) {
>+	if ((ret = ohci_run (ohci)) < 0) {
> 		err ("can't start %s", ohci->hcd.self.bus_name);
> 		ohci_stop (hcd);
>-		return -EBUSY;
>+		return ret;
> 	}
>-	create_debug_files (ohci);
>-
>-#ifdef	DEBUG
>-	ohci_dump (ohci, 1);
>-#endif /*DEBUG*/
> 	return 0;
> }
>
>diff -Nru a/drivers/usb/host/ohci-omap.c
> b/drivers/usb/host/ohci-omap.c ---
> a/drivers/usb/host/ohci-omap.c	2004-09-13 20:54:04 -07:00 +++
> b/drivers/usb/host/ohci-omap.c	2004-09-13 20:54:04 -07:00 @@
> -428,40 +428,18 @@
> 	struct ohci_hcd	*ohci = hcd_to_ohci (hcd);
> 	int		ret;
>
>-	config = hcd->self.controller->platform_data;
>-	ohci->hcca = dma_alloc_coherent (hcd->self.controller,
>-			sizeof *ohci->hcca, &ohci->hcca_dma, 0);
>-	if (!ohci->hcca)
>-		return -ENOMEM;
>-
>-        memset (ohci->hcca, 0, sizeof (struct ohci_hcca));
>-	if ((ret = ohci_mem_init (ohci)) < 0) {
>-		ohci_stop (hcd);
>+	if ((ret = ohci_init(ohci)) < 0)
> 		return ret;
>-	}
>-	ohci->regs = hcd->regs;
>
>+	config = hcd->self.controller->platform_data;
> 	if (config->otg || config->rwc)
> 		writel(OHCI_CTRL_RWC, &ohci->regs->control);
>
>-	if (hc_reset (ohci) < 0) {
>-		ohci_stop (hcd);
>-		return -ENODEV;
>-	}
>-
>-	if (hc_start (ohci) < 0) {
>+	if ((ret = ohci_run (ohci)) < 0) {
> 		err ("can't start %s", ohci->hcd.self.bus_name);
> 		ohci_stop (hcd);
>-		return -EBUSY;
>+		return ret;
> 	}
>-	if (ohci->power_budget)
>-		hub_set_power_budget(ohci->hcd.self.root_hub,
>-					ohci->power_budget);
>-	create_debug_files (ohci);
>-
>-#ifdef	DEBUG
>-	ohci_dump (ohci, 1);
>-#endif
> 	return 0;
> }
>
>diff -Nru a/drivers/usb/host/ohci-pci.c
> b/drivers/usb/host/ohci-pci.c ---
> a/drivers/usb/host/ohci-pci.c	2004-09-13 20:54:04 -07:00 +++
> b/drivers/usb/host/ohci-pci.c	2004-09-13 20:54:04 -07:00 @@ -35,9
> +35,7 @@
> {
> 	struct ohci_hcd	*ohci = hcd_to_ohci (hcd);
>
>-	ohci->regs = hcd->regs;
>-	ohci->next_statechange = jiffies;
>-	return hc_reset (ohci);
>+	return ohci_init (ohci);
> }
>
> static int __devinit
>@@ -46,11 +44,6 @@
> 	struct ohci_hcd	*ohci = hcd_to_ohci (hcd);
> 	int		ret;
>
>-	ohci->hcca = dma_alloc_coherent (hcd->self.controller,
>-			sizeof *ohci->hcca, &ohci->hcca_dma, 0);
>-	if (!ohci->hcca)
>-		return -ENOMEM;
>-
> 	if(hcd->self.controller && hcd->self.controller->bus ==
> &pci_bus_type) { struct pci_dev *pdev =
> to_pci_dev(hcd->self.controller);
>
>@@ -104,31 +97,14 @@
>
> 	}
>
>-        memset (ohci->hcca, 0, sizeof (struct ohci_hcca));
>-	if ((ret = ohci_mem_init (ohci)) < 0) {
>-		ohci_stop (hcd);
>-		return ret;
>-	}
>-
>-	/* NOTE: this is a second reset. the first one helps
>-	 * keep bios/smm irqs from making trouble, but it was
>-	 * probably more than 1msec ago...
>+	/* NOTE: there may have already been a first reset, to
>+	 * keep bios/smm irqs from making trouble
> 	 */
>-	if (hc_reset (ohci) < 0) {
>-		ohci_stop (hcd);
>-		return -ENODEV;
>-	}
>-
>-	if (hc_start (ohci) < 0) {
>+	if ((ret = ohci_run (ohci)) < 0) {
> 		ohci_err (ohci, "can't start\n");
> 		ohci_stop (hcd);
>-		return -EBUSY;
>+		return ret;
> 	}
>-	create_debug_files (ohci);
>-
>-#ifdef	DEBUG
>-	ohci_dump (ohci, 1);
>-#endif
> 	return 0;
> }
>
>diff -Nru a/drivers/usb/host/ohci-sa1111.c
> b/drivers/usb/host/ohci-sa1111.c ---
> a/drivers/usb/host/ohci-sa1111.c	2004-09-13 20:54:04 -07:00 +++
> b/drivers/usb/host/ohci-sa1111.c	2004-09-13 20:54:04 -07:00 @@
> -272,33 +272,14 @@
> 	struct ohci_hcd	*ohci = hcd_to_ohci (hcd);
> 	int		ret;
>
>-	ohci->hcca = dma_alloc_coherent (hcd->self.controller,
>-			sizeof *ohci->hcca, &ohci->hcca_dma, 0);
>-	if (!ohci->hcca)
>-		return -ENOMEM;
>-
>-	memset (ohci->hcca, 0, sizeof (struct ohci_hcca));
>-	if ((ret = ohci_mem_init (ohci)) < 0) {
>-		ohci_stop (hcd);
>+	if ((ret = ohci_init(ohci)) < 0)
> 		return ret;
>-	}
>-	ohci->regs = hcd->regs;
>
>-	if (hc_reset (ohci) < 0) {
>-		ohci_stop (hcd);
>-		return -ENODEV;
>-	}
>-
>-	if (hc_start (ohci) < 0) {
>+	if ((ret = ohci_run (ohci)) < 0) {
> 		err ("can't start %s", ohci->hcd.self.bus_name);
> 		ohci_stop (hcd);
>-		return -EBUSY;
>+		return ret;
> 	}
>-	create_debug_files (ohci);
>-
>-#ifdef	DEBUG
>-	ohci_dump (ohci, 1);
>-#endif
> 	return 0;
> }
>
>diff -Nru a/drivers/usb/host/ohci.h b/drivers/usb/host/ohci.h
>--- a/drivers/usb/host/ohci.h	2004-09-13 20:54:04 -07:00
>+++ b/drivers/usb/host/ohci.h	2004-09-13 20:54:04 -07:00
>@@ -42,7 +42,6 @@
>
> 	/* create --> IDLE --> OPER --> ... --> IDLE --> destroy
> 	 * usually:  OPER --> UNLINK --> (IDLE | OPER) --> ...
>-	 * some special cases :  OPER --> IDLE ...
> 	 */
> 	u8			state;		/* ED_{IDLE,UNLINK,OPER} */
> #define ED_IDLE 	0x00		/* NOT linked to HC */
>@@ -406,15 +405,14 @@
> }
>
> #define	FI			0x2edf		/* 12000 bits per frame (-1) */
>-#define	FSMP(fi) 		((6 * ((fi) - 210)) / 7)
>+#define	FSMP(fi) 		(0x7fff & ((6 * ((fi) - 210)) / 7))
> #define LSTHRESH		0x628		/* lowspeed bit threshold */
>
> static inline void periodic_reinit (struct ohci_hcd *ohci)
> {
> 	u32	fi = ohci->fminterval & 0x0ffff;
>-	writel (ohci->fminterval, &ohci->regs->fminterval);
>+
> 	writel (((9 * fi) / 10) & 0x3fff, &ohci->regs->periodicstart);
>-	writel (LSTHRESH, &ohci->regs->lsthresh);
> }
>
> /*-----------------------------------------------------------------
>--------*/ @@ -438,6 +436,8 @@
> #	define ohci_vdbg(ohci, fmt, args...) do { } while (0)
> #endif
>
>+/*-----------------------------------------------------------------
>--------*/ +
> #ifdef CONFIG_ARCH_LH7A404
> 	/* Marc Singer: at the time this code was written, the LH7A404
> 	 * had a problem reading the USB host registers.  This
>@@ -457,3 +457,25 @@
> 	return readl (regs);
> }
> #endif
>+
>+/* AMD-756 (D2 rev) reports corrupt register contents in some
> cases. + * The erratum (#4) description is incorrect.  AMD's
> workaround waits + * till some bits (mostly reserved) are clear; ok
> for all revs. + */
>+#define read_roothub(hc, register, mask) ({ \
>+	u32 temp = ohci_readl (&hc->regs->roothub.register); \
>+	if (temp == -1) \
>+		disable (hc); \
>+	else if (hc->flags & OHCI_QUIRK_AMD756) \
>+		while (temp & mask) \
>+			temp = ohci_readl (&hc->regs->roothub.register); \
>+	temp; })
>+
>+static u32 roothub_a (struct ohci_hcd *hc)
>+	{ return read_roothub (hc, a, 0xfc0fe000); }
>+static inline u32 roothub_b (struct ohci_hcd *hc)
>+	{ return ohci_readl (&hc->regs->roothub.b); }
>+static inline u32 roothub_status (struct ohci_hcd *hc)
>+	{ return ohci_readl (&hc->regs->roothub.status); }
>+static u32 roothub_portstatus (struct ohci_hcd *hc, int i)
>+	{ return read_roothub (hc, portstatus [i], 0xffe0fce0); }

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.26% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
