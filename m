Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317533AbSFEDFX>; Tue, 4 Jun 2002 23:05:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317535AbSFEDFW>; Tue, 4 Jun 2002 23:05:22 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:31475 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S317533AbSFEDFW>; Tue, 4 Jun 2002 23:05:22 -0400
Date: Tue, 4 Jun 2002 23:05:23 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [RFC] stack check patch for x86
Message-ID: <20020604230523.G9111@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey all,

This patch builds upon the 4KB stack patch by adding a stack check 
debug option.  It is set to trigger if less than 512 bytes of the 
stack are remaining, and hooks into code by means of gcc's -p option, 
which inserts calls to the mcount function.  When an overflow is 
detected, the code switches to a safety stack, and then proceeds 
to dump a backtrace and panic.  Comments?

		-ben
-- 
"You will be reincarnated as a toad; and you will be much happier."

:r ~/patches/v2.5.20/v2.5.20-stackcheck-A0.diff
diff -urN smallstack-2.5.20.diff/arch/i386/Makefile stackcheck-2.5.20.diff/arch/i386/Makefile
--- smallstack-2.5.20.diff/arch/i386/Makefile	Fri May 31 23:16:35 2002
+++ stackcheck-2.5.20.diff/arch/i386/Makefile	Tue Jun  4 21:10:16 2002
@@ -86,6 +86,10 @@
 CFLAGS += -march=i586
 endif
 
+ifdef CONFIG_X86_STACK_CHECK
+CFLAGS += -p
+endif
+
 HEAD := arch/i386/kernel/head.o arch/i386/kernel/init_task.o
 
 SUBDIRS += arch/i386/kernel arch/i386/mm arch/i386/lib
diff -urN smallstack-2.5.20.diff/arch/i386/boot/compressed/misc.c stackcheck-2.5.20.diff/arch/i386/boot/compressed/misc.c
--- smallstack-2.5.20.diff/arch/i386/boot/compressed/misc.c	Mon Nov 12 12:59:43 2001
+++ stackcheck-2.5.20.diff/arch/i386/boot/compressed/misc.c	Tue Jun  4 21:11:22 2002
@@ -381,3 +381,7 @@
 	if (high_loaded) close_output_buffer_if_we_run_high(mv);
 	return high_loaded;
 }
+
+/* We don't actually check for stack overflows this early. */
+__asm__(".globl mcount ; mcount: ret\n");
+
diff -urN smallstack-2.5.20.diff/arch/i386/kernel/i386_ksyms.c stackcheck-2.5.20.diff/arch/i386/kernel/i386_ksyms.c
--- smallstack-2.5.20.diff/arch/i386/kernel/i386_ksyms.c	Fri May 31 23:16:35 2002
+++ stackcheck-2.5.20.diff/arch/i386/kernel/i386_ksyms.c	Tue Jun  4 21:29:09 2002
@@ -176,3 +176,8 @@
 EXPORT_SYMBOL(is_sony_vaio_laptop);
 
 EXPORT_SYMBOL(__PAGE_KERNEL);
+
+#ifdef CONFIG_X86_STACK_CHECK
+extern void mcount(void);
+EXPORT_SYMBOL(mcount);
+#endif
