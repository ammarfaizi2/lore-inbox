Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268860AbUIMTGw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268860AbUIMTGw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 15:06:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268870AbUIMTGw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 15:06:52 -0400
Received: from hera.cwi.nl ([192.16.191.8]:37587 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S268860AbUIMTGq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 15:06:46 -0400
Date: Mon, 13 Sep 2004 21:06:35 +0200
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [no patch] broken use of mm_release / deactivate_mm
Message-ID: <20040913190633.GA22639@apps.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Recent kernels have a bug in fork(). Things can be improved a bit
by commenting out the lines

        /* Get rid of any cached register state */
        deactivate_mm(tsk, mm);

in fork.c:mm_release().

What happens at a fork, is that a long sequence of things is done,
and if a failure occurs all previous things are undone. Thus
(in copy_process()):

        if ((retval = copy_mm(clone_flags, p)))
                goto bad_fork_cleanup_signal;
        if ((retval = copy_namespace(clone_flags, p)))
                goto bad_fork_cleanup_mm;
        retval = copy_thread(0, clone_flags, stack_start, stack_size, p, regs);
        if (retval)
                goto bad_fork_cleanup_namespace;

...

bad_fork_cleanup_namespace:
        exit_namespace(p);
bad_fork_cleanup_mm:
        exit_mm(p);
        if (p->active_mm)
                mmdrop(p->active_mm);
bad_fork_cleanup_signal:
...

Thus, we may do exit_mm() when an attempted fork fails.
The argument of exit_mm() is this new, not completeley initialized
task_struct.

Now exit.c:exit_mm(p) does mm_release(p,p->mm), and this
mm_release() does deactivate_mm(), a macro that clears %fs and %gs.
Ach. A segfault is the result.

More is wrong with mm_release(). It examines p->clear_child_tid,
and possibly does put_user(0, tidptr);.
Oops.

In our case p->clear_child_tid had not yet been initialized for
the child, that happens in copy_thread() that we never reached.
So this is the value the parent had.

Also the call
	enter_lazy_tlb(mm, current);
seems strange in this context.

It seems to me that the proper action is some reshuffling
of this code. Maybe it is cleanest to separate the cleanup
code for a failed fork entirely from the code for an exiting
process.

Andries
