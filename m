Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261708AbUKTADo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261708AbUKTADo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 19:03:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261706AbUKTACy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 19:02:54 -0500
Received: from fw.osdl.org ([65.172.181.6]:44435 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261721AbUKSXyw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 18:54:52 -0500
Date: Fri, 19 Nov 2004 15:58:54 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH][PPC32] Marvell host bridge support (mv64x60)
Message-Id: <20041119155854.02af2174.akpm@osdl.org>
In-Reply-To: <419E6900.5070001@mvista.com>
References: <419E6900.5070001@mvista.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Mark A. Greer" <mgreer@mvista.com> wrote:
>
> This patch adds core support for a line of host bridges from Marvell 
> (formerly Galileo).  This code has been tested with a GT64260a, 
> GT64260b, MV64360, and MV64460.  Patches for platforms that use these 
> bridges will be sent separately.
> 

Shouldn't these guys:


+       u32     cpu2mem_tab[MV64x60_CPU2MEM_WINDOWS][2] = {
+                       { MV64x60_CPU2MEM_0_BASE, MV64x60_CPU2MEM_0_SIZE },
+                       { MV64x60_CPU2MEM_1_BASE, MV64x60_CPU2MEM_1_SIZE },
+                       { MV64x60_CPU2MEM_2_BASE, MV64x60_CPU2MEM_2_SIZE },
+                       { MV64x60_CPU2MEM_3_BASE, MV64x60_CPU2MEM_3_SIZE }
+       };
+       u32     com2mem_tab[MV64x60_CPU2MEM_WINDOWS][2] = {
+                       { MV64360_MPSC2MEM_0_BASE, MV64360_MPSC2MEM_0_SIZE },
+                       { MV64360_MPSC2MEM_1_BASE, MV64360_MPSC2MEM_1_SIZE },
+                       { MV64360_MPSC2MEM_2_BASE, MV64360_MPSC2MEM_2_SIZE },
+                       { MV64360_MPSC2MEM_3_BASE, MV64360_MPSC2MEM_3_SIZE }
+       };
+       u32     dram_selects[MV64x60_CPU2MEM_WINDOWS] = { 0xe, 0xd, 0xb, 0x7 };

be static, and maybe __devinitdata?  Right now, the CPU has to populate
them by hand at runtime.

+wait_for_ownership(int chan)
+{
+	int	i;
+
+	for (i=0; i<MAX_TX_WAIT; i++) {
+		if ((MV64x60_REG_READ(sdma_regs[chan].sdcm) &
+				SDMA_SDCM_TXD) == 0)
+			break;
+
+		udelay(1000);

ow, big busywait.  Can't use a sleep in here?  I guess not :(

+ * arch/ppc/boot/simple/mv64x60_tty.c

hm.  Normally we put arch-specific drivers like this into drivers/serial
and do the appropriate Kconfig work.  Is there a reason why this serial
driver is buried under arch/ppc?

+#include "../../../../drivers/serial/mpsc_defs.h"

erk.

+struct mv64x60_rx_desc {
+	volatile u16 bufsize;
+	volatile u16 bytecnt;
+	volatile u32 cmd_stat;
+	volatile u32 next_desc_ptr;
+	volatile u32 buffer;
+};
+
+struct mv64x60_tx_desc {
+	volatile u16 bytecnt;
+	volatile u16 shadow;
+	volatile u32 cmd_stat;
+	volatile u32 next_desc_ptr;
+	volatile u32 buffer;
+};

Do these need to be volatile?  If so, it indicates that the driver is doing
something wrong.

+gt64260_register_hdlrs(void)
+{
+	/* Register CPU interface error interrupt handler */
+	request_irq(MV64x60_IRQ_CPU_ERR, gt64260_cpu_error_int_handler,
+		    SA_INTERRUPT, CPU_INTR_STR, 0);

request_irq() can fail.

+int
+mv64360_get_irq(struct pt_regs *regs)
+{
+	int irq;
+	int irq_gpp;
+
+#ifdef CONFIG_SMP
+	/*
+	 * Second CPU gets only doorbell (message) interrupts.
+	 * The doorbell interrupt is BIT28 in the main interrupt low cause reg.
+	 */
+	int cpu_nr = smp_processor_id();

This function has no callers, so I am unable to determine whether it is
called from non-preemptible code.  If it is called from preemptible code
then that smp_processor_id() is buggy, because you can switch CPUs at any
time.


+static struct platform_device mpsc_shared_device = { /* Shared device */
+	.name		= MPSC_SHARED_NAME,
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(mv64x60_mpsc_shared_resources),
+	.resource	= mv64x60_mpsc_shared_resources,
+	.dev = {
+		.driver_data = (void *)&mv64x60_mpsc_shared_pd_dd,
+	},
+};

The cast to void* is unnecessary.

+	(void)mv64x60_setup_for_chip(&bh);

how come you always stick that (void) in there?

+mv64x60_config_cpu2mem_windows(struct mv64x60_handle *bh,
+	struct mv64x60_setup_info *si,
+	u32 mem_windows[MV64x60_CPU2MEM_WINDOWS][2])
+{
+	u32	i, win;
+	u32	prot_tab[] = {
+			MV64x60_CPU_PROT_0_WIN, MV64x60_CPU_PROT_1_WIN,
+			MV64x60_CPU_PROT_2_WIN, MV64x60_CPU_PROT_3_WIN
+		};
+	u32	cpu_snoop_tab[] = {
+			MV64x60_CPU_SNOOP_0_WIN, MV64x60_CPU_SNOOP_1_WIN,
+			MV64x60_CPU_SNOOP_2_WIN, MV64x60_CPU_SNOOP_3_WIN
+		};

static initialisation?

+mv64x60_config_cpu2pci_windows(struct mv64x60_handle *bh,
+	struct mv64x60_pci_info *pi, u32 bus)
+{
+	int	i;
+	u32	win_tab[2][4] = {
+			{ MV64x60_CPU2PCI0_IO_WIN, MV64x60_CPU2PCI0_MEM_0_WIN,
+			  MV64x60_CPU2PCI0_MEM_1_WIN,
+			  MV64x60_CPU2PCI0_MEM_2_WIN },
+			{ MV64x60_CPU2PCI1_IO_WIN, MV64x60_CPU2PCI1_MEM_0_WIN,
+			  MV64x60_CPU2PCI1_MEM_1_WIN,
+			  MV64x60_CPU2PCI1_MEM_2_WIN },
+		};
+	u32	remap_tab[2][4] = {
+			{ MV64x60_CPU2PCI0_IO_REMAP_WIN,
+			  MV64x60_CPU2PCI0_MEM_0_REMAP_WIN,
+			  MV64x60_CPU2PCI0_MEM_1_REMAP_WIN,
+			  MV64x60_CPU2PCI0_MEM_2_REMAP_WIN },
+			{ MV64x60_CPU2PCI1_IO_REMAP_WIN,
+			  MV64x60_CPU2PCI1_MEM_0_REMAP_WIN,
+			  MV64x60_CPU2PCI1_MEM_1_REMAP_WIN,
+			  MV64x60_CPU2PCI1_MEM_2_REMAP_WIN }
+		};
+

ditto

+mv64x60_config_pci2mem_windows(struct mv64x60_handle *bh,

and here

+mv64360_set_pci2mem_window(struct pci_controller *hose, u32 bus, u32 window,

and here

+mv64360_config_io2mem_windows(struct mv64x60_handle *bh,

and here


Anyway, I'll stick this as-is in -mm.  Feel free to send an incremental
patch, or a replacement.


