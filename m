Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262176AbTEHVxs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 17:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262177AbTEHVxr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 17:53:47 -0400
Received: from ns.suse.de ([213.95.15.193]:39947 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262176AbTEHVxk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 17:53:40 -0400
Date: Fri, 9 May 2003 00:05:52 +0200 (CEST)
From: Bernhard Kaindl <bk@suse.de>
To: linux-kernel@vger.kernel.org, Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Bernhard Kaindl <bernhard.kaindl@gmx.de>
Subject: [PATCH][2.4] cleanup ptrace secfix and fix most side effects
Message-ID: <Pine.LNX.4.44.0305082310230.12720-200000@wotan.suse.de>
MIME-Version: 1.0
Content-Type: MULTIPART/Mixed; BOUNDARY="1283901862-669685055-1052348127=:1818"
Content-ID: <Pine.LNX.4.53.0305080102051.1818@hase.a11.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1283901862-669685055-1052348127=:1818
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.53.0305080102052.1818@hase.a11.local>

Hello,

The attached patch cleans up the too restrictive checks which were
included in the original ptrace/kmod secfix posted by Alan Cox
and applies on top of a clean 2.4.20-rc1 source tree.

It is the result of my continued work on fixing the side effects
introduced by the too restrictive checks which were included and
and I'm sending it here for review.

One side effect introduced by the ptrace/kmod secfix remains unfixed
for now: It results in modules not being loaded if the tasks which
would normally cause them being loaded are traced.

No error code is returned to the traced process in this case and
an printk like this is triggered by the kernel:

request_module[net-pf-15]: waitpid(4363,...) failed, errno 512

You could trigger this if you debug e.g. FreeS/WAN commands.

Fixing this is not as trivial as fixing other side effects, but
should be possible also.

I'm posting this cleanup because it fixes most side effects and
I don't know how long it will take to fix this remaining issue,
but I've a plan in preparation which should finally fix this last
issue.

For understanding the rest of this mail, the reader should have knowledge
about how the ptrace implementation in the linux kernel works, I don't have
a complete documentation at hand, please just send it if you know one.

For now, the best thing is to read all code paths which start at sys_ptrace()
in arch/i386/kernel/process.c, with background info from ptrace(2).

List of issues addressed by this cleanup:

Issue a:

Description: root is prevented from tracing not dumpable processes
Symptom:     root can't debug setuid applications
Problem:     The checks added to ptrace_check_attach() and access_process_vm()
             were too strict and at the wrong place.
Solution:    Revert the checks which were added to ptrace_check_attach() and
             access_process_vm().
Details:     ptrace_check_attach() is called by sys_ptrace() to verify if
             current has properly attached to child, no checks should be
             added there.
             The revert in to access_process_vm() is also needed. The dumpable
             check were not neccesary because ptrace_check_attach has to be
             always consulted before.
             The init_mm check there was also not neccesary as ptrace_attach
             already does the right check with task_dumpable and task->mm.

Issue b:

Description: /proc/<pid>/cmdline of not dumpable processes is empty
Symptom:     Broken process monitoring,
             e.g. running processes may be reported dead.
Problem:     The change in access_process_vm() affected not only ptrace.
	     access_process_vm() is also used by procfs which is changes
	     the userland interface for process monitoring tools
Solution:    Revert the check added to access_process_vm(), see description
             of issue a) for details about access_process_vm()

Issue c:

Description: priviliged tracers can cause processes hanging in stopped state
Symptom:     processes traced by root which call exec() for a setuid program
             or which call setuid finctions to change uids are left in stopped
             state, even ptrace detach is blocked.
Problem:     The checks added to ptrace_check_attach() and access_process_vm()
             were too strict and at the wrong place.
             The check in ptrace_attach() together with the other code is
             perfect.
Solution:    same as a)

Issue d:

Description: tracing processes which call prctl(PR_SET_DUMPABLE, 0)
             causes traced processes hanging in stopped state.
Symptom:     traced processes hang in stopped state after they called
             prctl(PR_SET_DUMPABLE, 0)
Problem:     The checks added to ptrace_check_attach() and access_process_vm()
             were too strict and at the wrong place.
Solution:    same as a)

Issue e:

Description: processes which want to change their dumpable status have
             prctl(PR_SET_DUMPABLE, 1) ignored.
Symptom:     Impossible to create a core dump of processes which changed uids,
             even if the process requests it by calling prctl(PR_SET_DUMPABLE,1)
Problem:     The change to the PR_SET_DUMPABLE in sys_prctl was too strict.
Solution:    Revert the change to the sys_prctl(PR_SET_DUMPABLE) case:
             No change was neccesary to prevent a thread with same mm to change
             task->mm->dumpable, because a kernel_thread() and ptrace_attach()
             use task->task_dumpable to forbid ptrace for a kernel thread.

Patch with comments added:
(no comments in the attached version)

--- kernel/ptrace.c
+++ kernel/ptrace.c
@@ -21,9 +21,6 @@
  */
 int ptrace_check_attach(struct task_struct *child, int kill)
 {
-	mb();
-	if (!is_dumpable(child))
-		return -EPERM;

 	if (!(child->ptrace & PT_PTRACED))
 		return -ESRCH;

Using is_dumpable() here is not neccesary because the checks done here are:

>        if (!(child->ptrace & PT_PTRACED))
>                return -ESRCH;
>
>        if (child->p_pptr != current)
>                return -ESRCH;

This means ptrace_check_attach() returns -ESRCH if "current" is not properly
attached as tracer to "child", which is the only check it is called for.

The only place where child->ptrace and child->p_pptr are set to the values
which pass this test, is ptrace_attach() which works as explained in the
ptrace fix description further down this mail.

In turn, ptrace_attach() does the is_dumpable check *before* setting
these fields.

And as kernel_thread() aborts if child->ptrace is set, a kernel
thread with ptrace flag set cannot be created and as this flag
is checked here, adding any other checks here hurts the implementation.

@@ -127,8 +124,6 @@ int access_process_vm(struct task_struct
 	/* Worry about races with exit() */
 	task_lock(tsk);
 	mm = tsk->mm;
-	if (!is_dumpable(tsk) || (&init_mm == mm))
-		mm = NULL;
 	if (mm)
 		atomic_inc(&mm->mm_users);
 	task_unlock(tsk);

Similar case here for the is_dumpable(tsk) check. access_process_vm()
is only called if ptrace_check_attach() passed it's tests.
See text above for more detail.

The check if &init_mm == mm is also not neccesary because kernel_thread()
sets task_dumpable to 0 which indicates a kernel thread and causes
ptrace_attach() to abort and because ptrace_check_attach() must pass
it's attach checks, access_process_vm() cannot be reached then.

So was with ptrace_check_attach, adding any check here is superflous
and can be harmful, which the is_dumpable check here already proofed
to be.

--- kernel/sys.c	2003/04/25 06:23:15	1.1
+++ kernel/sys.c	2003/04/25 06:23:51
@@ -1252,8 +1252,7 @@ asmlinkage long sys_prctl(int option, un
 				error = -EINVAL;
 				break;
 			}
-			if (is_dumpable(current))
-				current->mm->dumpable = arg2;
+			current->mm->dumpable = arg2;
 			break;

 	        case PR_SET_UNALIGN:

Adding is_dumpable(current) as guard against setting
current->mm->dumpable is not neccesary because mm->dumpable
is not checked in kmod creation, task_dumpable is used.

See the ptrace fix description for a detailed explanation further down
this mail.

Very Best Begards,
Bernhard Kaindl, SuSE Linux AG

PS:

Description of the last remaining side effect(already mentioned
the the beginning of the mail):

The current 2.4.20-rc1 code aborts the creation of the kernel thread
if it finds the task traced. This is a side effect of the patch which
may possibly be preventable by creating the new thread detached from
ptrace.

This could be done by disabling the ptrace status of the calling
task before calling arch_kernel_thread() and restoring the ptrace
status in the parent afterwards.

Other ways are also possible, but would either require assembler
changes to all architectures or adding a call to simial code to
a function which should be called from all kernel threads.

I think this can be also done in a later kernel release, because
it should not have the severity the other side effects have.

PPS:

Detailed description of the core of ptrace/kmod fix:
====================================================

You have to think SMP here, two processes can execute kernel code
at the same time so proper SMP-safe locking has to be ensured.

SMP is the reason why the task->task_dumpable flag is needed, which plays
a major role in the fix. It is 0 for all kernel threads created by the
new kernel_thread function, otherwise it's 1.

task->ptrace is the other important flag. It is used to indicate wether
task is being traced. It gets a bit set when a tracer attaches to the
task and if task->ptrace is 0, a tracer has to attach to the process
again to be able to trace.

The third important part is the task_lock, a spinlock within the
task_struct which holds the two important flags ptrace and task_dumpable.
It serves a tool to serialize and group the accesses to these flags
as if there would be only one CPU executing the code parts which are
surrounded by take and release this lock.

With this this power at hand, the kernel serializes the important code
section in ptrace_attach() with the corresponding code in kernel_thread():

Let me show you the relevant code of kernel_thread():

        /* lock out any potential ptracer */
spin>   task_lock(task);
check>  if (task->ptrace) {
                task_unlock(task);
exit>           return -EPERM;
        }

        old_task_dumpable = task->task_dumpable;
flag>   task->task_dumpable = 0;
unlock> task_unlock(task);

I've added tags here so you see:

- the take of the task lock:		task_lock(task);
- the check of the task->ptrace flag:   if (task->ptrace) {
  if ptraced:
  - the exit if task is being traced:         return -EPERM;
  if not:
  - the set of the task_dumpable flag to 0:   task->task_dumpable = 0;
- the release of the task lock:		task_unlock(task);

And finally you see the unlock of the task's spinlock which blocked
other code, possibly running on antoher CPU, waiting in busy loop
until this task_unlock is executed if it was trying to accesss the
same task.

This is the corresponding code in ptrace_attach():

spin>   task_lock(task);
        if (task->pid <= 1)
                goto bad;
        if (task == current)
                goto bad;
        if (!task->mm)
                goto bad;
        if(((current->uid != task->euid) ||
            (current->uid != task->suid) ||
            (current->uid != task->uid) ||
            (current->gid != task->egid) ||
            (current->gid != task->sgid) ||
            (!cap_issubset(task->cap_permitted, current->cap_permitted)) ||
            (current->gid != task->gid)) && !capable(CAP_SYS_PTRACE))
                goto bad;
        rmb();
check>  if (!is_dumpable(task) && !capable(CAP_SYS_PTRACE))
exit>           goto bad;
        /* the same process cannot be attached many times */
        if (task->ptrace & PT_PTRACED)
                goto bad;

        /* Go */
flag>   task->ptrace |= PT_PTRACED;
        if (capable(CAP_SYS_PTRACE))
                task->ptrace |= PT_PTRACE_CAP;
unlock> task_unlock(task);

I've added tags here so you see:

- the take of the task lock:         task_lock(task);
- the check of task_dumpable:        if (!is_dumpable(task)
  - the abort on a kernel thread:        goto bad;
- the set of the ptrace flag:        task->ptrace |= PT_PTRACED;
- the release of the task lock:	     task_unlock(task);

As there is no code which manipulates task->task_dumpable or
task->ptrace in a way which would allow to fool these checks
the code aboves prevents tracing kernel threads.

If you know a way to fool these checks, please tell me and Marcelo.
EOF

--1283901862-669685055-1052348127=:1818
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="ptrace-cleanup-1.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.53.0305080055270.1818@hase.a11.local>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="ptrace-cleanup-1.diff"

ZGlmZiAtck51IGxpbnV4LTIuNC4yMS1yYzEva2VybmVsL3B0cmFjZS5jIGxp
bnV4LTIuNC4yMS1yazEva2VybmVsL3B0cmFjZS5jDQotLS0gbGludXgtMi40
LjIxLXJjMS9rZXJuZWwvcHRyYWNlLmMJMjAwMy0wNS0wOCAwMDo0ODozOS4w
MDAwMDAwMDAgKzAyMDANCisrKyBsaW51eC0yLjQuMjEtcmsxL2tlcm5lbC9w
dHJhY2UuYwkyMDAzLTA1LTA4IDAwOjUzOjAyLjAwMDAwMDAwMCArMDIwMA0K
QEAgLTIxLDkgKzIxLDYgQEANCiAgKi8NCiBpbnQgcHRyYWNlX2NoZWNrX2F0
dGFjaChzdHJ1Y3QgdGFza19zdHJ1Y3QgKmNoaWxkLCBpbnQga2lsbCkNCiB7
DQotCW1iKCk7DQotCWlmICghaXNfZHVtcGFibGUoY2hpbGQpKQ0KLQkJcmV0
dXJuIC1FUEVSTTsNCiANCiAJaWYgKCEoY2hpbGQtPnB0cmFjZSAmIFBUX1BU
UkFDRUQpKQ0KIAkJcmV0dXJuIC1FU1JDSDsNCkBAIC0xNDAsOCArMTM3LDYg
QEANCiAJLyogV29ycnkgYWJvdXQgcmFjZXMgd2l0aCBleGl0KCkgKi8NCiAJ
dGFza19sb2NrKHRzayk7DQogCW1tID0gdHNrLT5tbTsNCi0JaWYgKCFpc19k
dW1wYWJsZSh0c2spIHx8ICgmaW5pdF9tbSA9PSBtbSkpDQotCQltbSA9IE5V
TEw7DQogCWlmIChtbSkNCiAJCWF0b21pY19pbmMoJm1tLT5tbV91c2Vycyk7
DQogCXRhc2tfdW5sb2NrKHRzayk7DQpkaWZmIC1yTnUgbGludXgtMi40LjIx
LXJjMS9rZXJuZWwvc3lzLmMgbGludXgtMi40LjIxLXJrMS9rZXJuZWwvc3lz
LmMNCi0tLSBsaW51eC0yLjQuMjEtcmMxL2tlcm5lbC9zeXMuYwkyMDAzLTA1
LTA4IDAwOjQ4OjM5LjAwMDAwMDAwMCArMDIwMA0KKysrIGxpbnV4LTIuNC4y
MS1yazEva2VybmVsL3N5cy5jCTIwMDMtMDUtMDggMDA6NTM6MDIuMDAwMDAw
MDAwICswMjAwDQpAQCAtMTI0Niw4ICsxMjQ2LDcgQEANCiAJCQkJZXJyb3Ig
PSAtRUlOVkFMOw0KIAkJCQlicmVhazsNCiAJCQl9DQotCQkJaWYgKGlzX2R1
bXBhYmxlKGN1cnJlbnQpKQ0KLQkJCQljdXJyZW50LT5tbS0+ZHVtcGFibGUg
PSBhcmcyOw0KKwkJCWN1cnJlbnQtPm1tLT5kdW1wYWJsZSA9IGFyZzI7DQog
CQkJYnJlYWs7DQogDQogCSAgICAgICAgY2FzZSBQUl9TRVRfVU5BTElHTjoN
Cg==

--1283901862-669685055-1052348127=:1818--
