Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268383AbUHLANG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268383AbUHLANG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 20:13:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268435AbUHLAMS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 20:12:18 -0400
Received: from omx1-ext.SGI.COM ([192.48.179.11]:23275 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S268383AbUHKXgB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 19:36:01 -0400
From: Pat Gefre <pfg@sgi.com>
Message-Id: <200408112334.i7BNYcuE152521@fsgi900.americas.sgi.com>
Subject: Re: Altix I/O code reorganization - 16 of 21
To: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       hch@infradead.org
Date: Wed, 11 Aug 2004 18:34:38 -0500 (CDT)
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/08/11 16:54:23-05:00 pfg@sgi.com 
#   code clean up
#   ran thru Lindent
#   changes needed for new I/O structure
#   update copyright
# 
# arch/ia64/sn/kernel/setup.c
#   2004/08/11 16:53:27-05:00 pfg@sgi.com +174 -159
#    
# 
# arch/ia64/sn/kernel/irq.c
#   2004/08/11 16:53:26-05:00 pfg@sgi.com +210 -226
#    
# 
diff -Nru a/arch/ia64/sn/kernel/irq.c b/arch/ia64/sn/kernel/irq.c
--- a/arch/ia64/sn/kernel/irq.c	2004-08-11 16:55:17 -05:00
+++ b/arch/ia64/sn/kernel/irq.c	2004-08-11 16:55:17 -05:00
@@ -5,97 +5,55 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Copyright (c) 2000-2003 Silicon Graphics, Inc.  All Rights Reserved.
+ * Copyright (c) 2000-2004 Silicon Graphics, Inc.  All Rights Reserved.
  */
 
-#include <linux/init.h>
-#include <linux/sched.h>
-#include <linux/vmalloc.h>
 #include <linux/irq.h>
-#include <linux/interrupt.h>
-#include <linux/slab.h>
-#include <linux/bootmem.h>
-#include <linux/cpumask.h>
-#include <asm/page.h>
-#include <asm/pgtable.h>
-#include <asm/sn/sgi.h>
-#include <asm/sn/hcl.h>
-#include <asm/sn/types.h>
-#include <asm/sn/pci/pciio.h>
-#include <asm/sn/pci/pciio_private.h>
-#include <asm/sn/pci/pcibr.h>
-#include <asm/sn/pci/pcibr_private.h>
-#include <asm/sn/sn_cpuid.h>
-#include <asm/sn/io.h>
 #include <asm/sn/intr.h>
 #include <asm/sn/addrs.h>
-#include <asm/sn/driver.h>
 #include <asm/sn/arch.h>
-#include <asm/sn/pda.h>
-#include <asm/processor.h>
-#include <asm/system.h>
-#include <asm/bitops.h>
+#include <asm/sn/xtalk/xtalk_provider.h>
+#include <asm/sn/xtalk/xwidgetdev.h>
+#include <asm/sn/xtalk/xtalk_sal.h>
+#include <asm/sn/pci/pcibus_provider_defs.h>
+#include <asm/sn/pci/pcidev.h>
+#include <asm/sn/pci/pcibus.h>
+#include <asm/sn/pci/pcibr_provider.h>
 #include <asm/sn/sn2/shub_mmr.h>
 
 static void force_interrupt(int irq);
-extern void pcibr_force_interrupt(pcibr_intr_t intr);
-extern int sn_force_interrupt_flag;
-struct irq_desc * sn_irq_desc(unsigned int irq);
-extern cpumask_t    __cacheline_aligned pending_irq_cpumask[NR_IRQS];
-
-struct sn_intr_list_t {
-	struct sn_intr_list_t *next;
-	pcibr_intr_t intr;
-};
+static void register_intr_pda(struct sn_irq_info *sn_irq_info);
+static void unregister_intr_pda(struct sn_irq_info *sn_irq_info);
 
-static struct sn_intr_list_t *sn_intr_list[NR_IRQS];
-
-
-static unsigned int
-sn_startup_irq(unsigned int irq)
-{
-        return(0);
-}
+extern int sn_force_interrupt_flag;
+struct sn_irq_info **sn_irq;
 
-static void
-sn_shutdown_irq(unsigned int irq)
+static unsigned int sn_startup_irq(unsigned int irq)
 {
+	return 0;
 }
 
-static void
-sn_disable_irq(unsigned int irq)
+static void sn_shutdown_irq(unsigned int irq)
 {
 }
 
-static void
-sn_enable_irq(unsigned int irq)
+static void sn_disable_irq(unsigned int irq)
 {
 }
 
-static inline void sn_move_irq(int irq)
+static void sn_enable_irq(unsigned int irq)
 {
-	/* note - we hold desc->lock */
-	cpumask_t tmp;
-	irq_desc_t *desc = irq_descp(irq);
-
-	if (!cpus_empty(pending_irq_cpumask[irq])) {
-		cpus_and(tmp, pending_irq_cpumask[irq], cpu_online_map);
-		if (unlikely(!cpus_empty(tmp))) {
-			desc->handler->set_affinity(irq, pending_irq_cpumask[irq]);
-		}
-		cpus_clear(pending_irq_cpumask[irq]);
-	}
 }
 
-static void
-sn_ack_irq(unsigned int irq)
+static void sn_ack_irq(unsigned int irq)
 {
-	unsigned long event_occurred, mask = 0;
+	uint64_t event_occurred, mask = 0;
 	int nasid;
 
 	irq = irq & 0xff;
 	nasid = smp_physical_node_id();
-	event_occurred = HUB_L( (unsigned long *)GLOBAL_MMR_ADDR(nasid,SH_EVENT_OCCURRED) );
+	event_occurred =
+	    HUB_L((uint64_t *) GLOBAL_MMR_ADDR(nasid, SH_EVENT_OCCURRED));
 	if (event_occurred & SH_EVENT_OCCURRED_UART_INT_MASK) {
 		mask |= (1 << SH_EVENT_OCCURRED_UART_INT_SHFT);
 	}
@@ -108,63 +66,91 @@
 	if (event_occurred & SH_EVENT_OCCURRED_II_INT1_MASK) {
 		mask |= (1 << SH_EVENT_OCCURRED_II_INT1_SHFT);
 	}
-	HUB_S((unsigned long *)GLOBAL_MMR_ADDR(nasid, SH_EVENT_OCCURRED_ALIAS), mask );
+	HUB_S((uint64_t *) GLOBAL_MMR_ADDR(nasid, SH_EVENT_OCCURRED_ALIAS),
+	      mask);
 	__set_bit(irq, (volatile void *)pda->sn_in_service_ivecs);
-	sn_move_irq(irq);
 }
 
-static void
-sn_end_irq(unsigned int irq)
+static void sn_end_irq(unsigned int irq)
 {
 	int nasid;
 	int ivec;
-	unsigned long event_occurred;
-	irq_desc_t *desc = sn_irq_desc(irq);
-	unsigned int status = desc->status;
+	uint64_t event_occurred;
 
 	ivec = irq & 0xff;
 	if (ivec == SGI_UART_VECTOR) {
 		nasid = smp_physical_node_id();
-		event_occurred = HUB_L( (unsigned long *)GLOBAL_MMR_ADDR(nasid,SH_EVENT_OCCURRED) );
-		// If the UART bit is set here, we may have received an interrupt from the
-		// UART that the driver missed.  To make sure, we IPI ourselves to force us
-		// to look again.
+		event_occurred = HUB_L((uint64_t *) GLOBAL_MMR_ADDR
+				       (nasid, SH_EVENT_OCCURRED));
+		/* If the UART bit is set here, we may have received an 
+		 * interrupt from the UART that the driver missed.  To
+		 * make sure, we IPI ourselves to force us to look again.
+		 */
 		if (event_occurred & SH_EVENT_OCCURRED_UART_INT_MASK) {
-				platform_send_ipi(smp_processor_id(), SGI_UART_VECTOR, IA64_IPI_DM_INT, 0);
+			platform_send_ipi(smp_processor_id(), SGI_UART_VECTOR,
+					  IA64_IPI_DM_INT, 0);
 		}
 	}
 	__clear_bit(ivec, (volatile void *)pda->sn_in_service_ivecs);
 	if (sn_force_interrupt_flag)
-		if (!(status & (IRQ_DISABLED | IRQ_INPROGRESS)))
-			force_interrupt(irq);
+		force_interrupt(irq);
 }
 
-static void
-sn_set_affinity_irq(unsigned int irq, cpumask_t mask)
+static void sn_set_affinity_irq(unsigned int irq, cpumask_t mask)
 {
-#ifdef CONFIG_SMP
-	int redir = 0;
-	int cpu;
-	struct sn_intr_list_t *p = sn_intr_list[irq];
-	pcibr_intr_t intr;
-	extern void sn_shub_redirect_intr(pcibr_intr_t intr, unsigned long cpu);
-	extern void sn_tio_redirect_intr(pcibr_intr_t intr, unsigned long cpu);
-
-	if (p == NULL)
-		return; 
-        
-	intr = p->intr;
-
-	if (intr == NULL)
-		return; 
-
-	cpu = first_cpu(mask);
-	sn_shub_redirect_intr(intr, cpu);
-	irq = irq & 0xff;  /* strip off redirect bit, if someone stuck it on. */
-	(void) set_irq_affinity_info(irq, cpu_physical_id(intr->bi_cpu), redir);
-#endif /* CONFIG_SMP */
-}
+	struct sn_irq_info *sn_irq_info = sn_irq[irq];
+	int cpuid, cpuphys;
+	nasid_t t_nasid;	/* nasid to target */
+	int t_slice;		/* slice to target */
+
+	cpuid = first_cpu(mask);
+	cpuphys = cpu_physical_id(cpuid);
+	t_nasid = cpu_physical_id_to_nasid(cpuphys);
+	t_slice = cpu_physical_id_to_slice(cpuphys);
+
+	while (sn_irq_info) {
+		struct xwidget_info *xwidget_info =
+		    sn_irq_info->irq_xwidgetinfo;
+		struct sn_irq_info *new_sn_irq_info, *next_sn_irq_info;
+
+		new_sn_irq_info = (xwidget_info->xwi_khub_provider->intr_alloc)
+		    (xwidget_info, irq, t_nasid, t_slice);
+		if (new_sn_irq_info) {
+			int bridge_type = sn_irq_info->irq_bridge_type;
+			uint64_t xtalk_addr = new_sn_irq_info->irq_xtalkaddr;
+			struct sn_irq_info *next_info =
+			    new_sn_irq_info->irq_next;
+
+			*new_sn_irq_info = *sn_irq_info;	/* struct copy */
+			new_sn_irq_info->irq_next = next_info;
+			new_sn_irq_info->irq_xtalkaddr = xtalk_addr;
+			new_sn_irq_info->irq_nasid = t_nasid;
+			new_sn_irq_info->irq_slice = t_slice;
+			new_sn_irq_info->irq_cpuid = cpuid;
+
+			if (IS_PCI_BRIDGE_ASIC(bridge_type) &&
+			    (new_sn_irq_info->irq_bridge != NULL)) {
+				pcibr_change_devices_irq(new_sn_irq_info);
+			}
+
+			/* unregister the old irq, register the new one */
+			unregister_intr_pda(sn_irq_info);
+			register_intr_pda(new_sn_irq_info);
+
+			next_sn_irq_info = sn_irq_info->irq_next;
 
+			/* Free the old sn_irq_info */
+			(xwidget_info->xwi_khub_provider->intr_free)
+			    (xwidget_info, sn_irq_info);
+
+			sn_irq_info = next_sn_irq_info;
+
+			set_irq_affinity_info((irq & 0xff), cpuphys, 0);
+		} else {
+			break;	/* snp_affiity failed the intr_alloc */
+		}
+	}
+}
 
 struct hw_interrupt_type irq_type_sn = {
 	"SN hub",
@@ -172,208 +158,206 @@
 	sn_shutdown_irq,
 	sn_enable_irq,
 	sn_disable_irq,
-	sn_ack_irq, 
+	sn_ack_irq,
 	sn_end_irq,
 	sn_set_affinity_irq
 };
 
-
-struct irq_desc *
-sn_irq_desc(unsigned int irq)
+struct irq_desc *sn_irq_desc(unsigned int irq)
 {
 
 	irq = SN_IVEC_FROM_IRQ(irq);
 
-	return(_irq_desc + irq);
+	return (_irq_desc + irq);
 }
 
-u8
-sn_irq_to_vector(unsigned int irq)
+u8 sn_irq_to_vector(u8 irq)
 {
-	return(irq);
+	return irq;
 }
 
-unsigned int
-sn_local_vector_to_irq(u8 vector)
+unsigned int sn_local_vector_to_irq(u8 vector)
 {
 	return (CPU_VECTOR_TO_IRQ(smp_processor_id(), vector));
 }
 
-void
-sn_irq_init (void)
+void sn_irq_init(void)
 {
 	int i;
 	irq_desc_t *base_desc = _irq_desc;
 
-	for (i=0; i<NR_IRQS; i++) {
+	for (i = 0; i < NR_IRQS; i++) {
 		if (base_desc[i].handler == &no_irq_type) {
 			base_desc[i].handler = &irq_type_sn;
 		}
 	}
 }
 
-void
-register_pcibr_intr(int irq, pcibr_intr_t intr)
+static void register_intr_pda(struct sn_irq_info *sn_irq_info)
 {
-	struct sn_intr_list_t *p = kmalloc(sizeof(struct sn_intr_list_t), GFP_KERNEL);
-	struct sn_intr_list_t *list;
-	int cpu = intr->bi_cpu;
+	int irq = sn_irq_info->irq_irq;
+	int cpu = sn_irq_info->irq_cpuid;
 
 	if (pdacpu(cpu)->sn_last_irq < irq) {
 		pdacpu(cpu)->sn_last_irq = irq;
 	}
-	if (pdacpu(cpu)->sn_first_irq == 0 || pdacpu(cpu)->sn_first_irq > irq) pdacpu(cpu)->sn_first_irq = irq;
-	if (!p) panic("Could not allocate memory for sn_intr_list_t\n");
-	if ((list = sn_intr_list[irq])) {
-		while (list->next) list = list->next;
-		list->next = p;
-		p->next = NULL;
-		p->intr = intr;
-	} else {
-		sn_intr_list[irq] = p;
-		p->next = NULL;
-		p->intr = intr;
+
+	if (pdacpu(cpu)->sn_first_irq == 0 || pdacpu(cpu)->sn_first_irq > irq) {
+		pdacpu(cpu)->sn_first_irq = irq;
 	}
 }
 
-void
-unregister_pcibr_intr(int irq, pcibr_intr_t intr)
+static void unregister_intr_pda(struct sn_irq_info *sn_irq_info)
 {
+	int irq = sn_irq_info->irq_irq;
+	int cpu = sn_irq_info->irq_cpuid;
+	struct sn_irq_info *tmp_irq_info;
+	int i, foundmatch;
 
-	struct sn_intr_list_t **prev, *curr;
-	int cpu = intr->bi_cpu;
-	int i;
-
-	if (sn_intr_list[irq] == NULL)
-		return;
-
-	prev = &sn_intr_list[irq];
-	curr = sn_intr_list[irq];
-	while (curr) {
-		if (curr->intr == intr)	 {
-			*prev = curr->next;
-			break;
+	if (pdacpu(cpu)->sn_last_irq == irq) {
+		foundmatch = 0;
+		for (i = pdacpu(cpu)->sn_last_irq - 1; i; i--) {
+			tmp_irq_info = sn_irq[i];
+			while (tmp_irq_info) {
+				if (tmp_irq_info->irq_cpuid == cpu) {
+					foundmatch++;
+					break;
+				}
+				tmp_irq_info = tmp_irq_info->irq_next;
+			}
+			if (foundmatch) {
+				break;
+			}
 		}
-		prev = &curr->next;
-		curr = curr->next;
+		pdacpu(cpu)->sn_last_irq = i;
 	}
 
-	if (curr)
-		kfree(curr);
-
-	if (!sn_intr_list[irq]) {
-		if (pdacpu(cpu)->sn_last_irq == irq) {
-			for (i = pdacpu(cpu)->sn_last_irq - 1; i; i--)
-				if (sn_intr_list[i])
+	if (pdacpu(cpu)->sn_first_irq == irq) {
+		foundmatch = 0;
+		for (i = pdacpu(cpu)->sn_first_irq + 1; i < NR_IRQS; i++) {
+			tmp_irq_info = sn_irq[i];
+			while (tmp_irq_info) {
+				if (tmp_irq_info->irq_cpuid == cpu) {
+					foundmatch++;
 					break;
-			pdacpu(cpu)->sn_last_irq = i;
-		}
-
-		if (pdacpu(cpu)->sn_first_irq == irq) {
-			pdacpu(cpu)->sn_first_irq = 0;
-			for (i = pdacpu(cpu)->sn_first_irq + 1; i < NR_IRQS; i++)
-				if (sn_intr_list[i])
-					pdacpu(cpu)->sn_first_irq = i;
+				}
+				tmp_irq_info = tmp_irq_info->irq_next;
+			}
+			if (foundmatch) {
+				break;
+			}
 		}
+		pdacpu(cpu)->sn_first_irq = ((i == NR_IRQS) ? 0 : i);
 	}
-
 }
 
-void
-force_polled_int(void)
+void sn_irq_setup(void)
 {
+	struct sn_irq_info *sn_irq_info;
 	int i;
-	struct sn_intr_list_t *p;
 
-	for (i=0; i<NR_IRQS;i++) {
-		p = sn_intr_list[i];
-		while (p) {
-			if (p->intr){
-				pcibr_force_interrupt(p->intr);
-			}
-			p = p->next;
+	for (i = 0; i < NR_IRQS; i++) {
+		/* set the cpuid in all the sn_irq_info_s structures
+		 * and update sn_first_irq & sn_last_irq in the PDA
+		 */
+		sn_irq_info = sn_irq[i];
+		while (sn_irq_info) {
+			nasid_t nasid = sn_irq_info->irq_nasid;
+			int slice = sn_irq_info->irq_slice;
+			int cpu = nasid_slice_to_cpuid(nasid, slice);
+			sn_irq_info->irq_cpuid = cpu;
+			(void)register_intr_pda(sn_irq_info);
+			sn_irq_info = sn_irq_info->irq_next;
 		}
 	}
 }
 
-static void
-force_interrupt(int irq)
+static void force_interrupt(int irq)
 {
-	struct sn_intr_list_t *p = sn_intr_list[irq];
+	struct sn_irq_info *sn_irq_info = sn_irq[irq];
 
-	while (p) {
-		if (p->intr) {
-			pcibr_force_interrupt(p->intr);
+	while (sn_irq_info) {
+		if (IS_PCI_BRIDGE_ASIC(sn_irq_info->irq_bridge_type) &&
+		    (sn_irq_info->irq_bridge != NULL)) {
+			pcibr_force_interrupt(sn_irq_info);
 		}
-		p = p->next;
+		sn_irq_info = sn_irq_info->irq_next;
 	}
 }
 
 /*
-Check for lost interrupts.  If the PIC int_status reg. says that
-an interrupt has been sent, but not handled, and the interrupt
-is not pending in either the cpu irr regs or in the soft irr regs,
-and the interrupt is not in service, then the interrupt may have
-been lost.  Force an interrupt on that pin.  It is possible that
-the interrupt is in flight, so we may generate a spurious interrupt,
-but we should never miss a real lost interrupt.
-*/
-
-static void
-sn_check_intr(int irq, pcibr_intr_t intr)
+ * Check for lost interrupts.  If the PIC int_status reg. says that
+ * an interrupt has been sent, but not handled, and the interrupt
+ * is not pending in either the cpu irr regs or in the soft irr regs,
+ * and the interrupt is not in service, then the interrupt may have
+ * been lost.  Force an interrupt on that pin.  It is possible that
+ * the interrupt is in flight, so we may generate a spurious interrupt,
+ * but we should never miss a real lost interrupt.
+ */
+static void sn_check_intr(int irq, struct sn_irq_info *sn_irq_info)
 {
-	unsigned long regval;
+	uint64_t regval;
 	int irr_reg_num;
 	int irr_bit;
-	unsigned long irr_reg;
+	uint64_t irr_reg;
+	struct pcidev_info *pcidev_info;
+	struct pcibus_info *pcibus_info;
 
+	pcidev_info = (struct pcidev_info *)sn_irq_info->irq_pciioinfo;
+	if (!pcidev_info)
+		return;
+
+	pcibus_info = (struct pcibus_info *) pcidev_info->pdi_pcibus_info;
+	regval = pcireg_intr_status_get(pcibus_info);
 
-	regval = pcireg_intr_status_get(intr->bi_soft);
 	irr_reg_num = irq_to_vector(irq) / 64;
 	irr_bit = irq_to_vector(irq) % 64;
 	switch (irr_reg_num) {
-		case 0:
-			irr_reg = ia64_getreg(_IA64_REG_CR_IRR0);
-			break;
-		case 1:
-			irr_reg = ia64_getreg(_IA64_REG_CR_IRR1);
-			break;
-		case 2:
-			irr_reg = ia64_getreg(_IA64_REG_CR_IRR2);
-			break;
-		case 3:
-			irr_reg = ia64_getreg(_IA64_REG_CR_IRR3);
-			break;
-	}
-	if (!test_bit(irr_bit, &irr_reg) ) {
-		if (!test_bit(irq, pda->sn_soft_irr) ) {
-			if (!test_bit(irq, pda->sn_in_service_ivecs) ) {
+	case 0:
+		irr_reg = ia64_getreg(_IA64_REG_CR_IRR0);
+		break;
+	case 1:
+		irr_reg = ia64_getreg(_IA64_REG_CR_IRR1);
+		break;
+	case 2:
+		irr_reg = ia64_getreg(_IA64_REG_CR_IRR2);
+		break;
+	case 3:
+		irr_reg = ia64_getreg(_IA64_REG_CR_IRR3);
+		break;
+	}
+	if (!test_bit(irr_bit, &irr_reg)) {
+		if (!test_bit(irq, pda->sn_soft_irr)) {
+			if (!test_bit(irq, pda->sn_in_service_ivecs)) {
 				regval &= 0xff;
-				if (intr->bi_ibits & regval & intr->bi_last_intr) {
-					regval &= ~(intr->bi_ibits & regval);
-					pcibr_force_interrupt(intr);
+				if (sn_irq_info->irq_int_bit & regval &
+				    sn_irq_info->irq_last_intr) {
+					regval &=
+					    ~(sn_irq_info->
+					      irq_int_bit & regval);
+					pcibr_force_interrupt(sn_irq_info);
 				}
 			}
 		}
 	}
-	intr->bi_last_intr = regval;
+	sn_irq_info->irq_last_intr = regval;
 }
 
-void
-sn_lb_int_war_check(void)
+void sn_lb_int_war_check(void)
 {
 	int i;
 
-	if (pda->sn_first_irq == 0) return;
-	for (i=pda->sn_first_irq;
-		i <= pda->sn_last_irq; i++) {
-			struct sn_intr_list_t *p = sn_intr_list[i];
-			if (p == NULL) {
-				continue;
-			}
-			while (p) {
-				sn_check_intr(i, p->intr);
-				p = p->next;
+	if (pda->sn_first_irq == 0)
+		return;
+	for (i = pda->sn_first_irq; i <= pda->sn_last_irq; i++) {
+		struct sn_irq_info *sn_irq_info = sn_irq[i];
+		while (sn_irq_info) {
+			/* Only call for PCI bridges that are fully initialized. */
+			if (IS_PCI_BRIDGE_ASIC(sn_irq_info->irq_bridge_type) &&
+			    (sn_irq_info->irq_bridge != NULL)) {
+				sn_check_intr(i, sn_irq_info);
 			}
+			sn_irq_info = sn_irq_info->irq_next;
+		}
 	}
 }
diff -Nru a/arch/ia64/sn/kernel/setup.c b/arch/ia64/sn/kernel/setup.c
--- a/arch/ia64/sn/kernel/setup.c	2004-08-11 16:55:17 -05:00
+++ b/arch/ia64/sn/kernel/setup.c	2004-08-11 16:55:17 -05:00
@@ -3,7 +3,7 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Copyright (C) 1999,2001-2003 Silicon Graphics, Inc. All rights reserved.
+ * Copyright (C) 1999,2001-2004 Silicon Graphics, Inc. All rights reserved.
  */
 
 #include <linux/config.h>
@@ -35,44 +35,50 @@
 #include <asm/system.h>
 #include <asm/processor.h>
 #include <asm/sn/sgi.h>
-#include <asm/sn/io.h>
 #include <asm/sn/arch.h>
 #include <asm/sn/addrs.h>
 #include <asm/sn/pda.h>
 #include <asm/sn/nodepda.h>
 #include <asm/sn/sn_cpuid.h>
-#include <asm/sn/sn_private.h>
 #include <asm/sn/simulator.h>
 #include <asm/sn/leds.h>
 #include <asm/sn/bte.h>
 #include <asm/sn/clksupport.h>
 #include <asm/sn/sn_sal.h>
 #include <asm/sn/sn2/shub.h>
+#include <asm/sn/klconfig.h>
 
 DEFINE_PER_CPU(struct pda_s, pda_percpu);
 
-#define MAX_PHYS_MEMORY		(1UL << 49)     /* 1 TB */
+#define MAX_PHYS_MEMORY		(1UL << 49)	/* 1 TB */
 
-extern void bte_init_node (nodepda_t *, cnodeid_t);
+lboard_t *root_lboard[MAX_COMPACT_NODES];
+
+extern hubdev_init_node(nodepda_t *, cnodeid_t);
+extern void bte_init_node(nodepda_t *, cnodeid_t);
+extern void bte_init_cpu(void);
 extern void sn_timer_init(void);
 extern unsigned long last_time_offset;
-extern void init_platform_hubinfo(nodepda_t **nodepdaindr);
-extern void (*ia64_mark_idle)(int);
+extern void (*ia64_mark_idle) (int);
 extern void snidle(int);
 extern unsigned char acpi_kbd_controller_present;
 
+unsigned long sn_rtc_cycles_per_second;
 
-unsigned long sn_rtc_cycles_per_second;   
+EXPORT_SYMBOL(sn_rtc_cycles_per_second);
 
 partid_t sn_partid = -1;
+EXPORT_SYMBOL(sn_partid);
 char sn_system_serial_number_string[128];
+EXPORT_SYMBOL(sn_system_serial_number_string);
 u64 sn_partition_serial_number;
+EXPORT_SYMBOL(sn_partition_serial_number);
 
 short physical_node_map[MAX_PHYSNODE_ID];
 
 EXPORT_SYMBOL(physical_node_map);
 
-int	numionodes;
+int numionodes;
 /*
  * This is the address of the RRegs in the HSpace of the global
  * master.  It is used by a hack in serial.c (serial_[in|out],
@@ -86,11 +92,7 @@
 static void sn_init_pdas(char **);
 static void scan_for_ionodes(void);
 
-
-static nodepda_t	*nodepdaindr[MAX_COMPACT_NODES];
-
-irqpda_t		*irqpdaindr;
-
+static nodepda_t *nodepdaindr[MAX_COMPACT_NODES];
 
 /*
  * The format of "screen_info" is strange, and due to early i386-setup
@@ -98,14 +100,14 @@
  * VGA color display.
  */
 struct screen_info sn_screen_info = {
-	.orig_x			= 0,
-	.orig_y			= 0,
-	.orig_video_mode	= 3,
-	.orig_video_cols	= 80,
-	.orig_video_ega_bx	= 3,
-	.orig_video_lines	= 25,
-	.orig_video_isVGA	= 1,
-	.orig_video_points	= 16
+	.orig_x = 0,
+	.orig_y = 0,
+	.orig_video_mode = 3,
+	.orig_video_cols = 80,
+	.orig_video_ega_bx = 3,
+	.orig_video_lines = 25,
+	.orig_video_isVGA = 1,
+	.orig_video_points = 16
 };
 
 /*
@@ -117,9 +119,9 @@
  * is sufficient (the IDE driver will autodetect the drive geometry).
  */
 #ifdef CONFIG_IA64_GENERIC
-extern char drive_info[4*16];
+extern char drive_info[4 * 16];
 #else
-char drive_info[4*16];
+char drive_info[4 * 16];
 #endif
 
 /*
@@ -131,8 +133,7 @@
  * may not be initialized yet.
  */
 
-static int __init
-pxm_to_nasid(int pxm)
+static int __init pxm_to_nasid(int pxm)
 {
 	int i;
 	int nid;
@@ -145,6 +146,7 @@
 	}
 	return -1;
 }
+
 /**
  * early_sn_setup - early setup routine for SN platforms
  *
@@ -152,16 +154,15 @@
  * for bringup.  See start_kernel() in init/main.c.
  */
 
-void __init
-early_sn_setup(void)
+void __init early_sn_setup(void)
 {
-	void ia64_sal_handler_init (void *entry_point, void *gpval);
-	efi_system_table_t			*efi_systab;
-	efi_config_table_t 			*config_tables;
-	struct ia64_sal_systab			*sal_systab;
-	struct ia64_sal_desc_entry_point	*ep;
-	char					*p;
-	int					i;
+	void ia64_sal_handler_init(void *entry_point, void *gpval);
+	efi_system_table_t *efi_systab;
+	efi_config_table_t *config_tables;
+	struct ia64_sal_systab *sal_systab;
+	struct ia64_sal_desc_entry_point *ep;
+	char *p;
+	int i;
 
 	/*
 	 * Parse enough of the SAL tables to locate the SAL entry point. Since, console
@@ -170,16 +171,20 @@
 	 * This code duplicates some of the ACPI table parsing that is in efi.c & sal.c.
 	 * Any changes to those file may have to be made hereas well.
 	 */
-	efi_systab = (efi_system_table_t*)__va(ia64_boot_param->efi_systab);
+	efi_systab = (efi_system_table_t *) __va(ia64_boot_param->efi_systab);
 	config_tables = __va(efi_systab->tables);
 	for (i = 0; i < efi_systab->nr_tables; i++) {
-		if (efi_guidcmp(config_tables[i].guid, SAL_SYSTEM_TABLE_GUID) == 0) {
+		if (efi_guidcmp(config_tables[i].guid, SAL_SYSTEM_TABLE_GUID) ==
+		    0) {
 			sal_systab = __va(config_tables[i].table);
-			p = (char*)(sal_systab+1);
+			p = (char *)(sal_systab + 1);
 			for (i = 0; i < sal_systab->entry_count; i++) {
 				if (*p == SAL_DESC_ENTRY_POINT) {
-					ep = (struct ia64_sal_desc_entry_point *) p;
-					ia64_sal_handler_init(__va(ep->sal_proc), __va(ep->gp));
+					ep = (struct ia64_sal_desc_entry_point
+					      *)p;
+					ia64_sal_handler_init(__va
+							      (ep->sal_proc),
+							      __va(ep->gp));
 					break;
 				}
 				p += SAL_DESC_SIZE(*p);
@@ -187,9 +192,12 @@
 		}
 	}
 
-	if ( IS_RUNNING_ON_SIMULATOR() ) {
-		master_node_bedrock_address = (u64)REMOTE_HUB(get_nasid(), SH_JUNK_BUS_UART0);
-		printk(KERN_DEBUG "early_sn_setup: setting master_node_bedrock_address to 0x%lx\n", master_node_bedrock_address);
+	if (IS_RUNNING_ON_SIMULATOR()) {
+		master_node_bedrock_address =
+		    (u64) REMOTE_HUB(get_nasid(), SH_JUNK_BUS_UART0);
+		printk(KERN_DEBUG
+		       "early_sn_setup: setting master_node_bedrock_address to 0x%lx\n",
+		       master_node_bedrock_address);
 	}
 }
 
@@ -197,55 +205,32 @@
 extern nasid_t master_nasid;
 static int shub_1_1_found __initdata;
 
-
 /*
  * sn_check_for_wars
  *
  * Set flag for enabling shub specific wars
  */
 
-static inline int __init
-is_shub_1_1(int nasid)
+static inline int __init is_shub_1_1(int nasid)
 {
 	unsigned long id;
-	int	rev;
+	int rev;
 
 	id = REMOTE_HUB_L(nasid, SH_SHUB_ID);
-	rev =  (id & SH_SHUB_ID_REVISION_MASK) >> SH_SHUB_ID_REVISION_SHFT;
+	rev = (id & SH_SHUB_ID_REVISION_MASK) >> SH_SHUB_ID_REVISION_SHFT;
 	return rev <= 2;
 }
 
-static void __init
-sn_check_for_wars(void)
+static void __init sn_check_for_wars(void)
 {
-	int	cnode;
+	int cnode;
 
-	for (cnode=0; cnode< numnodes; cnode++)
+	for (cnode = 0; cnode < numnodes; cnode++)
 		if (is_shub_1_1(cnodeid_to_nasid(cnode)))
 			shub_1_1_found = 1;
 }
 
 /**
- * sn_set_error_handling_features - Tell the SN prom how to handle certain
- * error types.
- */
-static void __init
-sn_set_error_handling_features(void)
-{
-	u64 ret;
-	u64 sn_ehf_bits[7];	/* see ia64_sn_set_error_handling_features */
-	memset(sn_ehf_bits, 0, sizeof(sn_ehf_bits));
-#define EHF(x) __set_bit(SN_SAL_EHF_ ## x, sn_ehf_bits)
-	EHF(MCA_SLV_TO_OS_INIT_SLV);
-	EHF(NO_RZ_TLBC);
-	// Uncomment once Jesse's code goes in - EHF(NO_RZ_IO_READ); 
-#undef	EHF
-	ret = ia64_sn_set_error_handling_features(sn_ehf_bits);
-	if (ret)
-		printk(KERN_ERR "%s: failed, return code %ld\n", __FUNCTION__, ret);
-}
-
-/**
  * sn_setup - SN platform setup routine
  * @cmdline_p: kernel command line
  *
@@ -253,15 +238,12 @@
  * the RTC frequency (via a SAL call), initializing secondary CPUs, and
  * setting up per-node data areas.  The console is also initialized here.
  */
-void __init
-sn_setup(char **cmdline_p)
+void __init sn_setup(char **cmdline_p)
 {
 	long status, ticks_per_sec, drift;
 	int pxm;
 	int major = sn_sal_rev_major(), minor = sn_sal_rev_minor();
-	extern nasid_t snia_get_master_baseio_nasid(void);
 	extern void sn_cpu_init(void);
-	extern nasid_t snia_get_console_nasid(void);
 
 	/*
 	 * If the generic code has enabled vga console support - lets
@@ -283,10 +265,10 @@
 	MAX_DMA_ADDRESS = PAGE_OFFSET + MAX_PHYS_MEMORY;
 
 	memset(physical_node_map, -1, sizeof(physical_node_map));
-	for (pxm=0; pxm<MAX_PXM_DOMAINS; pxm++)
+	for (pxm = 0; pxm < MAX_PXM_DOMAINS; pxm++)
 		if (pxm_to_nid_map[pxm] != -1)
-			physical_node_map[pxm_to_nasid(pxm)] = pxm_to_nid_map[pxm];
-
+			physical_node_map[pxm_to_nasid(pxm)] =
+			    pxm_to_nid_map[pxm];
 
 	/*
 	 * Old PROMs do not provide an ACPI FADT. Disable legacy keyboard
@@ -313,31 +295,28 @@
 	}
 
 	master_nasid = get_nasid();
-	(void)snia_get_console_nasid();
-	(void)snia_get_master_baseio_nasid();
 
-	status = ia64_sal_freq_base(SAL_FREQ_BASE_REALTIME_CLOCK, &ticks_per_sec, &drift);
+	status =
+	    ia64_sal_freq_base(SAL_FREQ_BASE_REALTIME_CLOCK, &ticks_per_sec,
+			       &drift);
 	if (status != 0 || ticks_per_sec < 100000) {
-		printk(KERN_WARNING "unable to determine platform RTC clock frequency, guessing.\n");
+		printk(KERN_WARNING
+		       "unable to determine platform RTC clock frequency, guessing.\n");
 		/* PROM gives wrong value for clock freq. so guess */
-		sn_rtc_cycles_per_second = 1000000000000UL/30000UL;
-	}
-	else
+		sn_rtc_cycles_per_second = 1000000000000UL / 30000UL;
+	} else
 		sn_rtc_cycles_per_second = ticks_per_sec;
 
 	platform_intr_list[ACPI_INTERRUPT_CPEI] = IA64_CPE_VECTOR;
 
-
-	if ( IS_RUNNING_ON_SIMULATOR() )
-	{
-		master_node_bedrock_address = (u64)REMOTE_HUB(get_nasid(), SH_JUNK_BUS_UART0);
-		printk(KERN_DEBUG "sn_setup: setting master_node_bedrock_address to 0x%lx\n",
+	if (IS_RUNNING_ON_SIMULATOR()) {
+		master_node_bedrock_address =
+		    (u64) REMOTE_HUB(get_nasid(), SH_JUNK_BUS_UART0);
+		printk(KERN_DEBUG
+		       "sn_setup: setting master_node_bedrock_address to 0x%lx\n",
 		       master_node_bedrock_address);
 	}
 
-	/* Tell the prom how to handle certain error types */
-	sn_set_error_handling_features();
-
 	/*
 	 * we set the default root device to /dev/hda
 	 * to make simulation easy
@@ -357,12 +336,6 @@
 	 */
 	sn_cpu_init();
 
-	/*
-	 * Setup hubinfo stuff. Has to happen AFTER sn_cpu_init(),
-	 * because it uses the cnode to nasid tables.
-	 */
-	init_platform_hubinfo(nodepdaindr);
-
 #ifdef CONFIG_SMP
 	init_smp_config();
 #endif
@@ -376,32 +349,42 @@
  *
  * One time setup for Node Data Area.  Called by sn_setup().
  */
-void __init
-sn_init_pdas(char **cmdline_p)
+void __init sn_init_pdas(char **cmdline_p)
 {
-	cnodeid_t	cnode;
+	cnodeid_t cnode;
 
-	memset(pda->cnodeid_to_nasid_table, -1, sizeof(pda->cnodeid_to_nasid_table));
-	for (cnode=0; cnode<numnodes; cnode++)
-		pda->cnodeid_to_nasid_table[cnode] = pxm_to_nasid(nid_to_pxm_map[cnode]);
+	memset(pda->cnodeid_to_nasid_table, -1,
+	       sizeof(pda->cnodeid_to_nasid_table));
+	for (cnode = 0; cnode < numnodes; cnode++)
+		pda->cnodeid_to_nasid_table[cnode] =
+		    pxm_to_nasid(nid_to_pxm_map[cnode]);
 
 	numionodes = numnodes;
 	scan_for_ionodes();
 
-        /*
-         * Allocate & initalize the nodepda for each node.
-         */
-        for (cnode=0; cnode < numnodes; cnode++) {
-		nodepdaindr[cnode] = alloc_bootmem_node(NODE_DATA(cnode), sizeof(nodepda_t));
+	/*
+	 * Allocate & initalize the nodepda for each node.
+	 */
+	for (cnode = 0; cnode < numnodes; cnode++) {
+		nodepdaindr[cnode] =
+		    alloc_bootmem_node(NODE_DATA(cnode), sizeof(nodepda_t));
 		memset(nodepdaindr[cnode], 0, sizeof(nodepda_t));
-        }
+	}
 
 	/*
-	 * Now copy the array of nodepda pointers to each nodepda.
+	 * Allocate & initialize nodepda for TIOs.  For now, put them on node 0.
 	 */
-        for (cnode=0; cnode < numionodes; cnode++)
-		memcpy(nodepdaindr[cnode]->pernode_pdaindr, nodepdaindr, sizeof(nodepdaindr));
+	for (cnode = numnodes; cnode < numionodes; cnode ++) {
+		nodepdaindr[cnode] = alloc_bootmem_node(NODE_DATA(0), sizeof(nodepda_t));
+		memset(nodepdaindr[cnode], 0, sizeof(nodepda_t));
+	}
 
+	/*
+	 * Now copy the array of nodepda pointers to each nodepda.
+	 */
+	for (cnode = 0; cnode < numionodes; cnode++)
+		memcpy(nodepdaindr[cnode]->pernode_pdaindr, nodepdaindr,
+		       sizeof(nodepdaindr));
 
 	/*
 	 * Set up IO related platform-dependent nodepda fields.
@@ -409,8 +392,15 @@
 	 * in nodepda.
 	 */
 	for (cnode = 0; cnode < numnodes; cnode++) {
-		init_platform_nodepda(nodepdaindr[cnode], cnode);
-		bte_init_node (nodepdaindr[cnode], cnode);
+		bte_init_node(nodepdaindr[cnode], cnode);
+	}
+
+	/*
+	 * Initialize the per node hubdev.  This includes IO Nodes and 
+	 * headless/memless nodes.
+	 */
+	for (cnode = 0; cnode < numionodes; cnode++) {
+		hubdev_init_node(nodepdaindr[cnode], cnode);
 	}
 }
 
@@ -423,15 +413,14 @@
  * Also sets up a few fields in the nodepda.  Also known as
  * platform_cpu_init() by the ia64 machvec code.
  */
-void __init
-sn_cpu_init(void)
+void __init sn_cpu_init(void)
 {
-	int	cpuid;
-	int	cpuphyid;
-	int	nasid;
-	int	slice;
-	int	cnode;
-	static int	wars_have_been_checked;
+	int cpuid;
+	int cpuphyid;
+	int nasid;
+	int slice;
+	int cnode;
+	static int wars_have_been_checked;
 
 	/*
 	 * The boot cpu makes this call again after platform initialization is
@@ -448,15 +437,17 @@
 
 	memset(pda, 0, sizeof(pda));
 	pda->p_nodepda = nodepdaindr[cnode];
-	pda->led_address = (typeof(pda->led_address)) (LED0 + (slice<<LED_CPU_SHIFT));
+	pda->led_address =
+	    (typeof(pda->led_address)) (LED0 + (slice << LED_CPU_SHIFT));
 	pda->led_state = LED_ALWAYS_SET;
-	pda->hb_count = HZ/2;
+	pda->hb_count = HZ / 2;
 	pda->hb_state = 0;
 	pda->idle_flag = 0;
 
-	if (cpuid != 0){
-		memcpy(pda->cnodeid_to_nasid_table, pdacpu(0)->cnodeid_to_nasid_table,
-				sizeof(pda->cnodeid_to_nasid_table));
+	if (cpuid != 0) {
+		memcpy(pda->cnodeid_to_nasid_table,
+		       pdacpu(0)->cnodeid_to_nasid_table,
+		       sizeof(pda->cnodeid_to_nasid_table));
 	}
 
 	/*
@@ -470,31 +461,30 @@
 		wars_have_been_checked = 1;
 	}
 	pda->shub_1_1_found = shub_1_1_found;
-	
 
 	/*
 	 * We must use different memory allocators for first cpu (bootmem 
 	 * allocator) than for the other cpus (regular allocator).
 	 */
-	if (cpuid == 0)
-		irqpdaindr = alloc_bootmem_node(NODE_DATA(cpuid_to_cnodeid(cpuid)),sizeof(irqpda_t));
-
-	memset(irqpdaindr, 0, sizeof(irqpda_t));
-	irqpdaindr->irq_flags[SGI_PCIBR_ERROR] = SN2_IRQ_SHARED;
-	irqpdaindr->irq_flags[SGI_PCIBR_ERROR] |= SN2_IRQ_RESERVED;
-	irqpdaindr->irq_flags[SGI_II_ERROR] = SN2_IRQ_SHARED;
-	irqpdaindr->irq_flags[SGI_II_ERROR] |= SN2_IRQ_RESERVED;
-
 	pda->pio_write_status_addr = (volatile unsigned long *)
-			LOCAL_MMR_ADDR((slice < 2 ? SH_PIO_WRITE_STATUS_0 : SH_PIO_WRITE_STATUS_1 ) );
+	    LOCAL_MMR_ADDR((slice <
+			    2 ? SH_PIO_WRITE_STATUS_0 : SH_PIO_WRITE_STATUS_1));
 	pda->mem_write_status_addr = (volatile u64 *)
-			LOCAL_MMR_ADDR((slice < 2 ? SH_MEMORY_WRITE_STATUS_0 : SH_MEMORY_WRITE_STATUS_1 ) );
+	    LOCAL_MMR_ADDR((slice <
+			    2 ? SH_MEMORY_WRITE_STATUS_0 :
+			    SH_MEMORY_WRITE_STATUS_1));
 
 	if (local_node_data->active_cpu_count++ == 0) {
-		int	buddy_nasid;
-		buddy_nasid = cnodeid_to_nasid(numa_node_id() == numnodes-1 ? 0 : numa_node_id()+ 1);
-		pda->pio_shub_war_cam_addr = (volatile unsigned long*)GLOBAL_MMR_ADDR(nasid, SH_PI_CAM_CONTROL);
+		int buddy_nasid;
+		buddy_nasid =
+		    cnodeid_to_nasid(numa_node_id() ==
+				     numnodes - 1 ? 0 : numa_node_id() + 1);
+		pda->pio_shub_war_cam_addr =
+		    (volatile unsigned long *)GLOBAL_MMR_ADDR(nasid,
+							      SH_PI_CAM_CONTROL);
 	}
+
+	bte_init_cpu();
 }
 
 /*
@@ -502,48 +492,54 @@
  * physical_node_map and the pda and increment numionodes.
  */
 
-static void __init
-scan_for_ionodes(void)
+static void __init scan_for_ionodes(void)
 {
 	int nasid = 0;
 	lboard_t *brd;
 
 	/* Setup ionodes with memory */
-	for (nasid = 0; nasid < MAX_PHYSNODE_ID; nasid +=2) {
+	for (nasid = 0; nasid < MAX_PHYSNODE_ID; nasid += 2) {
 		u64 klgraph_header;
 		cnodeid_t cnodeid;
 
-		if (physical_node_map[nasid] == -1) 
+		if (physical_node_map[nasid] == -1)
 			continue;
 
 		klgraph_header = cnodeid = -1;
 		klgraph_header = ia64_sn_get_klconfig_addr(nasid);
 		if (klgraph_header <= 0) {
-			if ( IS_RUNNING_ON_SIMULATOR() )
+			if (IS_RUNNING_ON_SIMULATOR())
 				continue;
-			BUG(); /* All nodes must have klconfig tables! */
+			BUG();	/* All nodes must have klconfig tables! */
 		}
 		cnodeid = nasid_to_cnodeid(nasid);
 		root_lboard[cnodeid] = (lboard_t *)
-					NODE_OFFSET_TO_LBOARD( (nasid),
-					((kl_config_hdr_t *)(klgraph_header))->
-					ch_board_info);
+		    NODE_OFFSET_TO_LBOARD((nasid),
+					  ((kl_config_hdr_t
+					    *) (klgraph_header))->
+					  ch_board_info);
 	}
 
 	/* Scan headless/memless IO Nodes. */
-	for (nasid = 0; nasid < MAX_PHYSNODE_ID; nasid +=2) {
+	for (nasid = 0; nasid < MAX_PHYSNODE_ID; nasid += 2) {
 		/* if there's no nasid, don't try to read the klconfig on the node */
-		if (physical_node_map[nasid] == -1) continue;
-		brd = find_lboard_any((lboard_t *)root_lboard[nasid_to_cnodeid(nasid)], KLTYPE_SNIA);
+		if (physical_node_map[nasid] == -1)
+			continue;
+		brd =
+		    find_lboard_any((lboard_t *)
+				    root_lboard[nasid_to_cnodeid(nasid)],
+				    KLTYPE_SNIA);
 		if (brd) {
-			brd = KLCF_NEXT_ANY(brd); /* Skip this node's lboard */
+			brd = KLCF_NEXT_ANY(brd);	/* Skip this node's lboard */
 			if (!brd)
 				continue;
 		}
 
 		brd = find_lboard_any(brd, KLTYPE_SNIA);
+
 		while (brd) {
-			pda->cnodeid_to_nasid_table[numionodes] = brd->brd_nasid;
+			pda->cnodeid_to_nasid_table[numionodes] =
+				brd->brd_nasid;
 			physical_node_map[brd->brd_nasid] = numionodes;
 			root_lboard[numionodes] = brd;
 			numionodes++;
@@ -554,4 +550,23 @@
 			brd = find_lboard_any(brd, KLTYPE_SNIA);
 		}
 	}
+
+	/* Scan for TIO nodes. */
+	for (nasid = 0; nasid < MAX_PHYSNODE_ID; nasid +=2) {
+		/* if there's no nasid, don't try to read the klconfig on the node */
+		if (physical_node_map[nasid] == -1) continue;
+		brd = find_lboard_any((lboard_t *)root_lboard[nasid_to_cnodeid(nasid)], KLTYPE_TIO);
+		while (brd) {
+			pda->cnodeid_to_nasid_table[numionodes] = brd->brd_nasid;
+			physical_node_map[brd->brd_nasid] = numionodes;
+			root_lboard[numionodes] = brd;
+			numionodes++;
+			brd = KLCF_NEXT_ANY(brd);
+			if (!brd)
+				break;
+
+			brd = find_lboard_any(brd, KLTYPE_TIO);
+		}
+	}
+
 }
