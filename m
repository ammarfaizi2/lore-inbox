Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751310AbWH1SeC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310AbWH1SeC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 14:34:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbWH1SeB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 14:34:01 -0400
Received: from wx-out-0506.google.com ([66.249.82.231]:31038 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751310AbWH1SeA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 14:34:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BAGriukdA0sCeeuY5F7zhuIzXFMSrgiR3ibvV7SAnsuamolhQMm1/+N9MrMLEcc3wBducXhF5GkfTeip6lUYALEmO1CSZqNpB3gb9cM+lB2OCwb980p2/aQ3fuBkzEKohQoxeXiJNM/x1w0d5aj6sNg2b9GOa1y6en4KcFGsnm8=
Message-ID: <e6babb600608281133q3597c42dsa88820ddd82f9d01@mail.gmail.com>
Date: Mon, 28 Aug 2006 11:33:59 -0700
From: "Robert Crocombe" <rcrocomb@gmail.com>
To: "hui Bill Huey" <billh@gnuppy.monkey.org>
Subject: Re: rtmutex assert failure (was [Patch] restore the RCU callback...)
Cc: "Esben Nielsen" <nielsen.esben@gmail.com>, "Ingo Molnar" <mingo@elte.hu>,
       "Thomas Gleixner" <tglx@linutronix.de>, rostedt@goodmis.org,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20060826104923.GA7879@gnuppy.monkey.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060822013722.GA628@gnuppy.monkey.org>
	 <e6babb600608231014r23886965k9cbc1fd3b80930bb@mail.gmail.com>
	 <20060823202046.GA17267@gnuppy.monkey.org>
	 <20060823210558.GA17606@gnuppy.monkey.org>
	 <20060823210842.GB17606@gnuppy.monkey.org>
	 <e6babb600608231822s1ce8b229ubdc85ce7544c6b4@mail.gmail.com>
	 <20060824014658.GB19314@gnuppy.monkey.org>
	 <20060825071957.GA30720@gnuppy.monkey.org>
	 <e6babb600608251824g7e61e28n1c453db05a4e773d@mail.gmail.com>
	 <20060826104923.GA7879@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/26/06, hui Bill Huey <billh@gnuppy.monkey.org> wrote:

> Stop using icecream or anything that might to any kind of binary object
> caching or header analysis to minimize compiles during the build. Make sure
> you're really cleaning the entire kernel directory before each build. Make
> sure it'a full build for starters.

Yes.

> Throw a #error in the __put_task_struct_inline(), not the alternative
> __put_task_struct(). It should bark at compile time and fail to compile
> kernel/fork.c

added

#ifdef CONFIG_PREEMPT_RT
void __put_task_struct_inline(struct task_struct *tsk)
    #error Boo, you can't do this.

then

[rcrocomb@spanky test_2.6.17-rt8]$ make clean ; make -j4 > /dev/null
  CLEAN   /home/rcrocomb/kernel/test_2.6.17-rt8
  CLEAN   arch/x86_64/ia32
  CLEAN   init
  CLEAN   usr
  CLEAN   .tmp_versions
kernel/fork.c:134:6: error: #error Boo, you can't do this.
make[1]: *** [kernel/fork.o] Error 1

> The function __put_task_struct() should never show up a stack trace
> EVER. That function has been rename under all things CONFIG_PREEMPT_RT
> under my addendum patches. That's why I'm starting to think it's your
> build environment or you're miss applying the patches.

from sched.h:

static inline void put_task_struct(struct task_struct *t)
{
        if (atomic_dec_and_test(&t->usage))
                __put_task_struct(t);
}

but is it used?

[rcrocomb@spanky test_2.6.17-rt8]$ find ./ -name \*.c -print0 | xargs
-0 grep -l "put_task_struct(" | wc -l
30

Yes it is.   Also, beginning at line 292 in what I call t6.diff (the
most recent URL, I believe):

+#ifdef CONFIG_PREEMPT_RT
.
.
.

+
+/*
+ * We dont want to do complex work from the scheduler with preemption
+ * disabled, therefore we delay the work to a per-CPU worker thread.
+ */
+void fastcall __put_task_struct(struct task_struct *task)
+{
+       struct list_head *head;
+
+       head = &get_cpu_var(delayed_put_task_struct_list);
+       list_add_tail(&task->delayed_drop, head);
+
+       _wake_cpu_desched_task();
+
+       put_cpu_var(delayed_put_task_struct_list);
+}
+#endif
+

So I think you're mistaken.  Patch is applied like this:

[rcrocomb@spanky test_2.6.17-rt8]$ patch -p0 < ../patches/t6.diff
patching file arch/x86_64/kernel/smp.c
patching file arch/x86_64/mm/numa.c
patching file fs/jbd/journal.c
patching file include/linux/hardirq.h
patching file include/linux/init_task.h
patching file include/linux/sched.h
patching file include/linux/seqlock.h
Hunk #1 succeeded at 1 with fuzz 1.
patching file kernel/exit.c
patching file kernel/fork.c
patching file kernel/panic.c
patching file kernel/printk.c
patching file kernel/rtmutex.c
patching file kernel/sched.c


Note that I've posted the sysrq stuff at:

http://66.93.162.249/~rcrocomb/2.6.16-rt8/

Sorry about screwing up your name: I turned 'hui' into your last name somehow.

-- 
Robert Crocombe
rcrocomb@gmail.com
