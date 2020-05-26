Return-Path: <SRS0=0Or6=7I=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C06CEC433DF
	for <io-uring@archiver.kernel.org>; Tue, 26 May 2020 01:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A88DB2068D
	for <io-uring@archiver.kernel.org>; Tue, 26 May 2020 01:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388169AbgEZBRl (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Mon, 25 May 2020 21:17:41 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:48980 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387794AbgEZBRl (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Mon, 25 May 2020 21:17:41 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=jiufei.xue@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0TzfkLbV_1590455859;
Received: from ali-186590e05fa3.local(mailfrom:jiufei.xue@linux.alibaba.com fp:SMTPD_---0TzfkLbV_1590455859)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 26 May 2020 09:17:39 +0800
Subject: Re: [PATCH] io_uring: don't set REQ_F_NOWAIT if the file was opened
 O_NONBLOCK
From:   Jiufei Xue <jiufei.xue@linux.alibaba.com>
To:     io-uring@vger.kernel.org
Cc:     axboe@kernel.dk, joseph.qi@linux.alibaba.com
References: <1590403724-57101-1-git-send-email-jiufei.xue@linux.alibaba.com>
Message-ID: <a080c713-cd7a-becd-e54b-abab21154f81@linux.alibaba.com>
Date:   Tue, 26 May 2020 09:17:38 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1590403724-57101-1-git-send-email-jiufei.xue@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

I think we should not set the flag only for regular file,
I will resend it later. Please ignore this patch.

Thanks,
Jiufei

On 2020/5/25 下午6:48, Jiufei Xue wrote:
> When read from an ondisk file that was opened O_NONBLOCK, it will always
> return EAGAIN to the user if the page is not cached. It is not
> compatible with interfaces such as aio_read() and normal sys_read().
> 
> Files that care about this flag (eg. pipe, eventfd) will deal with it
> on their own. So I don't think we should set REQ_F_NOWAIT in
> io_prep_rw() to provent from queueing the async work.
> 
> Signed-off-by: Jiufei Xue <jiufei.xue@linux.alibaba.com>
> ---
>  fs/io_uring.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index bb25e39..65ae59b 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -2080,8 +2080,7 @@ static int io_prep_rw(struct io_kiocb *req, const struct io_uring_sqe *sqe,
>  		kiocb->ki_ioprio = get_current_ioprio();
>  
>  	/* don't allow async punt if RWF_NOWAIT was requested */
> -	if ((kiocb->ki_flags & IOCB_NOWAIT) ||
> -	    (req->file->f_flags & O_NONBLOCK))
> +	if (kiocb->ki_flags & IOCB_NOWAIT)
>  		req->flags |= REQ_F_NOWAIT;
>  
>  	if (force_nonblock)
> 
