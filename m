Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261571AbULYVa0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261571AbULYVa0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Dec 2004 16:30:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261572AbULYVaZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Dec 2004 16:30:25 -0500
Received: from gprs212-19.eurotel.cz ([160.218.212.19]:28546 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261571AbULYVaM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Dec 2004 16:30:12 -0500
Date: Sat, 25 Dec 2004 22:29:57 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>,
       Nigel Cunningham <ncunningham@linuxmail.org>
Subject: swsusp: try_to_freeze to make freezing hooks nicer
Message-ID: <20041225212957.GA20169@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This moves refrigerator changes to sched.h, so that every file
user of refrigerator does not have to include suspend.h, and makes
refrigerator support easier by introducing try_to_freeze. Please
apply,

								Pavel

Adapted from patch by Nigel Cunningham
Signed-off-by: Pavel Machek <pavel@suse.cz>

--- linux-cvs/include/linux/sched.h	2004-12-03 16:47:45.000000000 +0100
+++ linux/include/linux/sched.h	2004-12-25 15:51:46.000000000 +0100
@@ -1124,6 +1124,34 @@
 
 #endif
 
+/* try_to_freeze
+ *
+ * Checks whether we need to enter the refrigerator
+ * and returns 1 if we did so.
+ */
+#ifdef CONFIG_PM
+extern void refrigerator(unsigned long);
+extern int freeze_processes(void);
+extern void thaw_processes(void);
+
+static inline int try_to_freeze(unsigned long refrigerator_flags)
+{
+	if (unlikely(current->flags & PF_FREEZE)) {
+		refrigerator(refrigerator_flags);
+		return 1;
+	} else
+		return 0;
+}
+#else
+static inline void refrigerator(unsigned long flag) {}
+static inline int freeze_processes(void) { BUG(); }
+static inline void thaw_processes(void) {}
+
+static inline int try_to_freeze(unsigned long refrigerator_flags)
+{
+	return 0;
+}
+#endif /* CONFIG_PM */
 #endif /* __KERNEL__ */
 
 #endif
--- linux-cvs/include/linux/suspend.h	2004-12-10 22:35:58.000000000 +0100
+++ linux/include/linux/suspend.h	2004-12-01 13:52:10.000000000 +0100
@@ -36,26 +36,16 @@
 /* kernel/power/swsusp.c */
 extern int software_suspend(void);
 
-#else	/* CONFIG_SOFTWARE_SUSPEND */
+extern int pm_prepare_console(void);
+extern void pm_restore_console(void);
+
+#else
 static inline int software_suspend(void)
 {
 	printk("Warning: fake suspend called\n");
 	return -EPERM;
 }
-#endif	/* CONFIG_SOFTWARE_SUSPEND */
-
-
-#ifdef CONFIG_PM
-extern void refrigerator(unsigned long);
-extern int freeze_processes(void);
-extern void thaw_processes(void);
-
-extern int pm_prepare_console(void);
-extern void pm_restore_console(void);
-
-#else
-static inline void refrigerator(unsigned long flag) {}
-#endif	/* CONFIG_PM */
+#endif
 
 #ifdef CONFIG_SMP
 extern void disable_nonboot_cpus(void);

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
