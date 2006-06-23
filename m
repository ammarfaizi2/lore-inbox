Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751929AbWFWSsz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751929AbWFWSsz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 14:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751938AbWFWSmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 14:42:13 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:21199 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751931AbWFWSmI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 14:42:08 -0400
Message-Id: <20060623183915.678602000@linux-m68k.org>
References: <20060623183056.479024000@linux-m68k.org>
User-Agent: quilt/0.44-1
Date: Fri, 23 Jun 2006 20:31:14 +0200
From: zippel@linux-m68k.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 18/21] convert mac irq code
Content-Disposition: inline; filename=0024-M68K-convert-mac-irq-code.txt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 arch/m68k/mac/baboon.c       |    2 
 arch/m68k/mac/config.c       |    5 
 arch/m68k/mac/iop.c          |    2 
 arch/m68k/mac/macints.c      |  496 +++++++++++-------------------------------
 arch/m68k/mac/oss.c          |   14 +
 arch/m68k/mac/psc.c          |   10 -
 arch/m68k/mac/via.c          |   18 +-
 drivers/scsi/mac_esp.c       |    7 -
 drivers/scsi/mac_scsi.c      |    7 -
 include/asm-m68k/mac_oss.h   |   10 -
 include/asm-m68k/macintosh.h |   10 -
 include/asm-m68k/macints.h   |    3 
 12 files changed, 159 insertions(+), 425 deletions(-)

aff4be075ffb377f41a24be05476deee040f8bfc
diff --git a/arch/m68k/mac/baboon.c b/arch/m68k/mac/baboon.c
index b19b7dd..6eaa881 100644
--- a/arch/m68k/mac/baboon.c
+++ b/arch/m68k/mac/baboon.c
@@ -81,7 +81,7 @@ #endif
 	for (i = 0, irq_bit = 1 ; i < 3 ; i++, irq_bit <<= 1) {
 	        if (events & irq_bit/* & baboon_active*/) {
 			baboon_active &= ~irq_bit;
-			mac_do_irq_list(IRQ_BABOON_0 + i, regs);
+			m68k_handle_int(IRQ_BABOON_0 + i, regs);
 			baboon_active |= irq_bit;
 			baboon->mb_ifr &= ~irq_bit;
 		}
diff --git a/arch/m68k/mac/config.c b/arch/m68k/mac/config.c
index 7e04f2a..5a9990e 100644
--- a/arch/m68k/mac/config.c
+++ b/arch/m68k/mac/config.c
@@ -169,12 +169,7 @@ void __init config_mac(void)
 
 	mach_sched_init      = mac_sched_init;
 	mach_init_IRQ        = mac_init_IRQ;
-	mach_request_irq     = mac_request_irq;
-	mach_free_irq        = mac_free_irq;
-	enable_irq           = mac_enable_irq;
-	disable_irq          = mac_disable_irq;
 	mach_get_model	 = mac_get_model;
-	mach_get_irq_list    = show_mac_interrupts;
 	mach_gettimeoffset   = mac_gettimeoffset;
 #warning move to adb/via init
 #if 0
diff --git a/arch/m68k/mac/iop.c b/arch/m68k/mac/iop.c
index 9179a37..4c8ece7 100644
--- a/arch/m68k/mac/iop.c
+++ b/arch/m68k/mac/iop.c
@@ -317,7 +317,7 @@ void __init iop_register_interrupts(void
 {
 	if (iop_ism_present) {
 		if (oss_present) {
-			cpu_request_irq(OSS_IRQLEV_IOPISM, iop_ism_irq,
+			request_irq(OSS_IRQLEV_IOPISM, iop_ism_irq,
 					IRQ_FLG_LOCK, "ISM IOP",
 					(void *) IOP_NUM_ISM);
 			oss_irq_enable(IRQ_MAC_ADB);
diff --git a/arch/m68k/mac/macints.c b/arch/m68k/mac/macints.c
index 73b39cd..694b14b 100644
--- a/arch/m68k/mac/macints.c
+++ b/arch/m68k/mac/macints.c
@@ -137,14 +137,6 @@ #include <asm/macints.h>
 #define DEBUG_SPURIOUS
 #define SHUTUP_SONIC
 
-/*
- * The mac_irq_list array is an array of linked lists of irq_node_t nodes.
- * Each node contains one handler to be called whenever the interrupt
- * occurs, with fast handlers listed before slow handlers.
- */
-
-irq_node_t *mac_irq_list[NUM_MAC_SOURCES];
-
 /* SCC interrupt mask */
 
 static int scc_mask;
@@ -209,8 +201,8 @@ extern int  baboon_irq_pending(int);
  * SCC interrupt routines
  */
 
-static void scc_irq_enable(int);
-static void scc_irq_disable(int);
+static void scc_irq_enable(unsigned int);
+static void scc_irq_disable(unsigned int);
 
 /*
  * console_loglevel determines NMI handler function
@@ -221,21 +213,25 @@ irqreturn_t mac_debug_handler(int, void 
 
 /* #define DEBUG_MACINTS */
 
+static void mac_enable_irq(unsigned int irq);
+static void mac_disable_irq(unsigned int irq);
+
+static struct irq_controller mac_irq_controller = {
+	.name		= "mac",
+	.lock		= SPIN_LOCK_UNLOCKED,
+	.enable		= mac_enable_irq,
+	.disable	= mac_disable_irq,
+};
+
 void mac_init_IRQ(void)
 {
-        int i;
-
 #ifdef DEBUG_MACINTS
 	printk("mac_init_IRQ(): Setting things up...\n");
 #endif
-	/* Initialize the IRQ handler lists. Initially each list is empty, */
-
-	for (i = 0; i < NUM_MAC_SOURCES; i++) {
-		mac_irq_list[i] = NULL;
-	}
-
 	scc_mask = 0;
 
+	m68k_setup_irq_controller(&mac_irq_controller, IRQ_USER,
+				  NUM_MAC_SOURCES - IRQ_USER);
 	/* Make sure the SONIC interrupt is cleared or things get ugly */
 #ifdef SHUTUP_SONIC
 	printk("Killing onboard sonic... ");
@@ -252,15 +248,16 @@ #endif /* SHUTUP_SONIC */
 	 * at levels 1-7. Most of the work is done elsewhere.
 	 */
 
-	if (oss_present) {
+	if (oss_present)
 		oss_register_interrupts();
-	} else {
+	else
 		via_register_interrupts();
-	}
-	if (psc_present) psc_register_interrupts();
-	if (baboon_present) baboon_register_interrupts();
+	if (psc_present)
+		psc_register_interrupts();
+	if (baboon_present)
+		baboon_register_interrupts();
 	iop_register_interrupts();
-	cpu_request_irq(7, mac_nmi_handler, IRQ_FLG_LOCK, "NMI",
+	request_irq(IRQ_AUTO_7, mac_nmi_handler, 0, "NMI",
 			mac_nmi_handler);
 #ifdef DEBUG_MACINTS
 	printk("mac_init_IRQ(): Done!\n");
@@ -268,104 +265,6 @@ #endif
 }
 
 /*
- * Routines to work with irq_node_t's on linked lists lifted from
- * the Amiga code written by Roman Zippel.
- */
-
-static inline void mac_insert_irq(irq_node_t **list, irq_node_t *node)
-{
-	unsigned long flags;
-	irq_node_t *cur;
-
-	if (!node->dev_id)
-		printk("%s: Warning: dev_id of %s is zero\n",
-		       __FUNCTION__, node->devname);
-
-	local_irq_save(flags);
-
-	cur = *list;
-
-	if (node->flags & IRQ_FLG_FAST) {
-		node->flags &= ~IRQ_FLG_SLOW;
-		while (cur && cur->flags & IRQ_FLG_FAST) {
-			list = &cur->next;
-			cur = cur->next;
-		}
-	} else if (node->flags & IRQ_FLG_SLOW) {
-		while (cur) {
-			list = &cur->next;
-			cur = cur->next;
-		}
-	} else {
-		while (cur && !(cur->flags & IRQ_FLG_SLOW)) {
-			list = &cur->next;
-			cur = cur->next;
-		}
-	}
-
-	node->next = cur;
-	*list = node;
-
-	local_irq_restore(flags);
-}
-
-static inline void mac_delete_irq(irq_node_t **list, void *dev_id)
-{
-	unsigned long flags;
-	irq_node_t *node;
-
-	local_irq_save(flags);
-
-	for (node = *list; node; list = &node->next, node = *list) {
-		if (node->dev_id == dev_id) {
-			*list = node->next;
-			/* Mark it as free. */
-			node->handler = NULL;
-			local_irq_restore(flags);
-			return;
-		}
-	}
-	local_irq_restore(flags);
-	printk ("%s: tried to remove invalid irq\n", __FUNCTION__);
-}
-
-/*
- * Call all the handlers for a given interrupt. Fast handlers are called
- * first followed by slow handlers.
- *
- * This code taken from the original Amiga code written by Roman Zippel.
- */
-
-void mac_do_irq_list(int irq, struct pt_regs *fp)
-{
-	irq_node_t *node, *slow_nodes;
-	unsigned long flags;
-
-	kstat_cpu(0).irqs[irq]++;
-
-#ifdef DEBUG_SPURIOUS
-	if (!mac_irq_list[irq] && (console_loglevel > 7)) {
-		printk("mac_do_irq_list: spurious interrupt %d!\n", irq);
-		return;
-	}
-#endif
-
-	/* serve first fast and normal handlers */
-	for (node = mac_irq_list[irq];
-	     node && (!(node->flags & IRQ_FLG_SLOW));
-	     node = node->next)
-		node->handler(irq, node->dev_id, fp);
-	if (!node) return;
-	local_save_flags(flags);
-	local_irq_restore((flags & ~0x0700) | (fp->sr & 0x0700));
-	/* if slow handlers exists, serve them now */
-	slow_nodes = node;
-	for (; node; node = node->next) {
-		node->handler(irq, node->dev_id, fp);
-	}
-}
-
-/*
  *  mac_enable_irq - enable an interrupt source
  * mac_disable_irq - disable an interrupt source
  *   mac_clear_irq - clears a pending interrupt
@@ -374,265 +273,120 @@ #endif
  * These routines are just dispatchers to the VIA/OSS/PSC routines.
  */
 
-void mac_enable_irq (unsigned int irq)
+static void mac_enable_irq(unsigned int irq)
 {
-	int irq_src	= IRQ_SRC(irq);
+	int irq_src = IRQ_SRC(irq);
 
 	switch(irq_src) {
-		case 1: via_irq_enable(irq);
-			break;
-		case 2:
-		case 7: if (oss_present) {
-				oss_irq_enable(irq);
-			} else {
-				via_irq_enable(irq);
-			}
-			break;
-		case 3:
-		case 4:
-		case 5:
-		case 6: if (psc_present) {
-				psc_irq_enable(irq);
-			} else if (oss_present) {
-				oss_irq_enable(irq);
-			} else if (irq_src == 4) {
-				scc_irq_enable(irq);
-			}
-			break;
-		case 8: if (baboon_present) {
-				baboon_irq_enable(irq);
-			}
-			break;
+	case 1:
+		via_irq_enable(irq);
+		break;
+	case 2:
+	case 7:
+		if (oss_present)
+			oss_irq_enable(irq);
+		else
+			via_irq_enable(irq);
+		break;
+	case 3:
+	case 4:
+	case 5:
+	case 6:
+		if (psc_present)
+			psc_irq_enable(irq);
+		else if (oss_present)
+			oss_irq_enable(irq);
+		else if (irq_src == 4)
+			scc_irq_enable(irq);
+		break;
+	case 8:
+		if (baboon_present)
+			baboon_irq_enable(irq);
+		break;
 	}
 }
 
-void mac_disable_irq (unsigned int irq)
+static void mac_disable_irq(unsigned int irq)
 {
-	int irq_src	= IRQ_SRC(irq);
+	int irq_src = IRQ_SRC(irq);
 
 	switch(irq_src) {
-		case 1: via_irq_disable(irq);
-			break;
-		case 2:
-		case 7: if (oss_present) {
-				oss_irq_disable(irq);
-			} else {
-				via_irq_disable(irq);
-			}
-			break;
-		case 3:
-		case 4:
-		case 5:
-		case 6: if (psc_present) {
-				psc_irq_disable(irq);
-			} else if (oss_present) {
-				oss_irq_disable(irq);
-			} else if (irq_src == 4) {
-				scc_irq_disable(irq);
-			}
-			break;
-		case 8: if (baboon_present) {
-				baboon_irq_disable(irq);
-			}
-			break;
+	case 1:
+		via_irq_disable(irq);
+		break;
+	case 2:
+	case 7:
+		if (oss_present)
+			oss_irq_disable(irq);
+		else
+			via_irq_disable(irq);
+		break;
+	case 3:
+	case 4:
+	case 5:
+	case 6:
+		if (psc_present)
+			psc_irq_disable(irq);
+		else if (oss_present)
+			oss_irq_disable(irq);
+		else if (irq_src == 4)
+			scc_irq_disable(irq);
+		break;
+	case 8:
+		if (baboon_present)
+			baboon_irq_disable(irq);
+		break;
 	}
 }
 
-void mac_clear_irq( unsigned int irq )
+void mac_clear_irq(unsigned int irq)
 {
 	switch(IRQ_SRC(irq)) {
-		case 1: via_irq_clear(irq);
-			break;
-		case 2:
-		case 7: if (oss_present) {
-				oss_irq_clear(irq);
-			} else {
-				via_irq_clear(irq);
-			}
-			break;
-		case 3:
-		case 4:
-		case 5:
-		case 6: if (psc_present) {
-				psc_irq_clear(irq);
-			} else if (oss_present) {
-				oss_irq_clear(irq);
-			}
-			break;
-		case 8: if (baboon_present) {
-				baboon_irq_clear(irq);
-			}
-			break;
+	case 1:
+		via_irq_clear(irq);
+		break;
+	case 2:
+	case 7:
+		if (oss_present)
+			oss_irq_clear(irq);
+		else
+			via_irq_clear(irq);
+		break;
+	case 3:
+	case 4:
+	case 5:
+	case 6:
+		if (psc_present)
+			psc_irq_clear(irq);
+		else if (oss_present)
+			oss_irq_clear(irq);
+		break;
+	case 8:
+		if (baboon_present)
+			baboon_irq_clear(irq);
+		break;
 	}
 }
 
-int mac_irq_pending( unsigned int irq )
+int mac_irq_pending(unsigned int irq)
 {
 	switch(IRQ_SRC(irq)) {
-		case 1: return via_irq_pending(irq);
-		case 2:
-		case 7: if (oss_present) {
-				return oss_irq_pending(irq);
-			} else {
-				return via_irq_pending(irq);
-			}
-		case 3:
-		case 4:
-		case 5:
-		case 6: if (psc_present) {
-				return psc_irq_pending(irq);
-			} else if (oss_present) {
-				return oss_irq_pending(irq);
-			}
-	}
-	return 0;
-}
-
-/*
- * Add an interrupt service routine to an interrupt source.
- * Returns 0 on success.
- *
- * FIXME: You can register interrupts on nonexistent source (ie PSC4 on a
- *        non-PSC machine). We should return -EINVAL in those cases.
- */
-
-int mac_request_irq(unsigned int irq,
-		    irqreturn_t (*handler)(int, void *, struct pt_regs *),
-		    unsigned long flags, const char *devname, void *dev_id)
-{
-	irq_node_t *node;
-
-#ifdef DEBUG_MACINTS
-	printk ("%s: irq %d requested for %s\n", __FUNCTION__, irq, devname);
-#endif
-
-	if (irq < VIA1_SOURCE_BASE) {
-		return cpu_request_irq(irq, handler, flags, devname, dev_id);
-	}
-
-	if (irq >= NUM_MAC_SOURCES) {
-		printk ("%s: unknown irq %d requested by %s\n",
-		        __FUNCTION__, irq, devname);
-	}
-
-	/* Get a node and stick it onto the right list */
-
-	if (!(node = new_irq_node())) return -ENOMEM;
-
-	node->handler	= handler;
-	node->flags	= flags;
-	node->dev_id	= dev_id;
-	node->devname	= devname;
-	node->next	= NULL;
-	mac_insert_irq(&mac_irq_list[irq], node);
-
-	/* Now enable the IRQ source */
-
-	mac_enable_irq(irq);
-
-	return 0;
-}
-
-/*
- * Removes an interrupt service routine from an interrupt source.
- */
-
-void mac_free_irq(unsigned int irq, void *dev_id)
-{
-#ifdef DEBUG_MACINTS
-	printk ("%s: irq %d freed by %p\n", __FUNCTION__, irq, dev_id);
-#endif
-
-	if (irq < VIA1_SOURCE_BASE) {
-		cpu_free_irq(irq, dev_id);
-		return;
-	}
-
-	if (irq >= NUM_MAC_SOURCES) {
-		printk ("%s: unknown irq %d freed\n",
-		        __FUNCTION__, irq);
-		return;
-	}
-
-	mac_delete_irq(&mac_irq_list[irq], dev_id);
-
-	/* If the list for this interrupt is */
-	/* empty then disable the source.    */
-
-	if (!mac_irq_list[irq]) {
-		mac_disable_irq(irq);
-	}
-}
-
-/*
- * Generate a pretty listing for /proc/interrupts
- *
- * By the time we're called the autovector interrupt list has already been
- * generated, so we just need to do the machspec interrupts.
- *
- * 990506 (jmt) - rewritten to handle chained machspec interrupt handlers.
- *                Also removed display of num_spurious it is already
- *		  displayed for us as autovector irq 0.
- */
-
-int show_mac_interrupts(struct seq_file *p, void *v)
-{
-	int i;
-	irq_node_t *node;
-	char *base;
-
-	/* Don't do Nubus interrupts in this loop; we do them separately  */
-	/* below so that we can print slot numbers instead of IRQ numbers */
-
-	for (i = VIA1_SOURCE_BASE ; i < NUM_MAC_SOURCES ; ++i) {
-
-		/* Nonexistant interrupt or nothing registered; skip it. */
-
-		if ((node = mac_irq_list[i]) == NULL) continue;
-		if (node->flags & IRQ_FLG_STD) continue;
-
-		base = "";
-		switch(IRQ_SRC(i)) {
-			case 1: base = "via1";
-				break;
-			case 2: if (oss_present) {
-					base = "oss";
-				} else {
-					base = "via2";
-				}
-				break;
-			case 3:
-			case 4:
-			case 5:
-			case 6: if (psc_present) {
-					base = "psc";
-				} else if (oss_present) {
-					base = "oss";
-				} else {
-					if (IRQ_SRC(i) == 4) base = "scc";
-				}
-				break;
-			case 7: base = "nbus";
-				break;
-			case 8: base = "bbn";
-				break;
-		}
-		seq_printf(p, "%4s %2d: %10u ", base, i, kstat_cpu(0).irqs[i]);
-
-		do {
-			if (node->flags & IRQ_FLG_FAST) {
-				seq_puts(p, "F ");
-			} else if (node->flags & IRQ_FLG_SLOW) {
-				seq_puts(p, "S ");
-			} else {
-				seq_puts(p, "  ");
-			}
-			seq_printf(p, "%s\n", node->devname);
-			if ((node = node->next)) {
-				seq_puts(p, "                    ");
-			}
-		} while(node);
-
+	case 1:
+		return via_irq_pending(irq);
+	case 2:
+	case 7:
+		if (oss_present)
+			return oss_irq_pending(irq);
+		else
+			return via_irq_pending(irq);
+	case 3:
+	case 4:
+	case 5:
+	case 6:
+		if (psc_present)
+			return psc_irq_pending(irq);
+		else if (oss_present)
+			return oss_irq_pending(irq);
 	}
 	return 0;
 }
@@ -676,7 +430,7 @@ irqreturn_t mac_nmi_handler(int irq, voi
 	while (nmi_hold == 1)
 		udelay(1000);
 
-	if ( console_loglevel >= 8 ) {
+	if (console_loglevel >= 8) {
 #if 0
 		show_state();
 		printk("PC: %08lx\nSR: %04x  SP: %p\n", fp->pc, fp->sr, fp);
@@ -705,14 +459,16 @@ #endif
  * done in hardware (only the PSC can do that.)
  */
 
-static void scc_irq_enable(int irq) {
-	int irq_idx     = IRQ_IDX(irq);
+static void scc_irq_enable(unsigned int irq)
+{
+	int irq_idx = IRQ_IDX(irq);
 
 	scc_mask |= (1 << irq_idx);
 }
 
-static void scc_irq_disable(int irq) {
-	int irq_idx     = IRQ_IDX(irq);
+static void scc_irq_disable(unsigned int irq)
+{
+	int irq_idx = IRQ_IDX(irq);
 
 	scc_mask &= ~(1 << irq_idx);
 }
@@ -747,6 +503,8 @@ void mac_scc_dispatch(int irq, void *dev
 	/* and since they're autovector interrupts they */
 	/* pretty much kill the system.                 */
 
-	if (reg & 0x38) mac_do_irq_list(IRQ_SCCA, regs);
-	if (reg & 0x07) mac_do_irq_list(IRQ_SCCB, regs);
+	if (reg & 0x38)
+		m68k_handle_int(IRQ_SCCA, regs);
+	if (reg & 0x07)
+		m68k_handle_int(IRQ_SCCB, regs);
 }
diff --git a/arch/m68k/mac/oss.c b/arch/m68k/mac/oss.c
index 3335476..63e0436 100644
--- a/arch/m68k/mac/oss.c
+++ b/arch/m68k/mac/oss.c
@@ -67,15 +67,15 @@ void __init oss_init(void)
 
 void __init oss_register_interrupts(void)
 {
-	cpu_request_irq(OSS_IRQLEV_SCSI, oss_irq, IRQ_FLG_LOCK,
+	request_irq(OSS_IRQLEV_SCSI, oss_irq, IRQ_FLG_LOCK,
 			"scsi", (void *) oss);
-	cpu_request_irq(OSS_IRQLEV_IOPSCC, mac_scc_dispatch, IRQ_FLG_LOCK,
+	request_irq(OSS_IRQLEV_IOPSCC, mac_scc_dispatch, IRQ_FLG_LOCK,
 			"scc", mac_scc_dispatch);
-	cpu_request_irq(OSS_IRQLEV_NUBUS, oss_nubus_irq, IRQ_FLG_LOCK,
+	request_irq(OSS_IRQLEV_NUBUS, oss_nubus_irq, IRQ_FLG_LOCK,
 			"nubus", (void *) oss);
-	cpu_request_irq(OSS_IRQLEV_SOUND, oss_irq, IRQ_FLG_LOCK,
+	request_irq(OSS_IRQLEV_SOUND, oss_irq, IRQ_FLG_LOCK,
 			"sound", (void *) oss);
-	cpu_request_irq(OSS_IRQLEV_VIA1, via1_irq, IRQ_FLG_LOCK,
+	request_irq(OSS_IRQLEV_VIA1, via1_irq, IRQ_FLG_LOCK,
 			"via1", (void *) via1);
 }
 
@@ -113,7 +113,7 @@ #endif
 		oss->irq_pending &= ~OSS_IP_SOUND;
 	} else if (events & OSS_IP_SCSI) {
 		oss->irq_level[OSS_SCSI] = OSS_IRQLEV_DISABLED;
-		mac_do_irq_list(IRQ_MAC_SCSI, regs);
+		m68k_handle_int(IRQ_MAC_SCSI, regs);
 		oss->irq_pending &= ~OSS_IP_SCSI;
 		oss->irq_level[OSS_SCSI] = OSS_IRQLEV_SCSI;
 	} else {
@@ -146,7 +146,7 @@ #endif
 	for (i = 0, irq_bit = 1 ; i < 6 ; i++, irq_bit <<= 1) {
 		if (events & irq_bit) {
 			oss->irq_level[i] = OSS_IRQLEV_DISABLED;
-			mac_do_irq_list(NUBUS_SOURCE_BASE + i, regs);
+			m68k_handle_int(NUBUS_SOURCE_BASE + i, regs);
 			oss->irq_pending &= ~irq_bit;
 			oss->irq_level[i] = OSS_IRQLEV_NUBUS;
 		}
diff --git a/arch/m68k/mac/psc.c b/arch/m68k/mac/psc.c
index e72384e..e262180 100644
--- a/arch/m68k/mac/psc.c
+++ b/arch/m68k/mac/psc.c
@@ -117,10 +117,10 @@ #endif
 
 void __init psc_register_interrupts(void)
 {
-	cpu_request_irq(3, psc_irq, IRQ_FLG_LOCK, "psc3", (void *) 0x30);
-	cpu_request_irq(4, psc_irq, IRQ_FLG_LOCK, "psc4", (void *) 0x40);
-	cpu_request_irq(5, psc_irq, IRQ_FLG_LOCK, "psc5", (void *) 0x50);
-	cpu_request_irq(6, psc_irq, IRQ_FLG_LOCK, "psc6", (void *) 0x60);
+	request_irq(IRQ_AUTO_3, psc_irq, 0, "psc3", (void *) 0x30);
+	request_irq(IRQ_AUTO_4, psc_irq, 0, "psc4", (void *) 0x40);
+	request_irq(IRQ_AUTO_5, psc_irq, 0, "psc5", (void *) 0x50);
+	request_irq(IRQ_AUTO_6, psc_irq, 0, "psc6", (void *) 0x60);
 }
 
 /*
@@ -149,7 +149,7 @@ #endif
 	for (i = 0, irq_bit = 1 ; i < 4 ; i++, irq_bit <<= 1) {
 	        if (events & irq_bit) {
 			psc_write_byte(pIER, irq_bit);
-			mac_do_irq_list(base_irq + i, regs);
+			m68k_handle_int(base_irq + i, regs);
 			psc_write_byte(pIFR, irq_bit);
 			psc_write_byte(pIER, irq_bit | 0x80);
 		}
diff --git a/arch/m68k/mac/via.c b/arch/m68k/mac/via.c
index a6e3814..c4aa345 100644
--- a/arch/m68k/mac/via.c
+++ b/arch/m68k/mac/via.c
@@ -253,21 +253,21 @@ void __init via_init_clock(irqreturn_t (
 void __init via_register_interrupts(void)
 {
 	if (via_alt_mapping) {
-		cpu_request_irq(IRQ_AUTO_1, via1_irq,
+		request_irq(IRQ_AUTO_1, via1_irq,
 				IRQ_FLG_LOCK|IRQ_FLG_FAST, "software",
 				(void *) via1);
-		cpu_request_irq(IRQ_AUTO_6, via1_irq,
+		request_irq(IRQ_AUTO_6, via1_irq,
 				IRQ_FLG_LOCK|IRQ_FLG_FAST, "via1",
 				(void *) via1);
 	} else {
-		cpu_request_irq(IRQ_AUTO_1, via1_irq,
+		request_irq(IRQ_AUTO_1, via1_irq,
 				IRQ_FLG_LOCK|IRQ_FLG_FAST, "via1",
 				(void *) via1);
 	}
-	cpu_request_irq(IRQ_AUTO_2, via2_irq, IRQ_FLG_LOCK|IRQ_FLG_FAST,
+	request_irq(IRQ_AUTO_2, via2_irq, IRQ_FLG_LOCK|IRQ_FLG_FAST,
 			"via2", (void *) via2);
 	if (!psc_present) {
-		cpu_request_irq(IRQ_AUTO_4, mac_scc_dispatch, IRQ_FLG_LOCK,
+		request_irq(IRQ_AUTO_4, mac_scc_dispatch, IRQ_FLG_LOCK,
 				"scc", mac_scc_dispatch);
 	}
 	request_irq(IRQ_MAC_NUBUS, via_nubus_irq, IRQ_FLG_LOCK|IRQ_FLG_FAST,
@@ -424,7 +424,7 @@ irqreturn_t via1_irq(int irq, void *dev_
 	for (i = 0, irq_bit = 1 ; i < 7 ; i++, irq_bit <<= 1)
 		if (events & irq_bit) {
 			via1[vIER] = irq_bit;
-			mac_do_irq_list(VIA1_SOURCE_BASE + i, regs);
+			m68k_handle_int(VIA1_SOURCE_BASE + i, regs);
 			via1[vIFR] = irq_bit;
 			via1[vIER] = irq_bit | 0x80;
 		}
@@ -439,7 +439,7 @@ #if 0 /* freakin' pmu is doing weird stu
 		/* No, it won't be set. that's why we're doing this. */
 		via_irq_disable(IRQ_MAC_NUBUS);
 		via_irq_clear(IRQ_MAC_NUBUS);
-		mac_do_irq_list(IRQ_MAC_NUBUS, regs);
+		m68k_handle_int(IRQ_MAC_NUBUS, regs);
 		via_irq_enable(IRQ_MAC_NUBUS);
 	}
 #endif
@@ -459,7 +459,7 @@ irqreturn_t via2_irq(int irq, void *dev_
 		if (events & irq_bit) {
 			via2[gIER] = irq_bit;
 			via2[gIFR] = irq_bit | rbv_clear;
-			mac_do_irq_list(VIA2_SOURCE_BASE + i, regs);
+			m68k_handle_int(VIA2_SOURCE_BASE + i, regs);
 			via2[gIER] = irq_bit | 0x80;
 		}
 	return IRQ_HANDLED;
@@ -481,7 +481,7 @@ irqreturn_t via_nubus_irq(int irq, void 
 	for (i = 0, irq_bit = 1 ; i < 7 ; i++, irq_bit <<= 1) {
 		if (events & irq_bit) {
 			via_irq_disable(NUBUS_SOURCE_BASE + i);
-			mac_do_irq_list(NUBUS_SOURCE_BASE + i, regs);
+			m68k_handle_int(NUBUS_SOURCE_BASE + i, regs);
 			via_irq_enable(NUBUS_SOURCE_BASE + i);
 		}
 	}
diff --git a/drivers/scsi/mac_esp.c b/drivers/scsi/mac_esp.c
index e31fadd..118206d 100644
--- a/drivers/scsi/mac_esp.c
+++ b/drivers/scsi/mac_esp.c
@@ -43,9 +43,6 @@ #include <asm/macintosh.h>
 
 /* #define DEBUG_MAC_ESP */
 
-#define mac_turnon_irq(x)	mac_enable_irq(x)
-#define mac_turnoff_irq(x)	mac_disable_irq(x)
-
 extern void esp_handle(struct NCR_ESP *esp);
 extern void mac_esp_intr(int irq, void *dev_id, struct pt_regs *pregs);
 
@@ -639,13 +636,13 @@ static void dma_init_write(struct NCR_ES
 
 static void dma_ints_off(struct NCR_ESP * esp)
 {
-	mac_turnoff_irq(esp->irq);
+	disable_irq(esp->irq);
 }
 
 
 static void dma_ints_on(struct NCR_ESP * esp)
 {
-	mac_turnon_irq(esp->irq);
+	enable_irq(esp->irq);
 }
 
 /*
diff --git a/drivers/scsi/mac_scsi.c b/drivers/scsi/mac_scsi.c
index 777f9bc..a942a21 100644
--- a/drivers/scsi/mac_scsi.c
+++ b/drivers/scsi/mac_scsi.c
@@ -65,9 +65,6 @@ #endif
 #define RESET_BOOT
 #define DRIVER_SETUP
 
-#define	ENABLE_IRQ()	mac_enable_irq( IRQ_MAC_SCSI ); 
-#define	DISABLE_IRQ()	mac_disable_irq( IRQ_MAC_SCSI );
-
 extern void via_scsi_clear(void);
 
 #ifdef RESET_BOOT
@@ -351,7 +348,7 @@ static void mac_scsi_reset_boot(struct S
 	printk(KERN_INFO "Macintosh SCSI: resetting the SCSI bus..." );
 
 	/* switch off SCSI IRQ - catch an interrupt without IRQ bit set else */
-	mac_disable_irq(IRQ_MAC_SCSI);
+	disable_irq(IRQ_MAC_SCSI);
 
 	/* get in phase */
 	NCR5380_write( TARGET_COMMAND_REG,
@@ -369,7 +366,7 @@ static void mac_scsi_reset_boot(struct S
 		barrier();
 
 	/* switch on SCSI IRQ again */
-	mac_enable_irq(IRQ_MAC_SCSI);
+	enable_irq(IRQ_MAC_SCSI);
 
 	printk(KERN_INFO " done\n" );
 }
diff --git a/include/asm-m68k/mac_oss.h b/include/asm-m68k/mac_oss.h
index 7644a63..7221f72 100644
--- a/include/asm-m68k/mac_oss.h
+++ b/include/asm-m68k/mac_oss.h
@@ -69,12 +69,12 @@ #define OSS_POWEROFF	0x80
 
 #define OSS_IRQLEV_DISABLED	0
 #define OSS_IRQLEV_IOPISM	1	/* ADB? */
-#define OSS_IRQLEV_SCSI		2
-#define OSS_IRQLEV_NUBUS	3	/* keep this on its own level */
-#define OSS_IRQLEV_IOPSCC	4	/* matches VIA alternate mapping */
-#define OSS_IRQLEV_SOUND	5	/* matches VIA alternate mapping */
+#define OSS_IRQLEV_SCSI		IRQ_AUTO_2
+#define OSS_IRQLEV_NUBUS	IRQ_AUTO_3	/* keep this on its own level */
+#define OSS_IRQLEV_IOPSCC	IRQ_AUTO_4	/* matches VIA alternate mapping */
+#define OSS_IRQLEV_SOUND	IRQ_AUTO_5	/* matches VIA alternate mapping */
 #define OSS_IRQLEV_60HZ		6	/* matches VIA alternate mapping */
-#define OSS_IRQLEV_VIA1		6	/* matches VIA alternate mapping */
+#define OSS_IRQLEV_VIA1		IRQ_AUTO_6	/* matches VIA alternate mapping */
 #define OSS_IRQLEV_PARITY	7	/* matches VIA alternate mapping */
 
 #ifndef __ASSEMBLY__
diff --git a/include/asm-m68k/macintosh.h b/include/asm-m68k/macintosh.h
index 6fc3d19..27d11da 100644
--- a/include/asm-m68k/macintosh.h
+++ b/include/asm-m68k/macintosh.h
@@ -11,17 +11,7 @@ #include <linux/interrupt.h>
 extern void mac_reset(void);
 extern void mac_poweroff(void);
 extern void mac_init_IRQ(void);
-extern int mac_request_irq (unsigned int, irqreturn_t (*)(int, void *,
-				struct pt_regs *),
-				unsigned long, const char *, void *);
-extern void mac_free_irq(unsigned int, void *);
-extern void mac_enable_irq(unsigned int);
-extern void mac_disable_irq(unsigned int);
 extern int mac_irq_pending(unsigned int);
-extern int show_mac_interrupts(struct seq_file *, void *);
-#if 0
-extern void mac_default_handler(int irq);
-#endif
 extern void mac_identify(void);
 extern void mac_report_hardware(void);
 extern void mac_debugging_penguin(int);
diff --git a/include/asm-m68k/macints.h b/include/asm-m68k/macints.h
index c9604f8..679c48a 100644
--- a/include/asm-m68k/macints.h
+++ b/include/asm-m68k/macints.h
@@ -152,7 +152,4 @@ #define IRQ2SLOT(x)	  (x - 47)
 #define INT_CLK   24576	    /* CLK while int_clk =2.456MHz and divide = 100 */
 #define INT_TICKS 246	    /* to make sched_time = 99.902... HZ */
 
-extern irq_node_t *mac_irq_list[NUM_MAC_SOURCES];
-extern void mac_do_irq_list(int irq, struct pt_regs *);
-
 #endif /* asm/macints.h */
-- 
1.3.3

--

