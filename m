Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262187AbSJFVCy>; Sun, 6 Oct 2002 17:02:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262188AbSJFVCy>; Sun, 6 Oct 2002 17:02:54 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:14345
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S262187AbSJFVCx>; Sun, 6 Oct 2002 17:02:53 -0400
Subject: Re: [PATCH] 2.4: introduce get_cpu() and put_cpu()
From: Robert Love <rml@tech9.net>
To: Kasper Dupont <kasperd@daimi.au.dk>
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
In-Reply-To: <3DA09EBE.D9E2E148@daimi.au.dk>
References: <1033933547.743.4472.camel@phantasy> 
	<3DA09EBE.D9E2E148@daimi.au.dk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 06 Oct 2002 17:08:24 -0400
Message-Id: <1033938505.26955.16.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-10-06 at 16:36, Kasper Dupont wrote:

> To me it really looks like you are missing a put_cpu() call somewhere.
> I know it is a no-op, but since you intend to show how to use it, I
> it really ought to be there.

Whoops, you are right.

> Does this look right?

Yep, thanks.

Marcelo, attached patch is a resend with the missing put_cpu()
included.  Please, apply.

	Robert Love

diff -urN linux-2.4.20-pre9/arch/i386/kernel/ioport.c linux/arch/i386/kernel/ioport.c
--- linux-2.4.20-pre9/arch/i386/kernel/ioport.c	2002-10-06 14:58:01.000000000 -0400
+++ linux/arch/i386/kernel/ioport.c	2002-10-06 16:53:04.000000000 -0400
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
@@ -84,6 +87,8 @@
 	set_bitmap(t->io_bitmap, from, num, !turn_on);
 	set_bitmap(tss->io_bitmap, from, num, !turn_on);
 
+	put_cpu();
+
 	return 0;
 }
 
diff -urN linux-2.4.20-pre9/include/linux/smp.h linux/include/linux/smp.h
--- linux-2.4.20-pre9/include/linux/smp.h	2002-10-06 14:57:20.000000000 -0400
+++ linux/include/linux/smp.h	2002-10-06 16:52:45.000000000 -0400
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

