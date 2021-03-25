Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA0A4C433DB
	for <io-uring@archiver.kernel.org>; Thu, 25 Mar 2021 20:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91ABA61A44
	for <io-uring@archiver.kernel.org>; Thu, 25 Mar 2021 20:45:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbhCYUoy (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 25 Mar 2021 16:44:54 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:39202 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbhCYUog (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 25 Mar 2021 16:44:36 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lPWqJ-008Loq-8p; Thu, 25 Mar 2021 14:44:35 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lPWqI-007kcD-2u; Thu, 25 Mar 2021 14:44:34 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jens Axboe <axboe@kernel.dk>, io-uring <io-uring@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Stefan Metzmacher <metze@samba.org>
References: <20210325164343.807498-1-axboe@kernel.dk>
        <m1ft0j3u5k.fsf@fess.ebiederm.org>
        <CAHk-=wjOXiEAjGLbn2mWRsxqpAYUPcwCj2x5WgEAh=gj+o0t4Q@mail.gmail.com>
        <CAHk-=wg1XpX=iAv=1HCUReMbEgeN5UogZ4_tbi+ehaHZG6d==g@mail.gmail.com>
        <CAHk-=wgUcVeaKhtBgJO3TfE69miJq-krtL8r_Wf_=LBTJw6WSg@mail.gmail.com>
Date:   Thu, 25 Mar 2021 15:43:34 -0500
In-Reply-To: <CAHk-=wgUcVeaKhtBgJO3TfE69miJq-krtL8r_Wf_=LBTJw6WSg@mail.gmail.com>
        (Linus Torvalds's message of "Thu, 25 Mar 2021 13:12:42 -0700")
Message-ID: <m1lfab0xs9.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lPWqI-007kcD-2u;;;mid=<m1lfab0xs9.fsf@fess.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/f0dVqJdZlHqDKLajsEoUgpwHpwtu/hxw=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 0/2] Don't show PF_IO_WORKER in /proc/<pid>/task/
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Thu, Mar 25, 2021 at 12:42 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> On Thu, Mar 25, 2021 at 12:38 PM Linus Torvalds
>> <torvalds@linux-foundation.org> wrote:
>> >
>> > I don't know what the gdb logic is, but maybe there's some other
>> > option that makes gdb not react to them?
>>
>> .. maybe we could have a different name for them under the task/
>> subdirectory, for example (not  just the pid)? Although that probably
>> messes up 'ps' too..
>
> Actually, maybe the right model is to simply make all the io threads
> take signals, and get rid of all the special cases.
>
> Sure, the signals will never be delivered to user space, but if we
>
>  - just made the thread loop do "get_signal()" when there are pending signals
>
>  - allowed ptrace_attach on them
>
> they'd look pretty much like regular threads that just never do the
> user-space part of signal handling.
>
> The whole "signals are very special for IO threads" thing has caused
> so many problems, that maybe the solution is simply to _not_ make them
> special?

The special case in check_kill_permission is certainly unnecessary.
Having the signal blocked is enough to prevent signal_pending() from
being true. 


The most straight forward thing I can see is to allow ptrace_attach and
to modify ptrace_check_attach to always return -ESRCH for io workers
unless ignore_state is set causing none of the other ptrace operations
to work.

That is what a long running in-kernel thread would do today so
user-space aka gdb may actually cope with it.


We might be able to support if io workers start supporting SIGSTOP but I
am not at all certain.

Eric

