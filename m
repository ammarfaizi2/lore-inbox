Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262446AbTKNNJP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 08:09:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262458AbTKNNJP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 08:09:15 -0500
Received: from ns.suse.de ([195.135.220.2]:31177 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262446AbTKNNJM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 08:09:12 -0500
Date: Fri, 14 Nov 2003 14:09:07 +0100 (CET)
From: Bernhard Kaindl <bernhard.kaindl@gmx.de>
To: "Erik A. Hendriks" <hendriks@lanl.gov>
Cc: linux-kernel@vger.kernel.org, Bernhard Kaindl <bernhard.kaindl@gmx.de>
Subject: Re: ptrace + ioctl( LOOP_SET_FD ) brokeness.
In-Reply-To: <20031113215506.GO23534@lanl.gov>
Message-ID: <Pine.LNX.4.56.0311141243030.19155@wotan.suse.de>
References: <20031113215506.GO23534@lanl.gov>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Nov 2003, Erik A. Hendriks wrote:
>
> The following hangs reliably on 2.4.22 (test on x86 and x86_64):

and all newer 2.4 kernels, not an issue for 2.6.

> strace mount -o loop somefile /mnt

the chain is:

ioctl(LOOP_SET_FD) -> lo_ioctl() -> loop_set_fd() -> kernel_thread()

... since 2.4.22, you have this in kernel_thread():

        if (task->ptrace)
                return -EPERM;

that's the drawback which is triggered when making security fixes broader
and affect more code as needed(which the original ptrace patch demonstrated)

This is the remaining side effect of the ptrace security fix(there were
many others which I fixed) which I didn't fix before 2.4.22 was released.

This also affects request_module() if the process is traced, so e.g. a
traced startup of e.g. freeswan which loads modules fails also.

But here a process gets struck unkillable which is a little but more bad.

The reason for the process hang seems to be the way loop_set_fd calls calls
kernel_thread():

        kernel_thread(loop_thread, lo, CLONE_FS | CLONE_FILES | CLONE_SIGHAND);
        down(&lo->lo_sem); <- This seems to wait for loop_thread()

Since kernel_thread can fail at the moment, all places where it is
called would need to be checked and error handling added.

The other possibility would be to do the traced modprobe handling which
needs to be done for fixing the ptrace issue in a different way, which
would be preferable, because it would fix the ptrace modprobe issue
without introducing side effects.

But for this, it would be neccesary to do a fork from a ptraced process
where the child is not traced if it's a kernel_thread.

This would need either:

a) A way to save and restore the current ptrace status of the task
   (e.g. single step) so that kernel_thread can clear it before the
   fork of the child and restore it afterwards.

b) Use a free bit in the task struct(eg. in the dumpable field) which
   tells do_fork() to clear ptrace status(eg. single step) for the
   child

c) create a wrapper function for the function which is "forked" by
   kernel_thread() which clears the ptrace status before calling
   the real work function of the kernel thread.

d)

Of course it would also be possible to move the whole issue to
exec_usermodehelper() which already does the remaining of dirty parent
process indepence(==security) stuff before going back into user space.

I would very much like to fix all these security issues where it's
really neccesary to fix them(that is, before going back into user space,
in exec_usermodehelper) and not adding more hacks to general purpose code.

At least we won't affect code like loop_thread() which never goes back
into usermode, or else it would use exec_usermodehelper().

Comments? / Opinions?

Bernhard
--
PS: Please keep Bernhard Kaindl <bernhard.kaindl@gmx.de> in the cc,
I'm on vacation and I can't read the full list for the next time.
