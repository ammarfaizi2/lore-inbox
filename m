Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 989CCC433C1
	for <io-uring@archiver.kernel.org>; Sat, 20 Mar 2021 22:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52E0B61934
	for <io-uring@archiver.kernel.org>; Sat, 20 Mar 2021 22:10:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbhCTWJl (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sat, 20 Mar 2021 18:09:41 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:33944 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbhCTWJH (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sat, 20 Mar 2021 18:09:07 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lNjmM-00GVVv-9d; Sat, 20 Mar 2021 16:09:06 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1lNjmL-00062O-KY; Sat, 20 Mar 2021 16:09:06 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jens Axboe <axboe@kernel.dk>, io-uring <io-uring@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, criu@openvz.org
References: <20210320153832.1033687-1-axboe@kernel.dk>
        <m14kh5aj0n.fsf@fess.ebiederm.org>
        <CAHk-=whyL6prwWR0GdgxLZm_w-QWwo7jPw_DkEGYFbMeCdo8YQ@mail.gmail.com>
        <CAHk-=wh3DCgezr5RKQ4Mqffoj-F4i47rp85Q4MSFRNhrr8tg3w@mail.gmail.com>
Date:   Sat, 20 Mar 2021 17:08:02 -0500
In-Reply-To: <CAHk-=wh3DCgezr5RKQ4Mqffoj-F4i47rp85Q4MSFRNhrr8tg3w@mail.gmail.com>
        (Linus Torvalds's message of "Sat, 20 Mar 2021 12:18:15 -0700")
Message-ID: <m1im5l5vi5.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lNjmL-00062O-KY;;;mid=<m1im5l5vi5.fsf@fess.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX185RE4CDnNBooFl4xRNceHuRx8rf7VZFnQ=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCHSET 0/2] PF_IO_WORKER signal tweaks
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org


Added criu because I just realized that io_uring (which can open files
from an io worker thread) looks to require some special handling for
stopping and freezing processes.  If not in the SIGSTOP case in the
related cgroup freezer case.

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sat, Mar 20, 2021 at 10:51 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> Alternatively, make it not use
>> CLONE_SIGHAND|CLONE_THREAD at all, but that would make it
>> unnecessarily allocate its own signal state, so that's "cleaner" but
>> not great either.
>
> Thinking some more about that, it would be problematic for things like
> the resource counters too. They'd be much better shared.
>
> Not adding it to the thread list etc might be clever, but feels a bit too scary.
>
> So on the whole I think Jens' minor patches to just not have IO helper
> threads accept signals are probably the right thing to do.

The way I see it we have two options:

1) Don't ask PF_IO_WORKERs to stop do_signal_stop and in
   task_join_group_stop.

   The easiest comprehensive implementation looks like just
   updating task_set_jobctl_pending to treat PF_IO_WORKER
   as it treats PF_EXITING.

2) Have the main loop of the kernel thread test for JOBCTL_STOP_PENDING
   and call into do_signal_stop.

It is a wee bit trickier to modify the io_workers to stop, but it does
not look prohibitively difficult.

All of the work performed by the io worker is work scheduled via
io_uring by the process being stopped.

- Is the amount of work performed by the io worker thread sufficiently
  negligible that we don't care?

- Or is the amount of work performed by the io worker so great that it
  becomes a way for an errant process to escape SIGSTOP?

As the code is all intermingled with the cgroup_freezer.  I am also
wondering creating checkpoints needs additional stopping guarantees.


To solve the issue that SIGSTOP is simply broken right now I am totally
fine with something like:

diff --git a/kernel/signal.c b/kernel/signal.c
index ba4d1ef39a9e..cb9acdfb32fa 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -288,7 +288,8 @@ bool task_set_jobctl_pending(struct task_struct *task, unsigned long mask)
 			JOBCTL_STOP_SIGMASK | JOBCTL_TRAPPING));
 	BUG_ON((mask & JOBCTL_TRAPPING) && !(mask & JOBCTL_PENDING_MASK));
 
-	if (unlikely(fatal_signal_pending(task) || (task->flags & PF_EXITING)))
+	if (unlikely(fatal_signal_pending(task) ||
+		     (task->flags & (PF_EXITING | PF_IO_WORKER))))
 		return false;
 
 	if (mask & JOBCTL_STOP_SIGMASK)



Which just keeps from creating unstoppable processes today.  I am just
not convinced that is what we want as a long term solution.

Eric
