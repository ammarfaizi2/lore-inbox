Return-Path: <SRS0=AAoI=Z2=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B57BAC2BD09
	for <io-uring@archiver.kernel.org>; Wed,  4 Dec 2019 15:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8220A2073B
	for <io-uring@archiver.kernel.org>; Wed,  4 Dec 2019 15:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="oPkI281u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbfLDPnM (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 4 Dec 2019 10:43:12 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:41945 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727852AbfLDPnM (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 4 Dec 2019 10:43:12 -0500
Received: by mail-pj1-f68.google.com with SMTP id ca19so3141149pjb.8
        for <io-uring@vger.kernel.org>; Wed, 04 Dec 2019 07:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4KH5KSAnlwVsXz2BOqhV0MZORAh40adeUM9+QcH90bU=;
        b=oPkI281u3E9qmHjfIUregwz1mfCyEkaOPjbJCsXgqpvBBAJkxlUJqjUQDVkvrQqNwY
         95gXhHTdfCNoqHxRUJqPhk2AAYfxBJf/IgqDT13Z5OM3jcyJZvQBmG6y4xRba1n1Gu1O
         y/mXZxxiLKGHqbkBmyqnG1zCwA05azcBi7t7ccfOxIZ0v7LynF1SJlGgP9Nt2nC8pK+O
         +3Q0l5K8+GdvwZHZrRay7/06ssHPyf7DXzUfW2WuSrgfNC1DNpIl7lrMUQ/zM9orC643
         UVu7fr4vFjrk81jNAsd0u5kjdrhv7xFlqx5vt/OAE7xcs0/02oIslmPlVHKZewNRF5I3
         K1pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4KH5KSAnlwVsXz2BOqhV0MZORAh40adeUM9+QcH90bU=;
        b=Mo8/dEfUIz+cKo/8rXfmVzpro+e4y2eClQ8w0VRawuwXq4AEaaQtb77zLyJeNNUdhH
         h+xWjyUW6m6x/iPSUIMWVmB+gDimy2xk1TKlEQDfOwwttjtr9bVkS1gbqY/WSkSllGQg
         RBs55PNlrjAiZrJOZabFcq3yMm8R53uOMXCj0OXmZmls/mc4KgEAF6jNsMGdCKcM0Ln8
         ExIghhq4w+Folema5R4NrqWeG/eRYfAK1FM2Bh45UKtFyU5uy9bs8B9eRvz1cf5j4+Bt
         ViaGfE3Xiu30vQnyjRAQrGCI0uUbmheV+Ick5aQm/FeRYqSOsnd7shCEQqWWbNV/+BKR
         Sgng==
X-Gm-Message-State: APjAAAWaLuav9thjKkahpc7mTIuebzTYyNO4GxmDXPQZmqRdrpeKANk0
        0OOMRVU6K28yOd/XV5zREf5o8ofH8vf4CQ==
X-Google-Smtp-Source: APXvYqwBdfe6IROXsqmkPBwi3kh6v9hDwKMKj63z1O6jgrgJX+dI0iQ2t2d0dFZvGhkffnqUyClVWQ==
X-Received: by 2002:a17:90a:2668:: with SMTP id l95mr3914942pje.98.1575474190464;
        Wed, 04 Dec 2019 07:43:10 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id d85sm8868367pfd.146.2019.12.04.07.43.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2019 07:43:09 -0800 (PST)
Subject: Re: kernel (or fio) bug with IOSQE_IO_DRAIN
From:   Jens Axboe <axboe@kernel.dk>
To:     Andres Freund <andres@anarazel.de>
Cc:     linux-block@vger.kernel.org, io-uring <io-uring@vger.kernel.org>
References: <20190913215846.uz4llevvdm5rpatf@alap3.anarazel.de>
 <84b6083c-861c-c586-a5f2-09143d96b74c@kernel.dk>
Message-ID: <5c22cf17-a2ea-80f3-c7fb-b3b673ce9bee@kernel.dk>
Date:   Wed, 4 Dec 2019 08:43:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <84b6083c-861c-c586-a5f2-09143d96b74c@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 12/4/19 7:58 AM, Jens Axboe wrote:
> On 9/13/19 3:58 PM, Andres Freund wrote:
>> Hi Jens,
>>
>> While I'm not absolutely certain, this looks like a kernel side bug. I
>> modified fio to set DRAIN (because I'd need that in postgres, to not
>> actually just loose data as my current prototype does).  But the
>> submissions currently fail after a very short amount of time, as soon as
>> I use a queue depth bigger than one.
>>
>> I modified fio's master like (obviously not intended as an actual fio
>> patch):
>>
>> diff --git i/engines/io_uring.c w/engines/io_uring.c
>> index e5edfcd2..a3fe461f 100644
>> --- i/engines/io_uring.c
>> +++ w/engines/io_uring.c
>> @@ -181,16 +181,20 @@ static int fio_ioring_prep(struct thread_data *td, struct io_u *io_u)
>>                           sqe->len = 1;
>>                   }
>>                   sqe->off = io_u->offset;
>> +               sqe->flags |= IOSQE_IO_DRAIN;
>>           } else if (ddir_sync(io_u->ddir)) {
>>                   if (io_u->ddir == DDIR_SYNC_FILE_RANGE) {
>>                           sqe->off = f->first_write;
>>                           sqe->len = f->last_write - f->first_write;
>>                           sqe->sync_range_flags = td->o.sync_file_range;
>>                           sqe->opcode = IORING_OP_SYNC_FILE_RANGE;
>> +
>> +                       //sqe->flags |= IOSQE_IO_DRAIN;
>>                   } else {
>>                           if (io_u->ddir == DDIR_DATASYNC)
>>                                   sqe->fsync_flags |= IORING_FSYNC_DATASYNC;
>>                           sqe->opcode = IORING_OP_FSYNC;
>> +                       //sqe->flags |= IOSQE_IO_DRAIN;
>>                   }
>>           }
>>    
>>
>> I pretty much immediately get failed requests back with a simple fio
>> job:
>>
>> [global]
>> name=fio-drain-bug
>>
>> size=1G
>> nrfiles=1
>>
>> iodepth=2
>> ioengine=io_uring
>>
>> [test]
>> rw=write
>>
>>
>> andres@alap4:~/src/fio$ ~/build/fio/install/bin/fio  ~/tmp/fio-drain-bug.fio
>> test: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=io_uring, iodepth=2
>> fio-3.15
>> Starting 1 process
>> files=0
>> fio: io_u error on file test.0.0: Invalid argument: write offset=794877952, buflen=4096
>> fio: pid=3075, err=22/file:/home/andres/src/fio/io_u.c:1787, func=io_u error, error=Invalid argument
>>
>> test: (groupid=0, jobs=1): err=22 (file:/home/andres/src/fio/io_u.c:1787, func=io_u error, error=Invalid argument): pid=3075: Fri Sep 13 12:45:19 2019
>>
>>
>> Where I think the EINVAL might come from
>>
>> 	if (unlikely(s->index >= ctx->sq_entries))
>> 		return -EINVAL;
>>
>> based on the stack trace a perf probe returns (hacketyhack):
>>
>> kworker/u16:0-e  6304 [006] 28733.064781: probe:__io_submit_sqe: (ffffffff81356719)
>>           ffffffff8135671a __io_submit_sqe+0xfa (/lib/modules/5.3.0-rc8-andres-00007-g3120b9a6a3f7-dirty/build/vmlinux)
>>           ffffffff81356da0 io_sq_wq_submit_work+0xe0 (/lib/modules/5.3.0-rc8-andres-00007-g3120b9a6a3f7-dirty/build/vmlinux)
>>           ffffffff81137392 process_one_work+0x1d2 (/lib/modules/5.3.0-rc8-andres-00007-g3120b9a6a3f7-dirty/build/vmlinux)
>>           ffffffff8113758d worker_thread+0x4d (/lib/modules/5.3.0-rc8-andres-00007-g3120b9a6a3f7-dirty/build/vmlinux)
>>           ffffffff8113d1e6 kthread+0x106 (/lib/modules/5.3.0-rc8-andres-00007-g3120b9a6a3f7-dirty/build/vmlinux)
>>           ffffffff8200021a ret_from_fork+0x3a (/lib/modules/5.3.0-rc8-andres-00007-g3120b9a6a3f7-dirty/build/vmlinux
>>
>> /home/andres/src/kernel/fs/io_uring.c:1800
>>
>> which precisely the return:
>> 	if (unlikely(s->index >= ctx->sq_entries))
>> 		return -EINVAL;
>>
>> This is with your change to limit the number of workqueue threads
>> applied, but I don't think that should matter.
>>
>> I suspect that this is hit due to ->index being unitialized, rather than
>> actually too large. In io_sq_wq_submit_work() the sqe_submit embedded in
>> io_kiocb is used.  ISTM that e.g. when
>> io_uring_enter()->io_ring_submit()->io_submit_sqe()
>> allocates the new io_kiocb and io_queue_sqe()->io_req_defer() and then
>> submits that to io_sq_wq_submit_work() io_kiocb->submit.index (and some
>> other fields?) is not initialized.
> 
> For some reason I completely missed this one. I just tested this with
> the current tree, and I don't see any issues, but we also changed a few
> things there in this area and could have fixed this one inadvertently.
> I'll try 5.4/5.3, we might need a stable addition for this if it's still
> an issue.
> 
> Also see:
> 
> https://github.com/axboe/liburing/issues/33

I think your analysis is spot on, and it's affecting 5.2..5.4. This is
the patch for stable for 5.4, should apply to 5.2 and 5.3 as well by
just dropping the link hunk as 5.2/5.3 doesn't have that.

5.5-rc isn't affected.


diff --git a/fs/io_uring.c b/fs/io_uring.c
index 2c819c3c855d..0393545a39a7 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2016,7 +2017,7 @@ static int io_timeout(struct io_kiocb *req, const struct io_uring_sqe *sqe)
  }
  
  static int io_req_defer(struct io_ring_ctx *ctx, struct io_kiocb *req,
-			const struct io_uring_sqe *sqe)
+			struct sqe_submit *s)
  {
  	struct io_uring_sqe *sqe_copy;
  
@@ -2034,7 +2035,8 @@ static int io_req_defer(struct io_ring_ctx *ctx, struct io_kiocb *req,
  		return 0;
  	}
  
-	memcpy(sqe_copy, sqe, sizeof(*sqe_copy));
+	memcpy(&req->submit, s, sizeof(*s));
+	memcpy(sqe_copy, s->sqe, sizeof(*sqe_copy));
  	req->submit.sqe = sqe_copy;
  
  	INIT_WORK(&req->work, io_sq_wq_submit_work);
@@ -2399,7 +2401,7 @@ static int io_queue_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
  {
  	int ret;
  
-	ret = io_req_defer(ctx, req, s->sqe);
+	ret = io_req_defer(ctx, req, s);
  	if (ret) {
  		if (ret != -EIOCBQUEUED) {
  			io_free_req(req);
@@ -2426,7 +2428,7 @@ static int io_queue_link_head(struct io_ring_ctx *ctx, struct io_kiocb *req,
  	 * list.
  	 */
  	req->flags |= REQ_F_IO_DRAIN;
-	ret = io_req_defer(ctx, req, s->sqe);
+	ret = io_req_defer(ctx, req, s);
  	if (ret) {
  		if (ret != -EIOCBQUEUED) {
  			io_free_req(req);

-- 
Jens Axboe

