Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268807AbUHLVm3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268807AbUHLVm3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 17:42:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268817AbUHLVkB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 17:40:01 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:36049 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S268811AbUHLVfD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 17:35:03 -0400
Date: Thu, 12 Aug 2004 14:35:00 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] ppc32: Fix warning on CONFIG_PPC32 && CONFIG_6xx
Message-ID: <20040812213500.GB5583@smtp.west.cox.net>
References: <20040812194944.GA5583@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040812194944.GA5583@smtp.west.cox.net>
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2004 at 12:49:44PM -0700, Tom Rini wrote:

> In the *ppos cleanups, proc_dol2crvec was updated, but the prototype
> found at the top of kernel/sysctl.h was not, generating warning.  This
> corrects the prototype to match the code.
> 
> (I'm gonna take a stab at moving these into arch/ppc shortly)

The alternative to this, which I can resend after 2.6.8 if you'd prefer,
is to move both of these sysctls into arch/ppc where they belong.

Signed-off-by: Tom Rini <trini@kernel.crashing.org>

--- 1.23/arch/ppc/kernel/ppc_htab.c	2004-08-07 23:43:40 -07:00
+++ edited/arch/ppc/kernel/ppc_htab.c	2004-08-12 13:16:26 -07:00
@@ -20,6 +20,7 @@
 #include <linux/threads.h>
 #include <linux/smp_lock.h>
 #include <linux/seq_file.h>
+#include <linux/init.h>
 
 #include <asm/uaccess.h>
 #include <asm/bitops.h>
@@ -34,9 +35,6 @@
 static int ppc_htab_show(struct seq_file *m, void *v);
 static ssize_t ppc_htab_write(struct file * file, const char __user * buffer,
 			      size_t count, loff_t *ppos);
-int proc_dol2crvec(ctl_table *table, int write, struct file *filp,
-		  void __user *buffer, size_t *lenp, loff_t *ppos);
-
 extern PTE *Hash, *Hash_end;
 extern unsigned long Hash_size, Hash_mask;
 extern unsigned long _SDR1;
@@ -438,3 +436,32 @@
 	*ppos += *lenp;
 	return 0;
 }
+
+#ifdef CONFIG_SYSCTL
+/*
+ * Register our sysctl.
+ */
+static ctl_table htab_ctl_table[]={
+	{
+		.ctl_name	= KERN_PPC_L2CR,
+		.procname	= "l2cr",
+		.mode		= 0644,
+		.proc_handler	= &proc_dol2crvec,
+	},
+	{ 0, },
+};
+static ctl_table htab_sysctl_root[] = {
+	{ 1, "kernel", NULL, 0, 0755, htab_ctl_table, },
+ 	{ 0,},
+};
+
+static int __init
+register_ppc_htab_sysctl(void)
+{
+	register_sysctl_table(htab_sysctl_root, 0);
+
+	return 0;
+}
+
+__initcall(register_ppc_htab_sysctl);
+#endif
--- 1.19/arch/ppc/kernel/idle.c	2003-09-15 13:59:05 -07:00
+++ edited/arch/ppc/kernel/idle.c	2004-08-12 14:27:31 -07:00
@@ -21,6 +21,7 @@
 #include <linux/unistd.h>
 #include <linux/ptrace.h>
 #include <linux/slab.h>
+#include <linux/sysctl.h>
 
 #include <asm/pgtable.h>
 #include <asm/uaccess.h>
@@ -65,3 +66,36 @@
 			default_idle();
 	return 0;
 }
+
+#if defined(CONFIG_SYSCTL) && defined(CONFIG_6xx)
+/*
+ * Register the sysctl to set/clear powersave_nap.
+ */
+extern unsigned long powersave_nap;
+
+static ctl_table powersave_nap_ctl_table[]={
+	{
+		.ctl_name	= KERN_PPC_POWERSAVE_NAP,
+		.procname	= "powersave-nap",
+		.data		= &powersave_nap,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
+	{ 0, },
+};
+static ctl_table powersave_nap_sysctl_root[] = {
+	{ 1, "kernel", NULL, 0, 0755, powersave_nap_ctl_table, },
+ 	{ 0,},
+};
+
+static int __init
+register_powersave_nap_sysctl(void)
+{
+	register_sysctl_table(powersave_nap_sysctl_root, 0);
+
+	return 0;
+}
+
+__initcall(register_powersave_nap_sysctl);
+#endif
--- 1.82/kernel/sysctl.c	2004-08-07 23:43:41 -07:00
+++ edited/kernel/sysctl.c	2004-08-12 14:26:46 -07:00
@@ -110,12 +110,6 @@
 
 extern int sysctl_hz_timer;
 
-#if defined(CONFIG_PPC32) && defined(CONFIG_6xx)
-extern unsigned long powersave_nap;
-int proc_dol2crvec(ctl_table *table, int write, struct file *filp,
-		  void __user *buffer, size_t *lenp);
-#endif
-
 #ifdef CONFIG_BSD_PROCESS_ACCT
 extern int acct_parm[];
 #endif
@@ -353,22 +347,6 @@
 		.maxlen		= sizeof (int),
 		.mode		= 0644,
 		.proc_handler	= &proc_dointvec,
-	},
-#endif
-#if defined(CONFIG_PPC32) && defined(CONFIG_6xx)
-	{
-		.ctl_name	= KERN_PPC_POWERSAVE_NAP,
-		.procname	= "powersave-nap",
-		.data		= &powersave_nap,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= &proc_dointvec,
-	},
-	{
-		.ctl_name	= KERN_PPC_L2CR,
-		.procname	= "l2cr",
-		.mode		= 0644,
-		.proc_handler	= &proc_dol2crvec,
 	},
 #endif
 	{

-- 
Tom Rini
http://gate.crashing.org/~trini/
