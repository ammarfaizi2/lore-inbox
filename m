Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7BCDC433DB
	for <io-uring@archiver.kernel.org>; Sat, 20 Mar 2021 16:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 706386193A
	for <io-uring@archiver.kernel.org>; Sat, 20 Mar 2021 16:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbhCTQXb (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sat, 20 Mar 2021 12:23:31 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:52648 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbhCTQW6 (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sat, 20 Mar 2021 12:22:58 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lNeNL-00GCXC-Ei; Sat, 20 Mar 2021 10:22:55 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1lNeNJ-0002he-EZ; Sat, 20 Mar 2021 10:22:55 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring@vger.kernel.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, oleg@redhat.com,
        Stefan Metzmacher <metze@samba.org>
References: <20210320153832.1033687-1-axboe@kernel.dk>
        <20210320153832.1033687-3-axboe@kernel.dk>
Date:   Sat, 20 Mar 2021 11:21:50 -0500
In-Reply-To: <20210320153832.1033687-3-axboe@kernel.dk> (Jens Axboe's message
        of "Sat, 20 Mar 2021 09:38:32 -0600")
Message-ID: <m1sg4paj8h.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lNeNJ-0002he-EZ;;;mid=<m1sg4paj8h.fsf@fess.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/+h0JpbIOkzwR65kAwE6l72a6ANjW34k0=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 2/2] signal: don't allow STOP on PF_IO_WORKER threads
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Jens Axboe <axboe@kernel.dk> writes:

> Just like we don't allow normal signals to IO threads, don't deliver a
> STOP to a task that has PF_IO_WORKER set. The IO threads don't take
> signals in general, and have no means of flushing out a stop either.

At first glance this seems safe.  This is before we count all of the
threads, and it needs to be a non io_uring thread.

Further we can change this decision later if necessary, as this is not
really exposed to userspace.

But please tell me why is it not the right thing to have the io_uring
helper threads stop?  Why is it ok for that process to go on consuming
cpu resources in a non-stoppable way.

Eric


> Reported-by: Stefan Metzmacher <metze@samba.org>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  kernel/signal.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 730ecd3d6faf..b113bf647fb4 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -2349,6 +2349,10 @@ static bool do_signal_stop(int signr)
>  
>  		t = current;
>  		while_each_thread(current, t) {
> +			/* don't STOP PF_IO_WORKER threads */
> +			if (t->flags & PF_IO_WORKER)
> +				continue;
> +
>  			/*
>  			 * Setting state to TASK_STOPPED for a group
>  			 * stop is always done with the siglock held,
