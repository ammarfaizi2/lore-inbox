Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932367AbWG3Qnq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932367AbWG3Qnq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 12:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932369AbWG3Qnq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 12:43:46 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:45367 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932367AbWG3Qno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 12:43:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=uUDWCB6h7Q8spCtPYAjXMUfllz+9MRFXUE+dK4yWzJ5lEuwnCxLdOzDDsNB1FaLuALQ0wyLrOlGcb0uUgw8tLPzx44oWVWxkdRWbIkA39CTY19d8VcwYd7DgkZibOeONrE8SjoYEAOuSeTGZGZccqXThWRmIZSa/24kaKdOOl7c=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 12/12] making the kernel -Wshadow clean - 'irq' shadows local and global
Date: Sun, 30 Jul 2006 18:44:47 +0200
User-Agent: KMail/1.9.3
References: <200607301830.01659.jesper.juhl@gmail.com>
In-Reply-To: <200607301830.01659.jesper.juhl@gmail.com>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607301844.47934.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Get rid of various -Wshadow warnings related to 'irq' shadowing a local or
global.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 arch/i386/kernel/acpi/boot.c        |    2
 drivers/cdrom/mcdx.c                |    7 -
 drivers/char/cyclades.c             |   18 +--
 drivers/char/esp.c                  |    4
 drivers/char/synclink.c             |   10 +-
 drivers/char/watchdog/eurotechwdt.c |    2
 drivers/char/watchdog/wdt.c         |    2
 drivers/char/watchdog/wdt_pci.c     |    2
 drivers/isdn/pcbit/drv.c            |   10 +-
 drivers/isdn/pcbit/module.c         |    2
 drivers/mmc/wbsd.c                  |   32 +++---
 drivers/net/seeq8005.c              |    2
 include/linux/interrupt.h           |   28 ++---
 include/linux/irq.h                 |  128 +++++++++++++-------------
 include/linux/random.h              |    4
 sound/isa/gus/interwave.c           |    3
 16 files changed, 129 insertions(+), 127 deletions(-)

--- linux-2.6.18-rc2-git7-orig/arch/i386/kernel/acpi/boot.c	2006-07-29 14:56:45.000000000 +0200
+++ linux-2.6.18-rc2-git7/arch/i386/kernel/acpi/boot.c	2006-07-30 07:34:25.000000000 +0200
@@ -482,7 +482,7 @@ int acpi_register_gsi(u32 gsi, int trigg
 	 * Make sure all (legacy) PCI IRQs are set as level-triggered.
 	 */
 	if (acpi_irq_model == ACPI_IRQ_MODEL_PIC) {
-		extern void eisa_set_level_irq(unsigned int irq);
+		extern void eisa_set_level_irq(unsigned int);
 
 		if (triggering == ACPI_LEVEL_SENSITIVE)
 			eisa_set_level_irq(gsi);
--- linux-2.6.18-rc2-git7-orig/drivers/cdrom/mcdx.c	2006-07-29 14:56:54.000000000 +0200
+++ linux-2.6.18-rc2-git7/drivers/cdrom/mcdx.c	2006-07-30 07:39:35.000000000 +0200
@@ -265,7 +265,7 @@ static unsigned int msf2log(const struct
 static unsigned int uint2bcd(unsigned int);
 static unsigned int bcd2uint(unsigned char);
 static unsigned port(int *);
-static int irq(int *);
+static int get_irq(int *);
 static void mcdx_delay(struct s_drive_stuff *, long jifs);
 static int mcdx_transfer(struct s_drive_stuff *, char *buf, int sector,
 			 int nr_sectors);
@@ -1104,7 +1104,7 @@ static int __init mcdx_init_drive(int dr
 	stuffp->toc = NULL;	/* this should be NULL already */
 
 	/* setup our irq and i/o addresses */
-	stuffp->irq = irq(mcdx_drive_map[drive]);
+	stuffp->irq = get_irq(mcdx_drive_map[drive]);
 	stuffp->wreg_data = stuffp->rreg_data = port(mcdx_drive_map[drive]);
 	stuffp->wreg_reset = stuffp->rreg_status = stuffp->wreg_data + 1;
 	stuffp->wreg_hcon = stuffp->wreg_reset + 1;
@@ -1492,7 +1492,8 @@ static unsigned port(int *ip)
 {
 	return ip[0];
 }
-static int irq(int *ip)
+
+static int get_irq(int *ip)
 {
 	return ip[1];
 }
--- linux-2.6.18-rc2-git7-orig/drivers/char/cyclades.c	2006-07-29 14:56:54.000000000 +0200
+++ linux-2.6.18-rc2-git7/drivers/char/cyclades.c	2006-07-30 07:46:07.000000000 +0200
@@ -1017,13 +1017,13 @@ cyy_issue_cmd(void __iomem *base_addr, u
 static unsigned 
 detect_isa_irq(void __iomem *address)
 {
-  int irq;
+  int intr;
   unsigned long irqs, flags;
   int save_xir, save_car;
   int index = 0; /* IRQ probing is only for ISA */
 
     /* forget possible initially masked and pending IRQ */
-    irq = probe_irq_off(probe_irq_on());
+    intr = probe_irq_off(probe_irq_on());
 
     /* Clear interrupts on the board first */
     cy_writeb(address + (Cy_ClrIntr<<index), 0);
@@ -1047,7 +1047,7 @@ detect_isa_irq(void __iomem *address)
     udelay(5000L);
 
     /* Check which interrupt is in use */
-    irq = probe_irq_off(irqs);
+    intr = probe_irq_off(irqs);
 
     /* Clean up */
     save_xir = (u_char) cy_readb(address + (CyTIR<<index));
@@ -1060,7 +1060,7 @@ detect_isa_irq(void __iomem *address)
     cy_writeb(address + (Cy_ClrIntr<<index), 0);
 			      /* Cy_ClrIntr is 0x1800 */
 
-    return (irq > 0)? irq : 0;
+    return (intr > 0) ? intr : 0;
 }
 #endif /* CONFIG_ISA */
 
@@ -1069,7 +1069,7 @@ detect_isa_irq(void __iomem *address)
    received, out buffer empty, modem change, etc.
  */
 static irqreturn_t
-cyy_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+cyy_interrupt(int intr, void *dev_id, struct pt_regs *regs)
 {
   struct tty_struct *tty;
   int status;
@@ -1089,7 +1089,7 @@ cyy_interrupt(int irq, void *dev_id, str
   int len;
     if((cinfo = (struct cyclades_card *)dev_id) == 0){
 #ifdef CY_DEBUG_INTERRUPTS
-	printk("cyy_interrupt: spurious interrupt %d\n\r", irq);
+	printk("cyy_interrupt: spurious interrupt %d\n\r", intr);
 #endif
         return IRQ_NONE; /* spurious interrupt */
     }
@@ -1814,20 +1814,20 @@ cyz_handle_cmd(struct cyclades_card *cin
 
 #ifdef CONFIG_CYZ_INTR
 static irqreturn_t
-cyz_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+cyz_interrupt(int intr, void *dev_id, struct pt_regs *regs)
 {
   struct cyclades_card *cinfo;
 
     if((cinfo = (struct cyclades_card *)dev_id) == 0){
 #ifdef CY_DEBUG_INTERRUPTS
-	printk("cyz_interrupt: spurious interrupt %d\n\r", irq);
+	printk("cyz_interrupt: spurious interrupt %d\n\r", intr);
 #endif
         return IRQ_NONE; /* spurious interrupt */
     }
 
     if (!ISZLOADED(*cinfo)) {
 #ifdef CY_DEBUG_INTERRUPTS
-	printk("cyz_interrupt: board not yet loaded (IRQ%d).\n\r", irq);
+	printk("cyz_interrupt: board not yet loaded (IRQ%d).\n\r", intr);
 #endif
 	return IRQ_NONE;
     }
--- linux-2.6.18-rc2-git7-orig/drivers/char/esp.c	2006-07-29 14:56:54.000000000 +0200
+++ linux-2.6.18-rc2-git7/drivers/char/esp.c	2006-07-30 07:48:01.000000000 +0200
@@ -615,7 +615,7 @@ static inline void check_modem_status(st
 /*
  * This is the serial driver's interrupt routine
  */
-static irqreturn_t rs_interrupt_single(int irq, void *dev_id,
+static irqreturn_t rs_interrupt_single(int intr, void *dev_id,
 					struct pt_regs *regs)
 {
 	struct esp_struct * info;
@@ -623,7 +623,7 @@ static irqreturn_t rs_interrupt_single(i
 	unsigned int scratch;
 
 #ifdef SERIAL_DEBUG_INTR
-	printk("rs_interrupt_single(%d)...", irq);
+	printk("rs_interrupt_single(%d)...", intr);
 #endif
 	info = (struct esp_struct *)dev_id;
 	err_status = 0;
--- linux-2.6.18-rc2-git7-orig/drivers/char/synclink.c	2006-07-29 14:58:35.000000000 +0200
+++ linux-2.6.18-rc2-git7/drivers/char/synclink.c	2006-07-30 07:51:20.000000000 +0200
@@ -1698,13 +1698,13 @@ static void mgsl_isr_transmit_dma( struc
  * 	
  * Arguments:
  * 
- * 	irq		interrupt number that caused interrupt
+ * 	intr		interrupt number that caused interrupt
  * 	dev_id		device ID supplied during interrupt registration
  * 	regs		interrupted processor context
  * 	
  * Return Value: None
  */
-static irqreturn_t mgsl_interrupt(int irq, void *dev_id, struct pt_regs * regs)
+static irqreturn_t mgsl_interrupt(int intr, void *dev_id, struct pt_regs *regs)
 {
 	struct mgsl_struct * info;
 	u16 UscVector;
@@ -1712,7 +1712,7 @@ static irqreturn_t mgsl_interrupt(int ir
 
 	if ( debug_level >= DEBUG_LEVEL_ISR )	
 		printk("%s(%d):mgsl_interrupt(%d)entry.\n",
-			__FILE__,__LINE__,irq);
+			__FILE__,__LINE__,intr);
 
 	info = (struct mgsl_struct *)dev_id;	
 	if (!info)
@@ -1742,7 +1742,7 @@ static irqreturn_t mgsl_interrupt(int ir
 
 		if ( info->isr_overflow ) {
 			printk(KERN_ERR"%s(%d):%s isr overflow irq=%d\n",
-				__FILE__,__LINE__,info->device_name, irq);
+				__FILE__,__LINE__,info->device_name, intr);
 			usc_DisableMasterIrqBit(info);
 			usc_DisableDmaInterrupts(info,DICR_MASTER);
 			break;
@@ -1765,7 +1765,7 @@ static irqreturn_t mgsl_interrupt(int ir
 	
 	if ( debug_level >= DEBUG_LEVEL_ISR )	
 		printk("%s(%d):mgsl_interrupt(%d)exit.\n",
-			__FILE__,__LINE__,irq);
+			__FILE__,__LINE__,intr);
 	return IRQ_HANDLED;
 }	/* end of mgsl_interrupt() */
 
--- linux-2.6.18-rc2-git7-orig/drivers/char/watchdog/eurotechwdt.c	2006-07-29 14:56:54.000000000 +0200
+++ linux-2.6.18-rc2-git7/drivers/char/watchdog/eurotechwdt.c	2006-07-30 07:52:22.000000000 +0200
@@ -153,7 +153,7 @@ static void eurwdt_activate_timer(void)
  * Kernel methods.
  */
 
-static irqreturn_t eurwdt_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+static irqreturn_t eurwdt_interrupt(int intr, void *dev_id, struct pt_regs *regs)
 {
 	printk(KERN_CRIT "timeout WDT timeout\n");
 
--- linux-2.6.18-rc2-git7-orig/drivers/char/watchdog/wdt.c	2006-07-29 14:56:54.000000000 +0200
+++ linux-2.6.18-rc2-git7/drivers/char/watchdog/wdt.c	2006-07-30 07:53:26.000000000 +0200
@@ -232,7 +232,7 @@ static int wdt_get_temperature(int *temp
  *	a failure condition occurring.
  */
 
-static irqreturn_t wdt_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+static irqreturn_t wdt_interrupt(int intr, void *dev_id, struct pt_regs *regs)
 {
 	/*
 	 *	Read the status register see what is up and
--- linux-2.6.18-rc2-git7-orig/drivers/char/watchdog/wdt_pci.c	2006-07-29 14:56:54.000000000 +0200
+++ linux-2.6.18-rc2-git7/drivers/char/watchdog/wdt_pci.c	2006-07-30 07:54:03.000000000 +0200
@@ -277,7 +277,7 @@ static int wdtpci_get_temperature(int *t
  *	a failure condition occurring.
  */
 
-static irqreturn_t wdtpci_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+static irqreturn_t wdtpci_interrupt(int intr, void *dev_id, struct pt_regs *regs)
 {
 	/*
 	 *	Read the status register see what is up and
--- linux-2.6.18-rc2-git7-orig/drivers/isdn/pcbit/module.c	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6.18-rc2-git7/drivers/isdn/pcbit/module.c	2006-07-30 07:56:14.000000000 +0200
@@ -33,7 +33,7 @@ static int num_boards;
 struct pcbit_dev * dev_pcbit[MAX_PCBIT_CARDS];
 
 extern void pcbit_terminate(int board);
-extern int pcbit_init_dev(int board, int mem_base, int irq);
+extern int pcbit_init_dev(int board, int mem_base, int intr);
 
 static int __init pcbit_init(void)
 {
--- linux-2.6.18-rc2-git7-orig/drivers/isdn/pcbit/drv.c	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6.18-rc2-git7/drivers/isdn/pcbit/drv.c	2006-07-30 07:57:59.000000000 +0200
@@ -70,7 +70,7 @@ static int pcbit_check_msn(struct pcbit_
 
 extern void pcbit_deliver(void * data);
 
-int pcbit_init_dev(int board, int mem_base, int irq)
+int pcbit_init_dev(int board, int mem_base, int intr)
 {
 	struct pcbit_dev *dev;
 	isdn_if *dev_if;
@@ -135,7 +135,7 @@ int pcbit_init_dev(int board, int mem_ba
 	 *  interrupts
 	 */
 
-	if (request_irq(irq, &pcbit_irq_handler, 0, pcbit_devname[board], dev) != 0) 
+	if (request_irq(intr, &pcbit_irq_handler, 0, pcbit_devname[board], dev) != 0) 
 	{
 		kfree(dev->b1);
 		kfree(dev->b2);
@@ -146,7 +146,7 @@ int pcbit_init_dev(int board, int mem_ba
 		return -EIO;
 	}
 
-	dev->irq = irq;
+	dev->irq = intr;
 
 	/* next frame to be received */
 	dev->rcv_seq = 0;
@@ -158,7 +158,7 @@ int pcbit_init_dev(int board, int mem_ba
 	dev_if = kmalloc(sizeof(isdn_if), GFP_KERNEL);
 
 	if (!dev_if) {
-		free_irq(irq, dev);
+		free_irq(intr, dev);
 		kfree(dev->b1);
 		kfree(dev->b2);
 		iounmap(dev->sh_mem);
@@ -190,7 +190,7 @@ int pcbit_init_dev(int board, int mem_ba
 	strcpy(dev_if->id, pcbit_devname[board]);
 
 	if (!register_isdn(dev_if)) {
-		free_irq(irq, dev);
+		free_irq(intr, dev);
 		kfree(dev->b1);
 		kfree(dev->b2);
 		iounmap(dev->sh_mem);
--- linux-2.6.18-rc2-git7-orig/drivers/mmc/wbsd.c	2006-07-29 14:57:01.000000000 +0200
+++ linux-2.6.18-rc2-git7/drivers/mmc/wbsd.c	2006-07-30 08:30:27.000000000 +0200
@@ -1255,7 +1255,7 @@ end:
  * Interrupt handling
  */
 
-static irqreturn_t wbsd_irq(int irq, void *dev_id, struct pt_regs *regs)
+static irqreturn_t wbsd_irq(int intr, void *dev_id, struct pt_regs *regs)
 {
 	struct wbsd_host *host = dev_id;
 	int isr;
@@ -1545,7 +1545,7 @@ static void __devexit wbsd_release_dma(s
  * Allocate/free IRQ.
  */
 
-static int __devinit wbsd_request_irq(struct wbsd_host *host, int irq)
+static int __devinit wbsd_request_irq(struct wbsd_host *host, int intr)
 {
 	int ret;
 
@@ -1553,11 +1553,11 @@ static int __devinit wbsd_request_irq(st
 	 * Allocate interrupt.
 	 */
 
-	ret = request_irq(irq, wbsd_irq, IRQF_SHARED, DRIVER_NAME, host);
+	ret = request_irq(intr, wbsd_irq, IRQF_SHARED, DRIVER_NAME, host);
 	if (ret)
 		return ret;
 
-	host->irq = irq;
+	host->irq = intr;
 
 	/*
 	 * Set up tasklets.
@@ -1600,7 +1600,7 @@ static void __devexit wbsd_release_irq(s
  */
 
 static int __devinit wbsd_request_resources(struct wbsd_host *host,
-	int base, int irq, int dma)
+	int base, int intr, int dma)
 {
 	int ret;
 
@@ -1614,7 +1614,7 @@ static int __devinit wbsd_request_resour
 	/*
 	 * Allocate interrupt.
 	 */
-	ret = wbsd_request_irq(host, irq);
+	ret = wbsd_request_irq(host, intr);
 	if (ret)
 		return ret;
 
@@ -1687,7 +1687,7 @@ static void wbsd_chip_config(struct wbsd
 
 static int wbsd_chip_validate(struct wbsd_host *host)
 {
-	int base, irq, dma;
+	int base, intr, dma;
 
 	wbsd_unlock_config(host);
 
@@ -1702,7 +1702,7 @@ static int wbsd_chip_validate(struct wbs
 	base = wbsd_read_config(host, WBSD_CONF_PORT_HI) << 8;
 	base |= wbsd_read_config(host, WBSD_CONF_PORT_LO);
 
-	irq = wbsd_read_config(host, WBSD_CONF_IRQ);
+	intr = wbsd_read_config(host, WBSD_CONF_IRQ);
 
 	dma = wbsd_read_config(host, WBSD_CONF_DRQ);
 
@@ -1713,7 +1713,7 @@ static int wbsd_chip_validate(struct wbs
 	 */
 	if (base != host->base)
 		return 0;
-	if (irq != host->irq)
+	if (intr != host->irq)
 		return 0;
 	if ((dma != host->dma) && (host->dma != -1))
 		return 0;
@@ -1741,8 +1741,8 @@ static void wbsd_chip_poweroff(struct wb
  *                                                                           *
 \*****************************************************************************/
 
-static int __devinit wbsd_init(struct device *dev, int base, int irq, int dma,
-	int pnp)
+static int __devinit wbsd_init(struct device *dev, int base, int intr,
+	int dma, int pnp)
 {
 	struct wbsd_host *host = NULL;
 	struct mmc_host *mmc = NULL;
@@ -1773,7 +1773,7 @@ static int __devinit wbsd_init(struct de
 	/*
 	 * Request resources.
 	 */
-	ret = wbsd_request_resources(host, io, irq, dma);
+	ret = wbsd_request_resources(host, io, intr, dma);
 	if (ret) {
 		wbsd_release_resources(host);
 		wbsd_free_mmc(dev);
@@ -1880,21 +1880,21 @@ static int __devexit wbsd_remove(struct 
 static int __devinit
 wbsd_pnp_probe(struct pnp_dev *pnpdev, const struct pnp_device_id *dev_id)
 {
-	int io, irq, dma;
+	int io, intr, dma;
 
 	/*
 	 * Get resources from PnP layer.
 	 */
 	io = pnp_port_start(pnpdev, 0);
-	irq = pnp_irq(pnpdev, 0);
+	intr = pnp_irq(pnpdev, 0);
 	if (pnp_dma_valid(pnpdev, 0))
 		dma = pnp_dma(pnpdev, 0);
 	else
 		dma = -1;
 
-	DBGF("PnP resources: port %3x irq %d dma %d\n", io, irq, dma);
+	DBGF("PnP resources: port %3x irq %d dma %d\n", io, intr, dma);
 
-	return wbsd_init(&pnpdev->dev, io, irq, dma, 1);
+	return wbsd_init(&pnpdev->dev, io, intr, dma, 1);
 }
 
 static void __devexit wbsd_pnp_remove(struct pnp_dev *dev)
--- linux-2.6.18-rc2-git7-orig/drivers/net/seeq8005.c	2006-07-29 14:57:02.000000000 +0200
+++ linux-2.6.18-rc2-git7/drivers/net/seeq8005.c	2006-07-30 08:32:05.000000000 +0200
@@ -437,7 +437,7 @@ inline void wait_for_buffer(struct net_d
  
 /* The typical workload of the driver:
    Handle the network interface interrupts. */
-static irqreturn_t seeq8005_interrupt(int irq, void *dev_id, struct pt_regs * regs)
+static irqreturn_t seeq8005_interrupt(int intr, void *dev_id, struct pt_regs *regs)
 {
 	struct net_device *dev = dev_id;
 	struct net_local *lp;
--- linux-2.6.18-rc2-git7-orig/include/linux/interrupt.h	2006-07-29 14:57:26.000000000 +0200
+++ linux-2.6.18-rc2-git7/include/linux/interrupt.h	2006-07-30 09:11:39.000000000 +0200
@@ -100,9 +100,9 @@ extern void free_irq(unsigned int, void 
 #endif
 
 #ifdef CONFIG_GENERIC_HARDIRQS
-extern void disable_irq_nosync(unsigned int irq);
-extern void disable_irq(unsigned int irq);
-extern void enable_irq(unsigned int irq);
+extern void disable_irq_nosync(unsigned int i);
+extern void disable_irq(unsigned int i);
+extern void enable_irq(unsigned int i);
 
 /*
  * Special lockdep variants of irq disabling/enabling.
@@ -115,41 +115,41 @@ extern void enable_irq(unsigned int irq)
  * On !CONFIG_LOCKDEP they are equivalent to the normal
  * irq disable/enable methods.
  */
-static inline void disable_irq_nosync_lockdep(unsigned int irq)
+static inline void disable_irq_nosync_lockdep(unsigned int i)
 {
-	disable_irq_nosync(irq);
+	disable_irq_nosync(i);
 #ifdef CONFIG_LOCKDEP
 	local_irq_disable();
 #endif
 }
 
-static inline void disable_irq_lockdep(unsigned int irq)
+static inline void disable_irq_lockdep(unsigned int i)
 {
-	disable_irq(irq);
+	disable_irq(i);
 #ifdef CONFIG_LOCKDEP
 	local_irq_disable();
 #endif
 }
 
-static inline void enable_irq_lockdep(unsigned int irq)
+static inline void enable_irq_lockdep(unsigned int i)
 {
 #ifdef CONFIG_LOCKDEP
 	local_irq_enable();
 #endif
-	enable_irq(irq);
+	enable_irq(i);
 }
 
 /* IRQ wakeup (PM) control: */
-extern int set_irq_wake(unsigned int irq, unsigned int on);
+extern int set_irq_wake(unsigned int i, unsigned int on);
 
-static inline int enable_irq_wake(unsigned int irq)
+static inline int enable_irq_wake(unsigned int i)
 {
-	return set_irq_wake(irq, 1);
+	return set_irq_wake(i, 1);
 }
 
-static inline int disable_irq_wake(unsigned int irq)
+static inline int disable_irq_wake(unsigned int i)
 {
-	return set_irq_wake(irq, 0);
+	return set_irq_wake(i, 0);
 }
 
 #else /* !CONFIG_GENERIC_HARDIRQS */
--- linux-2.6.18-rc2-git7-orig/include/linux/irq.h	2006-07-29 14:57:26.000000000 +0200
+++ linux-2.6.18-rc2-git7/include/linux/irq.h	2006-07-30 08:47:53.000000000 +0200
@@ -85,26 +85,26 @@ struct proc_dir_entry;
  */
 struct irq_chip {
 	const char	*name;
-	unsigned int	(*startup)(unsigned int irq);
-	void		(*shutdown)(unsigned int irq);
-	void		(*enable)(unsigned int irq);
-	void		(*disable)(unsigned int irq);
-
-	void		(*ack)(unsigned int irq);
-	void		(*mask)(unsigned int irq);
-	void		(*mask_ack)(unsigned int irq);
-	void		(*unmask)(unsigned int irq);
-	void		(*eoi)(unsigned int irq);
-
-	void		(*end)(unsigned int irq);
-	void		(*set_affinity)(unsigned int irq, cpumask_t dest);
-	int		(*retrigger)(unsigned int irq);
-	int		(*set_type)(unsigned int irq, unsigned int flow_type);
-	int		(*set_wake)(unsigned int irq, unsigned int on);
+	unsigned int	(*startup)(unsigned int intr);
+	void		(*shutdown)(unsigned int intr);
+	void		(*enable)(unsigned int intr);
+	void		(*disable)(unsigned int intr);
+
+	void		(*ack)(unsigned int intr);
+	void		(*mask)(unsigned int intr);
+	void		(*mask_ack)(unsigned int intr);
+	void		(*unmask)(unsigned int intr);
+	void		(*eoi)(unsigned int intr);
+
+	void		(*end)(unsigned int intr);
+	void		(*set_affinity)(unsigned int intr, cpumask_t dest);
+	int		(*retrigger)(unsigned int intr);
+	int		(*set_type)(unsigned int intr, unsigned int flow_type);
+	int		(*set_wake)(unsigned int intr, unsigned int on);
 
 	/* Currently used only by UML, might disappear one day.*/
 #ifdef CONFIG_IRQ_RELEASE_METHOD
-	void		(*release)(unsigned int irq, void *dev_id);
+	void		(*release)(unsigned int intr, void *dev_id);
 #endif
 	/*
 	 * For compatibility, ->typename is copied into ->name.
@@ -137,7 +137,7 @@ struct irq_chip {
  * Pad this out to 32 bytes for cache and indexing reasons.
  */
 struct irq_desc {
-	void fastcall		(*handle_irq)(unsigned int irq,
+	void fastcall		(*handle_irq)(unsigned int intr,
 					      struct irq_desc *desc,
 					      struct pt_regs *regs);
 	struct irq_chip		*chip;
@@ -178,7 +178,7 @@ typedef struct irq_desc		irq_desc_t;
  */
 #include <asm/hw_irq.h>
 
-extern int setup_irq(unsigned int irq, struct irqaction *new);
+extern int setup_irq(unsigned int intr, struct irqaction *new);
 
 #ifdef CONFIG_GENERIC_HARDIRQS
 
@@ -187,12 +187,12 @@ extern int setup_irq(unsigned int irq, s
 #endif
 
 #ifdef CONFIG_SMP
-static inline void set_native_irq_info(int irq, cpumask_t mask)
+static inline void set_native_irq_info(int intr, cpumask_t mask)
 {
-	irq_desc[irq].affinity = mask;
+	irq_desc[intr].affinity = mask;
 }
 #else
-static inline void set_native_irq_info(int irq, cpumask_t mask)
+static inline void set_native_irq_info(int intr, cpumask_t mask)
 {
 }
 #endif
@@ -201,8 +201,8 @@ static inline void set_native_irq_info(i
 
 #if defined(CONFIG_GENERIC_PENDING_IRQ) || defined(CONFIG_IRQBALANCE)
 
-void set_pending_irq(unsigned int irq, cpumask_t mask);
-void move_native_irq(int irq);
+void set_pending_irq(unsigned int intr, cpumask_t mask);
+void move_native_irq(int intr);
 
 #ifdef CONFIG_PCI_MSI
 /*
@@ -212,45 +212,45 @@ void move_native_irq(int irq);
  * this operation on the real irq, when we dont use vector, i.e when
  * pci_use_vector() is false.
  */
-static inline void move_irq(int irq)
+static inline void move_irq(int intr)
 {
 }
 
-static inline void set_irq_info(int irq, cpumask_t mask)
+static inline void set_irq_info(int intr, cpumask_t mask)
 {
 }
 
 #else /* CONFIG_PCI_MSI */
 
-static inline void move_irq(int irq)
+static inline void move_irq(int intr)
 {
-	move_native_irq(irq);
+	move_native_irq(intr);
 }
 
-static inline void set_irq_info(int irq, cpumask_t mask)
+static inline void set_irq_info(int intr, cpumask_t mask)
 {
-	set_native_irq_info(irq, mask);
+	set_native_irq_info(intr, mask);
 }
 
 #endif /* CONFIG_PCI_MSI */
 
 #else /* CONFIG_GENERIC_PENDING_IRQ || CONFIG_IRQBALANCE */
 
-static inline void move_irq(int irq)
+static inline void move_irq(int intr)
 {
 }
 
-static inline void move_native_irq(int irq)
+static inline void move_native_irq(int intr)
 {
 }
 
-static inline void set_pending_irq(unsigned int irq, cpumask_t mask)
+static inline void set_pending_irq(unsigned int intr, cpumask_t mask)
 {
 }
 
-static inline void set_irq_info(int irq, cpumask_t mask)
+static inline void set_irq_info(int intr, cpumask_t mask)
 {
-	set_native_irq_info(irq, mask);
+	set_native_irq_info(intr, mask);
 }
 
 #endif /* CONFIG_GENERIC_PENDING_IRQ */
@@ -263,17 +263,17 @@ static inline void set_irq_info(int irq,
 #endif /* CONFIG_SMP */
 
 #ifdef CONFIG_IRQBALANCE
-extern void set_balance_irq_affinity(unsigned int irq, cpumask_t mask);
+extern void set_balance_irq_affinity(unsigned int intr, cpumask_t mask);
 #else
-static inline void set_balance_irq_affinity(unsigned int irq, cpumask_t mask)
+static inline void set_balance_irq_affinity(unsigned int intr, cpumask_t mask)
 {
 }
 #endif
 
 #ifdef CONFIG_AUTO_IRQ_AFFINITY
-extern int select_smp_affinity(unsigned int irq);
+extern int select_smp_affinity(unsigned int intr);
 #else
-static inline int select_smp_affinity(unsigned int irq)
+static inline int select_smp_affinity(unsigned int intr)
 {
 	return 1;
 }
@@ -282,7 +282,7 @@ static inline int select_smp_affinity(un
 extern int no_irq_affinity;
 
 /* Handle irq action chains: */
-extern int handle_IRQ_event(unsigned int irq, struct pt_regs *regs,
+extern int handle_IRQ_event(unsigned int intr, struct pt_regs *regs,
 			    struct irqaction *action);
 
 /*
@@ -290,20 +290,20 @@ extern int handle_IRQ_event(unsigned int
  * callable via desc->chip->handle_irq()
  */
 extern void fastcall
-handle_level_irq(unsigned int irq, struct irq_desc *desc, struct pt_regs *regs);
+handle_level_irq(unsigned int intr, struct irq_desc *desc, struct pt_regs *regs);
 extern void fastcall
-handle_fasteoi_irq(unsigned int irq, struct irq_desc *desc,
+handle_fasteoi_irq(unsigned int intr, struct irq_desc *desc,
 			 struct pt_regs *regs);
 extern void fastcall
-handle_edge_irq(unsigned int irq, struct irq_desc *desc, struct pt_regs *regs);
+handle_edge_irq(unsigned int intr, struct irq_desc *desc, struct pt_regs *regs);
 extern void fastcall
-handle_simple_irq(unsigned int irq, struct irq_desc *desc,
+handle_simple_irq(unsigned int intr, struct irq_desc *desc,
 		  struct pt_regs *regs);
 extern void fastcall
-handle_percpu_irq(unsigned int irq, struct irq_desc *desc,
+handle_percpu_irq(unsigned int intr, struct irq_desc *desc,
 		  struct pt_regs *regs);
 extern void fastcall
-handle_bad_irq(unsigned int irq, struct irq_desc *desc, struct pt_regs *regs);
+handle_bad_irq(unsigned int intr, struct irq_desc *desc, struct pt_regs *regs);
 
 /*
  * Get a descriptive string for the highlevel handler, for
@@ -317,7 +317,7 @@ handle_irq_name(void fastcall (*handle)(
  * Monolithic do_IRQ implementation.
  * (is an explicit fastcall, because i386 4KSTACKS calls it from assembly)
  */
-extern fastcall unsigned int __do_IRQ(unsigned int irq, struct pt_regs *regs);
+extern fastcall unsigned int __do_IRQ(unsigned int intr, struct pt_regs *regs);
 
 /*
  * Architectures call this to let the generic IRQ layer
@@ -325,22 +325,22 @@ extern fastcall unsigned int __do_IRQ(un
  * irqchip-style controller then we call the ->handle_irq() handler,
  * and it calls __do_IRQ() if it's attached to an irqtype-style controller.
  */
-static inline void generic_handle_irq(unsigned int irq, struct pt_regs *regs)
+static inline void generic_handle_irq(unsigned int intr, struct pt_regs *regs)
 {
-	struct irq_desc *desc = irq_desc + irq;
+	struct irq_desc *desc = irq_desc + intr;
 
 	if (likely(desc->handle_irq))
-		desc->handle_irq(irq, desc, regs);
+		desc->handle_irq(intr, desc, regs);
 	else
-		__do_IRQ(irq, regs);
+		__do_IRQ(intr, regs);
 }
 
 /* Handling of unhandled and spurious interrupts: */
-extern void note_interrupt(unsigned int irq, struct irq_desc *desc,
+extern void note_interrupt(unsigned int intr, struct irq_desc *desc,
 			   int action_ret, struct pt_regs *regs);
 
 /* Resending of interrupts :*/
-void check_irq_resend(struct irq_desc *desc, unsigned int irq);
+void check_irq_resend(struct irq_desc *desc, unsigned int intr);
 
 /* Initialize /proc/irq/ */
 extern void init_irq_proc(void);
@@ -349,19 +349,19 @@ extern void init_irq_proc(void);
 extern int noirqdebug_setup(char *str);
 
 /* Checks whether the interrupt can be requested by request_irq(): */
-extern int can_request_irq(unsigned int irq, unsigned long irqflags);
+extern int can_request_irq(unsigned int intr, unsigned long irqflags);
 
 /* Dummy irq-chip implementations: */
 extern struct irq_chip no_irq_chip;
 extern struct irq_chip dummy_irq_chip;
 
 extern void
-set_irq_chip_and_handler(unsigned int irq, struct irq_chip *chip,
+set_irq_chip_and_handler(unsigned int intr, struct irq_chip *chip,
 			 void fastcall (*handle)(unsigned int,
 						 struct irq_desc *,
 						 struct pt_regs *));
 extern void
-__set_irq_handler(unsigned int irq,
+__set_irq_handler(unsigned int intr,
 		  void fastcall (*handle)(unsigned int, struct irq_desc *,
 					  struct pt_regs *),
 		  int is_chained);
@@ -370,11 +370,11 @@ __set_irq_handler(unsigned int irq,
  * Set a highlevel flow handler for a given IRQ:
  */
 static inline void
-set_irq_handler(unsigned int irq,
+set_irq_handler(unsigned int intr,
 		void fastcall (*handle)(unsigned int, struct irq_desc *,
 					struct pt_regs *))
 {
-	__set_irq_handler(irq, handle, 0);
+	__set_irq_handler(intr, handle, 0);
 }
 
 /*
@@ -383,19 +383,19 @@ set_irq_handler(unsigned int irq,
  *  IRQ_NOREQUEST and IRQ_NOPROBE)
  */
 static inline void
-set_irq_chained_handler(unsigned int irq,
+set_irq_chained_handler(unsigned int intr,
 			void fastcall (*handle)(unsigned int, struct irq_desc *,
 						struct pt_regs *))
 {
-	__set_irq_handler(irq, handle, 1);
+	__set_irq_handler(intr, handle, 1);
 }
 
 /* Set/get chip/data for an IRQ: */
 
-extern int set_irq_chip(unsigned int irq, struct irq_chip *chip);
-extern int set_irq_data(unsigned int irq, void *data);
-extern int set_irq_chip_data(unsigned int irq, void *data);
-extern int set_irq_type(unsigned int irq, unsigned int type);
+extern int set_irq_chip(unsigned int intr, struct irq_chip *chip);
+extern int set_irq_data(unsigned int intr, void *data);
+extern int set_irq_chip_data(unsigned int intr, void *data);
+extern int set_irq_type(unsigned int intr, unsigned int type);
 
 #define get_irq_chip(irq)	(irq_desc[irq].chip)
 #define get_irq_chip_data(irq)	(irq_desc[irq].chip_data)
--- linux-2.6.18-rc2-git7-orig/include/linux/random.h	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6.18-rc2-git7/include/linux/random.h	2006-07-30 08:56:03.000000000 +0200
@@ -42,11 +42,11 @@ struct rand_pool_info {
 
 #ifdef __KERNEL__
 
-extern void rand_initialize_irq(int irq);
+extern void rand_initialize_irq(int intr);
 
 extern void add_input_randomness(unsigned int type, unsigned int code,
 				 unsigned int value);
-extern void add_interrupt_randomness(int irq);
+extern void add_interrupt_randomness(int intr);
 
 extern void get_random_bytes(void *buf, int nbytes);
 void generate_random_uuid(unsigned char uuid_out[16]);
--- linux-2.6.18-rc2-git7-orig/sound/isa/gus/interwave.c	2006-07-29 14:57:32.000000000 +0200
+++ linux-2.6.18-rc2-git7/sound/isa/gus/interwave.c	2006-07-30 08:57:11.000000000 +0200
@@ -299,7 +299,8 @@ static int __devinit snd_interwave_detec
 	return -ENODEV;
 }
 
-static irqreturn_t snd_interwave_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+static irqreturn_t snd_interwave_interrupt(int intr, void *dev_id,
+					   struct pt_regs *regs)
 {
 	struct snd_interwave *iwcard = (struct snd_interwave *) dev_id;
 	int loop, max = 5;



