Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263361AbTDSGnP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 02:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263364AbTDSGnP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 02:43:15 -0400
Received: from lisa.JS.Jura.Uni-Goettingen.de ([134.76.166.209]:44164 "EHLO
	lisa.goe.net") by vger.kernel.org with ESMTP id S263361AbTDSGnN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 02:43:13 -0400
Date: Sat, 19 Apr 2003 07:57:35 +0200
From: Bernhard Kaindl <bk@suse.de>
X-X-Sender: bkaindl@hase.a11.local
To: rmk@arm.linux.org.uk, Yusuf Wilajati Purna <purna@sm.sony.co.jp>
Cc: linux-kernel@vger.kernel.org, Bernhard Kaindl <bernhard.kaindl@gmx.de>,
       arjanv@redhat.com
Subject: Re: 2.4+ptrace exploit fix breaks root's ability to strace
In-Reply-To: <3E9E3FA9.6060509@sm.sony.co.jp>
Message-ID: <Pine.LNX.4.53.0304190532520.1887@hase.a11.local>
References: <3E9E3FA9.6060509@sm.sony.co.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Apr 2003, Yusuf Wilajati Purna wrote:
> On 2003-03-22 17:28:54, Arjan van de Ven wrote:
> >On Sat, Mar 22, 2003 at 05:13:12PM +0000, Russell King wrote:
> >>
> >> int ptrace_check_attach(struct task_struct *child, int kill)
> >> {
> >> 	...
> >> +       if (!is_dumpable(child))
> >> +               return -EPERM;
> >> }
> >>
> >> So, we went from being able to ptrace daemons as root, to being able to
> >> attach daemons and then being unable to do anything with them, even if
> >> you're root (or have the CAP_SYS_PTRACE capability).  I think this
> >> behaviour is getting on for being described as "insane" 8) and is
> >> clearly wrong.
> >
> >ok it seems this check is too strong. It *has* to check
> >child->task_dumpable and return -EPERM, but child->mm->dumpable is not
> >needed.
>
> So, do you mean that the following is enough:
>
> int ptrace_check_attach(struct task_struct *child, int kill)
> {
>       ...
> +       if (!child->task_dumpable)
> +               return -EPERM;
> }

It's enough to still be safe against the ptrace/kmod exploits.

I could not find a security problem in it yet because
compute_cred() ignores the suid bit on exec when the
process is being traced, so the strace does not get
access to privileges from somebody else and ptrace_attach
uses is_dumpable() which also checks task->mm->dumpable
so a tracer can't attach to a suid program.

It will also help the case Russell King describes above
where root failed to trace a daemon which changed uids
or a suid program, AFAICS.

It is not the complete fix for it because the ptrace functions
also use access_process_vm() where the patch had this hunk:

@@ -123,6 +127,8 @@ int access_process_vm(struct task_struct
        /* Worry about races with exit() */
        task_lock(tsk);
        mm = tsk->mm;
+       if (!is_dumpable(tsk) || (&init_mm == mm))
+               mm = NULL;
        if (mm)
                atomic_inc(&mm->mm_users);
        task_unlock(tsk);

You need to backout the tsk->mm->dumpable check done within is_dumpable
here by just checking task_dumpable and then ptracing from root works
prperly again.

As the kmod ptrace fix relies on task_dumpable for it's protection against
kernel thread trace, and you just remove the tsk->mm->dumpable check by
replacing !is_dumpable(tsk) with !tsk->task_dumpable here also, you don't
affect the kmod ptrace exploit protection in any way while fixing the
ability of root to trace any task.

This also fixes the problem /proc/<pid>/cmdline being empty (also for root)
if <pid> is not dumpable, which is the other bug introduced by this hunk
and broke process managment tools as it was also read on l-k.

Of course now people may say that this opens a security hole because a
normal user ist now able to read /proc/*/cmdline again (also for not
dumpable processes) but I'm answering to this that it has been well
known that it is insecure to put secrets onto the command line space
and e.g. if programs don't clear it properly, they are buggy and should
be audited to fix the bugs and not add a workaound to the kernel for
such programs.

Bernd
