Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F60C433EF
	for <io-uring@archiver.kernel.org>; Mon, 27 Sep 2021 15:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1446160EE2
	for <io-uring@archiver.kernel.org>; Mon, 27 Sep 2021 15:13:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235076AbhI0PPQ (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Mon, 27 Sep 2021 11:15:16 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:33598 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235078AbhI0PPP (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Mon, 27 Sep 2021 11:15:15 -0400
Received: from in01.mta.xmission.com ([166.70.13.51]:41654)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mUsJz-00Amvb-1B; Mon, 27 Sep 2021 09:13:35 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:55782 helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mUsJx-00427N-QW; Mon, 27 Sep 2021 09:13:34 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        io-uring <io-uring@vger.kernel.org>
References: <fb81a0f6-0a9d-6651-88bc-d22e589de0ee@kernel.dk>
        <CAHk-=whi3UxvY1C1LQNCO9d2xzX5A69qfzNGbBVGpRE_6gv=9Q@mail.gmail.com>
        <0eeefd32-f322-1470-9bcf-0f415be517bd@kernel.dk>
        <87lf3iazyu.fsf@disp2133>
        <feb00062-647c-1c74-dbe1-a7729ca49d7d@kernel.dk>
        <521162e9-c7e4-284e-e575-51c503c51793@kernel.dk>
Date:   Mon, 27 Sep 2021 10:13:26 -0500
In-Reply-To: <521162e9-c7e4-284e-e575-51c503c51793@kernel.dk> (Jens Axboe's
        message of "Mon, 27 Sep 2021 08:59:53 -0600")
Message-ID: <878rzi831l.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mUsJx-00427N-QW;;;mid=<878rzi831l.fsf@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18N/fYepbM78OeRkbTICBsyEF0kk9iKu7A=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [GIT PULL] io_uring fixes for 5.15-rc3
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Jens Axboe <axboe@kernel.dk> writes:

> On 9/27/21 8:29 AM, Jens Axboe wrote:
>> On 9/27/21 7:51 AM, Eric W. Biederman wrote:
>>> Jens Axboe <axboe@kernel.dk> writes:
>>>
>>>> On 9/25/21 5:05 PM, Linus Torvalds wrote:
>>>>> On Sat, Sep 25, 2021 at 1:32 PM Jens Axboe <axboe@kernel.dk> wrote:
>>>>>>
>>>>>> - io-wq core dump exit fix (me)
>>>>>
>>>>> Hmm.
>>>>>
>>>>> That one strikes me as odd.
>>>>>
>>>>> I get the feeling that if the io_uring thread needs to have that
>>>>> signal_group_exit() test, something is wrong in signal-land.
>>>>>
>>>>> It's basically a "fatal signal has been sent to another thread", and I
>>>>> really get the feeling that "fatal_signal_pending()" should just be
>>>>> modified to handle that case too.
>>>>
>>>> It did surprise me as well, which is why that previous change ended up
>>>> being broken for the coredump case... You could argue that the io-wq
>>>> thread should just exit on signal_pending(), which is what we did
>>>> before, but that really ends up sucking for workloads that do use
>>>> signals for communication purposes. postgres was the reporter here.
>>>
>>> The primary function get_signal is to make signals not pending.  So I
>>> don't understand any use of testing signal_pending after a call to
>>> get_signal.
>>>
>>> My confusion doubles when I consider the fact io_uring threads should
>>> only be dequeuing SIGSTOP and SIGKILL.
>>>
>>> I am concerned that an io_uring thread that dequeues SIGKILL won't call
>>> signal_group_exit and thus kill the other threads in the thread group.
>>>
>>> What motivated removing the break and adding the fatal_signal_pending
>>> test?
>> 
>> I played with this a bit this morning, and I agree it doesn't seem to be
>> needed at all. The original issue was with postgres, I'll give that a
>> whirl as well and see if we run into any unwarranted exits. My simpler
>> test case did not.
>
> Ran the postgres test, and we get tons of io-wq exiting on get_signal()
> returning true. Took a closer look, and it actually looks very much
> expected, as it's a SIGKILL to the original task.
>
> So it looks like I was indeed wrong, and this probably masked the
> original issue that was fixed in that series. I've been running with
> this:
>
> diff --git a/fs/io-wq.c b/fs/io-wq.c
> index c2360cdc403d..afd1db8e000d 100644
> --- a/fs/io-wq.c
> +++ b/fs/io-wq.c
> @@ -584,10 +584,9 @@ static int io_wqe_worker(void *data)
>  
>  			if (!get_signal(&ksig))
>  				continue;
> -			if (fatal_signal_pending(current) ||
> -			    signal_group_exit(current->signal))
> -				break;
> -			continue;
> +			if (ksig.sig != SIGKILL)
> +				printk("exit on sig! fatal? %d, sig=%d\n", fatal_signal_pending(current), ksig.sig);
> +			break;
>  		}
>  		last_timeout = !ret;
>  	}
>
> and it's running fine and, as expected, we don't generate any printk
> activity as these are all fatal deliveries to the parent.

Good.  So just a break should be fine.

A little bit of me is concerned about not calling do_group_exit in this
case.  Fortunately it is not a problem as complete_signal kills all of
the threads in a signal_group when SIGKILL is delivered.

So at least until something else is refactored and io_uring threads
unblock another fatal signal all is well.

Eric
