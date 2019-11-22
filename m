Return-Path: <SRS0=nrYQ=ZO=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BCACC432C0
	for <io-uring@archiver.kernel.org>; Fri, 22 Nov 2019 10:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDBD420726
	for <io-uring@archiver.kernel.org>; Fri, 22 Nov 2019 10:32:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfKVKc1 convert rfc822-to-8bit (ORCPT
        <rfc822;io-uring@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:32:27 -0500
Received: from smtpbg501.qq.com ([203.205.250.101]:56768 "EHLO smtpbg.qq.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727648AbfKVKcZ (ORCPT <rfc822;io-uring@vger.kernel.org>);
        Fri, 22 Nov 2019 05:32:25 -0500
X-QQ-mid: Xesmtp2t1574418438tiax3uvwp
Received: from [172.16.31.194] (unknown [218.76.23.26])
        by esmtp4.qq.com (ESMTP) with 
        id ; Fri, 22 Nov 2019 18:26:47 +0800 (CST)
X-QQ-SSF: 00000000000000B0SF101F00000000K
X-QQ-FEAT: fs34Pe/+C2TOstQJolLBPB+L5GsarrxtdqzULLh2wXW8wRU6SesXnQgQ5dSkR
        IHIIzX+1x6lfcnf2eOA7Rnr68OSiRfS3uuW4WubV+Mx0A/xU4tFacLkAh5nDvhh9a2TFHy8
        52YVN6MwMblWG2rkBX0lrhGi5AU6qGyvRuSKcRTdKT8RazEbJn9D5V1Gir1/Tkq/xjSz9iv
        YtMRO4xACgXH8znWyh6w+PGe6TqFWRUrMeEFp182PSN8NfCqSO1mVAnrVxpHdzElT7k9RCt
        x5Jxnb5AP8emxw6X/FUNqtOtExi5y7lSOCRX1wEhcx41xOsB7YCwILr/8=
X-QQ-GoodBg: 0
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: [PATCH RESEND] io_uring: a small optimization for
 REQ_F_DRAIN_LINK
From:   JackieLiu <jackieliu@byteisland.com>
In-Reply-To: <4132c196-afd5-4ac8-0842-2746cc9e4a6f@gmail.com>
Date:   Fri, 22 Nov 2019 18:26:46 +0800
Cc:     axboe@kernel.dk, io-uring@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <01E7FC11-C19D-40FE-A471-5E1FAD2ED3D8@byteisland.com>
References: <20191122060129.40251-1-jackieliu@byteisland.com>
 <20191122060129.40251-2-jackieliu@byteisland.com>
 <4132c196-afd5-4ac8-0842-2746cc9e4a6f@gmail.com>
To:     Pavel Begunkov <asml.silence@gmail.com>
X-Mailer: Apple Mail (2.3601.0.10)
X-QQ-SENDSIZE: 520
Feedback-ID: Xesmtp:byteisland.com:bgweb:bgweb1
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org



> 2019年11月22日 18:05，Pavel Begunkov <asml.silence@gmail.com> 写道：
> 
> On 11/22/2019 9:01 AM, Jackie Liu wrote:
>> From: Jackie Liu <liuyun01@kylinos.cn>
>> 
>> We don't need to set drain_next every time, make a small judgment
>> and add unlikely, it looks like there will be a little optimization.
>> 
> Not sure about that. It's 1 CMP + 1 SETcc/STORE, which works pretty fast
> as @drain_next is hot (especially after read) and there is no write-read
> dependency close. For yours, there is likely always 3 CMPs in the way.
> 
> Did you benchmarked it somehow or compared assembly?

It is only theoretically possible. In most cases, our drain_link 
and drain_next are both false, so only two CMPs are needed, and modern CPUs
have branch predictions. Perhaps these judgments can be optimized.

Your code is very nice, when I reading and understanding your code,
I want to try if there is any other way to optimize it. 

Sometimes you don't need to reset drain_next, such as drain_link == true && 
drain_next == true, you don't need to set below one more time.

--
Jackie Liu

> 
>> Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
>> ---
>> resend that patch, because reject by mail-list.
>> 
>> fs/io_uring.c | 6 ++++--
>> 1 file changed, 4 insertions(+), 2 deletions(-)
>> 
>> diff --git a/fs/io_uring.c b/fs/io_uring.c
>> index 013e5ed..f4ec44a 100644
>> --- a/fs/io_uring.c
>> +++ b/fs/io_uring.c
>> @@ -2938,12 +2938,14 @@ static void __io_queue_sqe(struct io_kiocb *req)
>> static void io_queue_sqe(struct io_kiocb *req)
>> {
>> 	int ret;
>> +	bool drain_link = req->flags & REQ_F_DRAIN_LINK;
>> 
>> -	if (unlikely(req->ctx->drain_next)) {
>> +	if (unlikely(req->ctx->drain_next && !drain_link)) {
>> 		req->flags |= REQ_F_IO_DRAIN;
>> 		req->ctx->drain_next = false;
>> +	} else if (unlikely(drain_link)) {
>> +		req->ctx->drain_next = true;
>> 	}
>> -	req->ctx->drain_next = (req->flags & REQ_F_DRAIN_LINK);
>> 
>> 	ret = io_req_defer(req);
>> 	if (ret) {
>> 
> 
> -- 
> Pavel Begunkov

