Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964959AbVJUOwV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964959AbVJUOwV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 10:52:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964964AbVJUOwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 10:52:21 -0400
Received: from sccrmhc12.comcast.net ([63.240.77.82]:61634 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S964959AbVJUOwU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 10:52:20 -0400
Date: Fri, 21 Oct 2005 09:52:04 -0500
From: Corey Minyard <minyard@acm.org>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH 3/9] ipmi: watchdog parms in sysfs
Message-ID: <20051021145204.GC19532@i2.minyard.local>
Reply-To: minyard@acm.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Modify the IPMI watchdog parameters (the ones that make sense)
to be exported from sysfs.  This is somewhat complicated because
these parameters have side-effects that must be handled.

Signed-off-by: Corey Minyard <minyard@acm.org>

Index: linux-2.6.14-rc2/drivers/char/ipmi/ipmi_watchdog.c
===================================================================
--- linux-2.6.14-rc2.orig/drivers/char/ipmi/ipmi_watchdog.c
+++ linux-2.6.14-rc2/drivers/char/ipmi/ipmi_watchdog.c
@@ -47,6 +47,8 @@
 #include <linux/reboot.h>
 #include <linux/wait.h>
 #include <linux/poll.h>
+#include <linux/string.h>
+#include <linux/ctype.h>
 #ifdef CONFIG_X86_LOCAL_APIC
 #include <asm/apic.h>
 #endif
@@ -158,27 +160,120 @@ static struct fasync_struct *fasync_q = 
 static char pretimeout_since_last_heartbeat = 0;
 static char expect_close;
 
+static DECLARE_RWSEM(register_sem);
+
+/* Parameters to ipmi_set_timeout */
+#define IPMI_SET_TIMEOUT_NO_HB			0
+#define IPMI_SET_TIMEOUT_HB_IF_NECESSARY	1
+#define IPMI_SET_TIMEOUT_FORCE_HB		2
+
+static int ipmi_set_timeout(int do_heartbeat);
+
 /* If true, the driver will start running as soon as it is configured
    and ready. */
 static int start_now = 0;
 
-module_param(timeout, int, 0);
+static int set_param_int(const char *val, struct kernel_param *kp)
+{
+	char *endp;
+	int  l;
+	int  rv = 0;
+
+	if (!val)
+		return -EINVAL;
+	l = simple_strtoul(val, &endp, 0);
+	if (endp == val)
+		return -EINVAL;
+
+	down_read(&register_sem);
+	*((int *)kp->arg) = l;
+	if (watchdog_user)
+		rv = ipmi_set_timeout(IPMI_SET_TIMEOUT_HB_IF_NECESSARY);
+	up_read(&register_sem);
+
+	return rv;
+}
+
+static int get_param_int(char *buffer, struct kernel_param *kp)
+{
+	return sprintf(buffer, "%i", *((int *)kp->arg));
+}
+
+typedef int (*action_fn)(const char *intval, char *outval);
+
+static int action_op(const char *inval, char *outval);
+static int preaction_op(const char *inval, char *outval);
+static int preop_op(const char *inval, char *outval);
+static void check_parms(void);
+
+static int set_param_str(const char *val, struct kernel_param *kp)
+{
+	action_fn  fn = (action_fn) kp->arg;
+	int        rv = 0;
+	const char *end;
+	char       valcp[16];
+	int        len;
+
+	/* Truncate leading and trailing spaces. */
+	while (isspace(*val))
+		val++;
+	end = val + strlen(val) - 1;
+	while ((end >= val) && isspace(*end))
+		end--;
+	len = end - val + 1;
+	if (len > sizeof(valcp) - 1)
+		return -EINVAL;
+	memcpy(valcp, val, len);
+	valcp[len] = '\0';
+
+	down_read(&register_sem);
+	rv = fn(valcp, NULL);
+	if (rv)
+		goto out_unlock;
+
+	check_parms();
+	if (watchdog_user)
+		rv = ipmi_set_timeout(IPMI_SET_TIMEOUT_HB_IF_NECESSARY);
+
+ out_unlock:
+	up_read(&register_sem);
+	return rv;
+}
+
+static int get_param_str(char *buffer, struct kernel_param *kp)
+{
+	action_fn fn = (action_fn) kp->arg;
+	int       rv;
+
+	rv = fn(NULL, buffer);
+	if (rv)
+		return rv;
+	return strlen(buffer);
+}
+
+module_param_call(timeout, set_param_int, get_param_int, &timeout, 0644);
 MODULE_PARM_DESC(timeout, "Timeout value in seconds.");
-module_param(pretimeout, int, 0);
+
+module_param_call(pretimeout, set_param_int, get_param_int, &pretimeout, 0644);
 MODULE_PARM_DESC(pretimeout, "Pretimeout value in seconds.");
-module_param_string(action, action, sizeof(action), 0);
+
+module_param_call(action, set_param_str, get_param_str, action_op, 0644);
 MODULE_PARM_DESC(action, "Timeout action. One of: "
 		 "reset, none, power_cycle, power_off.");
-module_param_string(preaction, preaction, sizeof(preaction), 0);
+
+module_param_call(preaction, set_param_str, get_param_str, preaction_op, 0644);
 MODULE_PARM_DESC(preaction, "Pretimeout action.  One of: "
 		 "pre_none, pre_smi, pre_nmi, pre_int.");
-module_param_string(preop, preop, sizeof(preop), 0);
+
+module_param_call(preop, set_param_str, get_param_str, preop_op, 0644);
 MODULE_PARM_DESC(preop, "Pretimeout driver operation.  One of: "
 		 "preop_none, preop_panic, preop_give_data.");
+
 module_param(start_now, int, 0);
 MODULE_PARM_DESC(start_now, "Set to 1 to start the watchdog as"
 		 "soon as the driver is loaded.");
-module_param(nowayout, int, 0);
+
+module_param(nowayout, int, 0644);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default=CONFIG_WATCHDOG_NOWAYOUT)");
 
 /* Default state of the timer. */
@@ -294,11 +389,6 @@ static int i_ipmi_set_timeout(struct ipm
 	return rv;
 }
 
-/* Parameters to ipmi_set_timeout */
-#define IPMI_SET_TIMEOUT_NO_HB			0
-#define IPMI_SET_TIMEOUT_HB_IF_NECESSARY	1
-#define IPMI_SET_TIMEOUT_FORCE_HB		2
-
 static int ipmi_set_timeout(int do_heartbeat)
 {
 	int send_heartbeat_now;
@@ -732,8 +822,6 @@ static struct miscdevice ipmi_wdog_miscd
 	.fops		= &ipmi_wdog_fops
 };
 
-static DECLARE_RWSEM(register_sem);
-
 static void ipmi_wdog_msg_handler(struct ipmi_recv_msg *msg,
 				  void                 *handler_data)
 {
@@ -839,6 +927,7 @@ static struct nmi_handler ipmi_nmi_handl
 	.handler  = ipmi_nmi,
 	.priority = 0, /* Call us last. */
 };
+int nmi_handler_registered;
 #endif
 
 static int wdog_reboot_handler(struct notifier_block *this,
@@ -921,59 +1010,86 @@ static struct ipmi_smi_watcher smi_watch
 	.smi_gone = ipmi_smi_gone
 };
 
-static int __init ipmi_wdog_init(void)
+static int action_op(const char *inval, char *outval)
 {
-	int rv;
+	if (outval)
+		strcpy(outval, action);
+
+	if (!inval)
+		return 0;
 
-	if (strcmp(action, "reset") == 0) {
+	if (strcmp(inval, "reset") == 0)
 		action_val = WDOG_TIMEOUT_RESET;
-	} else if (strcmp(action, "none") == 0) {
+	else if (strcmp(inval, "none") == 0)
 		action_val = WDOG_TIMEOUT_NONE;
-	} else if (strcmp(action, "power_cycle") == 0) {
+	else if (strcmp(inval, "power_cycle") == 0)
 		action_val = WDOG_TIMEOUT_POWER_CYCLE;
-	} else if (strcmp(action, "power_off") == 0) {
+	else if (strcmp(inval, "power_off") == 0)
 		action_val = WDOG_TIMEOUT_POWER_DOWN;
-	} else {
-		action_val = WDOG_TIMEOUT_RESET;
-		printk(KERN_INFO PFX "Unknown action '%s', defaulting to"
-		       " reset\n", action);
-	}
+	else
+		return -EINVAL;
+	strcpy(action, inval);
+	return 0;
+}
+
+static int preaction_op(const char *inval, char *outval)
+{
+	if (outval)
+		strcpy(outval, preaction);
 
-	if (strcmp(preaction, "pre_none") == 0) {
+	if (!inval)
+		return 0;
+
+	if (strcmp(inval, "pre_none") == 0)
 		preaction_val = WDOG_PRETIMEOUT_NONE;
-	} else if (strcmp(preaction, "pre_smi") == 0) {
+	else if (strcmp(inval, "pre_smi") == 0)
 		preaction_val = WDOG_PRETIMEOUT_SMI;
 #ifdef HAVE_NMI_HANDLER
-	} else if (strcmp(preaction, "pre_nmi") == 0) {
+	else if (strcmp(inval, "pre_nmi") == 0)
 		preaction_val = WDOG_PRETIMEOUT_NMI;
 #endif
-	} else if (strcmp(preaction, "pre_int") == 0) {
+	else if (strcmp(inval, "pre_int") == 0)
 		preaction_val = WDOG_PRETIMEOUT_MSG_INT;
-	} else {
-		preaction_val = WDOG_PRETIMEOUT_NONE;
-		printk(KERN_INFO PFX "Unknown preaction '%s', defaulting to"
-		       " none\n", preaction);
-	}
+	else
+		return -EINVAL;
+	strcpy(preaction, inval);
+	return 0;
+}
+
+static int preop_op(const char *inval, char *outval)
+{
+	if (outval)
+		strcpy(outval, preop);
 
-	if (strcmp(preop, "preop_none") == 0) {
+	if (!inval)
+		return 0;
+
+	if (strcmp(inval, "preop_none") == 0)
 		preop_val = WDOG_PREOP_NONE;
-	} else if (strcmp(preop, "preop_panic") == 0) {
+	else if (strcmp(inval, "preop_panic") == 0)
 		preop_val = WDOG_PREOP_PANIC;
-	} else if (strcmp(preop, "preop_give_data") == 0) {
+	else if (strcmp(inval, "preop_give_data") == 0)
 		preop_val = WDOG_PREOP_GIVE_DATA;
-	} else {
-		preop_val = WDOG_PREOP_NONE;
-		printk(KERN_INFO PFX "Unknown preop '%s', defaulting to"
-		       " none\n", preop);
-	}
+	else
+		return -EINVAL;
+	strcpy(preop, inval);
+	return 0;
+}
 
+static void check_parms(void)
+{
 #ifdef HAVE_NMI_HANDLER
+	int do_nmi = 0;
+	int rv;
+
 	if (preaction_val == WDOG_PRETIMEOUT_NMI) {
+		do_nmi = 1;
 		if (preop_val == WDOG_PREOP_GIVE_DATA) {
 			printk(KERN_WARNING PFX "Pretimeout op is to give data"
 			       " but NMI pretimeout is enabled, setting"
 			       " pretimeout op to none\n");
-			preop_val = WDOG_PREOP_NONE;
+			preop_op("preop_none", NULL);
+			do_nmi = 0;
 		}
 #ifdef CONFIG_X86_LOCAL_APIC
 		if (nmi_watchdog == NMI_IO_APIC) {
@@ -983,18 +1099,48 @@ static int __init ipmi_wdog_init(void)
 			       " Disabling IPMI nmi pretimeout.\n",
 			       nmi_watchdog);
 			preaction_val = WDOG_PRETIMEOUT_NONE;
-		} else {
+			do_nmi = 0;
+		}
 #endif
+	}
+	if (do_nmi && !nmi_handler_registered) {
 		rv = request_nmi(&ipmi_nmi_handler);
 		if (rv) {
-			printk(KERN_WARNING PFX "Can't register nmi handler\n");
-			return rv;
-		}
-#ifdef CONFIG_X86_LOCAL_APIC
-		}
-#endif
+			printk(KERN_WARNING PFX
+			       "Can't register nmi handler\n");
+			return;
+		} else
+			nmi_handler_registered = 1;
+	} else if (!do_nmi && nmi_handler_registered) {
+		release_nmi(&ipmi_nmi_handler);
+		nmi_handler_registered = 0;
 	}
 #endif
+}
+
+static int __init ipmi_wdog_init(void)
+{
+	int rv;
+
+	if (action_op(action, NULL)) {
+		action_op("reset", NULL);
+		printk(KERN_INFO PFX "Unknown action '%s', defaulting to"
+		       " reset\n", action);
+	}
+
+	if (preaction_op(preaction, NULL)) {
+		preaction_op("pre_none", NULL);
+		printk(KERN_INFO PFX "Unknown preaction '%s', defaulting to"
+		       " none\n", preaction);
+	}
+
+	if (preop_op(preop, NULL)) {
+		preop_op("preop_none", NULL);
+		printk(KERN_INFO PFX "Unknown preop '%s', defaulting to"
+		       " none\n", preop);
+	}
+
+	check_parms();
 
 	rv = ipmi_smi_watcher_register(&smi_watcher);
 	if (rv) {
@@ -1021,7 +1167,7 @@ static __exit void ipmi_unregister_watch
 	down_write(&register_sem);
 
 #ifdef HAVE_NMI_HANDLER
-	if (preaction_val == WDOG_PRETIMEOUT_NMI)
+	if (nmi_handler_registered)
 		release_nmi(&ipmi_nmi_handler);
 #endif
 
