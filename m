Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF82C433DB
	for <io-uring@archiver.kernel.org>; Sun, 21 Mar 2021 14:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B2D961943
	for <io-uring@archiver.kernel.org>; Sun, 21 Mar 2021 14:56:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbhCUOz0 (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sun, 21 Mar 2021 10:55:26 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:49836 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbhCUOzG (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sun, 21 Mar 2021 10:55:06 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lNzTs-007iGy-Fi; Sun, 21 Mar 2021 08:55:04 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lNzTr-00Bp84-2a; Sun, 21 Mar 2021 08:55:04 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        io-uring <io-uring@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Stefan Metzmacher <metze@samba.org>
References: <20210320153832.1033687-1-axboe@kernel.dk>
        <20210320153832.1033687-2-axboe@kernel.dk>
        <m1eeg9bxyi.fsf@fess.ebiederm.org>
        <CAHk-=wjLMy+J20ZSBec4iarw2NeSu5sWXm6wdMH59n-e0Qe06g@mail.gmail.com>
        <m1czvt8q0r.fsf@fess.ebiederm.org>
        <43f05d70-11a9-d59a-1eac-29adc8c53894@kernel.dk>
Date:   Sun, 21 Mar 2021 09:54:00 -0500
In-Reply-To: <43f05d70-11a9-d59a-1eac-29adc8c53894@kernel.dk> (Jens Axboe's
        message of "Sat, 20 Mar 2021 16:42:09 -0600")
Message-ID: <m18s6g5zhz.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lNzTr-00Bp84-2a;;;mid=<m18s6g5zhz.fsf@fess.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19Urg+ixCg8xQilwYhLhejmznGP1MApdtk=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 1/2] signal: don't allow sending any signals to PF_IO_WORKER threads
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Jens Axboe <axboe@kernel.dk> writes:

> On 3/20/21 3:38 PM, Eric W. Biederman wrote:
>> Linus Torvalds <torvalds@linux-foundation.org> writes:
>> 
>>> On Sat, Mar 20, 2021 at 9:19 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>>>
>>>> The creds should be reasonably in-sync with the rest of the threads.
>>>
>>> It's not about credentials (despite the -EPERM).
>>>
>>> It's about the fact that kernel threads cannot handle signals, and
>>> then get caught in endless loops of "if (sigpending()) return
>>> -EAGAIN".
>>>
>>> For a normal user thread, that "return -EAGAIN" (or whatever) will end
>>> up returning an error to user space - and before it does that, it will
>>> go through the "oh, returning to user space, so handle signal" path.
>>> Which will clear sigpending etc.
>>>
>>> A thread that never returns to user space fundamentally cannot handle
>>> this. The sigpending() stays on forever, the signal never gets
>>> handled, the thread can't do anything.
>>>
>>> So delivering a signal to a kernel thread fundamentally cannot work
>>> (although we do have some threads that explicitly see "oh, if I was
>>> killed, I will exit" - think things like in-kernel nfsd etc).
>> 
>> I agree that getting a kernel thread to receive a signal is quite
>> tricky.  But that is not what the patch affects.
>> 
>> The patch covers the case when instead of specifying the pid of the
>> process to kill(2) someone specifies the tid of a thread.  Which implies
>> that type is PIDTYPE_TGID, and in turn the signal is being placed on the
>> t->signal->shared_pending queue.  Not the thread specific t->pending
>> queue.
>> 
>> So my question is since the signal is delivered to the process as a
>> whole why do we care if someone specifies the tid of a kernel thread,
>> rather than the tid of a userspace thread?
>
> Right, that's what this first patch does, and in all honesty, it's not
> required like the 2/2 patch is. I do think it makes it more consistent,
> though - the threads don't take signals, period. Allowing delivery from
> eg kill(2) and then pass it to the owning task of the io_uring is
> somewhat counterintuitive, and differs from earlier kernels where there
> was no relationsship between that owning task and the async worker
> thread.
>
> That's why I think the patch DOES make sense. These threads may share a
> personality with the owning task, but I don't think we should be able to
> manipulate them from userspace at all. That includes SIGSTOP, of course,
> but also regular signals.
>
> Hence I do think we should do something like this.

I agree about signals.  Especially because being able to use kill(2)
with the tid of thread is a linuxism and a backwards compatibility thing
from before we had CLONE_THREAD.

I think for kill(2) we should just return -ESRCH.

Thank you for providing the reasoning that is what I really saw missing
in the patches.  The why.  And software is difficult to maintain without
the why.





Eric



