Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270009AbRIGAlP>; Thu, 6 Sep 2001 20:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270031AbRIGAlG>; Thu, 6 Sep 2001 20:41:06 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:13504 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S270009AbRIGAkt>;
	Thu, 6 Sep 2001 20:40:49 -0400
From: David Mosberger <davidm@hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15256.6038.599811.557582@napali.hpl.hp.com>
Date: Thu, 6 Sep 2001 17:40:54 -0700
To: Andrea Arcangeli <andrea@suse.de>
Cc: David Mosberger <davidm@hpl.hp.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] proposed fix for ptrace() SMP race
In-Reply-To: <20010907021900.L11329@athlon.random>
In-Reply-To: <200109062300.QAA27430@napali.hpl.hp.com>
	<20010907021900.L11329@athlon.random>
X-Mailer: VM 6.76 under Emacs 20.4.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Fri, 7 Sep 2001 02:19:00 +0200, Andrea Arcangeli <andrea@suse.de> said:

  Andrea> Last time I checked for such race it was looking ok (on
  Andrea> x86). Do you have a testcase to demonstrate it?

For ia64, yes.  I didn't look at x86.  Other platforms may or may not
be affected, that is true, but the races are so subtle, I'd rather
make sure this problem cannot occur on any platform.

  Andrea> but it cannot be running in "userspace" any longer once it
  Andrea> is set to TASK_STOPPED which should be the _only_ thing we
  Andrea> care in ptrace. If it's still running it's in its way to
  Andrea> schedule() a few lines after the setting of tsk->state to
  Andrea> TASK_STOPPED and that's ok for ptrace.

Yes, the code running in schedule() is sufficient.  On ia64, what
happened is that switch_to() may end up saving the floating-point
registers f32-f127.  After doing so, it will set a bit in the thread
flags and since this is done non-atomically (for good reason), it
creates a race with the code in ptrace() which also updates the thread
flags.

  Andrea> abusing cpus_allowed to forbid scheduling is racy so quite
  Andrea> unacceptable, we want to preserve the cpus_allowed field for
  Andrea> the administrator (he could as well set it during the
  Andrea> ptrace).

As long as the CPU manipulates cpus_allowed in an atomic fashion (xchg
or cmpxchg) this will be fine.  I'd argue it has to do this anyhow
(unless a task is changing its own cpus_allowed field).

If you don't like the cpus_allowed approach, please propose another
solution that ensures that the task does not get woken up while ptrace
is running.  I don't really care very much what the solution is, but I
do want to make sure we can guarantee that the task does not start
running while ptrace() is doing it's job.  Having to prove that race
conditions in ptrace() are harmless is far too painful (and bound to
be violated as code changes in the future...).

	--david
