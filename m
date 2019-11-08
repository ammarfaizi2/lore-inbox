Return-Path: <SRS0=cPsQ=ZA=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50956C43331
	for <io-uring@archiver.kernel.org>; Fri,  8 Nov 2019 01:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2796E21D7E
	for <io-uring@archiver.kernel.org>; Fri,  8 Nov 2019 01:24:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbfKHBY0 convert rfc822-to-8bit (ORCPT
        <rfc822;io-uring@archiver.kernel.org>);
        Thu, 7 Nov 2019 20:24:26 -0500
Received: from smtpbg702.qq.com ([203.205.195.102]:39759 "EHLO
        smtpproxy21.qq.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726094AbfKHBYZ (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 7 Nov 2019 20:24:25 -0500
X-Greylist: delayed 2460 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 Nov 2019 20:24:24 EST
X-QQ-mid: bizesmtp26t1573176259tcfhr4wb
Received: from [192.168.142.168] (unknown [218.76.23.26])
        by esmtp10.qq.com (ESMTP) with 
        id ; Fri, 08 Nov 2019 09:24:18 +0800 (CST)
X-QQ-SSF: 00400000002000S0ZU90000A0000000
X-QQ-FEAT: JYOFLJLLthhaOXZmuR17vavtLIQLgxWxnJb8ElaNk2NJobA6kmmmGcZg6pNFM
        asyESvBWd4moSaGVt5SUtGgXq3+q7kHDXALBQKvVBRn5It6MW/2rovfT/tjHa7t/pRyedK0
        ilE5fOzUKBAk6Yy32OizPhADPVC5eKmTTK0w4HQK6UC6Ge2YgnQApnh2aYJbok9WdPR/kyN
        GfpfBd5Sec3vKATdYTcjlZa5gHhvv376jPVsJPcc9elLIpCoSW7hhRT5mt03tm9MqXmzdw9
        gta/DsXXfXGdkMh7SYSzzfdM7szVusdQF54ee5Zhv9TF3Y6lDM7y68dgPb+YtXVA0NnicBU
        JmvFxO0c9WmVIO/7moaart81bdQTw==
X-QQ-GoodBg: 2
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: [PATCH v2] io_uring: add support for linked SQE timeouts
From:   Jackie Liu <liuyun01@kylinos.cn>
In-Reply-To: <a7a32933-10fb-9c90-04ce-3f64ecad2421@kernel.dk>
Date:   Fri, 8 Nov 2019 09:24:20 +0800
Cc:     io-uring@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <C0C26DA7-DD02-46EE-A398-51A50962A724@kylinos.cn>
References: <a7a32933-10fb-9c90-04ce-3f64ecad2421@kernel.dk>
To:     Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3601.0.10)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign5
X-QQ-Bgrelay: 1
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org



> 2019年11月7日 10:05，Jens Axboe <axboe@kernel.dk> 写道：
> 
> While we have support for generic timeouts, we don't have a way to tie
> a timeout to a specific SQE. The generic timeouts simply trigger wakeups
> on the CQ ring.
> 
> This adds support for IORING_OP_LINK_TIMEOUT. This command is only valid
> as a link to a previous command. The timeout specific can be either
> relative or absolute, following the same rules as IORING_OP_TIMEOUT. If
> the timeout triggers before the dependent command completes, it will
> attempt to cancel that command. Likewise, if the dependent command
> completes before the timeout triggers, it will cancel the timeout.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> ---
> 
> Changes since v1:
> - Move required locking outside of io_req_link_next(), it's much
>  cleaner this way and avoids sparse complaining.
> - Avoid 32-bit complaint on casting to pointer of different size
> - Fix IORING_TIMEOUT_ABS, used sqe->flags instead of timeout_flags
> - Rebase on top of current tree
> 
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index c39d1c50a3be..e29ecc1b0218 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -329,6 +329,7 @@ struct io_kiocb {
> #define REQ_F_IO_DRAIN		16	/* drain existing IO first */
> #define REQ_F_IO_DRAINED	32	/* drain done */
> #define REQ_F_LINK		64	/* linked sqes */
> +#define REQ_F_LINK_TIMEOUT	128	/* has linked timeout */
> #define REQ_F_FAIL_LINK		256	/* fail rest of links */
> #define REQ_F_SHADOW_DRAIN	512	/* link-drain shadow req */
> #define REQ_F_TIMEOUT		1024	/* timeout request */
> @@ -371,6 +372,7 @@ static void io_wq_submit_work(struct io_wq_work **workptr);
> static void io_cqring_fill_event(struct io_ring_ctx *ctx, u64 ki_user_data,
> 				 long res);
> static void __io_free_req(struct io_kiocb *req);
> +static void io_put_req(struct io_kiocb *req, struct io_kiocb **nxtptr);
> 
> static struct kmem_cache *req_cachep;
> 
> @@ -712,9 +714,28 @@ static void __io_free_req(struct io_kiocb *req)
> 	kmem_cache_free(req_cachep, req);
> }
> 
> +static bool io_link_cancel_timeout(struct io_ring_ctx *ctx,
> +				   struct io_kiocb *req)
> +{
> +	int ret;
> +
> +	ret = hrtimer_try_to_cancel(&req->timeout.timer);
> +	if (ret != -1) {
> +		io_cqring_fill_event(ctx, req->user_data, -ECANCELED);
> +		io_commit_cqring(ctx);
> +		req->flags &= ~REQ_F_LINK;
> +		__io_free_req(req);
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
> static void io_req_link_next(struct io_kiocb *req, struct io_kiocb **nxtptr)
> {
> +	struct io_ring_ctx *ctx = req->ctx;
> 	struct io_kiocb *nxt;
> +	bool wake_ev = false;
> 
> 	/*
> 	 * The list should never be empty when we are called here. But could
> @@ -722,7 +743,7 @@ static void io_req_link_next(struct io_kiocb *req, struct io_kiocb **nxtptr)
> 	 * safe side.
> 	 */
> 	nxt = list_first_entry_or_null(&req->link_list, struct io_kiocb, list);
> -	if (nxt) {
> +	while (nxt) {
> 		list_del(&nxt->list);
> 		if (!list_empty(&req->link_list)) {
> 			INIT_LIST_HEAD(&nxt->link_list);
> @@ -734,11 +755,23 @@ static void io_req_link_next(struct io_kiocb *req, struct io_kiocb **nxtptr)
> 		 * If we're in async work, we can continue processing the chain
> 		 * in this context instead of having to queue up new async work.
> 		 */
> -		if (nxtptr && current_work())
> +		if (req->flags & REQ_F_LINK_TIMEOUT) {
> +			wake_ev = io_link_cancel_timeout(ctx, nxt);
> +
> +			/* we dropped this link, get next */
> +			nxt = list_first_entry_or_null(&req->link_list,
> +							struct io_kiocb, list);
> +		} else if (nxtptr && current_work()) {
> 			*nxtptr = nxt;
> -		else
> +			nxt = NULL;

Use 'break' is more better? no need to set variables and compare.

> +		} else {
> 			io_queue_async_work(req->ctx, nxt);
> +			nxt = NULL;
> +		}
> 	}

--
BR, Jackie Liu



