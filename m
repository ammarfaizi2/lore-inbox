Return-Path: <linux-kernel-owner+willy=40w.ods.org-S323404AbUKAW2Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S323404AbUKAW2Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 17:28:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S323400AbUKAW2X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 17:28:23 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:27066 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S270848AbUKAT7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 14:59:18 -0500
Date: Mon, 1 Nov 2004 12:59:11 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Kumar Gala <kumar.gala@freescale.com>
Cc: akpm@osdl.org, Christoph Hellwig <hch@infradead.org>,
       Pantelis Antoniou <panto@intracom.gr>, Ingo Molnar <mingo@elte.hu>,
       Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       "Gala Kumar K.-galak" <kumar.gala@motorola.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] Fix early request_irq
Message-ID: <20041101195911.GL24459@smtp.west.cox.net>
References: <20041029161101.GS2097@smtp.west.cox.net> <Pine.GSO.4.44.0411011140100.17740-100000@sysperf.somerset.sps.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0411011140100.17740-100000@sysperf.somerset.sps.mot.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 01, 2004 at 11:41:44AM -0600, Kumar Gala wrote:

> Andrew,
> 
> Please apply this patch from Tom Rini.  I've tested it for PowerPC MPC85xx
> parts and it works.
> 
> Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

I've attached a slightly different version, which applies against
current -bk (Linus applied a patch from Ben that fixed pmac booting
which made my patch not apply), which is the only change.

Signed-off-by: Tom Rini <trini@kernel.crashing.org>

--- 1.37/arch/ppc/platforms/chrp_setup.c	2004-10-29 01:13:38 -07:00
+++ edited/arch/ppc/platforms/chrp_setup.c	2004-11-01 12:56:45 -07:00
@@ -371,19 +371,14 @@
 	}
 }
 
-static int __init
-chrp_request_cascade(void)
-{
-	if (_machine != _MACH_chrp)
-		return 0;
-
-	/* We have a cascade on OpenPIC IRQ 0, Linux IRQ 16 */
-	openpic_hookup_cascade(NUM_8259_INTERRUPTS, "82c59 cascade",
-			       i8259_irq);
-	return 0;
-}
-arch_initcall(chrp_request_cascade);
-
+#if defined(CONFIG_VT) && defined(CONFIG_INPUT_ADBHID) && defined(XMON)
+static struct irqaction xmon_irqaction = {
+	.handler = xmon_irq,
+	.mask = CPU_MASK_NONE,
+	.name = "XMON break",
+};
+#endif
+ 
 void __init chrp_init_IRQ(void)
 {
 	struct device_node *np;
@@ -413,6 +408,9 @@
 	OpenPIC_NumInitSenses = NR_IRQS - NUM_8259_INTERRUPTS;
 
 	openpic_init(NUM_8259_INTERRUPTS);
+	/* We have a cascade on OpenPIC IRQ 0, Linux IRQ 16 */
+	openpic_hookup_cascade(NUM_8259_INTERRUPTS, "82c59 cascade",
+			       i8259_irq);
 
 	for (i = 0; i < NUM_8259_INTERRUPTS; i++)
 		irq_desc[i].handler = &i8259_pic;
@@ -426,7 +424,7 @@
 		    && strcmp(kbd->parent->type, "adb") == 0)
 			break;
 	if (kbd)
-		request_irq(HYDRA_INT_ADB_NMI, xmon_irq, 0, "XMON break", 0);
+		setup_irq(HYDRA_INT_ADB_NMI, &xmon_irqaction);
 #endif
 }
 
--- 1.27/arch/ppc/platforms/lopec.c	2004-10-27 15:05:16 -07:00
+++ edited/arch/ppc/platforms/lopec.c	2004-11-01 12:55:54 -07:00
@@ -258,17 +258,6 @@
 }
 #endif /* BLK_DEV_IDE */
 
-static int __init
-lopec_request_cascade(void)
-{
-	/* We have a cascade on OpenPIC IRQ 0, Linux IRQ 16 */
-	openpic_hookup_cascade(NUM_8259_INTERRUPTS, "82c59 cascade",
-			&i8259_irq);
-
-	return 0;
-}
-arch_initcall(lopec_request_cascade);
-
 static void __init
 lopec_init_IRQ(void)
 {
@@ -281,6 +270,10 @@
 	OpenPIC_NumInitSenses = sizeof(lopec_openpic_initsenses);
 
 	mpc10x_set_openpic();
+
+	/* We have a cascade on OpenPIC IRQ 0, Linux IRQ 16 */
+	openpic_hookup_cascade(NUM_8259_INTERRUPTS, "82c59 cascade",
+			&i8259_irq);
 
 	/* Map i8259 interrupts */
 	for(i = 0; i < NUM_8259_INTERRUPTS; i++)
--- 1.19/arch/ppc/platforms/mcpn765.c	2004-10-27 15:05:16 -07:00
+++ edited/arch/ppc/platforms/mcpn765.c	2004-11-01 12:55:54 -07:00
@@ -363,15 +363,6 @@
 	return;
 }
 
-static int __init
-mcpn765_request_cascade(void)
-{
-	openpic_hookup_cascade(NUM_8259_INTERRUPTS, "82c59 cascade",
-			i8259_irq);
-	return 0;
-}
-arch_initcall(mcpn765_request_cascade);
-
 /*
  * Interrupt setup and service.
  * Have MPIC on HAWK and cascaded 8259s on VIA 82586 cascaded to MPIC.
@@ -385,6 +376,8 @@
 		ppc_md.progress("init_irq: enter", 0);
 
 	openpic_init(NUM_8259_INTERRUPTS);
+	openpic_hookup_cascade(NUM_8259_INTERRUPTS, "82c59 cascade",
+			i8259_irq);
 
 	for(i=0; i < NUM_8259_INTERRUPTS; i++)
 		irq_desc[i].handler = &i8259_pic;
--- 1.11/arch/ppc/platforms/mvme5100.c	2004-10-27 15:05:16 -07:00
+++ edited/arch/ppc/platforms/mvme5100.c	2004-11-01 12:55:54 -07:00
@@ -204,17 +204,6 @@
 	return;
 }
 
-static int __init
-mvme5100_request_cascade(void)
-{
-#ifdef CONFIG_MVME5100_IPMC761_PRESENT
-	openpic_hookup_cascade(NUM_8259_INTERRUPTS, "82c59 cascade",
-			&i8259_irq);
-#endif
-	return 0;
-}
-arch_initcall(mvme5100_request_cascade);
-
 /*
  * Interrupt setup and service.
  * Have MPIC on HAWK and cascaded 8259s on Winbond cascaded to MPIC.
@@ -232,12 +221,14 @@
 	openpic_set_sources(0, 16, OpenPIC_Addr + 0x10000);
 #ifdef CONFIG_MVME5100_IPMC761_PRESENT
 	openpic_init(NUM_8259_INTERRUPTS);
+	openpic_hookup_cascade(NUM_8259_INTERRUPTS, "82c59 cascade",
+			&i8259_irq);
 
 	/* Map i8259 interrupts. */
 	for (i = 0; i < NUM_8259_INTERRUPTS; i++)
 		irq_desc[i].handler = &i8259_pic;
 
-	i8259_init((long)NULL);
+	i8259_init(0);
 #else
 	openpic_init(0);
 #endif
--- 1.20/arch/ppc/platforms/pmac_smp.c	2004-09-07 23:32:57 -07:00
+++ edited/arch/ppc/platforms/pmac_smp.c	2004-11-01 12:55:54 -07:00
@@ -405,6 +405,13 @@
 	smp_tb_synchronized = 1;
 }
 
+static struct irqaction psurge_irqaction = {
+	.handler = psurge_primary_intr,
+	.flags = SA_INTERRUPT,
+	.mask = CPU_MASK_NONE,
+	.name = "primary IPI",
+};
+
 static void __init smp_psurge_setup_cpu(int cpu_nr)
 {
 
@@ -421,7 +428,7 @@
 		/* reset the entry point so if we get another intr we won't
 		 * try to startup again */
 		out_be32(psurge_start, 0x100);
-		if (request_irq(30, psurge_primary_intr, SA_INTERRUPT, "primary IPI", NULL))
+		if (setup_irq(30, &psurge_irqaction))
 			printk(KERN_ERR "Couldn't get primary IPI interrupt");
 	}
 
--- 1.23/arch/ppc/platforms/pplus.c	2004-10-27 15:05:16 -07:00
+++ edited/arch/ppc/platforms/pplus.c	2004-11-01 12:55:54 -07:00
@@ -654,16 +654,6 @@
 		return irq;
 }
 
-static int __init
-pplus_request_cascade(void)
-{
-	if (OpenPIC_Addr != NULL)
-		openpic_hookup_cascade(NUM_8259_INTERRUPTS, "82c59 cascade",
-				i8259_irq);
-	return 0;
-}
-arch_initcall(pplus_request_cascade);
-
 static void __init pplus_init_IRQ(void)
 {
 	int i;
@@ -678,6 +668,8 @@
 
 		openpic_set_sources(0, 16, OpenPIC_Addr + 0x10000);
 		openpic_init(NUM_8259_INTERRUPTS);
+		openpic_hookup_cascade(NUM_8259_INTERRUPTS, "82c59 cascade",
+					i8259_irq);
 		ppc_md.get_irq = openpic_get_irq;
 	}
 
--- 1.59/arch/ppc/platforms/prep_setup.c	2004-10-29 01:13:38 -07:00
+++ edited/arch/ppc/platforms/prep_setup.c	2004-11-01 12:56:21 -07:00
@@ -958,20 +958,6 @@
 	}
 }
 
-static int __init
-prep_request_cascade(void)
-{
-	if (_machine != _MACH_prep)
-		return 0;
-
-	if (OpenPIC_Addr != NULL)
-		/* We have a cascade on OpenPIC IRQ 0, Linux IRQ 16 */
-		openpic_hookup_cascade(NUM_8259_INTERRUPTS, "82c59 cascade",
-				i8259_irq);
-	return 0;
-}
-arch_initcall(prep_request_cascade);
-
 static void __init
 prep_init_IRQ(void)
 {
@@ -980,6 +966,9 @@
 
 	if (OpenPIC_Addr != NULL) {
 		openpic_init(NUM_8259_INTERRUPTS);
+		/* We have a cascade on OpenPIC IRQ 0, Linux IRQ 16 */
+		openpic_hookup_cascade(NUM_8259_INTERRUPTS, "82c59 cascade",
+				       i8259_irq);
 	}
 	for ( i = 0 ; i < NUM_8259_INTERRUPTS ; i++ )
 		irq_desc[i].handler = &i8259_pic;
--- 1.21/arch/ppc/platforms/sandpoint.c	2004-10-27 15:55:36 -07:00
+++ edited/arch/ppc/platforms/sandpoint.c	2004-11-01 12:56:00 -07:00
@@ -383,15 +383,6 @@
 
 arch_initcall(sandpoint_request_io);
 
-static int __init
-sandpoint_request_cascade(void)
-{
-	openpic_hookup_cascade(NUM_8259_INTERRUPTS, "82c59 cascade",
-			i8259_irq);
-	return 0;
-}
-arch_initcall(sandpoint_request_cascade);
-
 /*
  * Interrupt setup and service.  Interrrupts on the Sandpoint come
  * from the four PCI slots plus the 8259 in the Winbond Super I/O (SIO).
@@ -407,6 +398,8 @@
 	OpenPIC_NumInitSenses = sizeof(sandpoint_openpic_initsenses);
 
 	mpc10x_set_openpic();
+	openpic_hookup_cascade(NUM_8259_INTERRUPTS, "82c59 cascade",
+			i8259_irq);
 
 	/*
 	 * openpic_init() has set up irq_desc[16-31] to be openpic
--- 1.9/arch/ppc/platforms/sbc82xx.c	2004-10-18 22:26:40 -07:00
+++ edited/arch/ppc/platforms/sbc82xx.c	2004-11-01 12:56:00 -07:00
@@ -146,6 +146,13 @@
 	return IRQ_HANDLED;
 }
 
+static struct irqaction sbc82xx_i8259_irqaction = {
+	.handler = sbc82xx_i8259_demux,
+	.flags = SA_INTERRUPT,
+	.mask = CPU_MASK_NONE,
+	.name = "i8259 demux",
+};
+
 void __init sbc82xx_init_IRQ(void)
 {
 	volatile memctl_cpm2_t *mc = &cpm2_immr->im_memctl;
@@ -186,8 +193,7 @@
 	sbc82xx_i8259_map[1] = sbc82xx_i8259_mask; /* Set interrupt mask */
 
 	/* Request cascade IRQ */
-	if (request_irq(SIU_INT_IRQ6, sbc82xx_i8259_demux, SA_INTERRUPT,
-			"i8259 demux", 0)) {
+	if (setup_irq(SIU_INT_IRQ6, &sbc82xx_i8259_irqaction)) {
 		printk("Installation of i8259 IRQ demultiplexer failed.\n");
 	}
 }
--- 1.2/arch/ppc/platforms/85xx/mpc8560_ads.c	2004-10-18 22:26:40 -07:00
+++ edited/arch/ppc/platforms/85xx/mpc8560_ads.c	2004-11-01 12:56:00 -07:00
@@ -150,6 +150,13 @@
 	return IRQ_HANDLED;
 }
 
+static struct irqaction cpm2_irqaction = {
+	.handler = cpm2_cascade,
+	.flags = SA_INTERRUPT,
+	.mask = CPU_MASK_NONE,
+	.name = "cpm2_cascade",
+};
+
 static void __init
 mpc8560_ads_init_IRQ(void)
 {
@@ -173,7 +180,7 @@
 	immap->im_intctl.ic_scprrh = 0x05309770;
 	immap->im_intctl.ic_scprrl = 0x05309770;
 
-	request_irq(MPC85xx_IRQ_CPM, cpm2_cascade, SA_INTERRUPT, "cpm2_cascade", NULL);
+	setup_irq(MPC85xx_IRQ_CPM, &cpm2_irqaction);
 
 	return;
 }
--- 1.4/arch/ppc/platforms/85xx/mpc85xx_cds_common.c	2004-10-18 22:26:40 -07:00
+++ edited/arch/ppc/platforms/85xx/mpc85xx_cds_common.c	2004-11-01 12:56:00 -07:00
@@ -193,6 +193,13 @@
 	while((irq = cpm2_get_irq(regs)) >= 0)
 		__do_IRQ(irq, regs);
 }
+
+static struct irqaction cpm2_irqaction = {
+	.handler = cpm2_cascade,
+	.flags = SA_INTERRUPT,
+	.mask = CPU_MASK_NONE,
+	.name = "cpm2_cascade",
+};
 #endif /* CONFIG_CPM2 */
 
 void __init
@@ -235,7 +242,7 @@
 	immap->im_intctl.ic_scprrh = 0x05309770;
 	immap->im_intctl.ic_scprrl = 0x05309770;
 
-	request_irq(MPC85xx_IRQ_CPM, cpm2_cascade, SA_INTERRUPT, "cpm2_cascade", NULL);
+	setup_irq(MPC85xx_IRQ_CPM, &cpm2_irqaction);
 #endif
 
         return;
--- 1.15/arch/ppc/syslib/i8259.c	2004-10-29 01:13:38 -07:00
+++ edited/arch/ppc/syslib/i8259.c	2004-11-01 12:57:36 -07:00
@@ -13,7 +13,6 @@
 static spinlock_t i8259_lock = SPIN_LOCK_UNLOCKED;
 
 int i8259_pic_irq_offset;
-static int i8259_present;
 
 /*
  * Acknowledge the IRQ using either the PCI host bridge's interrupt
@@ -152,20 +151,13 @@
 	"8259 edge control", 0x4d0, 0x4d1, IORESOURCE_BUSY
 };
 
-static int __init
-i8259_hook_cascade(void)
-{
-	if (!i8259_present)
-		return 0;
-
-	/* reserve our resources */
-	request_irq( i8259_pic_irq_offset + 2, no_action, SA_INTERRUPT,
-				"82c59 secondary cascade", NULL );
-	return 0;
-}
-
-arch_initcall(i8259_hook_cascade);
-
+static struct irqaction i8259_irqaction = {
+	.handler = no_action,
+	.flags = SA_INTERRUPT,
+	.mask = CPU_MASK_NONE,
+	.name = "82c59 secondary cascade",
+};
+ 
 /*
  * i8259_init()
  * intack_addr - PCI interrupt acknowledge (real) address which will return
@@ -199,12 +191,12 @@
 
 	spin_unlock_irqrestore(&i8259_lock, flags);
 
+	/* reserve our resources */
+	setup_irq( i8259_pic_irq_offset + 2, &i8259_irqaction);
 	request_resource(&ioport_resource, &pic1_iores);
 	request_resource(&ioport_resource, &pic2_iores);
 	request_resource(&ioport_resource, &pic_edgectrl_iores);
 
 	if (intack_addr != 0)
 		pci_intack = ioremap(intack_addr, 1);
-
-	i8259_present = 1;
 }
--- 1.39/arch/ppc/syslib/open_pic.c	2004-09-22 13:28:16 -07:00
+++ edited/arch/ppc/syslib/open_pic.c	2004-11-01 12:56:00 -07:00
@@ -681,13 +681,21 @@
 /*
  * Hookup a cascade to the OpenPIC.
  */
+
+static struct irqaction openpic_cascade_irqaction = {
+	.handler = no_action,
+	.flags = SA_INTERRUPT,
+	.mask = CPU_MASK_NONE,
+};
+
 void __init
 openpic_hookup_cascade(u_int irq, char *name,
 	int (*cascade_fn)(struct pt_regs *))
 {
 	openpic_cascade_irq = irq;
 	openpic_cascade_fn = cascade_fn;
-	if (request_irq(irq, no_action, SA_INTERRUPT, name, NULL))
+
+	if (setup_irq(irq, &openpic_cascade_irqaction))
 		printk("Unable to get OpenPIC IRQ %d for cascade\n",
 				irq - open_pic_irq_offset);
 }

-- 
Tom Rini
http://gate.crashing.org/~trini/
