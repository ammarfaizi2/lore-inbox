Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277296AbRJEBeL>; Thu, 4 Oct 2001 21:34:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277297AbRJEBeC>; Thu, 4 Oct 2001 21:34:02 -0400
Received: from dot.cygnus.com ([205.180.230.224]:5124 "EHLO dot.cygnus.com")
	by vger.kernel.org with ESMTP id <S277296AbRJEBdt>;
	Thu, 4 Oct 2001 21:33:49 -0400
Date: Thu, 4 Oct 2001 18:34:15 -0700
From: Richard Henderson <rth@dot.cygnus.com>
To: torvalds@transmeta.com, alan@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: alpha 2.4.11-pre3: delay disabling early boot messages
Message-ID: <20011004183415.A6357@dot.cygnus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From Jay Estabrook:

Alpha has this nice way to output console messages via SRM callbacks
which we can enable immediately on bootup, and so get debugging output
before console_init.  This patch delays when we turn that off, and so
narrows the window in which we can't get debug output.


r~


diff -rup 2.4.10-dist/arch/alpha/kernel/irq_alpha.c 2.4.10/arch/alpha/kernel/irq_alpha.c
--- 2.4.10-dist/arch/alpha/kernel/irq_alpha.c	Mon Sep 17 13:16:30 2001
+++ 2.4.10/arch/alpha/kernel/irq_alpha.c	Thu Oct  4 16:05:16 2001
@@ -108,11 +108,6 @@ init_IRQ(void)
 	wrent(entInt, 0);
 
 	alpha_mv.init_irq();
-
-	/* If we had wanted SRM console printk echoing early, undo it now. */
-	if (alpha_using_srm && srmcons_output) {
-		unregister_srm_console();
-	}
 }
 
 /*
diff -rup 2.4.10-dist/arch/alpha/kernel/setup.c 2.4.10/arch/alpha/kernel/setup.c
--- 2.4.10-dist/arch/alpha/kernel/setup.c	Sun Aug 12 10:38:47 2001
+++ 2.4.10/arch/alpha/kernel/setup.c	Thu Oct  4 16:05:16 2001
@@ -63,12 +63,20 @@ unsigned long srm_hae;
 /* Which processor we booted from.  */
 int boot_cpuid;
 
-/* Using SRM callbacks for initial console output. This works from
-   setup_arch() time through the end of init_IRQ(), as those places
-   are under our control.
-
-   By default, OFF; set it with a bootcommand arg of "srmcons".
-*/
+/*
+ * Using SRM callbacks for initial console output. This works from
+ * setup_arch() time through the end of time_init(), as those places
+ * are under our (Alpha) control.
+
+ * "srmcons" specified in the boot command arguments allows us to
+ * see kernel messages during the period of time before the true
+ * console device is "registered" during console_init(). As of this
+ * version (2.4.10), time_init() is the last Alpha-specific code
+ * called before console_init(), so we put "unregister" code
+ * there to prevent schizophrenic console behavior later... ;-}
+ *
+ * By default, OFF; set it with a bootcommand arg of "srmcons".
+ */
 int srmcons_output = 0;
 
 /* Enforce a memory size limit; useful for testing. By default, none. */
diff -rup 2.4.10-dist/arch/alpha/kernel/time.c 2.4.10/arch/alpha/kernel/time.c
--- 2.4.10-dist/arch/alpha/kernel/time.c	Sun Aug 12 10:38:48 2001
+++ 2.4.10/arch/alpha/kernel/time.c	Thu Oct  4 16:05:16 2001
@@ -332,6 +333,21 @@ time_init(void)
 	alpha_mv.init_rtc();
 
 	do_get_fast_time = do_gettimeofday;
+
+	/*
+	 * If we had wanted SRM console printk echoing early, undo it now.
+	 *
+	 * "srmcons" specified in the boot command arguments allows us to
+	 * see kernel messages during the period of time before the true
+	 * console device is "registered" during console_init(). As of this
+	 * version (2.4.10), time_init() is the last Alpha-specific code
+	 * called before console_init(), so we put this "unregister" code
+	 * here to prevent schizophrenic console behavior later... ;-}
+	 */
+	if (alpha_using_srm && srmcons_output) {
+		unregister_srm_console();
+		srmcons_output = 0;
+	}
 }
 
 /*
