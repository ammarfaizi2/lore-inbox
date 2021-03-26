Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3261C433C1
	for <io-uring@archiver.kernel.org>; Fri, 26 Mar 2021 20:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF3BB61A24
	for <io-uring@archiver.kernel.org>; Fri, 26 Mar 2021 20:46:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbhCZUp6 (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 26 Mar 2021 16:45:58 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:57778 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbhCZUpb (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Fri, 26 Mar 2021 16:45:31 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lPtKk-000Pbs-Mm; Fri, 26 Mar 2021 14:45:30 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lPtKj-00B9Pu-LG; Fri, 26 Mar 2021 14:45:30 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring@vger.kernel.org, torvalds@linux-foundation.org,
        metze@samba.org, oleg@redhat.com, linux-kernel@vger.kernel.org
References: <20210326155128.1057078-1-axboe@kernel.dk>
        <20210326155128.1057078-5-axboe@kernel.dk>
Date:   Fri, 26 Mar 2021 15:44:30 -0500
In-Reply-To: <20210326155128.1057078-5-axboe@kernel.dk> (Jens Axboe's message
        of "Fri, 26 Mar 2021 09:51:17 -0600")
Message-ID: <m1y2e9wspd.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lPtKj-00B9Pu-LG;;;mid=<m1y2e9wspd.fsf@fess.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+pZfoEW05NiGjUuq71rJ/mKC4+c30eHWI=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 3/7] kernel: stop masking signals in create_io_thread()
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Jens Axboe <axboe@kernel.dk> writes:

> This is racy - move the blocking into when the task is created and
> we're marking it as PF_IO_WORKER anyway. The IO threads are now
> prepared to handle signals like SIGSTOP as well, so clear that from
> the mask to allow proper stopping of IO threads.

Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

>
> Reported-by: Oleg Nesterov <oleg@redhat.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  kernel/fork.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/kernel/fork.c b/kernel/fork.c
> index d3171e8e88e5..ddaa15227071 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1940,8 +1940,14 @@ static __latent_entropy struct task_struct *copy_process(
>  	p = dup_task_struct(current, node);
>  	if (!p)
>  		goto fork_out;
> -	if (args->io_thread)
> +	if (args->io_thread) {
> +		/*
> +		 * Mark us an IO worker, and block any signal that isn't
> +		 * fatal or STOP
> +		 */
>  		p->flags |= PF_IO_WORKER;
> +		siginitsetinv(&p->blocked, sigmask(SIGKILL)|sigmask(SIGSTOP));
> +	}
>  
>  	/*
>  	 * This _must_ happen before we call free_task(), i.e. before we jump
> @@ -2430,14 +2436,8 @@ struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node)
>  		.stack_size	= (unsigned long)arg,
>  		.io_thread	= 1,
>  	};
> -	struct task_struct *tsk;
>  
> -	tsk = copy_process(NULL, 0, node, &args);
> -	if (!IS_ERR(tsk)) {
> -		sigfillset(&tsk->blocked);
> -		sigdelsetmask(&tsk->blocked, sigmask(SIGKILL));
> -	}
> -	return tsk;
> +	return copy_process(NULL, 0, node, &args);
>  }
>  
>  /*
