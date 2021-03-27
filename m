Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C75C433C1
	for <io-uring@archiver.kernel.org>; Sat, 27 Mar 2021 17:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCEAE61938
	for <io-uring@archiver.kernel.org>; Sat, 27 Mar 2021 17:42:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbhC0RmE (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sat, 27 Mar 2021 13:42:04 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:53408 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbhC0Rlr (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sat, 27 Mar 2021 13:41:47 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lQCwS-00BjIc-VQ; Sat, 27 Mar 2021 11:41:45 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1lQCwR-0004WE-HT; Sat, 27 Mar 2021 11:41:44 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring@vger.kernel.org, torvalds@linux-foundation.org,
        metze@samba.org, oleg@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <387feabb-e758-220a-fc34-9e9325eab3a6@kernel.dk> (Jens Axboe's
        message of "Fri, 26 Mar 2021 16:49:53 -0600")
References: <20210326155128.1057078-1-axboe@kernel.dk>
        <20210326155128.1057078-3-axboe@kernel.dk>
        <m1wntty7yn.fsf@fess.ebiederm.org>
        <106a38d3-5a5f-17fd-41f7-890f5e9a3602@kernel.dk>
        <m1k0ptv9kj.fsf@fess.ebiederm.org>
        <01058178-dd66-1bff-4d74-5ff610817ed6@kernel.dk>
        <m18s69v8zb.fsf@fess.ebiederm.org>
        <7a71da2f-ca39-6bbf-28c1-bcc2eec43943@kernel.dk>
        <387feabb-e758-220a-fc34-9e9325eab3a6@kernel.dk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
Date:   Sat, 27 Mar 2021 12:40:44 -0500
Message-ID: <m1zgyotrz7.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lQCwR-0004WE-HT;;;mid=<m1zgyotrz7.fsf@fess.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19Atc7/uZz2rVkeMP0AYpou9ybZfvOoovQ=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 2/7] io_uring: handle signals for IO threads like a normal thread
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Jens Axboe <axboe@kernel.dk> writes:

> On 3/26/21 4:38 PM, Jens Axboe wrote:
>> OK good point, and follows the same logic even if it won't make a
>> difference in my case. I'll make the change.
>
> Made the suggested edits and ran the quick tests and the KILL/STOP
> testing, and no ill effects observed. Kicked off the longer runs now.
>
> Not a huge amount of changes from the posted series, but please peruse
> here if you want to double check:
>
> https://git.kernel.dk/cgit/linux-block/log/?h=io_uring-5.12
>
> And diff against v2 posted is below. Thanks!

That looks good.  Thanks.

Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

>
> diff --git a/fs/io-wq.c b/fs/io-wq.c
> index 3e2f059a1737..7434eb40ca8c 100644
> --- a/fs/io-wq.c
> +++ b/fs/io-wq.c
> @@ -505,10 +505,9 @@ static int io_wqe_worker(void *data)
>  		if (signal_pending(current)) {
>  			struct ksignal ksig;
>  
> -			if (fatal_signal_pending(current))
> -				break;
> -			if (get_signal(&ksig))
> +			if (!get_signal(&ksig))
>  				continue;
> +			break;
>  		}
>  		if (ret)
>  			continue;
> @@ -722,10 +721,9 @@ static int io_wq_manager(void *data)
>  		if (signal_pending(current)) {
>  			struct ksignal ksig;
>  
> -			if (fatal_signal_pending(current))
> -				set_bit(IO_WQ_BIT_EXIT, &wq->state);
> -			else if (get_signal(&ksig))
> +			if (!get_signal(&ksig))
>  				continue;
> +			set_bit(IO_WQ_BIT_EXIT, &wq->state);
>  		}
>  	} while (!test_bit(IO_WQ_BIT_EXIT, &wq->state));
>  
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index 66ae46874d85..880abd8b6d31 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -6746,10 +6746,9 @@ static int io_sq_thread(void *data)
>  		if (signal_pending(current)) {
>  			struct ksignal ksig;
>  
> -			if (fatal_signal_pending(current))
> -				break;
> -			if (get_signal(&ksig))
> +			if (!get_signal(&ksig))
>  				continue;
> +			break;
>  		}
>  		sqt_spin = false;
>  		cap_entries = !list_is_singular(&sqd->ctx_list);
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 5b75fbe3d2d6..f2718350bf4b 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -2752,15 +2752,6 @@ bool get_signal(struct ksignal *ksig)
>  		 */
>  		current->flags |= PF_SIGNALED;
>  
> -		/*
> -		 * PF_IO_WORKER threads will catch and exit on fatal signals
> -		 * themselves. They have cleanup that must be performed, so
> -		 * we cannot call do_exit() on their behalf. coredumps also
> -		 * do not apply to them.
> -		 */
> -		if (current->flags & PF_IO_WORKER)
> -			return false;
> -
>  		if (sig_kernel_coredump(signr)) {
>  			if (print_fatal_signals)
>  				print_fatal_signal(ksig->info.si_signo);
> @@ -2776,6 +2767,14 @@ bool get_signal(struct ksignal *ksig)
>  			do_coredump(&ksig->info);
>  		}
>  
> +		/*
> +		 * PF_IO_WORKER threads will catch and exit on fatal signals
> +		 * themselves. They have cleanup that must be performed, so
> +		 * we cannot call do_exit() on their behalf.
> +		 */
> +		if (current->flags & PF_IO_WORKER)
> +			goto out;
> +
>  		/*
>  		 * Death signals, no core dump.
>  		 */
> @@ -2783,7 +2782,7 @@ bool get_signal(struct ksignal *ksig)
>  		/* NOTREACHED */
>  	}
>  	spin_unlock_irq(&sighand->siglock);
> -
> +out:
>  	ksig->sig = signr;
>  
>  	if (!(ksig->ka.sa.sa_flags & SA_EXPOSE_TAGBITS))
