Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266149AbUF3AYq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266149AbUF3AYq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 20:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266150AbUF3AYq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 20:24:46 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:61876 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S266149AbUF3AY1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 20:24:27 -0400
Date: Tue, 29 Jun 2004 15:42:02 -0500
From: linas@austin.ibm.com
To: paulus@au1.ibm.com, paulus@samba.org
Cc: linuxppc64-dev@lists.linuxppc.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PPC64: (resend) Janitor signature of rtas_call() routine
Message-ID: <20040629154202.N21634@forte.austin.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="zCKi3GIZzVBPywwA"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--zCKi3GIZzVBPywwA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Hi Paul,
                                                                                
Can you please apply the following patch to the ameslab ppc64
tree, and/or roll it upwards to the marclello 2.6 tree?
This path is 100% pure cleanup; no functional changes.
                                                                                
I got irritated when I was given a -1 that was cast to an unsigned
int that was then cast to a signed (64-bit) long, and so I received
a value of 4 billion instead of -1.  This patch fixes this insanity.
                                                                                
Different files were treating this return code as being signed
or unsigned, 32-bit or 64-bit.  The 'real' return code is always
a signed 32-bit quantity, so this patch just makes the usage
consistent across the board.
                                                                                
Signed-off-by: Linas Vepstas <linas@linas.org>
                                                                                
--linas

--zCKi3GIZzVBPywwA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="rtas_call_sign.patch"

===== arch/ppc64/kernel/chrp_setup.c 1.62 vs edited =====
--- 1.62/arch/ppc64/kernel/chrp_setup.c	Sat May  1 07:12:21 2004
+++ edited/arch/ppc64/kernel/chrp_setup.c	Tue Jun 29 12:03:50 2004
@@ -189,7 +189,7 @@
  */
 void __init fwnmi_init(void)
 {
-	long ret;
+	int ret;
 	int ibm_nmi_register = rtas_token("ibm,nmi-register");
 	if (ibm_nmi_register == RTAS_UNKNOWN_SERVICE)
 		return;
===== arch/ppc64/kernel/eeh.c 1.30 vs edited =====
--- 1.30/arch/ppc64/kernel/eeh.c	Thu Jun  3 17:06:03 2004
+++ edited/arch/ppc64/kernel/eeh.c	Tue Jun 29 14:21:45 2004
@@ -408,7 +408,7 @@
 {
 	struct list_head	*tmp, *n;
 	struct eeh_event	*event;
-	unsigned long		log_event;
+	int    log_event;
 	int			rc;
 
 	spin_lock(&eeh_eventlist_lock);
@@ -467,7 +467,8 @@
 	unsigned long addr;
 	struct pci_dev *dev;
 	struct device_node *dn;
-	unsigned long ret, rets[2];
+	unsigned long rets[2];
+	int ret;
 
 	__get_cpu_var(total_mmio_ffs)++;
 
@@ -547,7 +548,7 @@
 static void *early_enable_eeh(struct device_node *dn, void *data)
 {
 	struct eeh_early_enable_info *info = data;
-	long ret;
+	int ret;
 	char *status = get_property(dn, "status", 0);
 	u32 *class_code = (u32 *)get_property(dn, "class-code", 0);
 	u32 *vendor_id = (u32 *)get_property(dn, "vendor-id", 0);
===== arch/ppc64/kernel/lparcfg.c 1.16 vs edited =====
--- 1.16/arch/ppc64/kernel/lparcfg.c	Thu Apr 29 11:32:57 2004
+++ edited/arch/ppc64/kernel/lparcfg.c	Tue Jun 29 12:00:18 2004
@@ -208,7 +208,7 @@
  */
 static void parse_system_parameter_string(struct seq_file *m)
 {
-	long call_status;
+	int call_status;
 	unsigned long ret[2];
 
 	char * local_buffer = kmalloc(SPLPAR_MAXLENGTH, GFP_KERNEL);
@@ -229,7 +229,7 @@
 	spin_unlock(&rtas_data_buf_lock);
 
 	if (call_status!=0) {
-		printk(KERN_INFO "%s %s Error calling get-system-parameter (0x%lx)\n",__FILE__,__FUNCTION__,call_status);
+		printk(KERN_INFO "%s %s Error calling get-system-parameter (0x%x)\n",__FILE__,__FUNCTION__,call_status);
 	} else {
 		int splpar_strlen;
 		int idx,w_idx;
===== arch/ppc64/kernel/ras.c 1.18 vs edited =====
--- 1.18/arch/ppc64/kernel/ras.c	Mon Apr 12 23:04:32 2004
+++ edited/arch/ppc64/kernel/ras.c	Tue Jun 29 12:12:58 2004
@@ -124,7 +124,7 @@
 {
 	struct rtas_error_log log_entry;
 	unsigned int size = sizeof(log_entry);
-	long status = 0xdeadbeef;
+	int status = 0xdeadbeef;
 
 	spin_lock(&log_lock);
 
@@ -138,10 +138,10 @@
 
 	spin_unlock(&log_lock);
 
-	udbg_printf("EPOW <0x%lx 0x%lx>\n", 
+	udbg_printf("EPOW <0x%lx 0x%x>\n", 
 		    *((unsigned long *)&log_entry), status); 
 	printk(KERN_WARNING 
-		"EPOW <0x%lx 0x%lx>\n",*((unsigned long *)&log_entry), status);
+		"EPOW <0x%lx 0x%x>\n",*((unsigned long *)&log_entry), status);
 
 	/* format and print the extended information */
 	log_error((char *)&log_entry, ERR_TYPE_RTAS_LOG, 0);
@@ -162,7 +162,7 @@
 {
 	struct rtas_error_log log_entry;
 	unsigned int size = sizeof(log_entry);
-	long status = 0xdeadbeef;
+	int status = 0xdeadbeef;
 	int fatal;
 
 	spin_lock(&log_lock);
@@ -186,10 +186,10 @@
 	log_error((char *)&log_entry, ERR_TYPE_RTAS_LOG, fatal); 
 
 	if (fatal) {
-		udbg_printf("HW Error <0x%lx 0x%lx>\n",
+		udbg_printf("HW Error <0x%lx 0x%x>\n",
 			    *((unsigned long *)&log_entry), status);
 		printk(KERN_EMERG 
-		       "Error: Fatal hardware error <0x%lx 0x%lx>\n",
+		       "Error: Fatal hardware error <0x%lx 0x%x>\n",
 		       *((unsigned long *)&log_entry), status);
 
 #ifndef DEBUG
@@ -200,10 +200,10 @@
 		ppc_md.power_off();
 #endif
 	} else {
-		udbg_printf("Recoverable HW Error <0x%lx 0x%lx>\n",
+		udbg_printf("Recoverable HW Error <0x%lx 0x%x>\n",
 			    *((unsigned long *)&log_entry), status); 
 		printk(KERN_WARNING 
-		       "Warning: Recoverable hardware error <0x%lx 0x%lx>\n",
+		       "Warning: Recoverable hardware error <0x%lx 0x%x>\n",
 		       *((unsigned long *)&log_entry), status);
 	}
 	return IRQ_HANDLED;
===== arch/ppc64/kernel/rtas.c 1.45 vs edited =====
--- 1.45/arch/ppc64/kernel/rtas.c	Fri Jun 18 21:17:30 2004
+++ edited/arch/ppc64/kernel/rtas.c	Tue Jun 29 12:13:46 2004
@@ -139,7 +139,7 @@
 		log_error(rtas_err_buf, ERR_TYPE_RTAS_LOG, 0);
 }
 
-long
+int
 rtas_call(int token, int nargs, int nret,
 	  unsigned long *outputs, ...)
 {
@@ -147,7 +147,7 @@
 	int i, logit = 0;
 	unsigned long s;
 	struct rtas_args *rtas_args;
-	long ret;
+	int ret;
 
 	PPCDBG(PPCDBG_RTAS, "Entering rtas_call\n");
 	PPCDBG(PPCDBG_RTAS, "\ttoken    = 0x%x\n", token);
@@ -191,7 +191,7 @@
 	if (nret > 1 && outputs != NULL)
 		for (i = 0; i < nret-1; ++i)
 			outputs[i] = rtas_args->rets[i+1];
-	ret = (ulong)((nret > 0) ? rtas_args->rets[0] : 0);
+	ret = (int)((nret > 0) ? rtas_args->rets[0] : 0);
 
 	/* Gotta do something different here, use global lock for now... */
 	spin_unlock_irqrestore(&rtas.lock, s);
@@ -234,7 +234,7 @@
 		return RTAS_UNKNOWN_OP;
 
 	while(1) {
-		rc = (int) rtas_call(token, 1, 2, &powerlevel, powerdomain);
+		rc = rtas_call(token, 1, 2, &powerlevel, powerdomain);
 		if (rc == RTAS_BUSY)
 			udelay(1);
 		else
@@ -256,7 +256,7 @@
 		return RTAS_UNKNOWN_OP;
 
 	while (1) {
-		rc = (int) rtas_call(token, 2, 2, &returned_level, powerdomain,
+		rc = rtas_call(token, 2, 2, &returned_level, powerdomain,
 					level);
 		if (rc == RTAS_BUSY)
 			udelay(1);
@@ -283,7 +283,7 @@
 		return RTAS_UNKNOWN_OP;
 
 	while (1) {
-		rc = (int) rtas_call(token, 2, 2, &returned_state, sensor,
+		rc = rtas_call(token, 2, 2, &returned_state, sensor,
 					index);
 		if (rc == RTAS_BUSY)
 			udelay(1);
@@ -309,7 +309,7 @@
 		return RTAS_UNKNOWN_OP;
 
 	while (1) {
-		rc = (int) rtas_call(token, 3, 1, NULL, indicator, index,
+		rc = rtas_call(token, 3, 1, NULL, indicator, index,
 					new_value);
 		if (rc == RTAS_BUSY)
 			udelay(1);
@@ -409,7 +409,7 @@
 	if (rtas_firmware_flash_list.next)
 		rtas_flash_firmware();
 
-        printk("RTAS system-reboot returned %ld\n",
+        printk("RTAS system-reboot returned %d\n",
 	       rtas_call(rtas_token("system-reboot"), 0, 1, NULL));
         for (;;);
 }
@@ -420,7 +420,7 @@
 	if (rtas_firmware_flash_list.next)
 		rtas_flash_bypass_warning();
         /* allow power on only with power button press */
-        printk("RTAS power-off returned %ld\n",
+        printk("RTAS power-off returned %d\n",
                rtas_call(rtas_token("power-off"), 2, 1, NULL,0xffffffff,0xffffffff));
         for (;;);
 }
@@ -438,7 +438,7 @@
 
 void rtas_os_term(char *str)
 {
-	long status;
+	int status;
 
 	snprintf(rtas_os_term_buf, 2048, "OS panic: %s", str);
 
@@ -449,7 +449,7 @@
 		if (status == RTAS_BUSY)
 			udelay(1);
 		else if (status != 0)
-			printk(KERN_EMERG "ibm,os-term call failed %ld\n",
+			printk(KERN_EMERG "ibm,os-term call failed %d\n",
 			       status);
 	} while (status == RTAS_BUSY);
 }
===== arch/ppc64/kernel/scanlog.c 1.8 vs edited =====
--- 1.8/arch/ppc64/kernel/scanlog.c	Tue Mar 16 18:46:46 2004
+++ edited/arch/ppc64/kernel/scanlog.c	Tue Jun 29 11:57:03 2004
@@ -49,7 +49,7 @@
         struct inode * inode = file->f_dentry->d_inode;
 	struct proc_dir_entry *dp;
 	unsigned int *data;
-	unsigned long status;
+	int status;
 	unsigned long len, off;
 	unsigned int wait_time;
 
@@ -85,7 +85,7 @@
 		memcpy(data, rtas_data_buf, RTAS_DATA_BUF_SIZE);
 		spin_unlock(&rtas_data_buf_lock);
 
-		DEBUG("status=%ld, data[0]=%x, data[1]=%x, data[2]=%x\n",
+		DEBUG("status=%d, data[0]=%x, data[1]=%x, data[2]=%x\n",
 		      status, data[0], data[1], data[2]);
 		switch (status) {
 		    case SCANLOG_COMPLETE:
@@ -118,7 +118,7 @@
 				wait_time = ms / (1000000/HZ); /* round down is fine */
 				/* Fall through to sleep */
 			} else {
-				printk(KERN_ERR "scanlog: unknown error from rtas: %ld\n", status);
+				printk(KERN_ERR "scanlog: unknown error from rtas: %d\n", status);
 				return -EIO;
 			}
 		}
@@ -133,7 +133,7 @@
 			     size_t count, loff_t *ppos)
 {
 	char stkbuf[20];
-	unsigned long status;
+	int status;
 
 	if (count > 19) count = 19;
 	if (copy_from_user (stkbuf, buf, count)) {
@@ -145,7 +145,7 @@
 		if (strncmp(stkbuf, "reset", 5) == 0) {
 			DEBUG("reset scanlog\n");
 			status = rtas_call(ibm_scan_log_dump, 2, 1, NULL, NULL, 0);
-			DEBUG("rtas returns %ld\n", status);
+			DEBUG("rtas returns %d\n", status);
 		} else if (strncmp(stkbuf, "debugon", 7) == 0) {
 			printk(KERN_ERR "scanlog: debug on\n");
 			scanlog_debug = 1;
===== arch/ppc64/kernel/xics.c 1.56 vs edited =====
--- 1.56/arch/ppc64/kernel/xics.c	Wed May 26 18:59:02 2004
+++ edited/arch/ppc64/kernel/xics.c	Tue Jun 29 12:17:50 2004
@@ -276,7 +276,7 @@
 static void xics_enable_irq(unsigned int virq)
 {
 	unsigned int irq;
-	long call_status;
+	int call_status;
 	unsigned int server;
 
 	irq = virt_irq_to_real(irq_offset_down(virq));
@@ -288,7 +288,7 @@
 				DEFAULT_PRIORITY);
 	if (call_status != 0) {
 		printk(KERN_ERR "xics_enable_irq: irq=%x: ibm_set_xive "
-		       "returned %lx\n", irq, call_status);
+		       "returned %x\n", irq, call_status);
 		return;
 	}
 
@@ -296,14 +296,14 @@
 	call_status = rtas_call(ibm_int_on, 1, 1, NULL, irq);
 	if (call_status != 0) {
 		printk(KERN_ERR "xics_enable_irq: irq=%x: ibm_int_on "
-		       "returned %lx\n", irq, call_status);
+		       "returned %x\n", irq, call_status);
 		return;
 	}
 }
 
 static void xics_disable_real_irq(unsigned int irq)
 {
-	long call_status;
+	int call_status;
 	unsigned int server;
 
 	if (irq == XICS_IPI)
@@ -312,7 +312,7 @@
 	call_status = rtas_call(ibm_int_off, 1, 1, NULL, irq);
 	if (call_status != 0) {
 		printk(KERN_ERR "xics_disable_real_irq: irq=%x: "
-		       "ibm_int_off returned %lx\n", irq, call_status);
+		       "ibm_int_off returned %x\n", irq, call_status);
 		return;
 	}
 
@@ -321,7 +321,7 @@
 	call_status = rtas_call(ibm_set_xive, 3, 1, NULL, irq, server, 0xff);
 	if (call_status != 0) {
 		printk(KERN_ERR "xics_disable_irq: irq=%x: ibm_set_xive(0xff)"
-		       " returned %lx\n", irq, call_status);
+		       " returned %x\n", irq, call_status);
 		return;
 	}
 }
@@ -613,7 +613,7 @@
 static void xics_set_affinity(unsigned int virq, cpumask_t cpumask)
 {
 	unsigned int irq;
-	long status;
+	int status;
 	unsigned long xics_status[2];
 	unsigned long newmask;
 	cpumask_t allcpus = CPU_MASK_ALL;
@@ -627,7 +627,7 @@
 
 	if (status) {
 		printk(KERN_ERR "xics_set_affinity: irq=%d ibm,get-xive "
-		       "returns %ld\n", irq, status);
+		       "returns %d\n", irq, status);
 		return;
 	}
 
@@ -646,7 +646,7 @@
 
 	if (status) {
 		printk(KERN_ERR "xics_set_affinity irq=%d ibm,set-xive "
-		       "returns %ld\n", irq, status);
+		       "returns %d\n", irq, status);
 		return;
 	}
 }
@@ -658,7 +658,7 @@
 {
 	int set_indicator = rtas_token("set-indicator");
 	const unsigned long giqs = 9005UL; /* Global Interrupt Queue Server */
-	unsigned long status = 0;
+	unsigned int status = 0;
 	unsigned int irq, cpu = smp_processor_id();
 	unsigned long xics_status[2];
 	unsigned long flags;
@@ -698,7 +698,7 @@
 				   irq);
 		if (status) {
 			printk(KERN_ERR "migrate_irqs_away: irq=%d "
-					"ibm,get-xive returns %ld\n",
+					"ibm,get-xive returns %d\n",
 					irq, status);
 			goto unlock;
 		}
@@ -721,7 +721,7 @@
 				irq, xics_status[0], xics_status[1]);
 		if (status)
 			printk(KERN_ERR "migrate_irqs_away irq=%d "
-					"ibm,set-xive returns %ld\n",
+					"ibm,set-xive returns %d\n",
 					irq, status);
 
 unlock:
===== include/asm-ppc64/rtas.h 1.26 vs edited =====
--- 1.26/include/asm-ppc64/rtas.h	Sat May 22 00:22:39 2004
+++ edited/include/asm-ppc64/rtas.h	Tue Jun 29 11:40:16 2004
@@ -168,7 +168,7 @@
 
 extern void enter_rtas(unsigned long);
 extern int rtas_token(const char *service);
-extern long rtas_call(int token, int, int, unsigned long *, ...);
+extern int rtas_call(int token, int, int, unsigned long *, ...);
 extern void call_rtas_display_status(char);
 extern void rtas_restart(char *cmd);
 extern void rtas_power_off(void);

--zCKi3GIZzVBPywwA--
