Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316604AbSFZTwg>; Wed, 26 Jun 2002 15:52:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316803AbSFZTwf>; Wed, 26 Jun 2002 15:52:35 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:33294 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S316604AbSFZTwe>; Wed, 26 Jun 2002 15:52:34 -0400
Date: Wed, 26 Jun 2002 21:52:38 +0200
From: Pavel Machek <pavel@ucw.cz>
To: torvalds@transmeta.com, kernel list <linux-kernel@vger.kernel.org>
Subject: suspend-to-disk: prototype fixes
Message-ID: <20020626195237.GA3391@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Adding missing prototypes / changing code not to need
prototypes. Please apply,

							Pavel

--- clean/arch/i386/kernel/suspend.c	Wed Jun 26 20:18:53 2002
+++ linux-swsusp/arch/i386/kernel/suspend.c	Wed Jun 12 08:39:31 2002
@@ -97,6 +97,14 @@
 	asm volatile ("pushfl ; popl (%0)" : "=m" (saved_context.eflags));
 }
 
+static void
+do_fpu_end(void)
+{
+        /* restore FPU regs if necessary */
+	/* Do it out of line so that gcc does not move cr0 load to some stupid place */
+        kernel_fpu_end();
+}
+
 /*
  * restore_processor_context
  * 
@@ -220,13 +228,6 @@
 
 }
 
-static void
-do_fpu_end(void)
-{
-        /* restore FPU regs if necessary */
-	/* Do it out of line so that gcc does not move cr0 load to some stupid place */
-        kernel_fpu_end();
-}
 
 #ifdef CONFIG_SOFTWARE_SUSPEND
 /* Local variables for do_magic */
--- clean/include/asm-i386/suspend.h	Mon Jun 10 17:17:48 2002
+++ linux-swsusp/include/asm-i386/suspend.h	Wed Jun 12 08:42:43 2002
@@ -38,7 +38,6 @@
                        : /* no output */ \
                        :"r" ((thread)->debugreg[register]))
 
-extern void do_fpu_end(void);
 extern void fix_processor_context(void);
 extern void do_magic(int resume);
 
--- clean/include/linux/suspend.h	Wed Jun 26 20:19:08 2002
+++ linux-swsusp/include/linux/suspend.h	Wed Jun 12 08:43:51 2002
@@ -56,9 +56,22 @@
 extern int unregister_suspend_notifier(struct notifier_block *);
 extern void refrigerator(unsigned long);
 
+extern int freeze_processes(void);
+extern void thaw_processes(void);
+
 extern unsigned int nr_copy_pages __nosavedata;
 extern suspend_pagedir_t *pagedir_nosave __nosavedata;
 
+/* Communication between kernel/suspend.c and arch/i386/suspend.c */
+
+extern void do_magic_resume_1(void);
+extern void do_magic_resume_2(void);
+extern void do_magic_suspend_1(void);
+extern void do_magic_suspend_2(void);
+
+/* Communication between acpi and arch/i386/suspend.c */
+
+extern void do_suspend_lowlevel(int resume);
 
 #else
 #define software_suspend()		do { } while(0)

-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
