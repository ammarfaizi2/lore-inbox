Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 552D4C433DB
	for <io-uring@archiver.kernel.org>; Sat, 20 Mar 2021 16:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2195B61966
	for <io-uring@archiver.kernel.org>; Sat, 20 Mar 2021 16:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbhCTQUK (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sat, 20 Mar 2021 12:20:10 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:34810 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbhCTQTi (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sat, 20 Mar 2021 12:19:38 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lNeK7-00FJur-86; Sat, 20 Mar 2021 10:19:35 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1lNeK4-0002L4-Py; Sat, 20 Mar 2021 10:19:34 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring@vger.kernel.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, oleg@redhat.com,
        Stefan Metzmacher <metze@samba.org>
References: <20210320153832.1033687-1-axboe@kernel.dk>
        <20210320153832.1033687-2-axboe@kernel.dk>
Date:   Sat, 20 Mar 2021 11:18:29 -0500
In-Reply-To: <20210320153832.1033687-2-axboe@kernel.dk> (Jens Axboe's message
        of "Sat, 20 Mar 2021 09:38:31 -0600")
Message-ID: <m1eeg9bxyi.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lNeK4-0002L4-Py;;;mid=<m1eeg9bxyi.fsf@fess.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18CIZY+/GAkzRU0WK1K+zdRzn1Dnv8x+DQ=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 1/2] signal: don't allow sending any signals to PF_IO_WORKER threads
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Jens Axboe <axboe@kernel.dk> writes:

> They don't take signals individually, and even if they share signals with
> the parent task, don't allow them to be delivered through the worker
> thread.

This is silly I know, but why do we care?

The creds should be reasonably in-sync with the rest of the threads.

There are other threads that will receive the signal, especially when
you worry about group_send_sig_info.  Which signal sending code paths
are actually a problem.

> Reported-by: Stefan Metzmacher <metze@samba.org>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  kernel/signal.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/kernel/signal.c b/kernel/signal.c
> index ba4d1ef39a9e..730ecd3d6faf 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -833,6 +833,9 @@ static int check_kill_permission(int sig, struct kernel_siginfo *info,
>  
>  	if (!valid_signal(sig))
>  		return -EINVAL;
> +	/* PF_IO_WORKER threads don't take any signals */
> +	if (t->flags & PF_IO_WORKER)
> +		return -EPERM;
>  
>  	if (!si_fromuser(info))
>  		return 0;
