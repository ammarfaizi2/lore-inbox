Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbUAANHZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 08:07:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261552AbUAANHZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 08:07:25 -0500
Received: from dp.samba.org ([66.70.73.150]:5575 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261500AbUAANFr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 08:05:47 -0500
Date: Fri, 2 Jan 2004 00:01:47 +1100
From: Anton Blanchard <anton@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: joneskoo@derbian.org, linux-kernel@vger.kernel.org
Subject: Re: swapper: page allocation failure. order:3, mode:0x20
Message-ID: <20040101130147.GM28023@krispykreme>
References: <20040101093553.GA24788@derbian.org> <20040101101541.GJ28023@krispykreme> <20040101022553.2be5f043.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040101022553.2be5f043.akpm@osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> So sure, ratelimit it, make it KERN_INFO and maybe add a dump_stack()?

Sounds good, I always end up adding a dump_stack there when debugging
these problems anyway.

> (printk_ratelimit() may be a suitable name)

How does this look?

Anton

===== Documentation/sysctl/kernel.txt 1.7 vs edited =====
--- 1.7/Documentation/sysctl/kernel.txt	Wed Apr  9 18:01:38 2003
+++ edited/Documentation/sysctl/kernel.txt	Thu Jan  1 23:52:10 2004
@@ -251,6 +251,25 @@
 
 ==============================================================
 
+printk_ratelimit:
+
+Some warning messages are rate limited. printk_ratelimit specifies
+the minimum length of time between these messages, by default we
+allow one every 5 seconds.
+
+A value of 0 will disable rate limiting.
+
+==============================================================
+
+printk_ratelimit_burst:
+
+While long term we enforce one message per printk_ratelimit 
+seconds, we do allow a burst of messages to pass through.
+printk_ratelimit_burst specifies the number of messages we can
+send before ratelimiting kicks in.
+
+==============================================================
+
 reboot-cmd: (Sparc only)
 
 ??? This seems to be a way to give an argument to the Sparc
===== include/linux/kernel.h 1.43 vs edited =====
--- 1.43/include/linux/kernel.h	Tue Dec 30 08:37:26 2003
+++ edited/include/linux/kernel.h	Thu Jan  1 23:52:10 2004
@@ -89,6 +89,8 @@
 
 unsigned long int_sqrt(unsigned long);
 
+extern int printk_ratelimit(void);
+
 static inline void console_silent(void)
 {
 	console_loglevel = 0;
===== include/linux/sysctl.h 1.54 vs edited =====
--- 1.54/include/linux/sysctl.h	Thu Dec 25 14:32:23 2003
+++ edited/include/linux/sysctl.h	Thu Jan  1 23:53:11 2004
@@ -127,6 +127,8 @@
 	KERN_PANIC_ON_OOPS=57,  /* int: whether we will panic on an oops */
 	KERN_HPPA_PWRSW=58,	/* int: hppa soft-power enable */
 	KERN_HPPA_UNALIGNED=59,	/* int: hppa unaligned-trap enable */
+	KERN_PRINTK_RATELIMIT=60, /* int: tune printk ratelimiting */
+	KERN_PRINTK_RATELIMIT_BURST=61,	/* int: tune printk ratelimiting */
 };
 
 
===== kernel/printk.c 1.29 vs edited =====
--- 1.29/kernel/printk.c	Tue Dec 30 12:01:55 2003
+++ edited/kernel/printk.c	Thu Jan  1 23:53:51 2004
@@ -762,3 +762,45 @@
 		tty->driver->write(tty, 0, msg, strlen(msg));
 	return;
 }
+
+/* minimum time in jiffies between messages */
+int printk_ratelimit_jiffies = 5*HZ;
+
+/* number of messages we send before ratelimiting */
+int printk_ratelimit_burst = 10;
+
+/* 
+ * printk rate limiting, lifted from the networking subsystem.
+ *
+ * This enforces a rate limit: not more than one kernel message
+ * every printk_ratelimit_jiffies to make a denial-of-service 
+ * attack impossible.
+ */ 
+int printk_ratelimit(void)
+{
+	static spinlock_t ratelimit_lock = SPIN_LOCK_UNLOCKED;
+	static unsigned long toks = 10*5*HZ;
+	static unsigned long last_msg; 
+	static int missed;
+	unsigned long flags;
+	unsigned long now = jiffies;
+
+	spin_lock_irqsave(&ratelimit_lock, flags);
+	toks += now - last_msg;
+	last_msg = now;
+	if (toks > (printk_ratelimit_burst * printk_ratelimit_jiffies))
+		toks = printk_ratelimit_burst * printk_ratelimit_jiffies;
+	if (toks >= printk_ratelimit_jiffies) {
+		int lost = missed;
+		missed = 0;
+		toks -= printk_ratelimit_jiffies;
+		spin_unlock_irqrestore(&ratelimit_lock, flags);
+		if (lost)
+			printk(KERN_WARNING "printk: %d messages suppressed.\n", lost);
+		return 1;
+	}
+	missed++;
+	spin_unlock_irqrestore(&ratelimit_lock, flags);
+	return 0;
+}
+EXPORT_SYMBOL(printk_ratelimit);
===== kernel/sysctl.c 1.55 vs edited =====
--- 1.55/kernel/sysctl.c	Thu Oct  2 17:12:07 2003
+++ edited/kernel/sysctl.c	Thu Jan  1 23:52:11 2004
@@ -60,6 +60,8 @@
 extern int pid_max;
 extern int sysctl_lower_zone_protection;
 extern int min_free_kbytes;
+extern int printk_ratelimit_jiffies;
+extern int printk_ratelimit_burst;
 
 /* this is needed for the proc_dointvec_minmax for [fs_]overflow UID and GID */
 static int maxolduid = 65535;
@@ -575,6 +577,22 @@
 		.ctl_name	= KERN_PANIC_ON_OOPS,
 		.procname	= "panic_on_oops",
 		.data		= &panic_on_oops,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
+	{
+		.ctl_name	= KERN_PRINTK_RATELIMIT,
+		.procname	= "printk_ratelimit",
+		.data		= &printk_ratelimit_jiffies,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec_jiffies,
+	},
+	{
+		.ctl_name	= KERN_PRINTK_RATELIMIT_BURST,
+		.procname	= "printk_ratelimit_burst",
+		.data		= &printk_ratelimit_burst,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= &proc_dointvec,
===== mm/page_alloc.c 1.176 vs edited =====
--- 1.176/mm/page_alloc.c	Tue Dec 30 08:38:05 2003
+++ edited/mm/page_alloc.c	Thu Jan  1 23:52:11 2004
@@ -670,10 +670,11 @@
 	}
 
 nopage:
-	if (!(gfp_mask & __GFP_NOWARN)) {
-		printk("%s: page allocation failure."
+	if (!(gfp_mask & __GFP_NOWARN) && printk_ratelimit()) {
+		printk(KERN_WARNING "%s: page allocation failure."
 			" order:%d, mode:0x%x\n",
 			p->comm, order, gfp_mask);
+		dump_stack();
 	}
 	return NULL;
 got_pg:
