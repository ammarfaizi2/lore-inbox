Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266647AbUF3MLu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266647AbUF3MLu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 08:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266644AbUF3MLh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 08:11:37 -0400
Received: from ozlabs.org ([203.10.76.45]:2529 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S266630AbUF3ML2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 08:11:28 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16610.43843.674814.312740@cargo.ozlabs.ibm.com>
Date: Wed, 30 Jun 2004 22:00:03 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: linas@austin.ibm.com, linuxppc64-dev@lists.linuxppc.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] ppc64: Janitor rtas_call() return variables
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Recently I changed the return value of rtas_call() from an unsigned
long to an int.  That patch missed a few places where we declare a
variable to store the result from rtas_call().  This new patch changes
those places to use an int variable instead of a long or unsigned long
variable.  Linas Vepstas pointed this out.

Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN linux-2.5/arch/ppc64/kernel/chrp_setup.c ppc64-2.5-pseries/arch/ppc64/kernel/chrp_setup.c
--- linux-2.5/arch/ppc64/kernel/chrp_setup.c	2004-06-30 22:01:50.030973712 +1000
+++ ppc64-2.5-pseries/arch/ppc64/kernel/chrp_setup.c	2004-06-30 21:36:26.000000000 +1000
@@ -189,7 +189,7 @@
  */
 void __init fwnmi_init(void)
 {
-	long ret;
+	int ret;
 	int ibm_nmi_register = rtas_token("ibm,nmi-register");
 	if (ibm_nmi_register == RTAS_UNKNOWN_SERVICE)
 		return;
diff -urN linux-2.5/arch/ppc64/kernel/eeh.c ppc64-2.5-pseries/arch/ppc64/kernel/eeh.c
--- linux-2.5/arch/ppc64/kernel/eeh.c	2004-06-30 22:01:50.031973560 +1000
+++ ppc64-2.5-pseries/arch/ppc64/kernel/eeh.c	2004-06-30 21:42:50.000000000 +1000
@@ -366,7 +366,7 @@
 	unsigned long addr;
 	struct pci_dev *dev;
 	struct device_node *dn;
-	unsigned long ret;
+	int ret;
 	int rets[2];
 	static spinlock_t lock = SPIN_LOCK_UNLOCKED;
 	/* dont want this on the stack */
@@ -420,7 +420,7 @@
 			BUID_LO(dn->phb->buid));
 
 	if (ret == 0 && rets[1] == 1 && rets[0] >= 2) {
-		unsigned long slot_err_ret;
+		int slot_err_ret;
 
 		spin_lock_irqsave(&lock, flags);
 		memset(slot_err_buf, 0, RTAS_ERROR_LOG_MAX);
@@ -471,7 +471,7 @@
 static void *early_enable_eeh(struct device_node *dn, void *data)
 {
 	struct eeh_early_enable_info *info = data;
-	long ret;
+	int ret;
 	char *status = get_property(dn, "status", 0);
 	u32 *class_code = (u32 *)get_property(dn, "class-code", 0);
 	u32 *vendor_id = (u32 *)get_property(dn, "vendor-id", 0);
diff -urN linux-2.5/arch/ppc64/kernel/lparcfg.c ppc64-2.5-pseries/arch/ppc64/kernel/lparcfg.c
--- linux-2.5/arch/ppc64/kernel/lparcfg.c	2004-06-30 22:01:50.032973408 +1000
+++ ppc64-2.5-pseries/arch/ppc64/kernel/lparcfg.c	2004-06-30 21:42:50.000000000 +1000
@@ -245,7 +245,7 @@
 	/* return 0 for now.  Underlying rtas functionality is not yet complete. 12/01/2003*/
 	return 0; 
 #if 0 
-	long call_status;
+	int call_status;
 	unsigned long ret[2];
 
 	char * buffer = kmalloc(SPLPAR_MAXLENGTH, GFP_KERNEL);
diff -urN linux-2.5/arch/ppc64/kernel/ras.c ppc64-2.5-pseries/arch/ppc64/kernel/ras.c
--- linux-2.5/arch/ppc64/kernel/ras.c	2004-06-30 22:01:50.033973256 +1000
+++ ppc64-2.5-pseries/arch/ppc64/kernel/ras.c	2004-06-30 21:37:00.349007216 +1000
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
diff -urN linux-2.5/arch/ppc64/kernel/scanlog.c ppc64-2.5-pseries/arch/ppc64/kernel/scanlog.c
--- linux-2.5/arch/ppc64/kernel/scanlog.c	2004-06-30 22:01:50.034973104 +1000
+++ ppc64-2.5-pseries/arch/ppc64/kernel/scanlog.c	2004-06-30 21:36:26.000000000 +1000
@@ -118,7 +118,7 @@
 				wait_time = ms / (1000000/HZ); /* round down is fine */
 				/* Fall through to sleep */
 			} else {
-				printk(KERN_ERR "scanlog: unknown error from rtas: %ld\n", status);
+				printk(KERN_ERR "scanlog: unknown error from rtas: %d\n", status);
 				return -EIO;
 			}
 		}
