Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262030AbVADEtF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262030AbVADEtF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 23:49:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262059AbVADErv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 23:47:51 -0500
Received: from chilli.pcug.org.au ([203.10.76.44]:23496 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S262030AbVADEoC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 23:44:02 -0500
Date: Tue, 4 Jan 2005 15:12:29 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@osdl.org>
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/11] PPC64: remove interrupt_controller from naca
Message-Id: <20050104151229.521e8083.sfr@canb.auug.org.au>
In-Reply-To: <20050104150833.5d3f3722.sfr@canb.auug.org.au>
References: <20050104145356.4d5333dd.sfr@canb.auug.org.au>
	<20050104150410.199b132e.sfr@canb.auug.org.au>
	<20050104150833.5d3f3722.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 1.0.0rc (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Tue__4_Jan_2005_15_12_30_+1100_ZGRhdYS8ZZAuRF7s"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Tue__4_Jan_2005_15_12_30_+1100_ZGRhdYS8ZZAuRF7s
Content-Type: multipart/mixed;
 boundary="Multipart=_Tue__4_Jan_2005_15_12_29_+1100_wmjHQRv1RAU_qeMa"


--Multipart=_Tue__4_Jan_2005_15_12_29_+1100_wmjHQRv1RAU_qeMa
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi Andrew,

This patch just moves the interrupt_controller field of the naca into a
global variable.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN linus-bk-naca.2/arch/ppc64/kernel/irq.c linus-bk-naca.3/arch/ppc64/kernel/irq.c
--- linus-bk-naca.2/arch/ppc64/kernel/irq.c	2004-10-21 07:17:18.000000000 +1000
+++ linus-bk-naca.3/arch/ppc64/kernel/irq.c	2004-12-31 14:53:21.000000000 +1100
@@ -65,6 +65,7 @@
 int __irq_offset_value;
 int ppc_spurious_interrupts;
 unsigned long lpevent_count;
+u64 ppc64_interrupt_controller;
 
 int show_interrupts(struct seq_file *p, void *v)
 {
@@ -360,7 +361,7 @@
 	unsigned int virq, first_virq;
 	static int warned;
 
-	if (naca->interrupt_controller == IC_OPEN_PIC)
+	if (ppc64_interrupt_controller == IC_OPEN_PIC)
 		return real_irq;	/* no mapping for openpic (for now) */
 
 	/* don't map interrupts < MIN_VIRT_IRQ */
diff -ruN linus-bk-naca.2/arch/ppc64/kernel/maple_setup.c linus-bk-naca.3/arch/ppc64/kernel/maple_setup.c
--- linus-bk-naca.2/arch/ppc64/kernel/maple_setup.c	2004-10-30 08:33:22.000000000 +1000
+++ linus-bk-naca.3/arch/ppc64/kernel/maple_setup.c	2004-12-31 14:53:21.000000000 +1100
@@ -155,7 +155,7 @@
 	}
 
 	/* Setup interrupt mapping options */
-	naca->interrupt_controller = IC_OPEN_PIC;
+	ppc64_interrupt_controller = IC_OPEN_PIC;
 
 	DBG(" <- maple_init_early\n");
 }
diff -ruN linus-bk-naca.2/arch/ppc64/kernel/pSeries_pci.c linus-bk-naca.3/arch/ppc64/kernel/pSeries_pci.c
--- linus-bk-naca.2/arch/ppc64/kernel/pSeries_pci.c	2004-11-16 16:05:10.000000000 +1100
+++ linus-bk-naca.3/arch/ppc64/kernel/pSeries_pci.c	2004-12-31 14:53:21.000000000 +1100
@@ -353,7 +353,7 @@
 	unsigned int *opprop = NULL;
 	struct device_node *root = of_find_node_by_path("/");
 
-	if (naca->interrupt_controller == IC_OPEN_PIC) {
+	if (ppc64_interrupt_controller == IC_OPEN_PIC) {
 		opprop = (unsigned int *)get_property(root,
 				"platform-open-pic", NULL);
 	}
@@ -375,7 +375,7 @@
 		pci_process_bridge_OF_ranges(phb, node);
 		pci_setup_phb_io(phb, index == 0);
 
-		if (naca->interrupt_controller == IC_OPEN_PIC && pSeries_mpic) {
+		if (ppc64_interrupt_controller == IC_OPEN_PIC && pSeries_mpic) {
 			int addr = root_size_cells * (index + 2) - 1;
 			mpic_assign_isu(pSeries_mpic, index, opprop[addr]);
 		}
diff -ruN linus-bk-naca.2/arch/ppc64/kernel/pSeries_setup.c linus-bk-naca.3/arch/ppc64/kernel/pSeries_setup.c
--- linus-bk-naca.2/arch/ppc64/kernel/pSeries_setup.c	2004-12-14 04:07:06.000000000 +1100
+++ linus-bk-naca.3/arch/ppc64/kernel/pSeries_setup.c	2004-12-31 15:22:17.000000000 +1100
@@ -196,7 +196,7 @@
 static void __init pSeries_setup_arch(void)
 {
 	/* Fixup ppc_md depending on the type of interrupt controller */
-	if (naca->interrupt_controller == IC_OPEN_PIC) {
+	if (ppc64_interrupt_controller == IC_OPEN_PIC) {
 		ppc_md.init_IRQ       = pSeries_init_mpic; 
 		ppc_md.get_irq        = mpic_get_irq;
 		/* Allocate the mpic now, so that find_and_init_phbs() can
@@ -308,13 +308,13 @@
 	 * to properly parse the OF interrupt tree & do the virtual irq mapping
 	 */
 	__irq_offset_value = NUM_ISA_INTERRUPTS;
-	naca->interrupt_controller = IC_INVALID;
+	ppc64_interrupt_controller = IC_INVALID;
 	for (np = NULL; (np = of_find_node_by_name(np, "interrupt-controller"));) {
 		typep = (char *)get_property(np, "compatible", NULL);
 		if (strstr(typep, "open-pic"))
-			naca->interrupt_controller = IC_OPEN_PIC;
+			ppc64_interrupt_controller = IC_OPEN_PIC;
 		else if (strstr(typep, "ppc-xicp"))
-			naca->interrupt_controller = IC_PPC_XIC;
+			ppc64_interrupt_controller = IC_PPC_XIC;
 		else
 			printk("initialize_naca: failed to recognize"
 			       " interrupt-controller\n");
diff -ruN linus-bk-naca.2/arch/ppc64/kernel/pSeries_smp.c linus-bk-naca.3/arch/ppc64/kernel/pSeries_smp.c
--- linus-bk-naca.2/arch/ppc64/kernel/pSeries_smp.c	2004-12-14 04:07:06.000000000 +1100
+++ linus-bk-naca.3/arch/ppc64/kernel/pSeries_smp.c	2004-12-31 15:22:45.000000000 +1100
@@ -348,7 +348,7 @@
 
 	DBG(" -> smp_init_pSeries()\n");
 
-	if (naca->interrupt_controller == IC_OPEN_PIC)
+	if (ppc64_interrupt_controller == IC_OPEN_PIC)
 		smp_ops = &pSeries_mpic_smp_ops;
 	else
 		smp_ops = &pSeries_xics_smp_ops;
diff -ruN linus-bk-naca.2/arch/ppc64/kernel/pmac_setup.c linus-bk-naca.3/arch/ppc64/kernel/pmac_setup.c
--- linus-bk-naca.2/arch/ppc64/kernel/pmac_setup.c	2004-12-31 14:52:14.000000000 +1100
+++ linus-bk-naca.3/arch/ppc64/kernel/pmac_setup.c	2004-12-31 14:53:21.000000000 +1100
@@ -70,7 +70,6 @@
 #include <asm/time.h>
 #include <asm/of_device.h>
 #include <asm/lmb.h>
-#include <asm/naca.h>
 
 #include "pmac.h"
 #include "mpic.h"
@@ -316,7 +315,7 @@
 	}
 
 	/* Setup interrupt mapping options */
-	naca->interrupt_controller = IC_OPEN_PIC;
+	ppc64_interrupt_controller = IC_OPEN_PIC;
 
 	DBG(" <- pmac_init_early\n");
 }
diff -ruN linus-bk-naca.2/arch/ppc64/kernel/prom.c linus-bk-naca.3/arch/ppc64/kernel/prom.c
--- linus-bk-naca.2/arch/ppc64/kernel/prom.c	2004-12-31 14:52:56.000000000 +1100
+++ linus-bk-naca.3/arch/ppc64/kernel/prom.c	2004-12-31 14:53:21.000000000 +1100
@@ -44,7 +44,6 @@
 #include <asm/system.h>
 #include <asm/mmu.h>
 #include <asm/pgtable.h>
-#include <asm/naca.h>
 #include <asm/pci.h>
 #include <asm/iommu.h>
 #include <asm/bootinfo.h>
@@ -557,7 +556,7 @@
 
 	DBG(" -> finish_device_tree\n");
 
-	if (naca->interrupt_controller == IC_INVALID) {
+	if (ppc64_interrupt_controller == IC_INVALID) {
 		DBG("failed to configure interrupt controller type\n");
 		panic("failed to configure interrupt controller type\n");
 	}
diff -ruN linus-bk-naca.2/arch/ppc64/kernel/setup.c linus-bk-naca.3/arch/ppc64/kernel/setup.c
--- linus-bk-naca.2/arch/ppc64/kernel/setup.c	2004-12-31 16:22:49.000000000 +1100
+++ linus-bk-naca.3/arch/ppc64/kernel/setup.c	2004-12-31 16:23:03.000000000 +1100
@@ -664,7 +664,7 @@
 	printk("naca                          = 0x%p\n", naca);
 	printk("ppc64_pft_size                = 0x%lx\n", ppc64_pft_size);
 	printk("naca->debug_switch            = 0x%lx\n", naca->debug_switch);
-	printk("naca->interrupt_controller    = 0x%ld\n", naca->interrupt_controller);
+	printk("ppc64_interrupt_controller    = 0x%ld\n", ppc64_interrupt_controller);
 	printk("systemcfg                     = 0x%p\n", systemcfg);
 	printk("systemcfg->platform           = 0x%x\n", systemcfg->platform);
 	printk("systemcfg->processorCount     = 0x%lx\n", systemcfg->processorCount);
diff -ruN linus-bk-naca.2/arch/ppc64/kernel/xics.c linus-bk-naca.3/arch/ppc64/kernel/xics.c
--- linus-bk-naca.2/arch/ppc64/kernel/xics.c	2004-12-14 04:07:06.000000000 +1100
+++ linus-bk-naca.3/arch/ppc64/kernel/xics.c	2004-12-31 15:24:20.000000000 +1100
@@ -24,7 +24,6 @@
 #include <asm/io.h>
 #include <asm/pgtable.h>
 #include <asm/smp.h>
-#include <asm/naca.h>
 #include <asm/rtas.h>
 #include <asm/xics.h>
 #include <asm/hvcall.h>
@@ -575,7 +574,7 @@
  */
 static int __init xics_setup_i8259(void)
 {
-	if (naca->interrupt_controller == IC_PPC_XIC &&
+	if (ppc64_interrupt_controller == IC_PPC_XIC &&
 	    xics_irq_8259_cascade != -1) {
 		if (request_irq(irq_offset_up(xics_irq_8259_cascade),
 				no_action, 0, "8259 cascade", NULL))
diff -ruN linus-bk-naca.2/include/asm-ppc64/naca.h linus-bk-naca.3/include/asm-ppc64/naca.h
--- linus-bk-naca.2/include/asm-ppc64/naca.h	2004-12-31 14:52:56.000000000 +1100
+++ linus-bk-naca.3/include/asm-ppc64/naca.h	2004-12-31 14:53:21.000000000 +1100
@@ -25,7 +25,6 @@
 	u64 banner;                     /* Ptr to banner string      0x28 */
 	u64 log;                        /* Ptr to log buffer         0x30 */
 	u64 serialPortAddr;		/* Phy addr of serial port   0x38 */
-	u64 interrupt_controller;	/* Type of int controller    0x40 */ 
 };
 
 extern struct naca_struct *naca;
diff -ruN linus-bk-naca.2/include/asm-ppc64/processor.h linus-bk-naca.3/include/asm-ppc64/processor.h
--- linus-bk-naca.2/include/asm-ppc64/processor.h	2004-12-31 15:01:17.000000000 +1100
+++ linus-bk-naca.3/include/asm-ppc64/processor.h	2004-12-31 15:25:17.000000000 +1100
@@ -484,6 +484,7 @@
 #ifdef __KERNEL__
 
 extern int have_of;
+extern u64 ppc64_interrupt_controller;
 
 struct task_struct;
 void start_thread(struct pt_regs *regs, unsigned long fdptr, unsigned long sp);


--Multipart=_Tue__4_Jan_2005_15_12_29_+1100_wmjHQRv1RAU_qeMa
Content-Type: application/pgp-signature;
 name="00000000.mimetmp"
Content-Disposition: attachment;
 filename="00000000.mimetmp"
Content-Transfer-Encoding: base64

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEuMi41IChHTlUv
TGludXgpCgppRDhEQlFGQjJoZDE0Q0pmcXV4OWErOFJBdlJuQUo5WHJGdUZpaThSTE50QWhmNmtX
dDVWYmJFd2pnQ2NERVlMCnNKMnNWWFh4S0lsN01TV0c0SEhvZG5nPQo9Z1QzSwotLS0tLUVORCBQ
R1AgU0lHTkFUVVJFLS0tLS0KCg==

--Multipart=_Tue__4_Jan_2005_15_12_29_+1100_wmjHQRv1RAU_qeMa--

--Signature=_Tue__4_Jan_2005_15_12_30_+1100_ZGRhdYS8ZZAuRF7s
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFB2heu4CJfqux9a+8RAr1ZAJsE+LWT96e/abGWUpznKR8/4/i04gCfQJbF
inwQWOjrSJZqP3AxUEjdO7s=
=ls4W
-----END PGP SIGNATURE-----

--Signature=_Tue__4_Jan_2005_15_12_30_+1100_ZGRhdYS8ZZAuRF7s--
