Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265467AbUEUKHq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265467AbUEUKHq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 06:07:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265474AbUEUKHq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 06:07:46 -0400
Received: from gprs214-158.eurotel.cz ([160.218.214.158]:13954 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S265467AbUEUKHn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 06:07:43 -0400
Date: Fri, 21 May 2004 12:07:34 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: swsusp: fix swsusp with intel-agp
Message-ID: <20040521100734.GA31550@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

swsusp contained rather nasty bug where it killed machine when
intel-agp or anything else split kernel 4MB mapping. Herbert Xu
diagnosed this. Fixed by switching to "known good" mapping for during
suspend/resume.

Please apply,
							Pavel

--- tmp/linux/arch/i386/mm/init.c	2004-05-20 23:08:05.000000000 +0200
+++ linux/arch/i386/mm/init.c	2004-05-20 23:10:50.000000000 +0200
@@ -331,6 +331,13 @@
 void zap_low_mappings (void)
 {
 	int i;
+
+#ifdef CONFIG_SOFTWARE_SUSPEND
+	{
+		extern char swsusp_pg_dir[PAGE_SIZE];
+		memcpy(swsusp_pg_dir, swapper_pg_dir, PAGE_SIZE);
+	}
+#endif
 	/*
 	 * Zap initial low-memory mappings.
 	 *
--- tmp/linux/arch/i386/power/cpu.c	2004-05-20 23:08:05.000000000 +0200
+++ linux/arch/i386/power/cpu.c	2004-05-20 23:10:50.000000000 +0200
@@ -35,6 +35,10 @@
 unsigned long saved_context_esi, saved_context_edi;
 unsigned long saved_context_eflags;
 
+/* Special page directory for resume */
+char __nosavedata swsusp_pg_dir[PAGE_SIZE]
+                  __attribute__ ((aligned (PAGE_SIZE)));
+
 extern void enable_sep_cpu(void *);
 
 void save_processor_state(void)
--- tmp/linux/arch/i386/power/swsusp.S	2004-05-20 23:08:05.000000000 +0200
+++ linux/arch/i386/power/swsusp.S	2004-05-20 23:11:05.000000000 +0200
@@ -36,7 +38,7 @@
 	jmp .L1449
 	.p2align 4,,7
 .L1450:
-	movl $swapper_pg_dir-__PAGE_OFFSET,%ecx
+	movl $swsusp_pg_dir-__PAGE_OFFSET,%ecx
 	movl %ecx,%cr3
 
 	call do_magic_resume_1
@@ -56,8 +58,6 @@
 	movl (%ecx,%eax),%eax
 	movb (%edx,%eax),%al
 	movb %al,(%edx,%ebx)
-	movl %cr3, %eax;              
-	movl %eax, %cr3;  # flush TLB 
 
 	movl loop2,%eax
 	leal 1(%eax),%edx
--- tmp/linux/include/asm-i386/suspend.h	2003-09-28 22:06:36.000000000 +0200
+++ linux/include/asm-i386/suspend.h	2004-04-27 23:10:24.000000000 +0200
@@ -9,6 +9,9 @@
 static inline int
 arch_prepare_suspend(void)
 {
+	/* If you want to make non-PSE machine work, turn off paging
+           in do_magic. swsusp_pg_dir should have identity mapping, so
+           it could work...  */
 	if (!cpu_has_pse)
 		return -EPERM;
 	return 0;

-- 
934a471f20d6580d5aad759bf0d97ddc
