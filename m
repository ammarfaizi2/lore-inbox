Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263152AbUB0Vdk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 16:33:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263155AbUB0Vdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 16:33:39 -0500
Received: from fed1mtao02.cox.net ([68.6.19.243]:20216 "EHLO
	fed1mtao02.cox.net") by vger.kernel.org with ESMTP id S263152AbUB0Vcz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 16:32:55 -0500
Date: Fri, 27 Feb 2004 14:32:54 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@suse.cz>, "Amit S. Kale" <amitkale@emsyssoft.com>,
       kgdb-bugreport@lists.sourceforge.net
Subject: [KGDB PATCH][3/7] SysRq-G
Message-ID: <20040227213254.GE1052@smtp.west.cox.net>
References: <20040227212301.GC1052@smtp.west.cox.net> <20040227212548.GD1052@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040227212548.GD1052@smtp.west.cox.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.  The following adds SysRq-G.  This is always configured in on
CONFIG_KGDB && CONFIG_SYSRQ.

diff -zrupN linux-2.6.3+config+serial/drivers/char/sysrq.c linux-2.6.3+config+serial+sysrq+arch_hooks/drivers/char/sysrq.c
--- linux-2.6.3+config+serial/drivers/char/sysrq.c	2004-02-27 12:06:22.000000000 -0700
+++ linux-2.6.3+config+serial+sysrq+arch_hooks/drivers/char/sysrq.c	2004-02-27 12:16:14.000000000 -0700
@@ -31,6 +31,7 @@
 #include <linux/suspend.h>
 #include <linux/writeback.h>
 #include <linux/buffer_head.h>		/* for fsync_bdev() */
+#include <linux/kgdb.h>			/* for breakpoint() */
 
 #include <linux/spinlock.h>
 
@@ -44,6 +45,25 @@ int sysrq_enabled = 1;
 /* Machine specific power off function */
 void (*sysrq_power_off)(void);
 
+/* Make a breakpoint() right now. */
+#ifdef CONFIG_KGDB
+#define  GDB_OP &kgdb_op
+static void kgdb_sysrq(int key, struct pt_regs *pt_regs, struct tty_struct *tty)
+{
+	printk("kgdb sysrq\n");
+	breakpoint();
+}
+
+static struct sysrq_key_op kgdb_op = {
+	.handler	= kgdb_sysrq,
+	.help_msg	= "kGdb|Fgdb",
+	.action_msg	= "Debug breakpoint\n",
+};
+
+#else
+#define  GDB_OP NULL
+#endif
+
 /* Loglevel sysrq handler */
 static void sysrq_handle_loglevel(int key, struct pt_regs *pt_regs,
 				  struct tty_struct *tty) 
@@ -239,7 +259,7 @@ static struct sysrq_key_op *sysrq_key_ta
 /* d */	NULL,
 /* e */	&sysrq_term_op,
 /* f */	NULL,
-/* g */	NULL,
+/* g */	GDB_OP,
 /* h */	NULL,
 /* i */	&sysrq_kill_op,
 /* j */	NULL,

-- 
Tom Rini
http://gate.crashing.org/~trini/
