Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7977FC433E0
	for <io-uring@archiver.kernel.org>; Fri, 19 Mar 2021 10:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 556BE64F6B
	for <io-uring@archiver.kernel.org>; Fri, 19 Mar 2021 10:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbhCSKbh (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 19 Mar 2021 06:31:37 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40257 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbhCSKbK (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Fri, 19 Mar 2021 06:31:10 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1lNCPN-0000ZW-Gn; Fri, 19 Mar 2021 10:31:09 +0000
Subject: Re: [PATCH] io_uring: fix provide_buffers sign extension
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
References: <562376a39509e260d8532186a06226e56eb1f594.1616149233.git.asml.silence@gmail.com>
From:   Colin Ian King <colin.king@canonical.com>
Message-ID: <a0a52343-0bf9-79c0-d1c3-0d049487c5cc@canonical.com>
Date:   Fri, 19 Mar 2021 10:31:08 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <562376a39509e260d8532186a06226e56eb1f594.1616149233.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 19/03/2021 10:21, Pavel Begunkov wrote:
> io_provide_buffers_prep()'s "p->len * p->nbufs" to sign extension
> problems. Not a huge problem as it's only used for access_ok() and
> increases the checked length, but better to keep typing right.
> 
> Reported-by: Colin Ian King <colin.king@canonical.com>
> Fixes: efe68c1ca8f49 ("io_uring: validate the full range of provided buffers for access")
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> ---
>  fs/io_uring.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index c2489b463eb9..4f1c98502a09 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -3978,6 +3978,7 @@ static int io_remove_buffers(struct io_kiocb *req, unsigned int issue_flags)
>  static int io_provide_buffers_prep(struct io_kiocb *req,
>  				   const struct io_uring_sqe *sqe)
>  {
> +	unsigned long size;
>  	struct io_provide_buf *p = &req->pbuf;
>  	u64 tmp;
>  
> @@ -3991,7 +3992,8 @@ static int io_provide_buffers_prep(struct io_kiocb *req,
>  	p->addr = READ_ONCE(sqe->addr);
>  	p->len = READ_ONCE(sqe->len);
>  
> -	if (!access_ok(u64_to_user_ptr(p->addr), (p->len * p->nbufs)))
> +	size = (unsigned long)p->len * p->nbufs;
> +	if (!access_ok(u64_to_user_ptr(p->addr), size))
>  		return -EFAULT;
>  
>  	p->bgid = READ_ONCE(sqe->buf_group);
> 

Does it make sense to make size a u64 and cast to a u64 rather than
unsigned long?
