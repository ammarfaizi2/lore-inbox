Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261299AbTKOC5e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 21:57:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbTKOC5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 21:57:34 -0500
Received: from ozlabs.org ([203.10.76.45]:17054 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261299AbTKOC5b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 21:57:31 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16309.38562.950351.137425@cargo.ozlabs.ibm.com>
Date: Sat, 15 Nov 2003 13:59:46 +1100
From: Paul Mackerras <paulus@samba.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PPC32: cancel syscall restart on signal delivery
In-Reply-To: <Pine.LNX.4.44.0311141612220.2214-100000@home.osdl.org>
References: <16309.28037.896731.19038@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.44.0311141612220.2214-100000@home.osdl.org>
X-Mailer: VM 7.17 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:

> On Sat, 15 Nov 2003, Paul Mackerras wrote:
> > 
> > BTW, do we have a test program that triggers the bug that this fixes?
> 
> No. In fact, it's an _incredibly_ tiny race, because the old code that 
> only handled it at the return path of the system call that got interrupted 
> would catch the thing in all cases _except_ if the system
> 
>  (a) decided to restart the system call
>  (b) got an interrupt _after_ the return to user mode but _before_ the 
>      system call instruction itself actually did the restart
>  (c) this interrupt caused a new signal with a handler (different from the
>      one that caused the restart, since that one by definition had no
>      handler) to the same program.

I just had another look at the x86 syscall exit code.  It looks to me
as though you have interrupts disabled all the way from before you
check current_thread_info()->flags, through the call to do_signal,
until you return to userspace.  Also, you deliver one signal and then
return to userspace even if there are more signals pending.  I could
be wrong about either or both assertions, of course, my x86 assembler
isn't particularly strong.

(Having interrupts disabled during do_signal is interesting, given
that its subroutines call __put_user and friends. :)

On PPC, I disable interrupts before checking the thread_info flags,
but then reenable them before calling do_signal.  Then after do_signal
returns, I check the thread_info flags again (having first disabled
interrupts), so if there is another signal pending, it will get
delivered before we return to userspace.

Thus I think the race was possibly a little wider on PPC than on x86:
we didn't have to get back to userspace, the interrupt could happen
during do_signal.

However, I think the race window was actually wider on x86 than you
seem to imply, since the external interrupt could become pending any
time from when you disable interrupts before checking the thread_info
flags until you return to userspace, and still cause the problem.
Still, either way it's a pretty narrow race.

> To make it even worse, even if the above incredibly unlikely thing
> actually _happens_, most of the time it wouldn't really matter. The worst
> case schenario is that the signal handler itself does a system call that
> needs restarting, in which case on signal handler return we now restart
> the _wrong_ system call once we return.

Now you have me scared, because I can't see where the restart_syscall
system call resets current_thread_info()->restart_block.fn to
do_no_restart_syscall.  Now, when we get an ignored signal during a
restartable system call, the signal code sets up userspace to do a
restart_syscall system call.  If we get the race and then deliver a
signal to the process, we don't undo the changes to userspace, we just
arrange that when it does the restart_syscall call, it will give the
same effect as if the original system call had returned -EINTR.

Now if the signal handler does a restartable system call, which ends
needing to be restarted, that will undo the change that we made on
signal delivery where we set restart_block.fn = do_no_restart_syscall.
In other words, we will return from the signal handler with
restart_block.fn set to something else, and promptly proceed to
restart the wrong syscall.

Am I missing something?  Perhaps we should reset restart_block.fn in
sys_{,rt_}sigreturn, or possibly in sys_restart_syscall.

Paul.
