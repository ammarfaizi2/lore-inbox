Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261816AbVATSXo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261816AbVATSXo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 13:23:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261577AbVATSVw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 13:21:52 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:735 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261503AbVATSP2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 13:15:28 -0500
Date: Thu, 20 Jan 2005 12:14:30 -0600
From: Erik Jacobson <erikj@efs.americas.sgi.com>
To: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
cc: Andrew Morton <akpm@osdl.org>, Limin Gu <limin@engr.sgi.com>,
       Erich Focht <efocht@hpce.nec.com>, lkml <linux-kernel@vger.kernel.org>,
       LSE-Tech <lse-tech@lists.sourceforge.net>,
       elsa-devel <elsa-devel@lists.sourceforge.net>,
       Philip Mucci <mucci@cs.utk.edu>
Subject: Re: [Lse-tech] Re: [patch] Job - inescapable job containers
In-Reply-To: <1106224946.10947.131.camel@frecb000711.frec.bull.fr>
Message-ID: <Pine.SGI.4.53.0501201058540.42807@efs.americas.sgi.com>
References: <1106213319.17195.96.camel@frecb000711.frec.bull.fr>
 <1106224946.10947.131.camel@frecb000711.frec.bull.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> hooks. So, there is PAGG that offers hooks and is the right framework.
> But there is some other applications, like LTT or whatever, that will
> need new hooks. Isn't there a duplicate usage of hooks? Will it be
> interesting for Linux to provide some generic hooks because it seems
> that some (like in do_fork(), do_exit(), ... ) are often needed by
> applications instead of doing the job for security, accounting,
> tracing, ...

There are a couple ways to view PAGG.  We commonly look at it for its
"container" aspects and its use to "group otherwise unrelated tasks
together".  Job is based on this view.

Another way to view PAGG is as a hook manager.  When a task is created
(copy_process), kernel modules (PAGG users) are notified.  By default, the
new task has the same "tracking or PAGG" associations as the parent task.
But the kernel module author could also decide that there should be no
"tracking" for a given task.  In other words, the kernel module author can
control which tasks are being "tracked" and which are not.

We have a hook set up for exec, for example.  The way we decide if we want
notification when a task gets to exec is if the the task is being "tracked".
If it is, the kernel module (PAGG user) can be notified when that tracked
task is in exec and execute the associated callout.

We also have support of an "init" function pointer.  If the kernel mdoule
author uses this, then all current tasks in the system will be "tracked"
when the pagg hook is registered.  Kernel modules that need notification for
all tasks would implement this in the attach hook to get notification for
all tasks currently on the system, and all their children moving forward
(by default).

One reason this implementation could be better in some ways than just an
array of generic hook users is because, by default with PAGG, there is little
overhead.  The overhead starts increasing only when kernel modules begin to
need varous hooks.  Perhaps a typical system would only have a few tasks
being "tracked".

One could imagine that we could increase the number of hooks PAGG supports
as there is demand.

In summary - kernel module authors could use PAGG to manage tasks, decide
which tasks they cares about, and implement callouts when a task reaches
certain "hooks" in the kernel.

Here is a very simple exmaple I sometimes build on for testing PAGG.  Some
pieces of the example were contributed by Peter Williams.   Note that
I didn't include all pieces of the example (but can supply it if requested).
So this won't simply "compile" but should show my point.

Here is how we could define the pagg hook.  It shows which callouts we
wish to use.  exec, for example, can be NULL.

static struct pagg_hook pagg_hook = {
   .module = THIS_MODULE,
   .name = TEST_PAGG,
   .data = NULL,
   .entry = LIST_HEAD_INIT(pagg_hook.entry),
   .init = test_init,
   .attach = test_attach,
   .detach = test_detach,
   .exec = test_exec,
};


Here is how you might register with pagg for a given kernel module...

static int __init test_module_init(void)
{
   int rc = pagg_hook_register(&pagg_hook);
   if (rc < 0) {
      return -1;
   }

   return 0;
}


And here are a couple examples of the function pointers referenced in the
PAGG hook.

Since test_init is defined, it means all tasks on the system will
be "tracked" for this kernel module.  Of course, if a kernel module
doesn't need to know about all current processes, that module shouldn't
implement this.

static int test_init(struct task_struct *tsk, struct pagg *pagg)
{
   if (pagg_get(tsk, TEST_PAGG) == NULL)
      dprintk("ERROR PAGG expected \"%s\" PID = %d\n", TEST_PAGG, tsk->pid);

   dprintk("FYI PAGG init hook fired for PID = %d\n", tsk->pid);
   atomic_inc(&init_count);
   return 0;
}


This function would be executed when a parent forks - this is associated
with the pagg_attach callout in copy_process.  There would be a very
similar test_detach function (not shown).  This is also where kernel
author can control which tasks are "tracked" and which are not depending
on the function's return value.  A negative value results in the fork
failing.  zero is success.  >0 means success, but the function doesn't
want the task "tacked".

static int test_attach(struct task_struct *tsk, struct pagg *pagg, void *vp)
{
   dprintk("PAGG attach hook fired for PID = %d\n", tsk->pid);
   atomic_inc(&attach_count);

   return 0;
}



And here is an example function to run when a task gets to exec.  So any
time a "tracked" process gets to exec, this would execute.  More
hooks/callouts similar to this one could be implemented as there is demand
for them.

static void test_exec(struct task_struct *tsk, struct pagg *pagg)
{
   dprintk("PAGG exec hook fired for PID %d\n", tsk->pid);
   atomic_inc(&exec_count);

}



And finally, here is an example of cleaning up done in __exit.

static void __exit test_module_cleanup(void)
{
   pagg_hook_unregister(&pagg_hook);
   printk("detach called %d times...\n", atomic_read(&detach_count));
   printk("attach called %d times...\n", atomic_read(&attach_count));
   printk("init called %d times...\n", atomic_read(&init_count));
   printk("exec called %d times ...\n", atomic_read(&exec_count));
   if (atomic_read(&attach_count) + atomic_read(&init_count) !=
    atomic_read(&detach_count))
      printk("PAGG PROBLEM: attach count + init count SHOULD equal detach cound and doesn't\n");
   else
      printk("Good - attach count + init count equals detach count.\n");
}


Hopefully this helps explain what I'm talking about.

--
Erik Jacobson - Linux System Software - Silicon Graphics - Eagan, Minnesota
