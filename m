Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750712AbWH2EF3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbWH2EF3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 00:05:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751083AbWH2EF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 00:05:29 -0400
Received: from wx-out-0506.google.com ([66.249.82.238]:25518 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750712AbWH2EF2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 00:05:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mbBR1TnVK/WWTr1csZ56+xNRTIKj8YWxcGU++tpcOTnRcuVZMBNLAPAOEFYXJVG+tjDgYTMkgUl3r67JJ5SUIGaak69oZhhPQLiAJTU7H9XWKHsqPC8zmtZwIJ8yspgLNS3w521Np12zff87pLoE2RShiU7M+q3PTs2ou6RP53Y=
Message-ID: <e6babb600608282105v7d8c90b0g6631414b3f868e3c@mail.gmail.com>
Date: Mon, 28 Aug 2006 21:05:27 -0700
From: "Robert Crocombe" <rcrocomb@gmail.com>
To: "hui Bill Huey" <billh@gnuppy.monkey.org>
Subject: Re: rtmutex assert failure (was [Patch] restore the RCU callback...)
Cc: "Esben Nielsen" <nielsen.esben@gmail.com>, "Ingo Molnar" <mingo@elte.hu>,
       "Thomas Gleixner" <tglx@linutronix.de>, rostedt@goodmis.org,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20060828202827.GA3625@gnuppy.monkey.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <e6babb600608231014r23886965k9cbc1fd3b80930bb@mail.gmail.com>
	 <20060823210558.GA17606@gnuppy.monkey.org>
	 <20060823210842.GB17606@gnuppy.monkey.org>
	 <e6babb600608231822s1ce8b229ubdc85ce7544c6b4@mail.gmail.com>
	 <20060824014658.GB19314@gnuppy.monkey.org>
	 <20060825071957.GA30720@gnuppy.monkey.org>
	 <e6babb600608251824g7e61e28n1c453db05a4e773d@mail.gmail.com>
	 <20060826104923.GA7879@gnuppy.monkey.org>
	 <e6babb600608281133q3597c42dsa88820ddd82f9d01@mail.gmail.com>
	 <20060828202827.GA3625@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/28/06, hui Bill Huey <billh@gnuppy.monkey.org> wrote:

> I was unclear in explain that __put_task_struct() should never
> appear with free_task() in a stack trace as you can clearly see
> from the implementation. All it's suppose to do is wake a thread,
> so "how?" you're getting those things simultaneously in the stack
> trace is completely baffling to me. Could you double check to see
> if it's booting the right kernel ? maybe make sure that's calling
> that version of the function with printks or something ?

So I built another kernel with the most recent "t6" patches from
scratch and stuck in a directory 2.6.17-rt8-mrproper.

[rcrocomb@spanky ~]$ cd kernel/
[rcrocomb@spanky kernel]$ rm -Rf test_2.6.17-rt8/
[rcrocomb@spanky kernel]$ tar xf source/linux-2.6.16.tar
[rcrocomb@spanky kernel]$ mv linux-2.6.16/ 2.6.17-rt8-mrproper
[rcrocomb@spanky kernel]$ cd 2.6.17-rt8-mrproper/
[rcrocomb@spanky 2.6.17-rt8-mrproper]$ patch -s -p1 < ../patches/patch-2.6.17
[rcrocomb@spanky 2.6.17-rt8-mrproper]$ patch -s -p1 <
../patches/patch-2.6.17-rt8
[rcrocomb@spanky 2.6.17-rt8-mrproper]$ patch -s -p0 < ../patches/t6.diff
[rcrocomb@spanky 2.6.17-rt8-mrproper]$ uname -r
2.6.17-rt8_UP_00
[rcrocomb@spanky 2.6.17-rt8-mrproper]$ zcat /proc/config.gz > ./.config
[rcrocomb@spanky 2.6.17-rt8-mrproper]$ make oldconfig

I added some printk()s:

[rcrocomb@spanky 2.6.17-rt8-mrproper]$ diff -u
~/kernel/2.6.17-rt8-t6/kernel/fork.c kernel/fork.c
--- /home/rcrocomb/kernel/2.6.17-rt8-t6/kernel/fork.c   2006-08-25
13:32:43.000000000 -0700
+++ kernel/fork.c       2006-08-28 19:52:22.000000000 -0700
@@ -1753,12 +1753,16 @@
 {
        struct list_head *head;

+        printk(KERN_DEBUG "+");
+
        head = &get_cpu_var(delayed_put_task_struct_list);
        list_add_tail(&task->delayed_drop, head);

        _wake_cpu_desched_task();

        put_cpu_var(delayed_put_task_struct_list);
+
+        printk(KERN_DEBUG "-\n");
 }
 #endif

but these make the machine sad:

+<3>BUG: sleeping function called from invalid context modprobe(2927)
at kernel/rtmutex.c:777
in_atomic():1 [00000001], irqs_disabled():0

Call Trace:
       <ffffffff80304596>{vgacon_cursor+470}
       <ffffffff8020b2c6>{__might_sleep+271}
       <ffffffff8025f276>{rt_lock+155}
       <ffffffff80337cb6>{serial8250_console_write+86}
       <ffffffff803310e1>{vt_console_print+550}
       <ffffffff80279c24>{__call_console_drivers+75}
       <ffffffff80279c9b>{_call_console_drivers+102}
       <ffffffff80215e11>{release_console_sem+372}
       <ffffffff8027a212>{vprintk+671}
       <ffffffff802629c9>{__switch_to+42}
       <ffffffff8028f2ff>{debug_rt_mutex_lock+186}
       <ffffffff8027a2cd>{printk+103}
       <ffffffff80244d0b>{try_to_wake_up+358}
       <ffffffff802629c9>{__switch_to+42}
       <ffffffff80245886>{__put_task_struct+26}
       <ffffffff8025d556>{thread_return+144}
       <ffffffff80278939>{rt_mutex_setprio+206}
       <ffffffff8025d662>{preempt_schedule+80}
       <ffffffff8028d9af>{rt_mutex_adjust_prio+80}
       <ffffffff8025ec99>{rt_lock_slowunlock+181}
       <ffffffff8025f1d9>{__lock_text_start+9}
       <ffffffff8025f4c5>{rt_write_unlock+9}
       <ffffffff802149df>{do_exit+2100}
       <ffffffff8028f452>{debug_rt_mutex_unlock+293}
       <ffffffff80246f79>{cpu_idle+0}
       <ffffffff8024a87a>{sys_exit_group+18}
       <ffffffff8025964e>{system_call+126}
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<ffffffff8025d003>] .... __schedule+0xb3/0x576
.....[<ffffffff8025d662>] ..   ( <= preempt_schedule+0x50/0x81)
-

I originally was using KERN_ERR, but the machine wouldn't finish
booting, so I thought that by using KERN_DEBUG, I could boot it and
then switch loglevels with Sysrq.  So I think it's relatively assured
that it is indeed going into this version of __put_task_struct().  If
it's at all valuable, the last character printing before lockup was
always the "+" character, but this last char is only on the video
console and not the serial.

Err, I hope this is what you meant.  I have unlimited bits, and can
sprinkle them whereever you'd like.

Also, I switched up configs a bit (disabling a few debugging options)
because I was curious as to what gcc -E would show when processing
fork.c, and it appeared that lots of code could be snipped by doing
this.  I kinda hoped there was some cool GNU utility to generate a
static call graph or similar (I was trying to find how free_task()
could come after __put_task_struct() as you mentioned).  I've appended
a diff of the config from the original UP kernel and 'mrproper''.
Note that UP is vanilla 2.6.17-rt8 while mrproper includes your t6
patches (but its CONFIG_LOCALVERSION is UP_01 vs UP_00: consistency is
not my strong suit).

After the config diff is the result of the command:

gcc -D__KERNEL__ -I../include -E fork.c

(which I hope is reasonable) while in the kernel directory.  I hoped
that a free_task() would magically appear, but was disappointed, and
tracing down and expanding all the various functions made me dizzy.
Someone needs to hook 'sparse' and graphviz together >:<.

-- 
Robert Crocombe
rcrocomb@gmail.com

[rcrocomb@spanky 2.6.17-rt8-mrproper]$ diff -u
~/kernel/2.6.17-rt8-UP/.config ./.config
--- /home/rcrocomb/kernel/2.6.17-rt8-UP/.config 2006-08-25
17:14:28.000000000 -0700
+++ ./.config   2006-08-28 19:57:33.000000000 -0700
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.17-rt8
-# Fri Aug 25 17:14:28 2006
+# Mon Aug 28 19:57:33 2006
 #
 CONFIG_X86_64=y
 CONFIG_64BIT=y
@@ -30,7 +30,7 @@
 #
 # General setup
 #
-CONFIG_LOCALVERSION="_UP_00"
+CONFIG_LOCALVERSION="_UP_01"
 CONFIG_LOCALVERSION_AUTO=y
 CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
@@ -1026,19 +1026,10 @@
 CONFIG_DEBUG_RT_MUTEXES=y
 CONFIG_DEBUG_PI_LIST=y
 # CONFIG_RT_MUTEX_TESTER is not set
-CONFIG_WAKEUP_TIMING=y
-CONFIG_WAKEUP_LATENCY_HIST=y
+# CONFIG_WAKEUP_TIMING is not set
 CONFIG_PREEMPT_TRACE=y
-CONFIG_CRITICAL_PREEMPT_TIMING=y
-CONFIG_PREEMPT_OFF_HIST=y
-CONFIG_CRITICAL_IRQSOFF_TIMING=y
-CONFIG_INTERRUPT_OFF_HIST=y
-CONFIG_CRITICAL_TIMING=y
-CONFIG_DEBUG_TRACE_IRQFLAGS=y
-CONFIG_LATENCY_TIMING=y
-CONFIG_CRITICAL_LATENCY_HIST=y
-CONFIG_LATENCY_HIST=y
-# CONFIG_LATENCY_TRACE is not set
+# CONFIG_CRITICAL_PREEMPT_TIMING is not set
+# CONFIG_CRITICAL_IRQSOFF_TIMING is not set
 # CONFIG_DEBUG_KOBJECT is not set
 CONFIG_DEBUG_INFO=y
 # CONFIG_DEBUG_FS is not set

All the formatting is mine own, and I stripped some do-while (0)s.

void __put_task_struct(struct task_struct *task)
{
    struct list_head *head;

    head = &(*(
    {

        add_preempt_count(1);
        __asm__ __volatile__("": : :"memory");

        &(*(
        {
            unsigned long __ptr;
            __asm__ ("" : "=r"(__ptr) :
"0"(&per_cpu__delayed_put_task_struct_list));
            (typeof(&per_cpu__delayed_put_task_struct_list)) (__ptr + ((
            {
                typeof(((struct x8664_pda *)0)->data_offset) ret__;

                switch ((sizeof(((struct x8664_pda *)0)->data_offset)))
                {
                case 2: asm volatile(BLORP_A); break; // it's all asm.
 I have it, if you care
                case 4: asm volatile(BLORP_B); break;
                case 8: asm volatile(BLORP_C); break;
                default: __bad_pda_field();
                }

                ret__;
            }
            )));
        }));

    }));

    list_add_tail(&task->delayed_drop, head);

    _wake_cpu_desched_task();

    __asm__ __volatile__("": : :"memory");
    sub_preempt_count(1);
    __asm__ __volatile__("": : :"memory");

    if (__builtin_expect(!!(test_ti_thread_flag(current_thread_info(), 3)), 0))
        preempt_schedule();
}
