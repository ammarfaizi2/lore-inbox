Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287307AbSBKGbb>; Mon, 11 Feb 2002 01:31:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287303AbSBKGbW>; Mon, 11 Feb 2002 01:31:22 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27148 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S287289AbSBKGbQ>;
	Mon, 11 Feb 2002 01:31:16 -0500
Message-ID: <3C6764E6.DB1E8F8D@zip.com.au>
Date: Sun, 10 Feb 2002 22:29:58 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: John Weber <weber@nyc.rr.com>
CC: Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.4 Compile Error
In-Reply-To: <3C674CFA.2030107@nyc.rr.com> <3C6750CD.46575DAA@mandrakesoft.com> <3C675E6B.4010605@nyc.rr.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Weber wrote:
> 
> I don't know what the problem is, but un-inlining this function isn't
> correcting it.
> 

Try this:

--- linux-2.5.4/include/asm-i386/processor.h	Sun Feb 10 22:00:29 2002
+++ 25/include/asm-i386/processor.h	Sun Feb 10 22:21:53 2002
@@ -435,14 +435,7 @@ extern int kernel_thread(int (*fn)(void 
 /* Copy and release all segment info associated with a VM */
 extern void copy_segments(struct task_struct *p, struct mm_struct * mm);
 extern void release_segments(struct mm_struct * mm);
-
-/*
- * Return saved PC of a blocked thread.
- */
-static inline unsigned long thread_saved_pc(struct task_struct *tsk)
-{
-	return ((unsigned long *)tsk->thread->esp)[3];
-}
+extern unsigned long thread_saved_pc(struct task_struct *tsk);
 
 unsigned long get_wchan(struct task_struct *p);
 #define KSTK_EIP(tsk)	(((unsigned long *)(4096+(unsigned long)(tsk)->thread_info))[1019])
--- linux-2.5.4/arch/i386/kernel/process.c	Sun Feb 10 22:00:28 2002
+++ 25/arch/i386/kernel/process.c	Sun Feb 10 22:26:35 2002
@@ -55,6 +55,14 @@ asmlinkage void ret_from_fork(void) __as
 int hlt_counter;
 
 /*
+ * Return saved PC of a blocked thread.
+ */
+unsigned long thread_saved_pc(struct task_struct *tsk)
+{
+	return ((unsigned long *)tsk->thread.esp)[3];
+}
+
+/*
  * Powermanagement idle function, if any..
  */
 void (*pm_idle)(void);


-
