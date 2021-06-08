Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C6D2C48BCF
	for <io-uring@archiver.kernel.org>; Tue,  8 Jun 2021 03:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17A176135A
	for <io-uring@archiver.kernel.org>; Tue,  8 Jun 2021 03:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbhFHDv7 (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Mon, 7 Jun 2021 23:51:59 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:57650 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbhFHDv7 (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Mon, 7 Jun 2021 23:51:59 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lqSke-009Bvp-EB; Mon, 07 Jun 2021 21:50:04 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lqSkc-00C0QU-OI; Mon, 07 Jun 2021 21:50:03 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Olivier Langlois <olivier@trillion01.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        "Peter Zijlstra \(Intel\)" <peterz@infradead.org>,
        Marco Elver <elver@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        io-uring@vger.kernel.org
In-Reply-To: <E1lqLo6-00ENqW-TB@mx03.mta.xmission.com> (Olivier Langlois's
        message of "Sun, 30 May 2021 18:49:38 -0400")
References: <E1lqLo6-00ENqW-TB@mx03.mta.xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
Date:   Mon, 07 Jun 2021 22:49:55 -0500
Message-ID: <8735ttggm4.fsf@disp2133>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lqSkc-00C0QU-OI;;;mid=<8735ttggm4.fsf@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+wrPfGBuLdsECYUiaY2GIbrnn7EZmPfsg=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH] signal: Set PF_SIGNALED flag for io workers during a group exit
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Olivier Langlois <olivier@trillion01.com> writes:

> io worker threads are in most regards userspace threads except
> that they never resume userspace. Therefore, they need to explicitly
> handle signals.
>
> On delivering a fatal signal generating a core dump to a thread of
> a group having 1 or more io workers, it is possible for the io_workers
> to exit with pending signals.
>
> One example of this is the io_wqe_worker() function thread in fs/io-wq.c
> This thread can exit the function with pending signals when its
> IO_WQ_BIT_EXIT bit is set.
>
> The consequence of exiting with pending signals is that PF_SIGNALED
> will not be set. This flag is used in exit_mm() to engage into
> the synchronization between do_coredump() and exit_mm().
>
> The purpose of this synchronization is not well documented and all
> that I have found is that it is used to avoid corruption in the core file
> in the section "Deleting a Process Address Space", chapter 9 of the
> Bovet & Cesati book.

We added the check just a little while ago.  I am surprised it shows up
in any book.  What is the Bovett & Cesati book?

The flag PF_SIGNALED today is set in exactly one place, and that
is in get_signal.  The meaning of PF_SIGNALED is that do_group_exit
was called from get_signal.  AKA your task was killed by a signal.

The check in exit_mm() that tests PF_SIGNALED is empirically testing
to see if all of the necessary state is saved on the kernel stack.
That state is the state accessed by fs/binfmt_elf.c:fill_note_info.

The very good description from the original change can be found in
the commit 123cbec460db ("signal: Remove the helper signal_group_exit").

For alpha it is has the assembly function do_switch_stack been called
before your code path was called in the kernel.

Since io_uring does not have a userspace  I don't know if testing
for PF_SIGNALED is at all meaningful to detect values saved on the
stack.

I suspect io_uring is simply broken on architectures that need
extra state saved on the stack, but I haven't looked yet.


> So I am not sure if the synchronizatin MUST be applied to io_workers
> or not but the proposed patch is making sure that it is applied in
> all cases if it is needed.

That patch is definitely wrong.  If anything the check in exit_mm
should be updated.

Can you share which code paths in io_uring exit with a
fatal_signal_pending and don't bother to call get_signal?

I am currently looking to see if the wait for a coredump to read
a threads data can be moved from exit_mm into get_signal.  Even
with that io_uring might need a some additional fixes.

Eric

> Signed-off-by: Olivier Langlois <olivier@trillion01.com>
> ---
>  kernel/signal.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/kernel/signal.c b/kernel/signal.c
> index f7c6ffcbd044..477bfe55fd3c 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -2925,6 +2925,15 @@ void exit_signals(struct task_struct *tsk)
>  
>  	if (thread_group_empty(tsk) || signal_group_exit(tsk->signal)) {
>  		tsk->flags |= PF_EXITING;
> +		/*
> +		 * It is possible for an io worker thread to reach this
> +		 * function with a pending SIGKILL.
> +		 * Set PF_SIGNALED for proper core dump generation
> +		 * (See exit_mm())
> +		 */
> +		if (tsk->flags & PF_IO_WORKER &&
> +		    signal_group_exit(tsk->signal))
> +			tsk->flags |= PF_SIGNALED;
>  		cgroup_threadgroup_change_end(tsk);
>  		return;
>  	}
