Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265049AbUGCI0T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265049AbUGCI0T (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jul 2004 04:26:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265057AbUGCI0T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jul 2004 04:26:19 -0400
Received: from ozlabs.org ([203.10.76.45]:62684 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S265049AbUGCIZm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jul 2004 04:25:42 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16614.24766.12792.553307@cargo.ozlabs.ibm.com>
Date: Sat, 3 Jul 2004 17:31:10 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: linas@austin.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH] ppc64 RTAS error log locking fix
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linas Vepstas <linas@austin.ibm.com>

When an RTAS call returns the "hardware error" code, we need to do
another RTAS call to find out what went wrong.  Previously we weren't
doing that inside the lock that serializes RTAS calls, and thus
another cpu could get in and do another RTAS call in the meantime.
This patch fixes it.  This patch also includes some minor whitespace
fixes.

Signed-off-by: Linas Vepstas <linas@linas.org>
Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN linux-2.5/arch/ppc64/kernel/rtas.c test25/arch/ppc64/kernel/rtas.c
--- linux-2.5/arch/ppc64/kernel/rtas.c	2004-07-03 08:37:48.200932504 +1000
+++ test25/arch/ppc64/kernel/rtas.c	2004-07-03 15:00:45.648951640 +1000
@@ -74,8 +74,14 @@
 }
 
 
+/** Return a copy of the detailed error text associated with the
+ *  most recent failed call to rtas.  Because the error text
+ *  might go stale if there are any other intervening rtas calls,
+ *  this routine must be called atomically with whatever produced
+ *  the error (i.e. with rtas.lock still held from the previous call).
+ */
 static int
-__log_rtas_error(void)
+__fetch_rtas_last_error(void)
 {
 	struct rtas_args err_args, save_args;
 
@@ -102,25 +108,13 @@
 	return err_args.rets[0];
 }
 
-void
-log_rtas_error(void)
-{
-	unsigned long s;
-	int rc;
-
-	spin_lock_irqsave(&rtas.lock, s);
-	rc = __log_rtas_error();
-	spin_unlock_irqrestore(&rtas.lock, s);
-	if (rc == 0)
-		log_error(rtas_err_buf, ERR_TYPE_RTAS_LOG, 0);
-}
-
 int rtas_call(int token, int nargs, int nret, int *outputs, ...)
 {
 	va_list list;
 	int i, logit = 0;
 	unsigned long s;
 	struct rtas_args *rtas_args;
+	char * buff_copy = NULL;
 	int ret;
 
 	PPCDBG(PPCDBG_RTAS, "Entering rtas_call\n");
@@ -154,8 +148,10 @@
 	enter_rtas(__pa(rtas_args));
 	PPCDBG(PPCDBG_RTAS, "\treturned from rtas ...\n");
 
+	/* A -1 return code indicates that the last command couldn't
+	   be completed due to a hardware error. */
 	if (rtas_args->rets[0] == -1)
-		logit = (__log_rtas_error() == 0);
+		logit = (__fetch_rtas_last_error() == 0);
 
 	ifppcdebug(PPCDBG_RTAS) {
 		for(i=0; i < nret ;i++)
@@ -167,12 +163,21 @@
 			outputs[i] = rtas_args->rets[i+1];
 	ret = (nret > 0)? rtas_args->rets[0]: 0;
 
+	/* Log the error in the unlikely case that there was one. */
+	if (unlikely(logit)) {
+		buff_copy = kmalloc(RTAS_ERROR_LOG_MAX, GFP_ATOMIC);
+		if (buff_copy) {
+			memcpy(buff_copy, rtas_err_buf, RTAS_ERROR_LOG_MAX);
+		}
+	}
+
 	/* Gotta do something different here, use global lock for now... */
 	spin_unlock_irqrestore(&rtas.lock, s);
 
-	if (logit)
-		log_error(rtas_err_buf, ERR_TYPE_RTAS_LOG, 0);
-
+	if (buff_copy) {
+		log_error(buff_copy, ERR_TYPE_RTAS_LOG, 0);
+		kfree(buff_copy);
+	}
 	return ret;
 }
 
@@ -192,7 +197,7 @@
 
 	/* Use microseconds for reasonable accuracy */
 	for (ms=1; order > 0; order--)
-		ms *= 10;          
+		ms *= 10;
 
 	return ms; 
 }
@@ -367,9 +372,9 @@
 	if (rtas_firmware_flash_list.next)
 		rtas_flash_firmware();
 
-        printk("RTAS system-reboot returned %d\n",
+	printk("RTAS system-reboot returned %d\n",
 	       rtas_call(rtas_token("system-reboot"), 0, 1, NULL));
-        for (;;);
+	for (;;);
 }
 
 void
@@ -377,10 +382,10 @@
 {
 	if (rtas_firmware_flash_list.next)
 		rtas_flash_bypass_warning();
-        /* allow power on only with power button press */
-        printk("RTAS power-off returned %d\n",
-               rtas_call(rtas_token("power-off"), 2, 1, NULL, -1, -1));
-        for (;;);
+	/* allow power on only with power button press */
+	printk("RTAS power-off returned %d\n",
+	       rtas_call(rtas_token("power-off"), 2, 1, NULL, -1, -1));
+	for (;;);
 }
 
 void
@@ -388,7 +393,7 @@
 {
 	if (rtas_firmware_flash_list.next)
 		rtas_flash_bypass_warning();
-        rtas_power_off();
+	rtas_power_off();
 }
 
 /* Must be in the RMO region, so we place it here */
@@ -418,7 +423,9 @@
 {
 	struct rtas_args args;
 	unsigned long flags;
+	char * buff_copy;
 	int nargs;
+	int err_rc = 0;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
@@ -437,17 +444,33 @@
 			   nargs * sizeof(rtas_arg_t)) != 0)
 		return -EFAULT;
 
+	buff_copy = kmalloc(RTAS_ERROR_LOG_MAX, GFP_KERNEL);
+
 	spin_lock_irqsave(&rtas.lock, flags);
 
 	rtas.args = args;
 	enter_rtas(__pa(&rtas.args));
 	args = rtas.args;
 
+	args.rets = &args.args[nargs];
+
+	/* A -1 return code indicates that the last command couldn't
+	   be completed due to a hardware error. */
+	if (args.rets[0] == -1) {
+		err_rc = __fetch_rtas_last_error();
+		if ((err_rc == 0) && buff_copy) {
+			memcpy(buff_copy, rtas_err_buf, RTAS_ERROR_LOG_MAX);
+		}
+	}
+
 	spin_unlock_irqrestore(&rtas.lock, flags);
 
-	args.rets  = (rtas_arg_t *)&(args.args[nargs]);
-	if (args.rets[0] == -1)
-		log_rtas_error();
+	if (buff_copy) {
+		if ((args.rets[0] == -1) && (err_rc == 0)) {
+			log_error(buff_copy, ERR_TYPE_RTAS_LOG, 0);
+		}
+		kfree(buff_copy);
+	}
 
 	/* Copy out args. */
 	if (copy_to_user(uargs->args + nargs,
