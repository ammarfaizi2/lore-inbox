Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D741C433E2
	for <io-uring@archiver.kernel.org>; Sat, 20 Mar 2021 21:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0F4E6148E
	for <io-uring@archiver.kernel.org>; Sat, 20 Mar 2021 21:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbhCTVjx (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sat, 20 Mar 2021 17:39:53 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:59372 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbhCTVjU (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sat, 20 Mar 2021 17:39:20 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lNjJV-00GTxI-D8; Sat, 20 Mar 2021 15:39:17 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1lNjJU-0003bJ-Nq; Sat, 20 Mar 2021 15:39:17 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jens Axboe <axboe@kernel.dk>, io-uring <io-uring@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Stefan Metzmacher <metze@samba.org>
References: <20210320153832.1033687-1-axboe@kernel.dk>
        <20210320153832.1033687-2-axboe@kernel.dk>
        <m1eeg9bxyi.fsf@fess.ebiederm.org>
        <CAHk-=wjLMy+J20ZSBec4iarw2NeSu5sWXm6wdMH59n-e0Qe06g@mail.gmail.com>
Date:   Sat, 20 Mar 2021 16:38:12 -0500
In-Reply-To: <CAHk-=wjLMy+J20ZSBec4iarw2NeSu5sWXm6wdMH59n-e0Qe06g@mail.gmail.com>
        (Linus Torvalds's message of "Sat, 20 Mar 2021 10:56:36 -0700")
Message-ID: <m1czvt8q0r.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lNjJU-0003bJ-Nq;;;mid=<m1czvt8q0r.fsf@fess.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/AWshnne4DuXHRMb8VAzfaz8DFr1tOQqI=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 1/2] signal: don't allow sending any signals to PF_IO_WORKER threads
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sat, Mar 20, 2021 at 9:19 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> The creds should be reasonably in-sync with the rest of the threads.
>
> It's not about credentials (despite the -EPERM).
>
> It's about the fact that kernel threads cannot handle signals, and
> then get caught in endless loops of "if (sigpending()) return
> -EAGAIN".
>
> For a normal user thread, that "return -EAGAIN" (or whatever) will end
> up returning an error to user space - and before it does that, it will
> go through the "oh, returning to user space, so handle signal" path.
> Which will clear sigpending etc.
>
> A thread that never returns to user space fundamentally cannot handle
> this. The sigpending() stays on forever, the signal never gets
> handled, the thread can't do anything.
>
> So delivering a signal to a kernel thread fundamentally cannot work
> (although we do have some threads that explicitly see "oh, if I was
> killed, I will exit" - think things like in-kernel nfsd etc).

I agree that getting a kernel thread to receive a signal is quite
tricky.  But that is not what the patch affects.

The patch covers the case when instead of specifying the pid of the
process to kill(2) someone specifies the tid of a thread.  Which implies
that type is PIDTYPE_TGID, and in turn the signal is being placed on the
t->signal->shared_pending queue.  Not the thread specific t->pending
queue.

So my question is since the signal is delivered to the process as a
whole why do we care if someone specifies the tid of a kernel thread,
rather than the tid of a userspace thread?

Eric
