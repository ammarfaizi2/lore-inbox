Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262144AbSJFTkz>; Sun, 6 Oct 2002 15:40:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262158AbSJFTkz>; Sun, 6 Oct 2002 15:40:55 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:1542
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S262146AbSJFTkL>; Sun, 6 Oct 2002 15:40:11 -0400
Subject: [PATCH] 2.4: introduce get_cpu() and put_cpu()
From: Robert Love <rml@tech9.net>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 06 Oct 2002 15:45:47 -0400
Message-Id: <1033933547.743.4472.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Master Marcelo,

In 2.5, it is unsafe to assume the current processor does not change out
from under you - thus you must be atomic when calling
smp_processor_id().  We introduced the get_cpu() and put_cpu() methods
to provide a safe way to access the current processor.

This patch back-ports those interfaces to 2.4.  Note they do nothing
special: get_cpu() simply returns smp_processor_id() and put_cpu() is a
no-op.  But this will allow easier back-porting from 2.5 and common
code-base for drivers, etc.  It also does not hurt to be explicit that
you do not want the processor to change.

As an example, I converted one use of smp_processor_id() to the new
interface.

Patch is against 2.4.20-pre9, please apply.

	Robert Love

diff -urN linux-2.4.20-pre9/arch/i386/kernel/ioport.c linux/arch/i386/kernel/ioport.c
--- linux-2.4.20-pre9/arch/i386/kernel/ioport.c	2002-10-06 14:58:01.000000000 -0400
+++ linux/arch/i386/kernel/ioport.c	2002-10-06 15:21:04.000000000 -0400
@@ -55,12 +55,15 @@
 asmlinkage int sys_ioperm(unsigned long from, unsigned long num, int turn_on)
 {
 	struct thread_struct * t = &current->thread;
-	struct tss_struct * tss = init_tss + smp_processor_id();
+	struct tss_struct * tss;
 
 	if ((from + num <= from) || (from + num > IO_BITMAP_SIZE*32))
 		return -EINVAL;
 	if (turn_on && !capable(CAP_SYS_RAWIO))
 		return -EPERM;
+
+	tss = init_tss + get_cpu();
+
 	/*
 	 * If it's the first ioperm() call in this thread's lifetime, set the
 	 * IO bitmap up. ioperm() is much less timing critical than clone(),
diff -urN linux-2.4.20-pre9/include/linux/smp.h linux/include/linux/smp.h
--- linux-2.4.20-pre9/include/linux/smp.h	2002-10-06 14:57:20.000000000 -0400
+++ linux/include/linux/smp.h	2002-10-06 15:11:00.000000000 -0400
@@ -87,5 +87,9 @@
 #define smp_call_function(func,info,retry,wait)	({ 0; })
 #define cpu_online_map				1
 
-#endif
-#endif
+#endif /* !CONFIG_SMP */
+
+#define get_cpu()	smp_processor_id()
+#define put_cpu()	do { } while(0)
+
+#endif /* __LINUX_SMP_H */

