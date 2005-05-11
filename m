Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262028AbVEKTag@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262028AbVEKTag (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 15:30:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262029AbVEKTag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 15:30:36 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:52670 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262028AbVEKT32 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 15:29:28 -0400
Subject: Re: BUGs in 2.6.12-rc2-RT-V0.7.45-01
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>, William Weston <weston@sysex.net>
Cc: linux-kernel@vger.kernel.org, dwalker@mvista.com
In-Reply-To: <Pine.LNX.4.58.0504151721410.18107@echo.lysdexia.org>
References: <Pine.LNX.4.58.0504121443310.3023@echo.lysdexia.org>
	 <20050412230921.GA22360@elte.hu>
	 <Pine.LNX.4.58.0504141352490.14125@echo.lysdexia.org>
	 <20050415080138.GA25262@elte.hu>
	 <Pine.LNX.4.58.0504151721410.18107@echo.lysdexia.org>
Content-Type: multipart/mixed; boundary="=-OW3Bxyhl+XOUmdVCuodB"
Organization: Kihon Technologies
Date: Wed, 11 May 2005 15:29:02 -0400
Message-Id: <1115839742.7763.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-OW3Bxyhl+XOUmdVCuodB
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Ingo,

I've seen lots of complaining about the yield BUG produced by
kstopmachine, and since I'm now starting to test this on an SMP machine,
I'm seeing it too.  So I've looked further into this, and here's what
I've found.

The kstopmachine creates one thread per CPU to run on each CPU.  It sets
this thread to the lowest RT priority and then spins on yield, each
thread expects to be on its designated CPU and spin until all threads
check in (all threads are on their expected CPU).  The yield is only to
allow one of the other threads (of same priority) to migrate to their
expected CPU if it started on the wrong CPU.  So the use of yield here
is actually correct!

So for this special case, I've included a patch here (attached) to allow
for a call of yield when it is actually OK for a RT task to call yield.
It's called rt_yield.  Take a look and see what you think.  I patched
this against 45-01 since that's what I'm currently working with.

-- Steve

On Fri, 2005-04-15 at 18:24 -0700, William Weston wrote:
> On Fri, 15 Apr 2005, Ingo Molnar wrote:
[...]
> 
> With 2.6.12-rc2-V0.7.44-03, the P4/HT box has been stable all day.  I'm 
> seeing another BUG on boot, not kprobes related this time:
> 
> Freeing unused kernel memory: 192k freed
> logips2pp: Detected unknown logitech mouse model 86
> input: ImExPS/2 Logitech Explorer Mouse on isa0060/serio1
> BUG: kstopmachine:1054 RT task yield()-ing!
>  [<c0103dba>] dump_stack+0x23/0x25 (20)
>  [<c030ff1f>] yield+0x67/0x69 (20)
>  [<c0142a44>] stop_machine+0xa4/0x15e (40)
>  [<c0142b2d>] do_stop+0x15/0x77 (20)
>  [<c0132c5b>] kthread+0xab/0xd3 (48)
>  [<c0100fe9>] kernel_thread_helper+0x5/0xb (563617812)
> ---------------------------
> | preempt count: 00000001 ]
> | 1-level deep critical section nesting:
> ----------------------------------------
> .. [<c013bca6>] .... print_traces+0x1b/0x52
> .....[<c0103dba>] ..   ( <= dump_stack+0x23/0x25)


--=-OW3Bxyhl+XOUmdVCuodB
Content-Disposition: attachment; filename=rt-yeild.patch
Content-Type: text/x-patch; name=rt-yeild.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit

Index: kernel/stop_machine.c
===================================================================
--- kernel/stop_machine.c	(revision 181)
+++ kernel/stop_machine.c	(working copy)
@@ -56,7 +56,7 @@
 		/* Yield in first stage: migration threads need to
 		 * help our sisters onto their CPUs. */
 		if (!prepared && !irqs_disabled)
-			yield();
+			rt_yield();
 		else
 			cpu_relax();
 	}
@@ -110,7 +110,7 @@
 
 	/* Wait for them all to come to life. */
 	while (atomic_read(&stopmachine_thread_ack) != stopmachine_num_threads)
-		yield();
+		rt_yield();
 
 	/* If some failed, kill them all. */
 	if (ret < 0) {
Index: kernel/sched.c
===================================================================
--- kernel/sched.c	(revision 181)
+++ kernel/sched.c	(working copy)
@@ -4288,7 +4288,7 @@
  * this is a shortcut for kernel-space yielding - it marks the
  * thread runnable and calls sys_sched_yield().
  */
-void __sched yield(void)
+static inline void __sched __yield(int rtok)
 {
 	static int once = 1;
 
@@ -4298,7 +4298,7 @@
 	 * us an idea about the scope of the problem, without spamming
 	 * the syslog:
 	 */
-	if (once && rt_task(current)) {
+	if (!rtok && once && rt_task(current)) {
 		once = 0;
 		printk(KERN_ERR "BUG: %s:%d RT task yield()-ing!\n",
 			current->comm, current->pid);
@@ -4308,7 +4308,18 @@
 	sys_sched_yield();
 }
 
+void __sched yield(void)
+{
+	__yield(0);
+}
+
+void __sched rt_yield(void)
+{
+	__yield(1);
+}
+
 EXPORT_SYMBOL(yield);
+EXPORT_SYMBOL(rt_yield);
 
 /*
  * This task is about to go to sleep on IO.  Increment rq->nr_iowait so
Index: include/linux/sched.h
===================================================================
--- include/linux/sched.h	(revision 181)
+++ include/linux/sched.h	(working copy)
@@ -1007,6 +1007,7 @@
 extern int mutex_getprio(task_t *p);
 
 void yield(void);
+void rt_yield(void);
 
 /*
  * The default (Linux) execution domain.

--=-OW3Bxyhl+XOUmdVCuodB--

