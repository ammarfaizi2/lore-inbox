Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030280AbWGaRXb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030280AbWGaRXb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 13:23:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030281AbWGaRXb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 13:23:31 -0400
Received: from web81206.mail.mud.yahoo.com ([68.142.199.110]:25259 "HELO
	web81206.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030280AbWGaRXa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 13:23:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=CvAUNqJwW8Ci/bQnnLCi56gDemVp2N9CdDYIyRTysJ8WZ6qzSLDTHbki57wfFeF3qg1xmpg5ATfj7hyOsmsAS7cBlE1bmzX4x/1ONvI1xlz4XcfBMVN4+2zXl7UyUnd7AmBZs2GkEZsaUhlVI+KtShLOkvH7Q2HHrWLp0rpArNY=  ;
Message-ID: <20060731172327.9269.qmail@web81206.mail.mud.yahoo.com>
Date: Mon, 31 Jul 2006 10:23:27 -0700 (PDT)
From: Aleksey Gorelov <dared1st@yahoo.com>
Subject: Re: [linux-usb-devel] [PATCH] Properly unregister reboot notifier in case of failure in ehci hcd
To: David Brownell <david-b@pacbell.net>,
       linux-usb-devel@lists.sourceforge.net
Cc: Andrew Morton <akpm@osdl.org>, gregkh@suse.de, stern@rowland.harvard.edu,
       linux-kernel@vger.kernel.org
In-Reply-To: <200607141433.48695.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- David Brownell <david-b@pacbell.net> wrote:
> On Friday 14 July 2006 9:46 am, Aleksey Gorelov wrote:
> 
> > David, Alan,
> > 
> > Do you think it is Ok to unregister reboot notifier in ehci_run before registering one to make
> > sure there is no 'double registering' of notifier, or is it better to move register/unregister
> > reboot notifier from ehci_run/ehci_stop completely to some other place ?
> 
> Probably the best way is to stop using the notifier, and brute force it
> by making every EHCI subdriver get its own shutdown() method.  That'd be
> obvious enough for PCI bus glue, and due to recent patches probably even
> for the non-PCI ones ... since they all use "platform_bus" now, they can
> all share the same method.  Though I could imagine some platforms might
> want to do extra stuff like clk_disable() after the root hub reset.
> 
> I could see the tail end of ehci-hcd.c with a forward decl for a method
> like ehci_platform_shutdown(), updating the subdrivers to reference that,
> and then #ifdef PLATFORM_DRIVER provide the definition of that routine
> (doing what the reboot notifier does) for use by the non-PCI subdrivers.
> 
> - Dave

Hi,

  Here is revised patch in accordance with Dave's suggestion. 

  If some problem occurs during ehci startup, for instance, request_irq fails, echi hcd driver
tries it best to cleanup, but fails to unregister reboot notifier, which in turn leads to crash on
reboot/poweroff. The following patch resolves this problem by not using reboot notifiers anymore,
but instead making ehci/ohci driver get its own shutdown method. For PCI, it is done through pci
glue, for everything else through platform driver glue.
  One downside: sa1111 does not use platform driver stuff, and does not have its own shutdown
hook, so no 'shutdown' is called for it now. I'm not sure if it is really necessary on that
platform, though.

Signed off by: Aleks Gorelov <dared1st@yahoo.com>

--- a/drivers/usb/core/hcd-pci.c
+++ b/drivers/usb/core/hcd-pci.c
@@ -413,4 +413,20 @@ EXPORT_SYMBOL (usb_hcd_pci_resume);
 
 #endif	/* CONFIG_PM */
 
+/**
+ * usb_hcd_pci_shutdown - shutdown host controller
+ * @dev: USB Host Controller being shutdown
+ */
+void usb_hcd_pci_shutdown (struct pci_dev *dev)
+{
+	struct usb_hcd		*hcd;
+
+	hcd = pci_get_drvdata(dev);
+	if (!hcd)
+		return;
+
+	if (hcd->driver->shutdown)
+		hcd->driver->shutdown(hcd);
+}
+EXPORT_SYMBOL (usb_hcd_pci_shutdown);
 
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -36,6 +36,7 @@ #include <linux/dma-mapping.h>
 #include <linux/mutex.h>
 #include <asm/irq.h>
 #include <asm/byteorder.h>
+#include <linux/platform_device.h>
 
 #include <linux/usb.h>
 
@@ -1915,6 +1916,16 @@ void usb_remove_hcd(struct usb_hcd *hcd)
 }
 EXPORT_SYMBOL (usb_remove_hcd);
 
+void 
+usb_hcd_platform_shutdown(struct platform_device* dev)
+{
+	struct usb_hcd *hcd = platform_get_drvdata(dev);
+
+	if (hcd->driver->shutdown)
+		hcd->driver->shutdown(hcd);
+}
+EXPORT_SYMBOL (usb_hcd_platform_shutdown);
+
 /*-------------------------------------------------------------------------*/
 
 #if defined(CONFIG_USB_MON)
--- a/drivers/usb/core/hcd.h
+++ b/drivers/usb/core/hcd.h
@@ -192,6 +192,9 @@ #define	HCD_USB2	0x0020		/* USB 2.0 */
 	/* cleanly make HCD stop writing memory and doing I/O */
 	void	(*stop) (struct usb_hcd *hcd);
 
+	/* shutdown HCD */
+	void	(*shutdown) (struct usb_hcd *hcd);
+
 	/* return current frame number */
 	int	(*get_frame_number) (struct usb_hcd *hcd);
 
@@ -227,6 +230,9 @@ extern int usb_add_hcd(struct usb_hcd *h
 		unsigned int irqnum, unsigned long irqflags);
 extern void usb_remove_hcd(struct usb_hcd *hcd);
 
+struct platform_device;
+extern void usb_hcd_platform_shutdown(struct platform_device* dev);
+
 #ifdef CONFIG_PCI
 struct pci_dev;
 struct pci_device_id;
@@ -239,6 +245,8 @@ extern int usb_hcd_pci_suspend (struct p
 extern int usb_hcd_pci_resume (struct pci_dev *dev);
 #endif /* CONFIG_PM */
 
+extern void usb_hcd_pci_shutdown (struct pci_dev *dev);
+
 #endif /* CONFIG_PCI */
 
 /* pci-ish (pdev null is ok) buffer alloc/mapping support */
--- a/drivers/usb/host/ehci-au1xxx.c
+++ b/drivers/usb/host/ehci-au1xxx.c
@@ -200,6 +200,7 @@ static const struct hc_driver ehci_au1xx
 	.reset = ehci_init,
 	.start = ehci_run,
 	.stop = ehci_stop,
+	.shutdown = ehci_shutdown,
 
 	/*
 	 * managing i/o requests and associated device resources
@@ -268,6 +269,7 @@ MODULE_ALIAS("au1xxx-ehci");
 static struct platform_driver ehci_hcd_au1xxx_driver = {
 	.probe = ehci_hcd_au1xxx_drv_probe,
 	.remove = ehci_hcd_au1xxx_drv_remove,
+	.shutdown = usb_hcd_platform_shutdown,
 	/*.suspend      = ehci_hcd_au1xxx_drv_suspend, */
 	/*.resume       = ehci_hcd_au1xxx_drv_resume, */
 	.driver = {
--- a/drivers/usb/host/ehci-fsl.c
+++ b/drivers/usb/host/ehci-fsl.c
@@ -285,6 +285,7 @@ #ifdef	CONFIG_PM
 	.resume = ehci_bus_resume,
 #endif
 	.stop = ehci_stop,
+	.shutdown = ehci_shutdown,
 
 	/*
 	 * managing i/o requests and associated device resources
@@ -329,6 +330,7 @@ MODULE_ALIAS("fsl-ehci");
 static struct platform_driver ehci_fsl_driver = {
 	.probe = ehci_fsl_drv_probe,
 	.remove = ehci_fsl_drv_remove,
+	.shutdown = usb_hcd_platform_shutdown,
 	.driver = {
 		   .name = "fsl-ehci",
 		   },
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -292,21 +292,20 @@ static void ehci_watchdog (unsigned long
 	spin_unlock_irqrestore (&ehci->lock, flags);
 }
 
-/* Reboot notifiers kick in for silicon on any bus (not just pci, etc).
+/* ehci_shutdown kick in for silicon on any bus (not just pci, etc).
  * This forcibly disables dma and IRQs, helping kexec and other cases
  * where the next system software may expect clean state.
  */
-static int
-ehci_reboot (struct notifier_block *self, unsigned long code, void *null)
+static void
+ehci_shutdown (struct usb_hcd *hcd)
 {
-	struct ehci_hcd		*ehci;
+	struct ehci_hcd	*ehci;
 
-	ehci = container_of (self, struct ehci_hcd, reboot_notifier);
+	ehci = hcd_to_ehci (hcd);
 	(void) ehci_halt (ehci);
 
 	/* make BIOS/etc use companion controller during reboot */
 	writel (0, &ehci->regs->configured_flag);
-	return 0;
 }
 
 static void ehci_port_power (struct ehci_hcd *ehci, int is_on)
@@ -381,7 +380,6 @@ static void ehci_stop (struct usb_hcd *h
 
 	/* let companion controllers work when we aren't */
 	writel (0, &ehci->regs->configured_flag);
-	unregister_reboot_notifier (&ehci->reboot_notifier);
 
 	remove_debug_files (ehci);
 
@@ -483,9 +481,6 @@ static int ehci_init(struct usb_hcd *hcd
 	}
 	ehci->command = temp;
 
-	ehci->reboot_notifier.notifier_call = ehci_reboot;
-	register_reboot_notifier(&ehci->reboot_notifier);
-
 	return 0;
 }
 
@@ -499,7 +494,6 @@ static int ehci_run (struct usb_hcd *hcd
 
 	/* EHCI spec section 4.1 */
 	if ((retval = ehci_reset(ehci)) != 0) {
-		unregister_reboot_notifier(&ehci->reboot_notifier);
 		ehci_mem_cleanup(ehci);
 		return retval;
 	}
--- a/drivers/usb/host/ehci-pci.c
+++ b/drivers/usb/host/ehci-pci.c
@@ -332,6 +332,7 @@ #ifdef	CONFIG_PM
 	.resume =		ehci_pci_resume,
 #endif
 	.stop =			ehci_stop,
+	.shutdown =		ehci_shutdown,
 
 	/*
 	 * managing i/o requests and associated device resources
@@ -378,4 +379,5 @@ #ifdef	CONFIG_PM
 	.suspend =	usb_hcd_pci_suspend,
 	.resume =	usb_hcd_pci_resume,
 #endif
+	.shutdown = 	usb_hcd_pci_shutdown,
 };
--- a/drivers/usb/host/ehci.h
+++ b/drivers/usb/host/ehci.h
@@ -82,7 +82,6 @@ #define	DEFAULT_I_TDPS		1024		/* some HC
 	struct dma_pool		*sitd_pool;	/* sitd per split iso urb */
 
 	struct timer_list	watchdog;
-	struct notifier_block	reboot_notifier;
 	unsigned long		actions;
 	unsigned		stamp;
 	unsigned long		next_statechange;
--- a/drivers/usb/host/ohci-at91.c
+++ b/drivers/usb/host/ohci-at91.c
@@ -212,6 +212,7 @@ static const struct hc_driver ohci_at91_
 	 */
 	.start =		ohci_at91_start,
 	.stop =			ohci_stop,
+	.shutdown = 		ohci_shutdown,
 
 	/*
 	 * managing i/o requests and associated device resources
@@ -280,6 +281,7 @@ MODULE_ALIAS("at91rm9200-ohci");
 static struct platform_driver ohci_hcd_at91_driver = {
 	.probe		= ohci_hcd_at91_drv_probe,
 	.remove		= ohci_hcd_at91_drv_remove,
+	.shutdown	= usb_hcd_platform_shutdown,
 	.suspend	= ohci_hcd_at91_drv_suspend,
 	.resume		= ohci_hcd_at91_drv_resume,
 	.driver		= {
--- a/drivers/usb/host/ohci-au1xxx.c
+++ b/drivers/usb/host/ohci-au1xxx.c
@@ -274,6 +274,7 @@ #ifdef	CONFIG_PM
 	/* resume:		ohci_au1xxx_resume,   -- tbd */
 #endif /*CONFIG_PM*/
 	.stop =			ohci_stop,
+	.shutdown = 		ohci_shutdown,
 
 	/*
 	 * managing i/o requests and associated device resources
@@ -339,6 +340,7 @@ static int ohci_hcd_au1xxx_drv_resume(st
 static struct platform_driver ohci_hcd_au1xxx_driver = {
 	.probe		= ohci_hcd_au1xxx_drv_probe,
 	.remove		= ohci_hcd_au1xxx_drv_remove,
+	.shutdown 	= usb_hcd_platform_shutdown,
 	/*.suspend	= ohci_hcd_au1xxx_drv_suspend, */
 	/*.resume	= ohci_hcd_au1xxx_drv_resume, */
 	.driver		= {
--- a/drivers/usb/host/ohci-ep93xx.c
+++ b/drivers/usb/host/ohci-ep93xx.c
@@ -128,6 +128,7 @@ static struct hc_driver ohci_ep93xx_hc_d
 	.flags			= HCD_USB11 | HCD_MEMORY,
 	.start			= ohci_ep93xx_start,
 	.stop			= ohci_stop,
+	.shutdown		= ohci_shutdown,		
 	.urb_enqueue		= ohci_urb_enqueue,
 	.urb_dequeue		= ohci_urb_dequeue,
 	.endpoint_disable	= ohci_endpoint_disable,
@@ -202,6 +203,7 @@ #endif
 static struct platform_driver ohci_hcd_ep93xx_driver = {
 	.probe		= ohci_hcd_ep93xx_drv_probe,
 	.remove		= ohci_hcd_ep93xx_drv_remove,
+	.shutdown 	= usb_hcd_platform_shutdown,
 #ifdef CONFIG_PM
 	.suspend	= ohci_hcd_ep93xx_drv_suspend,
 	.resume		= ohci_hcd_ep93xx_drv_resume,
--- a/drivers/usb/host/ohci-hcd.c
+++ b/drivers/usb/host/ohci-hcd.c
@@ -133,7 +133,6 @@ #include "ohci.h"
 static void ohci_dump (struct ohci_hcd *ohci, int verbose);
 static int ohci_init (struct ohci_hcd *ohci);
 static void ohci_stop (struct usb_hcd *hcd);
-static int ohci_reboot (struct notifier_block *, unsigned long , void *);
 
 #include "ohci-hub.c"
 #include "ohci-dbg.c"
@@ -416,21 +415,20 @@ static void ohci_usb_reset (struct ohci_
 	ohci_writel (ohci, ohci->hc_control, &ohci->regs->control);
 }
 
-/* reboot notifier forcibly disables IRQs and DMA, helping kexec and
+/* ohci_shutdown forcibly disables IRQs and DMA, helping kexec and
  * other cases where the next software may expect clean state from the
  * "firmware".  this is bus-neutral, unlike shutdown() methods.
  */
-static int
-ohci_reboot (struct notifier_block *block, unsigned long code, void *null)
+static void
+ohci_shutdown (struct usb_hcd *hcd)
 {
 	struct ohci_hcd *ohci;
 
-	ohci = container_of (block, struct ohci_hcd, reboot_notifier);
+	ohci = hcd_to_ohci (hcd);
 	ohci_writel (ohci, OHCI_INTR_MIE, &ohci->regs->intrdisable);
 	ohci_usb_reset (ohci);
 	/* flush the writes */
 	(void) ohci_readl (ohci, &ohci->regs->control);
-	return 0;
 }
 
 /*-------------------------------------------------------------------------*
@@ -502,7 +500,6 @@ #endif
 	if ((ret = ohci_mem_init (ohci)) < 0)
 		ohci_stop (hcd);
 	else {
-		register_reboot_notifier (&ohci->reboot_notifier);
 		create_debug_files (ohci);
 	}
 
@@ -777,7 +774,6 @@ static void ohci_stop (struct usb_hcd *h
 	ohci_writel (ohci, OHCI_INTR_MIE, &ohci->regs->intrdisable);
 	
 	remove_debug_files (ohci);
-	unregister_reboot_notifier (&ohci->reboot_notifier);
 	ohci_mem_cleanup (ohci);
 	if (ohci->hcca) {
 		dma_free_coherent (hcd->self.controller, 
--- a/drivers/usb/host/ohci-lh7a404.c
+++ b/drivers/usb/host/ohci-lh7a404.c
@@ -178,6 +178,7 @@ #ifdef	CONFIG_PM
 	/* resume:		ohci_lh7a404_resume,   -- tbd */
 #endif /*CONFIG_PM*/
 	.stop =			ohci_stop,
+	.shutdown = 		ohci_shutdown,
 
 	/*
 	 * managing i/o requests and associated device resources
@@ -244,6 +245,7 @@ static int ohci_hcd_lh7a404_drv_resume(s
 static struct platform_driver ohci_hcd_lh7a404_driver = {
 	.probe		= ohci_hcd_lh7a404_drv_probe,
 	.remove		= ohci_hcd_lh7a404_drv_remove,
+	.shutdown 	= usb_hcd_platform_shutdown,
 	/*.suspend	= ohci_hcd_lh7a404_drv_suspend, */
 	/*.resume	= ohci_hcd_lh7a404_drv_resume, */
 	.driver		= {
--- a/drivers/usb/host/ohci-mem.c
+++ b/drivers/usb/host/ohci-mem.c
@@ -28,7 +28,6 @@ static void ohci_hcd_init (struct ohci_h
 	ohci->next_statechange = jiffies;
 	spin_lock_init (&ohci->lock);
 	INIT_LIST_HEAD (&ohci->pending);
-	ohci->reboot_notifier.notifier_call = ohci_reboot;
 }
 
 /*-------------------------------------------------------------------------*/
--- a/drivers/usb/host/ohci-omap.c
+++ b/drivers/usb/host/ohci-omap.c
@@ -411,6 +411,7 @@ static const struct hc_driver ohci_omap_
 	 */
 	.start =		ohci_omap_start,
 	.stop =			ohci_stop,
+	.shutdown = 		ohci_shutdown,
 
 	/*
 	 * managing i/o requests and associated device resources
@@ -500,6 +501,7 @@ #endif
 static struct platform_driver ohci_hcd_omap_driver = {
 	.probe		= ohci_hcd_omap_drv_probe,
 	.remove		= ohci_hcd_omap_drv_remove,
+	.shutdown 	= usb_hcd_platform_shutdown,
 #ifdef	CONFIG_PM
 	.suspend	= ohci_omap_suspend,
 	.resume		= ohci_omap_resume,
--- a/drivers/usb/host/ohci-pci.c
+++ b/drivers/usb/host/ohci-pci.c
@@ -176,6 +176,7 @@ #ifdef	CONFIG_PM
 	.resume =		ohci_pci_resume,
 #endif
 	.stop =			ohci_stop,
+	.shutdown =		ohci_shutdown,
 
 	/*
 	 * managing i/o requests and associated device resources
@@ -224,6 +225,8 @@ #ifdef	CONFIG_PM
 	.suspend =	usb_hcd_pci_suspend,
 	.resume =	usb_hcd_pci_resume,
 #endif
+
+	.shutdown =	usb_hcd_pci_shutdown,
 };
 
  
--- a/drivers/usb/host/ohci-ppc-soc.c
+++ b/drivers/usb/host/ohci-ppc-soc.c
@@ -148,6 +148,7 @@ static const struct hc_driver ohci_ppc_s
 	 */
 	.start =		ohci_ppc_soc_start,
 	.stop =			ohci_stop,
+	.shutdown = 		ohci_shutdown,
 
 	/*
 	 * managing i/o requests and associated device resources
@@ -195,6 +196,7 @@ static int ohci_hcd_ppc_soc_drv_remove(s
 static struct platform_driver ohci_hcd_ppc_soc_driver = {
 	.probe		= ohci_hcd_ppc_soc_drv_probe,
 	.remove		= ohci_hcd_ppc_soc_drv_remove,
+	.shutdown 	= usb_hcd_platform_shutdown,
 #ifdef	CONFIG_PM
 	/*.suspend	= ohci_hcd_ppc_soc_drv_suspend,*/
 	/*.resume	= ohci_hcd_ppc_soc_drv_resume,*/
--- a/drivers/usb/host/ohci-pxa27x.c
+++ b/drivers/usb/host/ohci-pxa27x.c
@@ -270,6 +270,7 @@ static const struct hc_driver ohci_pxa27
 	 */
 	.start =		ohci_pxa27x_start,
 	.stop =			ohci_stop,
+	.shutdown = 		ohci_shutdown,
 
 	/*
 	 * managing i/o requests and associated device resources
@@ -357,6 +358,7 @@ #endif
 static struct platform_driver ohci_hcd_pxa27x_driver = {
 	.probe		= ohci_hcd_pxa27x_drv_probe,
 	.remove		= ohci_hcd_pxa27x_drv_remove,
+	.shutdown 	= usb_hcd_platform_shutdown,
 #ifdef CONFIG_PM
 	.suspend	= ohci_hcd_pxa27x_drv_suspend, 
 	.resume		= ohci_hcd_pxa27x_drv_resume,
--- a/drivers/usb/host/ohci-s3c2410.c
+++ b/drivers/usb/host/ohci-s3c2410.c
@@ -447,6 +447,7 @@ static const struct hc_driver ohci_s3c24
 	 */
 	.start =		ohci_s3c2410_start,
 	.stop =			ohci_stop,
+	.shutdown = 		ohci_shutdown,
 
 	/*
 	 * managing i/o requests and associated device resources
@@ -490,6 +491,7 @@ static int ohci_hcd_s3c2410_drv_remove(s
 static struct platform_driver ohci_hcd_s3c2410_driver = {
 	.probe		= ohci_hcd_s3c2410_drv_probe,
 	.remove		= ohci_hcd_s3c2410_drv_remove,
+	.shutdown 	= usb_hcd_platform_shutdown,
 	/*.suspend	= ohci_hcd_s3c2410_drv_suspend, */
 	/*.resume	= ohci_hcd_s3c2410_drv_resume, */
 	.driver		= {
--- a/drivers/usb/host/ohci.h
+++ b/drivers/usb/host/ohci.h
@@ -389,8 +389,6 @@ struct ohci_hcd {
 	unsigned long		next_statechange;	/* suspend/resume */
 	u32			fminterval;		/* saved register */
 
-	struct notifier_block	reboot_notifier;
-
 	unsigned long		flags;		/* for HC bugs */
 #define	OHCI_QUIRK_AMD756	0x01			/* erratum #4 */
 #define	OHCI_QUIRK_SUPERIO	0x02			/* natsemi */

