Return-Path: <SRS0=pC3Y=ZR=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B3BC432C0
	for <io-uring@archiver.kernel.org>; Mon, 25 Nov 2019 03:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30C5020748
	for <io-uring@archiver.kernel.org>; Mon, 25 Nov 2019 03:38:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfKYDii convert rfc822-to-8bit (ORCPT
        <rfc822;io-uring@archiver.kernel.org>);
        Sun, 24 Nov 2019 22:38:38 -0500
Received: from smtpbg513.qq.com ([203.205.250.40]:49083 "EHLO smtpbg.qq.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726921AbfKYDii (ORCPT <rfc822;io-uring@vger.kernel.org>);
        Sun, 24 Nov 2019 22:38:38 -0500
X-QQ-mid: Xesmtp4t1574652810tu3b6sl0s
Received: from [172.16.31.194] (unknown [218.76.23.26])
        by esmtp4.qq.com (ESMTP) with 
        id ; Mon, 25 Nov 2019 11:33:29 +0800 (CST)
X-QQ-SSF: 00000000000000B0SF101F00000000K
X-QQ-FEAT: asOxXDmQmvCBOsN02paYPJsp9+UmuXyQpi1wakvYUIFaJ51jhQrib6Z5CGWFl
        hTawHrP/R7BTKcWqNB9N3hbqLx/3BWCl3BX//vKzDI0uHChhr+NpQoYIoZq5v73K7/DEd2N
        ObCvOcDV5HcssEKZsFofrFh5lsqz5wgsJYftd1Nxcir5SFo+voS31hzXo/UvKlF/Ul4UjjC
        Pgyu8jYBgGxRfMh5U5fyTPt5DIQNRdqr2cJ2X8TQyDfxPHjkYf9+1e5VbauVUo4DWH5/qLJ
        hhpcY6DnYGxflU4Yd89yjGorosv1Muk/j3JThlGZ8M+xkDHr1QsTK5nA4=
X-QQ-GoodBg: 0
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: [PATCH v2] io_uring: fix dead-hung for non-iter fixed rw
From:   Jackie Liu <jackieliu@byteisland.com>
In-Reply-To: <838a574f-e118-cda2-5412-c21af85c512b@kernel.dk>
Date:   Mon, 25 Nov 2019 11:33:26 +0800
Cc:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <107FEF05-A0E6-4E81-BD0A-BB360CD7F628@byteisland.com>
References: <cover.1574585281.git.asml.silence@gmail.com>
 <620023b272fef0fd76d0f91ff1876fa64864caa6.1574585281.git.asml.silence@gmail.com>
 <6a2fcf67-1267-a02a-98ce-435bbb2ca9bb@kernel.dk>
 <c44dd55c-79b9-78c0-06ad-45f7d47fdd5f@gmail.com>
 <BEEAB31A-9949-4375-93EF-0D55D8100045@byteisland.com>
 <838a574f-e118-cda2-5412-c21af85c512b@kernel.dk>
To:     Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3601.0.10)
X-QQ-SENDSIZE: 520
Feedback-ID: Xesmtp:byteisland.com:bgweb:bgweb4
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org



> 2019年11月25日 10:38，Jens Axboe <axboe@kernel.dk> 写道：
> 
> On 11/24/19 5:43 PM, Jackie Liu wrote:
>> 
>> 
>>> 2019年11月25日 01:52，Pavel Begunkov <asml.silence@gmail.com> 写道：
>>> 
>>> On 24/11/2019 20:10, Jens Axboe wrote:
>>>> On 11/24/19 1:58 AM, Pavel Begunkov wrote:
>>>>> Read/write requests to devices without implemented read/write_iter
>>>>> using fixed buffers causes general protection fault, which totally
>>>>> hangs a machine.
>>>>> 
>>>>> io_import_fixed() initialises iov_iter with bvec, but loop_rw_iter()
>>>>> accesses it as iovec, so dereferencing random address.
>>>>> 
>>>>> kmap() page by page in this case
>>>> 
>>>> This looks good to me, much cleaner/simpler. I've added a few pipe fixed
>>>> buffer tests to liburing as well. Didn't crash for me, but obvious
>>>> garbage coming out. I've flagged this for stable as well.
>>>> 
>>> The problem I have is that __user pointer is meant to be checked
>>> for not being a kernel address. I suspect, it could fail in some
>>> device, which double checks the pointer after vfs (e.g. using access_ok()).
>>> Am I wrong? Not a fault at least...
>>> 
>>> #define access_ok(...) __range_not_ok(addr, user_addr_max());
>>> 
>>> BTW, is there anybody testing it for non x86-64 arch?
>>> 
>> 
>> I have some aarch64 platform, What test do you want me to do?
> 
> A basic one to try would be:
> 
> axboe@x1:/home/axboe/git/liburing $ test/stdout 
> This is a pipe test
> This is a fixed pipe test
> 
> But in general I'd just run make runtests in the liburing directory
> and go through all of them.
> 

For test/stdout is PASS. Tested-by: Jackie Liu <liuyun01@kylinos.cn>

But test/accept-link and test/fixed-link failed in for-5.5/io_uring-post branch.
that is expect?

--
Jackie Liu


