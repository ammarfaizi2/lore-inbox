Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261913AbUJZFRz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261913AbUJZFRz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 01:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261841AbUJZFMw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 01:12:52 -0400
Received: from mx1.redhat.com ([66.187.233.31]:48296 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262110AbUJZFE2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 01:04:28 -0400
Date: Mon, 25 Oct 2004 22:04:14 -0700
Message-Id: <200410260504.i9Q54Es8010423@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
X-Fcc: ~/Mail/linus
Cc: Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ptrace bug in -rc2+
In-Reply-To: Gerd Knorr's message of  Thursday, 14 October 2004 19:49:53 +0200 <20041014174952.GA29335@bytesex>
X-Zippy-Says: Ask me the DIFFERENCE between PHIL SILVERS and ALEXANDER HAIG!!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry it took a while for me to get back to you on this problem.

> The introduction of the new TASK_TRACED state in 2.6.9-rc2 changed the
> behavior of the kernel in a IMHO buggy way.  Sending a SIGKILL to a
> process which is traced _and_ stopped doesn't work any more.  user mode
> linux kernels do that on shutdown, thats why I ran into this.

This is a change that I explained when I posted the ptrace cleanup patches.
In general it is not safe to do any non-ptrace wakeup of a thread in
TASK_TRACED, because the waking thread could race with a ptrace call that
could be doing things like mucking directly with its kernel stack.  AFAIK
noone has established that whatever clobberation ptrace can do to a running
thread is safe even if it will never return to user mode, so we can't allow
this even for SIGKILL.

What we can safely do is make a thread switching out of TASK_TRACED resume
rather than sitting in TASK_STOPPED if it has a pending SIGKILL or SIGCONT.
The following patch does this.  

That doesn't make your test program happy.  But it should be sufficient for
the shutdown case.  When killing all processes, if the tracer gets killed
first, the tracee goes into TASK_STOPPED and will be woken and killed by
the SIGKILL (same as before).  If the tracee gets killed first, it gets a
pending SIGKILL and doesn't wake up immediately--but, now, when the tracer
gets killed, the tracee will then wake up to die.  You can observe the
change by kill -9'ing your test program and seeing that its child winds up
dead rather than stopped.  This will also fix the (same) situations that
can arise now where you have used gdb (or whatever ptrace caller), killed
-9 the gdb and the process being debugged, but still have to kill -CONT the
process before it goes away (now it should just go away either the first
time or when you kill gdb).

Your particular test program is the one special case where we could make
the SIGKILL work immediately: the caller of kill is the ptracer, so we know
noone else can be using ptrace at the same time.  But I am not in favor of
adding this special case.  If you use ptrace yourself, you should cope.


Thanks,
Roland


Signed-off-by: Roland McGrath <roland@redhat.com>

--- linux-2.6/kernel/ptrace.c 23 Oct 2004 17:07:11 -0000 1.39
+++ linux-2.6/kernel/ptrace.c 26 Oct 2004 04:13:16 -0000
@@ -38,6 +38,12 @@ void __ptrace_link(task_t *child, task_t
 	SET_LINKS(child);
 }
  
+static inline int pending_resume_signal(struct sigpending *pending)
+{
+#define M(sig) (1UL << ((sig)-1))
+	return sigtestsetmask(&pending->signal, M(SIGCONT) | M(SIGKILL));
+}
+
 /*
  * unptrace a task: move it back to its original parent and
  * remove it from the ptrace list.
@@ -61,8 +67,16 @@ void __ptrace_unlink(task_t *child)
 		 * Turn a tracing stop into a normal stop now,
 		 * since with no tracer there would be no way
 		 * to wake it up with SIGCONT or SIGKILL.
+		 * If there was a signal sent that would resume the child,
+		 * but didn't because it was in TASK_TRACED, resume it now.
 		 */
+		spin_lock(&child->sighand->siglock);
 		child->state = TASK_STOPPED;
+		if (pending_resume_signal(&child->pending) ||
+		    pending_resume_signal(&child->signal->shared_pending)) {
+			signal_wake_up(child, 1);
+		}
+		spin_unlock(&child->sighand->siglock);
 	}
 }
