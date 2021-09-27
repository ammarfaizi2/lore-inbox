Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 685B2C433EF
	for <io-uring@archiver.kernel.org>; Mon, 27 Sep 2021 17:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D53A60F70
	for <io-uring@archiver.kernel.org>; Mon, 27 Sep 2021 17:00:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235421AbhI0RCC (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Mon, 27 Sep 2021 13:02:02 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:45400 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235412AbhI0RCC (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Mon, 27 Sep 2021 13:02:02 -0400
Received: from in02.mta.xmission.com ([166.70.13.52]:58068)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mUtzL-00B3CH-DM; Mon, 27 Sep 2021 11:00:23 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:59490 helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mUtzK-00F5dO-F2; Mon, 27 Sep 2021 11:00:23 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring <io-uring@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <8b218623-7ce8-cef0-9f70-2e5aa2aeb70d@kernel.dk>
Date:   Mon, 27 Sep 2021 12:00:16 -0500
In-Reply-To: <8b218623-7ce8-cef0-9f70-2e5aa2aeb70d@kernel.dk> (Jens Axboe's
        message of "Mon, 27 Sep 2021 10:58:03 -0600")
Message-ID: <87r1da6jj3.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mUtzK-00F5dO-F2;;;mid=<87r1da6jj3.fsf@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19khlOinl1NzhVjK3KQnwWPuovzEzbI5zc=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH] io-wq: exclusively gate signal based exit on get_signal() return
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Jens Axboe <axboe@kernel.dk> writes:

> io-wq threads block all signals, except SIGKILL and SIGSTOP. We should not
> need any extra checking of signal_pending or fatal_signal_pending, rely
> exclusively on whether or not get_signal() tells us to exit.
>
> The original debugging of this issue led to the false positive that we
> were exiting on non-fatal signals, but that is not the case. The issue
> was around races with nr_workers accounting.

Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

>
> Fixes: 87c169665578 ("io-wq: ensure we exit if thread group is exiting")
> Fixes: 15e20db2e0ce ("io-wq: only exit on fatal signals")
> Reported-by: Eric W. Biederman <ebiederm@xmission.com>
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>
> ---
>
> diff --git a/fs/io-wq.c b/fs/io-wq.c
> index c2360cdc403d..5bf8aa81715e 100644
> --- a/fs/io-wq.c
> +++ b/fs/io-wq.c
> @@ -584,10 +584,7 @@ static int io_wqe_worker(void *data)
>  
>  			if (!get_signal(&ksig))
>  				continue;
> -			if (fatal_signal_pending(current) ||
> -			    signal_group_exit(current->signal))
> -				break;
> -			continue;
> +			break;
>  		}
>  		last_timeout = !ret;
>  	}
