Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D498BC433DB
	for <io-uring@archiver.kernel.org>; Fri, 26 Mar 2021 20:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C30CC61A24
	for <io-uring@archiver.kernel.org>; Fri, 26 Mar 2021 20:45:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbhCZUoy (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 26 Mar 2021 16:44:54 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:60042 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbhCZUop (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Fri, 26 Mar 2021 16:44:45 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lPtJz-00A5f3-2Z; Fri, 26 Mar 2021 14:44:43 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1lPtJy-0002C4-6V; Fri, 26 Mar 2021 14:44:42 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring@vger.kernel.org, torvalds@linux-foundation.org,
        metze@samba.org, oleg@redhat.com, linux-kernel@vger.kernel.org
References: <20210326155128.1057078-1-axboe@kernel.dk>
        <20210326155128.1057078-2-axboe@kernel.dk>
Date:   Fri, 26 Mar 2021 15:43:43 -0500
In-Reply-To: <20210326155128.1057078-2-axboe@kernel.dk> (Jens Axboe's message
        of "Fri, 26 Mar 2021 09:51:14 -0600")
Message-ID: <m14kgxy7b4.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lPtJy-0002C4-6V;;;mid=<m14kgxy7b4.fsf@fess.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/VwxW8Az6YjAF6RN0b0XNHN+rhgD9lWjg=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 1/7] kernel: don't call do_exit() for PF_IO_WORKER threads
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Jens Axboe <axboe@kernel.dk> writes:

> Right now we're never calling get_signal() from PF_IO_WORKER threads, but
> in preparation for doing so, don't handle a fatal signal for them. The
> workers have state they need to cleanup when exiting, and they don't do
> coredumps, so just return instead of performing either a dump or calling
> do_exit() on their behalf. The threads themselves will detect a fatal
> signal and do proper shutdown.
>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  kernel/signal.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/kernel/signal.c b/kernel/signal.c
> index f2a1b898da29..e3e1b8fbfe8a 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -2756,6 +2756,15 @@ bool get_signal(struct ksignal *ksig)
>  		 */
>  		current->flags |= PF_SIGNALED;
>  
> +		/*
> +		 * PF_IO_WORKER threads will catch and exit on fatal signals
> +		 * themselves. They have cleanup that must be performed, so
> +		 * we cannot call do_exit() on their behalf. coredumps also
> +		 * do not apply to them.
> +		 */
> +		if (current->flags & PF_IO_WORKER)
> +			return false;
> +

Returning false when get_signal needs the caller to handle a signal
adds a very weird and awkward special case to how get_signal returns
arguments.

Instead you should simply break and let get_signal return SIGKILL like
any other signal that has a handler that the caller of get_signal needs
to handle.

Something like:
> +		/*
> +		 * PF_IO_WORKER have cleanup that must be performed,
> +		 * before calling do_exit().
> +		 */
> +		if (current->flags & PF_IO_WORKER)
> +			break;


As do_coredump does not call do_exit there is no reason to skip calling into
the coredump handling either.   And allowing it will remove yet another
special case from the io worker code.

>  		if (sig_kernel_coredump(signr)) {
>  			if (print_fatal_signals)
>  				print_fatal_signal(ksig->info.si_signo);

Eric
