Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272718AbRIGPfl>; Fri, 7 Sep 2001 11:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272716AbRIGPfb>; Fri, 7 Sep 2001 11:35:31 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:29949 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S272718AbRIGPfT>;
	Fri, 7 Sep 2001 11:35:19 -0400
From: David Mosberger <davidm@hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15256.59715.523045.796917@napali.hpl.hp.com>
Date: Fri, 7 Sep 2001 08:35:31 -0700
To: Andrea Arcangeli <andrea@suse.de>
Cc: David Mosberger <davidm@hpl.hp.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] proposed fix for ptrace() SMP race
In-Reply-To: <20010907152858.O11329@athlon.random>
In-Reply-To: <200109062300.QAA27430@napali.hpl.hp.com>
	<20010907021900.L11329@athlon.random>
	<15256.6038.599811.557582@napali.hpl.hp.com>
	<20010907032801.N11329@athlon.random>
	<15256.22858.57091.769101@napali.hpl.hp.com>
	<20010907152858.O11329@athlon.random>
X-Mailer: VM 6.76 under Emacs 20.4.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Fri, 7 Sep 2001 15:28:58 +0200, Andrea Arcangeli <andrea@suse.de> said:

  Andrea> correct, I suggest to ignore SIGCONT as well while
  Andrea> PT_PTRACED is set.

Do you really think it's acceptable?  With your patch, you couldn't
SIGKILL or SIGCONT a task that happens to be ptraced.  I certainly
would expect to be able to do this for a task that is being strace'd,
for example.

Also, other signals will still wake up the task.  Yes, it won't get
very far as do_signal() will notify the parent instead, but still, the
task will run and that could be enough to create some race condition.

What about the other wakeup paths that I had mentioned?  E.g., what if
the ptraced task is ptracing another task?  Couldn't notify_parent()
end up waking up the task as well?

  Andrea> Also when you restore the cpus_allowed you won't effectively
  Andrea> wakup the task, it will just keep floating in the runqueue
  Andrea> but we won't try to reschedule the other idle cpus it so
  Andrea> it's broken.

Ah, that's a good point, thanks.  Nothing that can't be fixed, though.

  >> Hmmh, looking at ptrace() more closely, the entire locking
  >> situation seems to be a bit confused.  For example, what's
  >> stopping wait4() from releasing the task structure just after
  >> ptrace() released the tasklist_lock and before it checked
  >> child->state?

  Andrea> the get_task_struct()

Yes, I missed that.

	--david
