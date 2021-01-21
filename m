Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B913C433DB
	for <io-uring@archiver.kernel.org>; Thu, 21 Jan 2021 15:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1702423A1D
	for <io-uring@archiver.kernel.org>; Thu, 21 Jan 2021 15:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbhAUPyU (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 21 Jan 2021 10:54:20 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:48508 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731410AbhAUPwy (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 21 Jan 2021 10:52:54 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1l2cFO-004LO4-Vr; Thu, 21 Jan 2021 08:51:47 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1l2cFN-0029Ec-Pa; Thu, 21 Jan 2021 08:51:46 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Alexey Gladkov <gladkov.alexey@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        io-uring <io-uring@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>
References: <cover.1610722473.git.gladkov.alexey@gmail.com>
        <116c7669744404364651e3b380db2d82bb23f983.1610722473.git.gladkov.alexey@gmail.com>
        <CAHk-=wjsg0Lgf1Mh2UiJE4sqBDDo0VhFVBUbhed47ot2CQQwfQ@mail.gmail.com>
        <20210118194551.h2hrwof7b3q5vgoi@example.org>
        <CAHk-=wiNpc5BS2BfZhdDqofJx1G=uasBa2Q1eY4cr8O59Rev2A@mail.gmail.com>
        <20210118205629.zro2qkd3ut42bpyq@example.org>
        <87eeig74kv.fsf@x220.int.ebiederm.org>
        <20210121120427.iiggfmw3tpsmyzeb@example.org>
Date:   Thu, 21 Jan 2021 09:50:34 -0600
In-Reply-To: <20210121120427.iiggfmw3tpsmyzeb@example.org> (Alexey Gladkov's
        message of "Thu, 21 Jan 2021 13:04:27 +0100")
Message-ID: <87ft2u2ss5.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1l2cFN-0029Ec-Pa;;;mid=<87ft2u2ss5.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+qagvrCbWceuXumPpyz27FGwz07GA2gjk=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [RFC PATCH v3 1/8] Use refcount_t for ucounts reference counting
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Alexey Gladkov <gladkov.alexey@gmail.com> writes:

> On Tue, Jan 19, 2021 at 07:57:36PM -0600, Eric W. Biederman wrote:
>> Alexey Gladkov <gladkov.alexey@gmail.com> writes:
>> 
>> > On Mon, Jan 18, 2021 at 12:34:29PM -0800, Linus Torvalds wrote:
>> >> On Mon, Jan 18, 2021 at 11:46 AM Alexey Gladkov
>> >> <gladkov.alexey@gmail.com> wrote:
>> >> >
>> >> > Sorry about that. I thought that this code is not needed when switching
>> >> > from int to refcount_t. I was wrong.
>> >> 
>> >> Well, you _may_ be right. I personally didn't check how the return
>> >> value is used.
>> >> 
>> >> I only reacted to "it certainly _may_ be used, and there is absolutely
>> >> no comment anywhere about why it wouldn't matter".
>> >
>> > I have not found examples where checked the overflow after calling
>> > refcount_inc/refcount_add.
>> >
>> > For example in kernel/fork.c:2298 :
>> >
>> >    current->signal->nr_threads++;                           
>> >    atomic_inc(&current->signal->live);                      
>> >    refcount_inc(&current->signal->sigcnt);  
>> >
>> > $ semind search signal_struct.sigcnt
>> > def include/linux/sched/signal.h:83  		refcount_t		sigcnt;
>> > m-- kernel/fork.c:723 put_signal_struct 		if (refcount_dec_and_test(&sig->sigcnt))
>> > m-- kernel/fork.c:1571 copy_signal 		refcount_set(&sig->sigcnt, 1);
>> > m-- kernel/fork.c:2298 copy_process 				refcount_inc(&current->signal->sigcnt);
>> >
>> > It seems to me that the only way is to use __refcount_inc and then compare
>> > the old value with REFCOUNT_MAX
>> >
>> > Since I have not seen examples of such checks, I thought that this is
>> > acceptable. Sorry once again. I have not tried to hide these changes.
>> 
>> The current ucount code does check for overflow and fails the increment
>> in every case.
>> 
>> So arguably it will be a regression and inferior error handling behavior
>> if the code switches to the ``better'' refcount_t data structure.
>> 
>> I originally didn't use refcount_t because silently saturating and not
>> bothering to handle the error makes me uncomfortable.
>> 
>> Not having to acquire the ucounts_lock every time seems nice.  Perhaps
>> the path forward would be to start with stupid/correct code that always
>> takes the ucounts_lock for every increment of ucounts->count, that is
>> later replaced with something more optimal.
>> 
>> Not impacting performance in the non-namespace cases and having good
>> performance in the other cases is a fundamental requirement of merging
>> code like this.
>
> Did I understand your suggestion correctly that you suggest to use
> spin_lock for atomic_read and atomic_inc ?
>
> If so, then we are already incrementing the counter under ucounts_lock.
>
> 	...
> 	if (atomic_read(&ucounts->count) == INT_MAX)
> 		ucounts = NULL;
> 	else
> 		atomic_inc(&ucounts->count);
> 	spin_unlock_irq(&ucounts_lock);
> 	return ucounts;
>
> something like this ?

Yes.  But without atomics.  Something a bit more like:
> 	...
> 	if (ucounts->count == INT_MAX)
> 		ucounts = NULL;
> 	else
> 		ucounts->count++;
> 	spin_unlock_irq(&ucounts_lock);
> 	return ucounts;

I do believe at some point we will want to say using the spin_lock for
ucounts->count is cumbersome, and suboptimal and we want to change it to
get a better performing implementation.

Just for getting the semantics correct we should be able to use just
ucounts_lock for locking.  Then when everything is working we can
profile and optimize the code.

I just don't want figuring out what is needed to get hung up over little
details that we can change later.

Eric

