Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031870AbWLGJEx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031870AbWLGJEx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 04:04:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031872AbWLGJEx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 04:04:53 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:41039 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031870AbWLGJEv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 04:04:51 -0500
Date: Thu, 7 Dec 2006 09:55:51 +0100
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Subject: [patch] debug: add sysrq_always_enabled boot option
Message-ID: <20061207085551.GA27506@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -5.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-5.9 required=5.9 tests=ALL_TRUSTED,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [patch] debug: add sysrq_always_enabled boot option
From: Ingo Molnar <mingo@elte.hu>

most distributions enable sysrq support but set it to 0 by default. Add 
a sysrq_always_enabled boot option to always-enable sysrq keys. Useful 
for debugging - without having to modify the disribution's config files 
(which might not be possible if the kernel is on a live CD, etc.).

also, while at it, clean up the sysrq interfaces.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 Documentation/kernel-parameters.txt |    6 +++++
 drivers/char/sysrq.c                |   37 ++++++++++++++++++++++++++++++------
 drivers/char/viocons.c              |   10 +++------
 include/linux/sysrq.h               |   22 +++++++++++++++++----
 kernel/sysctl.c                     |    3 --
 5 files changed, 60 insertions(+), 18 deletions(-)

Index: linux/Documentation/kernel-parameters.txt
===================================================================
--- linux.orig/Documentation/kernel-parameters.txt
+++ linux/Documentation/kernel-parameters.txt
@@ -1637,6 +1637,12 @@ and is between 256 and 4096 characters. 
 	sym53c416=	[HW,SCSI]
 			See header of drivers/scsi/sym53c416.c.
 
+	sysrq_always_enabled
+			[KNL]
+			Ignore sysrq setting - this boot parameter will
+			neutralize any effect of /proc/sys/kernel/sysrq.
+			Useful for debugging.
+
 	t128=		[HW,SCSI]
 			See header of drivers/scsi/t128.c.
 
Index: linux/drivers/char/sysrq.c
===================================================================
--- linux.orig/drivers/char/sysrq.c
+++ linux/drivers/char/sysrq.c
@@ -41,7 +41,34 @@
 #include <asm/irq_regs.h>
 
 /* Whether we react on sysrq keys or just ignore them */
-int sysrq_enabled = 1;
+int __read_mostly __sysrq_enabled = 1;
+
+static int __read_mostly sysrq_always_enabled = 0;
+
+int sysrq_on(void)
+{
+	return __sysrq_enabled || sysrq_always_enabled;
+}
+
+/*
+ * A value of 1 means 'all', other nonzero values are an op mask:
+ */
+static inline int sysrq_on_mask(int mask)
+{
+	return sysrq_always_enabled || __sysrq_enabled == 1 ||
+						(__sysrq_enabled & mask);
+}
+
+int __init sysrq_always_enabled_setup(char *str)
+{
+	sysrq_always_enabled = 1;
+	printk(KERN_INFO "debug: sysrq always enabled.\n");
+
+	return 1;
+}
+
+__setup("sysrq_always_enabled", sysrq_always_enabled_setup);
+
 
 static void sysrq_handle_loglevel(int key, struct tty_struct *tty)
 {
@@ -383,8 +410,7 @@ void __handle_sysrq(int key, struct tty_
 		 * Should we check for enabled operations (/proc/sysrq-trigger
 		 * should not) and is the invoked operation enabled?
 		 */
-		if (!check_mask || sysrq_enabled == 1 ||
-		    (sysrq_enabled & op_p->enable_mask)) {
+		if (!check_mask || sysrq_on_mask(op_p->enable_mask)) {
 			printk("%s\n", op_p->action_msg);
 			console_loglevel = orig_log_level;
 			op_p->handler(key, tty);
@@ -418,9 +444,8 @@ void __handle_sysrq(int key, struct tty_
  */
 void handle_sysrq(int key, struct tty_struct *tty)
 {
-	if (!sysrq_enabled)
-		return;
-	__handle_sysrq(key, tty, 1);
+	if (sysrq_on())
+		__handle_sysrq(key, tty, 1);
 }
 EXPORT_SYMBOL(handle_sysrq);
 
Index: linux/drivers/char/viocons.c
===================================================================
--- linux.orig/drivers/char/viocons.c
+++ linux/drivers/char/viocons.c
@@ -61,10 +61,7 @@
 static DEFINE_SPINLOCK(consolelock);
 static DEFINE_SPINLOCK(consoleloglock);
 
-#ifdef CONFIG_MAGIC_SYSRQ
 static int vio_sysrq_pressed;
-extern int sysrq_enabled;
-#endif
 
 #define VIOCHAR_NUM_BUF		16
 
@@ -936,8 +933,10 @@ static void vioHandleData(struct HvLpEve
 	 */
 	num_pushed = 0;
 	for (index = 0; index < cevent->len; index++) {
-#ifdef CONFIG_MAGIC_SYSRQ
-		if (sysrq_enabled) {
+		/*
+		 * Will be optimized away if !CONFIG_MAGIC_SYSRQ:
+		 */
+		if (sysrq_on()) {
 			/* 0x0f is the ascii character for ^O */
 			if (cevent->data[index] == '\x0f') {
 				vio_sysrq_pressed = 1;
@@ -956,7 +955,6 @@ static void vioHandleData(struct HvLpEve
 				continue;
 			}
 		}
-#endif
 		/*
 		 * The sysrq sequence isn't included in this check if
 		 * sysrq is enabled and compiled into the kernel because
Index: linux/include/linux/sysrq.h
===================================================================
--- linux.orig/include/linux/sysrq.h
+++ linux/include/linux/sysrq.h
@@ -37,23 +37,37 @@ struct sysrq_key_op {
 
 #ifdef CONFIG_MAGIC_SYSRQ
 
+extern int sysrq_on(void);
+
+/*
+ * Do not use this one directly:
+ */
+extern int __sysrq_enabled;
+
 /* Generic SysRq interface -- you may call it from any device driver, supplying
  * ASCII code of the key, pointer to registers and kbd/tty structs (if they
  * are available -- else NULL's).
  */
 
-void handle_sysrq(int, struct tty_struct *);
-void __handle_sysrq(int, struct tty_struct *, int check_mask);
-int register_sysrq_key(int, struct sysrq_key_op *);
-int unregister_sysrq_key(int, struct sysrq_key_op *);
+void handle_sysrq(int key, struct tty_struct *tty);
+void __handle_sysrq(int key, struct tty_struct *tty, int check_mask);
+int register_sysrq_key(int key, struct sysrq_key_op *op);
+int unregister_sysrq_key(int key, struct sysrq_key_op *op);
 struct sysrq_key_op *__sysrq_get_key_op(int key);
 
 #else
 
+static inline int sysrq_on(void)
+{
+	return 0;
+}
 static inline int __reterr(void)
 {
 	return -EINVAL;
 }
+static inline void handle_sysrq(int key, struct tty_struct *tty)
+{
+}
 
 #define register_sysrq_key(ig,nore) __reterr()
 #define unregister_sysrq_key(ig,nore) __reterr()
Index: linux/kernel/sysctl.c
===================================================================
--- linux.orig/kernel/sysctl.c
+++ linux/kernel/sysctl.c
@@ -65,7 +65,6 @@ extern int sysctl_overcommit_memory;
 extern int sysctl_overcommit_ratio;
 extern int sysctl_panic_on_oom;
 extern int max_threads;
-extern int sysrq_enabled;
 extern int core_uses_pid;
 extern int suid_dumpable;
 extern char core_pattern[];
@@ -697,7 +696,7 @@ static ctl_table kern_table[] = {
 	{
 		.ctl_name	= KERN_SYSRQ,
 		.procname	= "sysrq",
-		.data		= &sysrq_enabled,
+		.data		= &__sysrq_enabled,
 		.maxlen		= sizeof (int),
 		.mode		= 0644,
 		.proc_handler	= &proc_dointvec,
