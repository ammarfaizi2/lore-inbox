Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59EEAC433C1
	for <io-uring@archiver.kernel.org>; Fri, 26 Mar 2021 22:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4367761A2A
	for <io-uring@archiver.kernel.org>; Fri, 26 Mar 2021 22:37:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbhCZWhT (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 26 Mar 2021 18:37:19 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:51452 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbhCZWg4 (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Fri, 26 Mar 2021 18:36:56 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lPv4W-00AEEr-Ur; Fri, 26 Mar 2021 16:36:53 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lPv4V-00BMGC-SI; Fri, 26 Mar 2021 16:36:52 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring@vger.kernel.org, torvalds@linux-foundation.org,
        metze@samba.org, oleg@redhat.com, linux-kernel@vger.kernel.org
References: <20210326155128.1057078-1-axboe@kernel.dk>
        <20210326155128.1057078-3-axboe@kernel.dk>
        <m1wntty7yn.fsf@fess.ebiederm.org>
        <106a38d3-5a5f-17fd-41f7-890f5e9a3602@kernel.dk>
        <m1k0ptv9kj.fsf@fess.ebiederm.org>
        <01058178-dd66-1bff-4d74-5ff610817ed6@kernel.dk>
Date:   Fri, 26 Mar 2021 17:35:52 -0500
In-Reply-To: <01058178-dd66-1bff-4d74-5ff610817ed6@kernel.dk> (Jens Axboe's
        message of "Fri, 26 Mar 2021 16:30:28 -0600")
Message-ID: <m18s69v8zb.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lPv4V-00BMGC-SI;;;mid=<m18s69v8zb.fsf@fess.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19ZogSeAxj83soMb/PNC5ocjw1KhthjNdM=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 2/7] io_uring: handle signals for IO threads like a normal thread
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Jens Axboe <axboe@kernel.dk> writes:

> On 3/26/21 4:23 PM, Eric W. Biederman wrote:
>> Jens Axboe <axboe@kernel.dk> writes:
>> 
>>> On 3/26/21 2:29 PM, Eric W. Biederman wrote:
>>>> Jens Axboe <axboe@kernel.dk> writes:
>>>>
>>>>> We go through various hoops to disallow signals for the IO threads, but
>>>>> there's really no reason why we cannot just allow them. The IO threads
>>>>> never return to userspace like a normal thread, and hence don't go through
>>>>> normal signal processing. Instead, just check for a pending signal as part
>>>>> of the work loop, and call get_signal() to handle it for us if anything
>>>>> is pending.
>>>>>
>>>>> With that, we can support receiving signals, including special ones like
>>>>> SIGSTOP.
>>>>>
>>>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>>>> ---
>>>>>  fs/io-wq.c    | 24 +++++++++++++++++-------
>>>>>  fs/io_uring.c | 12 ++++++++----
>>>>>  2 files changed, 25 insertions(+), 11 deletions(-)
>>>>>
>>>>> diff --git a/fs/io-wq.c b/fs/io-wq.c
>>>>> index b7c1fa932cb3..3e2f059a1737 100644
>>>>> --- a/fs/io-wq.c
>>>>> +++ b/fs/io-wq.c
>>>>> @@ -16,7 +16,6 @@
>>>>>  #include <linux/rculist_nulls.h>
>>>>>  #include <linux/cpu.h>
>>>>>  #include <linux/tracehook.h>
>>>>> -#include <linux/freezer.h>
>>>>>  
>>>>>  #include "../kernel/sched/sched.h"
>>>>>  #include "io-wq.h"
>>>>> @@ -503,10 +502,16 @@ static int io_wqe_worker(void *data)
>>>>>  		if (io_flush_signals())
>>>>>  			continue;
>>>>>  		ret = schedule_timeout(WORKER_IDLE_TIMEOUT);
>>>>> -		if (try_to_freeze() || ret)
>>>>> +		if (signal_pending(current)) {
>>>>> +			struct ksignal ksig;
>>>>> +
>>>>> +			if (fatal_signal_pending(current))
>>>>> +				break;
>>>>> +			if (get_signal(&ksig))
>>>>> +				continue;
>>>>                         ^^^^^^^^^^^^^^^^^^^^^^
>>>>
>>>> That is wrong.  You are promising to deliver a signal to signal
>>>> handler and them simply discarding it.  Perhaps:
>>>>
>>>> 			if (!get_signal(&ksig))
>>>>                         	continue;
>>>> 			WARN_ON(!sig_kernel_stop(ksig->sig));
>>>>                         break;
>>>
>>> Thanks, updated.
>> 
>> Gah.  Kill the WARN_ON.
>> 
>> I was thinking "WARN_ON(!sig_kernel_fatal(ksig->sig));"
>> The function sig_kernel_fatal does not exist.
>> 
>> Fatal is the state that is left when a signal is neither
>> ignored nor a stop signal, and does not have a handler.
>> 
>> The rest of the logic still works.
>
> I've just come to the same conclusion myself after testing it.
> Of the 3 cases, most of them can do the continue, but doesn't
> really matter with the way the loop is structured. Anyway, looks
> like this now:

This idiom in the code:
> +		if (signal_pending(current)) {
> +			struct ksignal ksig;
> +
> +			if (fatal_signal_pending(current))
> +				break;
> +			if (!get_signal(&ksig))
> +				continue;
>  }

Needs to be:
> +		if (signal_pending(current)) {
> +			struct ksignal ksig;
> +
> +			if (!get_signal(&ksig))
> +				continue;
> +			break;
>  }

Because any signal returned from get_signal is fatal in this case.
It might make sense to "WARN_ON(ksig->ka.sa.sa_handler != SIG_DFL)".
As the io workers don't handle that case.

It won't happen because you have everything blocked.

The extra fatal_signal_pending(current) logic is just confusing in this
case.

Eric
