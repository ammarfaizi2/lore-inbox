Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265971AbUIAJzU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265971AbUIAJzU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 05:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265930AbUIAJzU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 05:55:20 -0400
Received: from verein.lst.de ([213.95.11.210]:53384 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S266003AbUIAJym (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 05:54:42 -0400
Date: Wed, 1 Sep 2004 11:54:32 +0200
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] remove unused sysctls from kernel/personality.c
Message-ID: <20040901095432.GA23793@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These are only used by the out of tree linux-abi project, so it makes
sense to define them in those modules.


--- 1.6/include/linux/personality.h	2003-09-01 01:13:59 +02:00
+++ edited/include/linux/personality.h	2004-07-11 17:40:34 +02:00
@@ -12,17 +12,6 @@
 extern int		unregister_exec_domain(struct exec_domain *);
 extern int		__set_personality(unsigned long);
 
-
-/*
- * Sysctl variables related to binary emulation.
- */
-extern unsigned long abi_defhandler_coff;
-extern unsigned long abi_defhandler_elf;
-extern unsigned long abi_defhandler_lcall7;
-extern unsigned long abi_defhandler_libcso;
-extern int abi_fake_utsname;
-
-
 /*
  * Flags for bug emulation.
  *
===== kernel/exec_domain.c 1.16 vs edited =====
--- 1.16/kernel/exec_domain.c	2004-03-31 15:43:33 +02:00
+++ edited/kernel/exec_domain.c	2004-07-11 17:40:15 +02:00
@@ -44,29 +44,7 @@
 static void
 default_handler(int segment, struct pt_regs *regp)
 {
-	u_long			pers = 0;
-
-	/*
-	 * This may have been a static linked SVr4 binary, so we would
-	 * have the personality set incorrectly. Or it might have been
-	 * a Solaris/x86 binary. We can tell which because the former
-	 * uses lcall7, while the latter used lcall 0x27.
-	 * Try to find or load the appropriate personality, and fall back
-	 * to just forcing a SEGV.
-	 *
-	 * XXX: this is IA32-specific and should be moved to the MD-tree.
-	 */
-	switch (segment) {
-#ifdef __i386__
-	case 0x07:
-		pers = abi_defhandler_lcall7;
-		break;
-	case 0x27:
-		pers = PER_SOLARIS;
-		break;
-#endif
-	}
-	set_personality(pers);
+	set_personality(0);
 
 	if (current_thread_info()->exec_domain->handler != default_handler)
 		current_thread_info()->exec_domain->handler(segment, regp);
@@ -228,100 +206,3 @@
 EXPORT_SYMBOL(register_exec_domain);
 EXPORT_SYMBOL(unregister_exec_domain);
 EXPORT_SYMBOL(__set_personality);
-
-/*
- * We have to have all sysctl handling for the Linux-ABI
- * in one place as the dynamic registration of sysctls is
- * horribly crufty in Linux <= 2.4.
- *
- * I hope the new sysctl schemes discussed for future versions
- * will obsolete this.
- *
- * 				--hch
- */
-
-u_long abi_defhandler_coff = PER_SCOSVR3;
-u_long abi_defhandler_elf = PER_LINUX;
-u_long abi_defhandler_lcall7 = PER_SVR4;
-u_long abi_defhandler_libcso = PER_SVR4;
-u_int abi_traceflg;
-int abi_fake_utsname;
-
-static struct ctl_table abi_table[] = {
-	{
-		.ctl_name	= ABI_DEFHANDLER_COFF,
-		.procname	= "defhandler_coff",
-		.data		= &abi_defhandler_coff,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= &proc_doulongvec_minmax,
-	},
-	{
-		.ctl_name	= ABI_DEFHANDLER_ELF,
-		.procname	= "defhandler_elf",
-		.data		= &abi_defhandler_elf,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= &proc_doulongvec_minmax,
-	},
-	{
-		.ctl_name	= ABI_DEFHANDLER_LCALL7,
-		.procname	= "defhandler_lcall7",
-		.data		= &abi_defhandler_lcall7,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= &proc_doulongvec_minmax,
-	},
-	{
-		.ctl_name	= ABI_DEFHANDLER_LIBCSO,
-		.procname	= "defhandler_libcso",
-		.data		= &abi_defhandler_libcso,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= &proc_doulongvec_minmax,
-	},
-	{
-		.ctl_name	= ABI_TRACE,
-		.procname	= "trace",
-		.data		= &abi_traceflg,
-		.maxlen		= sizeof(u_int),
-		.mode		= 0644,
-		.proc_handler	= &proc_dointvec,
-	},
-	{
-		.ctl_name	= ABI_FAKE_UTSNAME,
-		.procname	= "fake_utsname",
-		.data		= &abi_fake_utsname,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= &proc_dointvec,
-	},
-	{ .ctl_name = 0 }
-};
-
-static struct ctl_table abi_root_table[] = {
-	{
-		.ctl_name	= CTL_ABI,
-		.procname	= "abi",
-		.mode		= 0555,
-		.child		= abi_table,
-	},
-	{ .ctl_name = 0 }
-};
-
-static int __init
-abi_register_sysctl(void)
-{
-	register_sysctl_table(abi_root_table, 1);
-	return 0;
-}
-
-__initcall(abi_register_sysctl);
-
-
-EXPORT_SYMBOL(abi_defhandler_coff);
-EXPORT_SYMBOL(abi_defhandler_elf);
-EXPORT_SYMBOL(abi_defhandler_lcall7);
-EXPORT_SYMBOL(abi_defhandler_libcso);
-EXPORT_SYMBOL(abi_traceflg);
-EXPORT_SYMBOL(abi_fake_utsname);
