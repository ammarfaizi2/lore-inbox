Return-Path: <SRS0=1ts2=ID=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF0AC433DB
	for <io-uring@archiver.kernel.org>; Fri,  5 Mar 2021 19:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E38A65074
	for <io-uring@archiver.kernel.org>; Fri,  5 Mar 2021 19:17:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbhCETRO (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 5 Mar 2021 14:17:14 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:40866 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbhCETQw (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Fri, 5 Mar 2021 14:16:52 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lIFwP-003HyV-NZ; Fri, 05 Mar 2021 12:16:49 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lIFwO-004xlW-B0; Fri, 05 Mar 2021 12:16:49 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Stefan Metzmacher <metze@samba.org>
Cc:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
        viro@zeniv.linux.org.uk, torvalds@linux-foundation.org
References: <20210219171010.281878-1-axboe@kernel.dk>
        <20210219171010.281878-10-axboe@kernel.dk>
        <85bc236d-94af-6878-928b-c69dbdcd46f9@samba.org>
        <d9704b9e-ae5e-0795-ba2e-029293f89616@kernel.dk>
        <a9f58269-b260-6281-4e83-43cb5e881d25@samba.org>
        <d3dfc422-8762-0078-bc80-989f1d71f006@samba.org>
Date:   Fri, 05 Mar 2021 13:16:50 -0600
In-Reply-To: <d3dfc422-8762-0078-bc80-989f1d71f006@samba.org> (Stefan
        Metzmacher's message of "Thu, 4 Mar 2021 17:13:56 +0100")
Message-ID: <m1czwdz9zx.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lIFwO-004xlW-B0;;;mid=<m1czwdz9zx.fsf@fess.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+6C/BpiopOEqKtYcVWc+Zd/cYXYsCixAQ=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 09/18] io-wq: fork worker threads from original task
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Stefan Metzmacher <metze@samba.org> writes:

> Am 04.03.21 um 14:19 schrieb Stefan Metzmacher:
>> Hi Jens,
>> 
>>>> Can you please explain why CLONE_SIGHAND is used here?
>>>
>>> We can't have CLONE_THREAD without CLONE_SIGHAND... The io-wq workers
>>> don't really care about signals, we don't use them internally.
>> 
>> I'm 100% sure, but I heard rumors that in some situations signals get
>> randomly delivered to any thread of a userspace process.
>
> Ok, from task_struct:
>
>         /* Signal handlers: */
>         struct signal_struct            *signal;
>         struct sighand_struct __rcu             *sighand;
>         sigset_t                        blocked;
>         sigset_t                        real_blocked;
>         /* Restored if set_restore_sigmask() was used: */
>         sigset_t                        saved_sigmask;
>         struct sigpending               pending;
>
> The signal handlers are shared, but 'blocked' is per thread/task.

Doing something so that wants_signal won't try and route
a signal to a PF_IO_WORKER seems sensible.

Either blocking the signal or modifying wants_signal.

>> My fear was that the related logic may select a kernel thread if they
>> share the same signal handlers.
>
> I found the related logic in the interaction between
> complete_signal() and wants_signal().
>
> static inline bool wants_signal(int sig, struct task_struct *p)
> {
>         if (sigismember(&p->blocked, sig))
>                 return false;
>
> ...
>
> Would it make sense to set up task->blocked to block all signals?
>
> Something like this:
>
> --- a/fs/io-wq.c
> +++ b/fs/io-wq.c
> @@ -611,15 +611,15 @@ pid_t io_wq_fork_thread(int (*fn)(void *), void *arg)
>  {
>         unsigned long flags = CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|
>                                 CLONE_IO|SIGCHLD;
> -       struct kernel_clone_args args = {
> -               .flags          = ((lower_32_bits(flags) | CLONE_VM |
> -                                   CLONE_UNTRACED) & ~CSIGNAL),
> -               .exit_signal    = (lower_32_bits(flags) & CSIGNAL),
> -               .stack          = (unsigned long)fn,
> -               .stack_size     = (unsigned long)arg,
> -       };
> +       sigset_t mask, oldmask;
> +       pid_t pid;
>
> -       return kernel_clone(&args);
> +       sigfillset(&mask);
> +       sigprocmask(SIG_BLOCK, &mask, &oldmask);
> +       pid = kernel_thread(fn, arg, flags);
> +       sigprocmask(SIG_SETMASK, &oldmask, NULL);
> +
> +       return ret;
>  }
>
> I think using kernel_thread() would be a good simplification anyway.

I have a memory of kernel_thread having a built in assumption that it is
being called from a kthreadd, but I am not seeing it now so that would
be a nice simplification if we can do that.

> sig_task_ignored() has some PF_IO_WORKER logic.
>
> Or is there any PF_IO_WORKER related logic that prevents
> an io_wq thread to be excluded in complete_signal().
>
> Or PF_IO_WORKER would teach kernel_clone to ignore CLONE_SIGHAND
> and create a fresh handler and alter the copy_signal() and copy_sighand()
> checks...

I believe it is desirable for SIGKILL to the process to kill all of it's
PF_IO_WORKERS as well.

All that wants_signal allows/prevents is a wake up to request the task
to call get_signal.  No matter what complete_signal suggests any thread
can still dequeue the signal and process it.

It probably makes sense to block everything except SIGKILL (and
SIGSTOP?) in task_thread so that wants_signal doesn't fail to wake up an
ordinary thread that could handle the signal when the signal arrives.

Eric

