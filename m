Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263037AbTEMAbk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 20:31:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263038AbTEMAbk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 20:31:40 -0400
Received: from lisa.JS.Jura.Uni-Goettingen.de ([134.76.166.209]:2993 "EHLO
	lisa.goe.net") by vger.kernel.org with ESMTP id S263037AbTEMAbd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 20:31:33 -0400
Date: Tue, 13 May 2003 02:43:14 +0200
From: Bernhard Kaindl <bk@suse.de>
X-X-Sender: bkaindl@hase.a11.local
To: Matthew Grant <grantma@anathoth.gen.nz>, Jeff Dike <jdike@karaya.com>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       Bernhard Kaindl <bernhard.kaindl@gmx.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [patch] Fix -EPERM returned by kernel_thead() if traced...
Message-ID: <Pine.LNX.4.53.0305130057420.1713@hase.a11.local>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1283901862-1552911378-1052695740=:1572"
Content-ID: <Pine.LNX.4.53.0305120129100.1572@hase.a11.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1283901862-1552911378-1052695740=:1572
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.53.0305120129101.1572@hase.a11.local>

Hi,
   as I wrote some days ago, there is another side effect
caused by the initial 2.4.21-pre ptrace/kmod secfix which
I believe is fixable:

> It results in modules not being loaded if the tasks which
> would normally cause them being loaded are traced.
>
> No error code is returned to the traced process in this case and
> and a printk() like this is triggered by the kernel:
>
> kernel: request_module[nfsd]: fork failed, errno 1

I've produced this by attempting to run the knfsd start script with
strace(compiled knfsd as module which was not yet loaded)

Starting FreeS/WAN with strace is another example where you could
hit this if this is the first start of FreeS/WAN.

I guess my patch could also help other ptrace users like User Mode Linux
and I've heard Wine in case they need to trigger a module load while
the task doing the syscall which triggers the load is being traced.

Given the previous descriptions I gave about the ptrace/kmod fix,
changing this place (the creation of a new kernel thread) seems
to be quite risky, but if you really think hard, you can see the
point I'm following.

The current kernel_thread() in 2.4.21-rc2 kernel/fork.c looks like
this (any locking removed to make it as simple as possible):

        if (task->ptrace)
                return -EPERM;

        task->task_dumpable = 0;

        ret = arch_kernel_thread(fn, arg, flags);

Ff the task is traced -EPERM is returned, otherwise task_dumpable = 0
is set, to forbid ptrace_attach() to attach to the thread.

Two scenarios:

a) task traced here -> -EPERM
b) task not traced here, but ptrace_attach() to new task:
   -> -EPERM because ptrace_attach() checks task_dumpable which is 0.

so it's safe, and with poper SMP locking (omitted above, but in the real
code) it's also SMP safe.

I've done very hard thinking on how it's possible to fix this and it's
quite suprising how easy it was:

It's again just removal of code! :-) (Yes, funny)

If you read all the surrounding code, you see that kernel_thread() is
being called from various other places to create a new thread which
may become privileged. Now it's neccesary to prevent that somebody
can later run ptrace_attach() against the new pid and attach to it
before it changes the uids and makes itself privileged, which is
the point where, if the task executes user code again, it could
be used for an exploit.

But this is prevented as long as the new thread always has
task->task_dumpable set to 0, at which ptrace_attach aborts.

so case b) is safe as long as task_dumpable is always 0 in the
new thread to prevent the attach before it changes gives itself
privileges.

Now, interestingy, you can just remove the

        if (task->ptrace)
                return -EPERM;

from kernel_thread() and let the traced task do the creation
of the new thread. You are protected against b) because of the
task_dumpable flag and I think you are safe against a) - task
being traced already because:

  arch_kernel_thread() calls clone() which calls do_fork() which
  creates a new task_struct by:

 		p = alloc_task_struct();
		if (!p)
			goto fork_out;

	        *p = *current;

  So at first, it copies the complete task_struct, including
  task_dumpable *and* ptrace.

  But later on, it calls copy_flags() which does this:

        if (!(clone_flags & CLONE_PTRACE))
                p->ptrace = 0;

  So unless someone sets CLONE_PTRACE in the clone_flags passed
  to kernel_thread(), which it passed on to clone() and do_fork()
  ptrace is not copied to the new task.

  kernel_thread() is not a system call(would be bad if), it's
  a kernel function to create kernel threads and to have CLONE_PTRACE
  passed to it, the kernel would have to accept clone_flags from
  the user for creating a kernel thread. So far I have not found
  such code, grep did not find anything and I think it would be
  really weird.

  So I really have to assume that CLONE_PTRACE is never passed
  to create a kernel thread. If you are paranoid, you could just
  unmask it in kernel_thread() if you want.

But finally, because of fork()/clone() disables ptrace by
default for the new task, the new task is effectively detached
from the tracer (can't do a ptrace call on it) and nobody
can attach to it(because task_dumpable is 0).

The minimum diff is:

--- kernel/fork.c
+++ kernel/fork.c
@@ -644,16 +644,9 @@
 	unsigned old_task_dumpable;
 	long ret;

-	/* lock out any potential ptracer */
-	task_lock(task);
-	if (task->ptrace) {
-		task_unlock(task);
-		return -EPERM;
-	}
-
 	old_task_dumpable = task->task_dumpable;
+	/* prevent ptrace_attach() on the new task: */
 	task->task_dumpable = 0;
-	task_unlock(task);

 	ret = arch_kernel_thread(fn, arg, flags);


Yes, it looks Evil ;-) But AFAICS it's ok and I've tested it on
my laptop... Note this code (the whole function) was added by
the original code, so it's quite new code which is changed, not
old code.

I'd have to do some tests on bigger SMP machines and some people
trying their exploits on their machine to feel really convinced
that it is correct.

Ok, start flooding me with mail about this terrible looking patch,
but I also hope some people will like to try it and run their clever
exploits against it and tell what they get... I'm interested.

Maybe I've overlooked something, but so far, I could not find it,
so any specific hint is appreciated...

Bernhard

PS:
I've tried some other attempts, but this is the
cleanest way I've found (and also the simplest)
--1283901862-1552911378-1052695740=:1572
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="ptrace-kmod-2.4.21-rc2.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.53.0305120129000.1572@hase.a11.local>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="ptrace-kmod-2.4.21-rc2.diff"

LS0tIGxpbnV4LTIuNC4yMS1yYzIva2VybmVsL2ZvcmsuYw0KKysrIGxpbnV4
LTIuNC4yMS1yYzItYmsxL2tlcm5lbC9mb3JrLmMNCkBAIC01NzIsMjEgKzU3
MiwxMyBAQA0KIAl1bnNpZ25lZCBvbGRfdGFza19kdW1wYWJsZTsNCiAJbG9u
ZyByZXQ7DQogDQotCS8qIGxvY2sgb3V0IGFueSBwb3RlbnRpYWwgcHRyYWNl
ciAqLw0KLQl0YXNrX2xvY2sodGFzayk7DQotCWlmICh0YXNrLT5wdHJhY2Up
IHsNCi0JCXRhc2tfdW5sb2NrKHRhc2spOw0KLQkJcmV0dXJuIC1FUEVSTTsN
Ci0JfQ0KLQ0KLQlvbGRfdGFza19kdW1wYWJsZSA9IHRhc2stPnRhc2tfZHVt
cGFibGU7DQorCS8qIGxvY2sgb3V0IGFueSBwb3RlbnRpYWwgcHRyYWNlciBm
b3IgdGhlIG5ldyB0YXNrX3N0cnVjdCBjb3B5ICovDQogCXRhc2stPnRhc2tf
ZHVtcGFibGUgPSAwOw0KLQl0YXNrX3VubG9jayh0YXNrKTsNCiANCiAJcmV0
ID0gYXJjaF9rZXJuZWxfdGhyZWFkKGZuLCBhcmcsIGZsYWdzKTsNCiANCiAJ
LyogbmV2ZXIgcmVhY2hlZCBpbiBjaGlsZCBwcm9jZXNzLCBvbmx5IGluIHBh
cmVudCAqLw0KLQljdXJyZW50LT50YXNrX2R1bXBhYmxlID0gb2xkX3Rhc2tf
ZHVtcGFibGU7DQorCXRhc2stPnRhc2tfZHVtcGFibGUgPSBvbGRfdGFza19k
dW1wYWJsZTsNCiANCiAJcmV0dXJuIHJldDsNCiB9DQo=

--1283901862-1552911378-1052695740=:1572--
