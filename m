Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268101AbUGWWGK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268101AbUGWWGK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 18:06:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268107AbUGWWGJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 18:06:09 -0400
Received: from ozlabs.org ([203.10.76.45]:43444 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S268101AbUGWWFg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 18:05:36 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16641.35625.461106.646666@cargo.ozlabs.ibm.com>
Date: Fri, 23 Jul 2004 18:03:21 -0400
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, anton@samba.org, nfont@austin.ibm.com
Subject: [PATCH] PPC64 Fix RAS irq handlers
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On pSeries systems, the firmware tells us a list of interrupt numbers
that we should enable in order to detect various error conditions.
When we get one of these interrupts we are supposed to call the
firmware, which will work out and tell us what the error was and
possibly also fix it.

We were not correctly parsing the property values that tell us which
interrupts need to be handled in this fashion.  This patch fixes it.
It exports prom_n_intr_cells from prom.c since that is needed to do
the parsing properly.

Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN --exclude SCCS linux-2.5/arch/ppc64/kernel/prom.c test25/arch/ppc64/kernel/prom.c
--- linux-2.5/arch/ppc64/kernel/prom.c	2004-07-24 04:25:06.000000000 +1000
+++ test25/arch/ppc64/kernel/prom.c	2004-07-24 06:47:21.000000000 +1000
@@ -1881,8 +1881,7 @@
  * Find out the size of each entry of the interrupts property
  * for a node.
  */
-static int __devinit
-prom_n_intr_cells(struct device_node *np)
+int __devinit prom_n_intr_cells(struct device_node *np)
 {
 	struct device_node *p;
 	unsigned int *icp;
@@ -1896,7 +1895,7 @@
 		    || get_property(p, "interrupt-map", NULL) != NULL) {
 			printk("oops, node %s doesn't have #interrupt-cells\n",
 			       p->full_name);
-		return 1;
+			return 1;
 		}
 	}
 #ifdef DEBUG_IRQ
diff -urN --exclude SCCS linux-2.5/arch/ppc64/kernel/ras.c test25/arch/ppc64/kernel/ras.c
--- linux-2.5/arch/ppc64/kernel/ras.c	2004-07-05 11:49:19.000000000 +1000
+++ test25/arch/ppc64/kernel/ras.c	2004-07-24 07:53:04.086893568 +1000
@@ -52,6 +52,16 @@
 #include <asm/rtas.h>
 #include <asm/ppcdebug.h>
 
+static unsigned char log_buf[RTAS_ERROR_LOG_MAX];
+static spinlock_t log_lock = SPIN_LOCK_UNLOCKED;
+
+static int ras_get_sensor_state_token;
+static int ras_check_exception_token;
+
+#define EPOW_SENSOR_TOKEN	9
+#define EPOW_SENSOR_INDEX	0
+#define RAS_VECTOR_OFFSET	0x500
+
 static irqreturn_t ras_epow_interrupt(int irq, void *dev_id,
 					struct pt_regs * regs);
 static irqreturn_t ras_error_interrupt(int irq, void *dev_id,
@@ -59,6 +69,35 @@
 
 /* #define DEBUG */
 
+static void request_ras_irqs(struct device_node *np, char *propname,
+			irqreturn_t (*handler)(int, void *, struct pt_regs *),
+			const char *name)
+{
+	unsigned int *ireg, len, i;
+	int virq, n_intr;
+
+	ireg = (unsigned int *)get_property(np, propname, &len);
+	if (ireg == NULL)
+		return;
+	n_intr = prom_n_intr_cells(np);
+	len /= n_intr * sizeof(*ireg);
+
+	for (i = 0; i < len; i++) {
+		virq = virt_irq_create_mapping(*ireg);
+		if (virq == NO_IRQ) {
+			printk(KERN_ERR "Unable to allocate interrupt "
+			       "number for %s\n", np->full_name);
+			return;
+		}
+		if (request_irq(irq_offset_up(virq), handler, 0, name, NULL)) {
+			printk(KERN_ERR "Unable to request interrupt %d for "
+			       "%s\n", irq_offset_up(virq), np->full_name);
+			return;
+		}
+		ireg += n_intr;
+	}
+}
+
 /*
  * Initialize handlers for the set of interrupts caused by hardware errors
  * and power system events.
@@ -66,52 +105,34 @@
 static int __init init_ras_IRQ(void)
 {
 	struct device_node *np;
-	unsigned int *ireg, len, i;
-	int virq;
 
-	if ((np = of_find_node_by_path("/event-sources/internal-errors")) &&
-	    (ireg = (unsigned int *)get_property(np, "open-pic-interrupt",
-						 &len))) {
-		for (i=0; i<(len / sizeof(*ireg)); i++) {
-			virq = virt_irq_create_mapping(*(ireg));
-			if (virq == NO_IRQ) {
-				printk(KERN_ERR "Unable to allocate interrupt "
-				       "number for %s\n", np->full_name);
-				break;
-			}
-			request_irq(irq_offset_up(virq),
-				    ras_error_interrupt, 0, 
-				    "RAS_ERROR", NULL);
-			ireg++;
-		}
+	ras_get_sensor_state_token = rtas_token("get-sensor-state");
+	ras_check_exception_token = rtas_token("check-exception");
+
+	/* Internal Errors */
+	np = of_find_node_by_path("/event-sources/internal-errors");
+	if (np != NULL) {
+		request_ras_irqs(np, "open-pic-interrupt", ras_error_interrupt,
+				 "RAS_ERROR");
+		request_ras_irqs(np, "interrupts", ras_error_interrupt,
+				 "RAS_ERROR");
+		of_node_put(np);
 	}
-	of_node_put(np);
 
-	if ((np = of_find_node_by_path("/event-sources/epow-events")) &&
-	    (ireg = (unsigned int *)get_property(np, "open-pic-interrupt",
-						 &len))) {
-		for (i=0; i<(len / sizeof(*ireg)); i++) {
-			virq = virt_irq_create_mapping(*(ireg));
-			if (virq == NO_IRQ) {
-				printk(KERN_ERR "Unable to allocate interrupt "
-				       " number for %s\n", np->full_name);
-				break;
-			}
-			request_irq(irq_offset_up(virq),
-				    ras_epow_interrupt, 0, 
-				    "RAS_EPOW", NULL);
-			ireg++;
-		}
+	/* EPOW Events */
+	np = of_find_node_by_path("/event-sources/epow-events");
+	if (np != NULL) {
+		request_ras_irqs(np, "open-pic-interrupt", ras_epow_interrupt,
+				 "RAS_EPOW");
+		request_ras_irqs(np, "interrupts", ras_epow_interrupt,
+				 "RAS_EPOW");
+		of_node_put(np);
 	}
-	of_node_put(np);
 
 	return 1;
 }
 __initcall(init_ras_IRQ);
 
-static struct rtas_error_log log_buf;
-static spinlock_t log_lock = SPIN_LOCK_UNLOCKED;
-
 /*
  * Handle power subsystem events (EPOW).
  *
@@ -122,30 +143,35 @@
 static irqreturn_t
 ras_epow_interrupt(int irq, void *dev_id, struct pt_regs * regs)
 {
-	struct rtas_error_log log_entry;
-	unsigned int size = sizeof(log_entry);
 	int status = 0xdeadbeef;
+	int state = 0;
+	int critical;
 
-	spin_lock(&log_lock);
+	status = rtas_call(ras_get_sensor_state_token, 2, 2, &state,
+			   EPOW_SENSOR_TOKEN, EPOW_SENSOR_INDEX);
 
-	status = rtas_call(rtas_token("check-exception"), 6, 1, NULL, 
-			   0x500, irq, 
-			   RTAS_EPOW_WARNING | RTAS_POWERMGM_EVENTS, 
-			   1,  /* Time Critical */
-			   __pa(&log_buf), size);
-
-	log_entry = log_buf;
+	if (state > 3)
+		critical = 1;  /* Time Critical */
+	else
+		critical = 0;
 
-	spin_unlock(&log_lock);
+	spin_lock(&log_lock);
 
-	udbg_printf("EPOW <0x%lx 0x%x>\n",
-		    *((unsigned long *)&log_entry), status); 
-	printk(KERN_WARNING 
-		"EPOW <0x%lx 0x%x>\n",*((unsigned long *)&log_entry), status);
+	status = rtas_call(ras_check_exception_token, 6, 1, NULL,
+			   RAS_VECTOR_OFFSET,
+			   virt_irq_to_real(irq_offset_down(irq)),
+			   RTAS_EPOW_WARNING | RTAS_POWERMGM_EVENTS,
+			   critical, __pa(&log_buf), RTAS_ERROR_LOG_MAX);
+
+	udbg_printf("EPOW <0x%lx 0x%x 0x%x>\n",
+		    *((unsigned long *)&log_buf), status, state);
+	printk(KERN_WARNING "EPOW <0x%lx 0x%x 0x%x>\n",
+	       *((unsigned long *)&log_buf), status, state);
 
 	/* format and print the extended information */
-	log_error((char *)&log_entry, ERR_TYPE_RTAS_LOG, 0);
-	
+	log_error(log_buf, ERR_TYPE_RTAS_LOG, 0);
+
+	spin_unlock(&log_lock);
 	return IRQ_HANDLED;
 }
 
@@ -160,37 +186,33 @@
 static irqreturn_t
 ras_error_interrupt(int irq, void *dev_id, struct pt_regs * regs)
 {
-	struct rtas_error_log log_entry;
-	unsigned int size = sizeof(log_entry);
+	struct rtas_error_log *rtas_elog;
 	int status = 0xdeadbeef;
 	int fatal;
 
 	spin_lock(&log_lock);
 
-	status = rtas_call(rtas_token("check-exception"), 6, 1, NULL, 
-			   0x500, irq, 
-			   RTAS_INTERNAL_ERROR, 
-			   1, /* Time Critical */
-			   __pa(&log_buf), size);
+	status = rtas_call(ras_check_exception_token, 6, 1, NULL,
+			   RAS_VECTOR_OFFSET,
+			   virt_irq_to_real(irq_offset_down(irq)),
+			   RTAS_INTERNAL_ERROR, 1 /*Time Critical */,
+			   __pa(&log_buf), RTAS_ERROR_LOG_MAX);
 
-	log_entry = log_buf;
+	rtas_elog = (struct rtas_error_log *)log_buf;
 
-	spin_unlock(&log_lock);
-
-	if ((status == 0) && (log_entry.severity >= SEVERITY_ERROR_SYNC)) 
+	if ((status == 0) && (rtas_elog->severity >= SEVERITY_ERROR_SYNC))
 		fatal = 1;
 	else
 		fatal = 0;
 
 	/* format and print the extended information */
-	log_error((char *)&log_entry, ERR_TYPE_RTAS_LOG, fatal); 
+	log_error(log_buf, ERR_TYPE_RTAS_LOG, fatal);
 
 	if (fatal) {
-		udbg_printf("HW Error <0x%lx 0x%x>\n",
-			    *((unsigned long *)&log_entry), status);
-		printk(KERN_EMERG 
-		       "Error: Fatal hardware error <0x%lx 0x%x>\n",
-		       *((unsigned long *)&log_entry), status);
+		udbg_printf("Fatal HW Error <0x%lx 0x%x>\n",
+			    *((unsigned long *)&log_buf), status);
+		printk(KERN_EMERG "Error: Fatal hardware error <0x%lx 0x%x>\n",
+		       *((unsigned long *)&log_buf), status);
 
 #ifndef DEBUG
 		/* Don't actually power off when debugging so we can test
@@ -201,10 +223,12 @@
 #endif
 	} else {
 		udbg_printf("Recoverable HW Error <0x%lx 0x%x>\n",
-			    *((unsigned long *)&log_entry), status); 
-		printk(KERN_WARNING 
+			    *((unsigned long *)&log_buf), status);
+		printk(KERN_WARNING
 		       "Warning: Recoverable hardware error <0x%lx 0x%x>\n",
-		       *((unsigned long *)&log_entry), status);
+		       *((unsigned long *)&log_buf), status);
 	}
+
+	spin_unlock(&log_lock);
 	return IRQ_HANDLED;
 }
diff -urN --exclude SCCS linux-2.5/include/asm-ppc64/prom.h test25/include/asm-ppc64/prom.h
--- linux-2.5/include/asm-ppc64/prom.h	2004-06-25 07:03:04.000000000 +1000
+++ test25/include/asm-ppc64/prom.h	2004-07-24 06:47:21.000000000 +1000
@@ -269,6 +269,7 @@
 extern void print_properties(struct device_node *node);
 extern int prom_n_addr_cells(struct device_node* np);
 extern int prom_n_size_cells(struct device_node* np);
+extern int prom_n_intr_cells(struct device_node* np);
 extern void prom_get_irq_senses(unsigned char *senses, int off, int max);
 extern void prom_add_property(struct device_node* np, struct property* prop);
 
