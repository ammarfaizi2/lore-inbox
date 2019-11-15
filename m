Return-Path: <SRS0=yjkE=ZH=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 762B2C432C3
	for <io-uring@archiver.kernel.org>; Fri, 15 Nov 2019 12:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 497F42075E
	for <io-uring@archiver.kernel.org>; Fri, 15 Nov 2019 12:17:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gMBUzsII"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbfKOMRj (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 15 Nov 2019 07:17:39 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:60226 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbfKOMRj (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Fri, 15 Nov 2019 07:17:39 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAFC95gM111208;
        Fri, 15 Nov 2019 12:17:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=Un2IoY2z4Wec9Js6709sEmH67Vqn3x7pgm4zlwtAtH4=;
 b=gMBUzsIIFkzdi1iQpqZuLIgM6K+pWEml6jD+9BtNs99sIeoQCGDfdAGbw9oCe8mnO3rO
 p9pBq6WDlk6SnOGRR4LZM0G9C6xjsgZOnULpmWJ+uNJdmCIltcnqvaMITTw/F74G6fvz
 JzZDlWMU04yTm6pbANaVMarbjzZ8a3xn/Gbq1oP14sMV47OIm/9ibIHT44KK8+GY5QLK
 3XGW5oNv1FsPJK/HcyntuwaZADtWpNNo2f0R0cif1Xxgp7ZOTiVn2OybATY0UBCcvUD7
 7WLd4wRdGIWHEZ/r4pMV4VnKIw6ZsJYdCXHE/XaV02/GBFy0rWls0hMUYHUNFwGFhfaW +w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2w9gxpjxrn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Nov 2019 12:17:35 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAFCDicT167731;
        Fri, 15 Nov 2019 12:17:34 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2w9h14m3t4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Nov 2019 12:17:34 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAFCHXet019046;
        Fri, 15 Nov 2019 12:17:33 GMT
Received: from [192.168.1.14] (/114.88.246.185)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 15 Nov 2019 04:17:33 -0800
Subject: Re: [PATCH] io_uring: fix duplicated increase of cached_cq_overflow
To:     Pavel Begunkov <asml.silence@gmail.com>, axboe@kernel.dk
Cc:     io-uring@vger.kernel.org
References: <20191115093733.18396-1-bob.liu@oracle.com>
 <9ba5abd2-94c2-585a-b55c-d97dc5f429a6@gmail.com>
From:   Bob Liu <bob.liu@oracle.com>
Message-ID: <7ed5d143-c9ba-7d0a-03fe-57af65e88a54@oracle.com>
Date:   Fri, 15 Nov 2019 20:17:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <9ba5abd2-94c2-585a-b55c-d97dc5f429a6@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9441 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911150116
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9441 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911150116
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/15/19 5:49 PM, Pavel Begunkov wrote:
> On 11/15/2019 12:37 PM, Bob Liu wrote:
>> cached_cq_overflow already be increased in function
>> io_cqring_overflow_flush().
>>
>> Signed-off-by: Bob Liu <bob.liu@oracle.com>
>> ---
>>  fs/io_uring.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/io_uring.c b/fs/io_uring.c
>> index 55f8b1d..eb23451 100644
>> --- a/fs/io_uring.c
>> +++ b/fs/io_uring.c
>> @@ -701,7 +701,7 @@ static void io_cqring_fill_event(struct io_kiocb *req, long res)
>>  		WRITE_ONCE(cqe->flags, 0);
>>  	} else if (ctx->cq_overflow_flushed) {
>>  		WRITE_ONCE(ctx->rings->cq_overflow,
>> -				atomic_inc_return(&ctx->cached_cq_overflow));
>> +				atomic_read(&ctx->cached_cq_overflow));
> 
> Not really. It won't get into io_cqring_overflow_flush() if this branch
> is executed. 

io_cqring_overflow_flush(force=true) must have been called when this branch is executed,
since io_cqring_overflow_flush() is the only place can set 'ctx->cq_overflow_flushed' to true.

And 'ctx->cached_cq_overflow' may already be increased in io_cqring_overflow_flush() if force is true and cqe==NULL.

static void io_cqring_overflow_flush(struct io_ring_ctx *ctx, bool force)
{
	...
        if (force)
                ctx->cq_overflow_flushed = true;
                
        while (!list_empty(&ctx->cq_overflow_list)) {
                cqe = io_get_cqring(ctx);
                if (!cqe && !force)
                        break;
                        
                req = list_first_entry(&ctx->cq_overflow_list, struct io_kiocb,
                                                list);
                list_move(&req->list, &list);   
                if (cqe) {
			...
                } else {
                        WRITE_ONCE(ctx->rings->cq_overflow,
                                atomic_inc_return(&ctx->cached_cq_overflow));
			  ^^^^^^^^^^^
			  ctx->cached_cq_overflow is increased if 'force=true' and 'ceq==NULL'.


Did I miss anything?

> See, it's enqueued for overflow in "else" right below.
> 
> i.e. list_add_tail(&req->list, &ctx->cq_overflow_list);
> 
>>  	} else {
>>  		refcount_inc(&req->refs);
>>  		req->result = res;
>>

