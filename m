Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129569AbRCLIDR>; Mon, 12 Mar 2001 03:03:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129583AbRCLIDI>; Mon, 12 Mar 2001 03:03:08 -0500
Received: from mail.zmailer.org ([194.252.70.162]:5380 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S129569AbRCLICw>;
	Mon, 12 Mar 2001 03:02:52 -0500
Date: Mon, 12 Mar 2001 10:01:55 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: 2.4.2-ac18 fix for Alpha machines
Message-ID: <20010312100155.P23336@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The linkage of vmlinux fails with lacking code for  bust_spinlocks(),
thus I cloned the i386 one as is -- which apparently is not really
processor specific...


--- arch/alpha/mm/fault.c~	Sun Mar 11 11:49:23 2001
+++ arch/alpha/mm/fault.c	Sun Mar 11 14:46:39 2001
@@ -231,3 +231,39 @@
 	}
 #endif
 }
+
+extern spinlock_t timerlist_lock;
+
+/*
+ * Unlock any spinlocks which will prevent us from getting the
+ * message out (timerlist_lock is acquired through the
+ * console unblank code)
+ */
+void bust_spinlocks(int yes)
+{
+	spin_lock_init(&timerlist_lock);
+	if (yes) {
+		oops_in_progress = 1;
+#ifdef CONFIG_SMP
+		global_irq_lock = 0;	/* Many serial drivers do __global_cli() */
+#endif
+	} else {
+		int loglevel_save = console_loglevel;
+		unblank_screen();
+		oops_in_progress = 0;
+		/*
+		 * OK, the message is on the console.  Now we call printk()
+		 * without oops_in_progress set so that printk will give klogd
+		 * a poke.  Hold onto your hats...
+		 */
+		console_loglevel = 15;		/* NMI oopser may have shut the console up */
+		printk(" ");
+		console_loglevel = loglevel_save;
+	}
+}
+
+void do_BUG(const char *file, int line)
+{
+	bust_spinlocks(1);
+	printk("kernel BUG at %s:%d!\n", file, line);
+}
