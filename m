Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91111C433C1
	for <io-uring@archiver.kernel.org>; Fri, 26 Mar 2021 22:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8494561A32
	for <io-uring@archiver.kernel.org>; Fri, 26 Mar 2021 22:25:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbhCZWYh (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 26 Mar 2021 18:24:37 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:45548 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbhCZWYK (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Fri, 26 Mar 2021 18:24:10 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lPusC-000XAB-LB; Fri, 26 Mar 2021 16:24:08 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lPusB-00BL1H-2w; Fri, 26 Mar 2021 16:24:08 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring@vger.kernel.org, torvalds@linux-foundation.org,
        metze@samba.org, oleg@redhat.com, linux-kernel@vger.kernel.org
References: <20210326155128.1057078-1-axboe@kernel.dk>
        <20210326155128.1057078-3-axboe@kernel.dk>
        <m1wntty7yn.fsf@fess.ebiederm.org>
        <106a38d3-5a5f-17fd-41f7-890f5e9a3602@kernel.dk>
Date:   Fri, 26 Mar 2021 17:23:08 -0500
In-Reply-To: <106a38d3-5a5f-17fd-41f7-890f5e9a3602@kernel.dk> (Jens Axboe's
        message of "Fri, 26 Mar 2021 16:14:48 -0600")
Message-ID: <m1k0ptv9kj.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lPusB-00BL1H-2w;;;mid=<m1k0ptv9kj.fsf@fess.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/shYyeRWs6JVLWuaWNXtLje+PNW5eZ8CQ=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 2/7] io_uring: handle signals for IO threads like a normal thread
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Jens Axboe <axboe@kernel.dk> writes:

> On 3/26/21 2:29 PM, Eric W. Biederman wrote:
>> Jens Axboe <axboe@kernel.dk> writes:
>> 
>>> We go through various hoops to disallow signals for the IO threads, but
>>> there's really no reason why we cannot just allow them. The IO threads
>>> never return to userspace like a normal thread, and hence don't go through
>>> normal signal processing. Instead, just check for a pending signal as part
>>> of the work loop, and call get_signal() to handle it for us if anything
>>> is pending.
>>>
>>> With that, we can support receiving signals, including special ones like
>>> SIGSTOP.
>>>
>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>> ---
>>>  fs/io-wq.c    | 24 +++++++++++++++++-------
>>>  fs/io_uring.c | 12 ++++++++----
>>>  2 files changed, 25 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/fs/io-wq.c b/fs/io-wq.c
>>> index b7c1fa932cb3..3e2f059a1737 100644
>>> --- a/fs/io-wq.c
>>> +++ b/fs/io-wq.c
>>> @@ -16,7 +16,6 @@
>>>  #include <linux/rculist_nulls.h>
>>>  #include <linux/cpu.h>
>>>  #include <linux/tracehook.h>
>>> -#include <linux/freezer.h>
>>>  
>>>  #include "../kernel/sched/sched.h"
>>>  #include "io-wq.h"
>>> @@ -503,10 +502,16 @@ static int io_wqe_worker(void *data)
>>>  		if (io_flush_signals())
>>>  			continue;
>>>  		ret = schedule_timeout(WORKER_IDLE_TIMEOUT);
>>> -		if (try_to_freeze() || ret)
>>> +		if (signal_pending(current)) {
>>> +			struct ksignal ksig;
>>> +
>>> +			if (fatal_signal_pending(current))
>>> +				break;
>>> +			if (get_signal(&ksig))
>>> +				continue;
>>                         ^^^^^^^^^^^^^^^^^^^^^^
>> 
>> That is wrong.  You are promising to deliver a signal to signal
>> handler and them simply discarding it.  Perhaps:
>> 
>> 			if (!get_signal(&ksig))
>>                         	continue;
>> 			WARN_ON(!sig_kernel_stop(ksig->sig));
>>                         break;
>
> Thanks, updated.

Gah.  Kill the WARN_ON.

I was thinking "WARN_ON(!sig_kernel_fatal(ksig->sig));"
The function sig_kernel_fatal does not exist.

Fatal is the state that is left when a signal is neither
ignored nor a stop signal, and does not have a handler.

The rest of the logic still works.

Eric

