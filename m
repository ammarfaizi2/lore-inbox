Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262365AbTH2VxO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 17:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262396AbTH2VxO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 17:53:14 -0400
Received: from notes.hallinto.turkuamk.fi ([195.148.215.149]:50697 "EHLO
	notes.hallinto.turkuamk.fi") by vger.kernel.org with ESMTP
	id S262365AbTH2Vw7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 17:52:59 -0400
Message-ID: <3F4FCCC6.4020501@kolumbus.fi>
Date: Sat, 30 Aug 2003 00:59:34 +0300
From: =?ISO-8859-1?Q?Mika_Penttil=E4?= <mika.penttila@kolumbus.fi>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 4G/4G preempt on vstack
References: <Pine.LNX.4.44.0308292151480.1816-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0308292151480.1816-100000@localhost.localdomain>
X-MIMETrack: Itemize by SMTP Server on marconi.hallinto.turkuamk.fi/TAMK(Release 5.0.8 |June
 18, 2001) at 30.08.2003 00:54:31,
	Serialize by Router on notes.hallinto.turkuamk.fi/TAMK(Release 5.0.10 |March
 22, 2002) at 30.08.2003 00:53:53,
	Serialize complete at 30.08.2003 00:53:53
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hmm. you make the window smaller, but can't the preempt happen even 
inside repeat_if_esp_changed, after xorl? Disabling interrupts seems the 
only solution.

---Mika


Hugh Dickins wrote:

>Repeated -j3 kernel builds, run in tandem on dual PIII, have been
>collapsing recently on -mm with 4G/4G split, SMP and preemption.
>Typically 'make' fails with Error 139 because 'as' or another
>got SIGSEGV; maybe within ten minutes, maybe after ten hours.
>
>This patch seems to fix that (ran successfully overnight on test4-mm1,
>will run over the weekend on test4-mm3-1).  Please cast a critical eye
>over it, I expect Ingo or someone else will find it can be improved.
>
>The problem is that a task may be preempted just after it has entered
>kernelspace, while using the transitional "virtual stack" i.e. %esp
>pointing to high per-cpu kmap of the kernel stack.  If the task resumes
>on another cpu, that %esp needs to be repointed into the new cpu's kmap.
>
>The corresponding returns to userspace look okay to me: interrupts are
>disabled over the critical points.  And in general no copy is taken of
>%esp while on the virtual stack e.g. setting pointer to pt_regs is and
>must be done after switching to real stack.  But there's one place in
>__SWITCH_KERNELSPACE itself where we need to check and repeat if moved.
>
>Hugh
>
>--- 2.6.0-test4-mm3-1/arch/i386/kernel/entry.S	Fri Aug 29 16:31:30 2003
>+++ linux/arch/i386/kernel/entry.S	Fri Aug 29 20:53:33 2003
>@@ -103,6 +103,20 @@
> 
> #ifdef CONFIG_X86_SWITCH_PAGETABLES
> 
>+#if defined(CONFIG_PREEMPT) && defined(CONFIG_SMP)
>+/*
>+ * If task is preempted in __SWITCH_KERNELSPACE, and moved to another cpu,
>+ * __switch_to repoints %esp to the appropriate virtual stack; but %ebp is
>+ * left stale, so we must check whether to repeat the real stack calculation.
>+ */
>+#define repeat_if_esp_changed				\
>+	xorl %esp, %ebp;				\
>+	testl $0xffffe000, %ebp;			\
>+	jnz 0b
>+#else
>+#define repeat_if_esp_changed
>+#endif
>+
> /* clobbers ebx, edx and ebp */
> 
> #define __SWITCH_KERNELSPACE				\
>@@ -117,12 +131,13 @@
> 	movl $swapper_pg_dir-__PAGE_OFFSET, %edx;	\
> 							\
> 	/* GET_THREAD_INFO(%ebp) intermixed */		\
>-							\
>+0:							\
> 	movl %esp, %ebp;				\
> 	movl %esp, %ebx;				\
> 	andl $0xffffe000, %ebp;				\
> 	andl $0x00001fff, %ebx;				\
> 	orl TI_real_stack(%ebp), %ebx;			\
>+	repeat_if_esp_changed;				\
> 							\
> 	movl %edx, %cr3;				\
> 	movl %ebx, %esp;				\
>--- 2.6.0-test4-mm3-1/arch/i386/kernel/process.c	Fri Aug 29 16:31:30 2003
>+++ linux/arch/i386/kernel/process.c	Fri Aug 29 20:53:33 2003
>@@ -479,13 +479,27 @@
> 	__kmap_atomic(next->stack_page1, KM_VSTACK1);
> 
> 	/*
>-	 * Reload esp0:
>-	 */
>-	/*
> 	 * NOTE: here we rely on the task being the stack as well
> 	 */
> 	next_p->thread_info->virtual_stack = (void *)__kmap_atomic_vaddr(KM_VSTACK0);
>+
>+#if defined(CONFIG_PREEMPT) && defined(CONFIG_SMP)
>+	/*
>+	 * If next was preempted on entry from userspace to kernel,
>+	 * and now it's on a different cpu, we need to adjust %esp.
>+	 * This assumes that entry.S does not copy %esp while on the
>+	 * virtual stack (with interrupts enabled): which is so,
>+	 * except within __SWITCH_KERNELSPACE itself.
>+	 */
>+	if (unlikely(next->esp >= TASK_SIZE)) {
>+		next->esp &= THREAD_SIZE - 1;
>+		next->esp |= (unsigned long) next_p->thread_info->virtual_stack;
>+	}
>+#endif
> #endif
>+	/*
>+	 * Reload esp0:
>+	 */
> 	load_esp0(tss, virtual_esp0(next_p));
> 
> 	/*
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>

