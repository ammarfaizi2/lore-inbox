Return-Path: <SRS0=pC3Y=ZR=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C560C432C3
	for <io-uring@archiver.kernel.org>; Mon, 25 Nov 2019 00:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 404D420748
	for <io-uring@archiver.kernel.org>; Mon, 25 Nov 2019 00:43:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfKYAnl convert rfc822-to-8bit (ORCPT
        <rfc822;io-uring@archiver.kernel.org>);
        Sun, 24 Nov 2019 19:43:41 -0500
Received: from smtpbg505.qq.com ([203.205.250.114]:53409 "EHLO smtpbg.qq.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726865AbfKYAnk (ORCPT <rfc822;io-uring@vger.kernel.org>);
        Sun, 24 Nov 2019 19:43:40 -0500
X-QQ-mid: Xesmtp2t1574642607tdv42jxil
Received: from [172.16.31.194] (unknown [218.76.23.26])
        by esmtp4.qq.com (ESMTP) with 
        id ; Mon, 25 Nov 2019 08:43:25 +0800 (CST)
X-QQ-SSF: 00000000000000B0SF101F00000000K
X-QQ-FEAT: WLyAQnF3LFnjUUHz7YtoXaubmctqYYApjTsU/aMmSXVABhv/nKTQIM97PHLrd
        xws7umg3B2+XaIrSziC2jg/n0ZdDsG25VcUjNtxi2SQo2P+dkb4kk+SRe7mihArNt/2DAp0
        RAfWkAQ/KqkL+wtKArBfbrSNg4Hi8Mu1IfjsbxYDsz0ji4oVyUSXrHsMcEQF6EZVTbeLwch
        +iGdKPsrq/N0gyF1VdbrBubErP9Gqv5cI2kKJVyEAfFGhvB1awtAoR1xVYBHAa4cwmE8Hjb
        WvVOZSRQrIKvvKZeTHHb1bR5ZvIAn5qnoC1DFnd1k9Xng3W48joTm7Ph4=
X-QQ-GoodBg: 0
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: [PATCH v2] io_uring: fix dead-hung for non-iter fixed rw
From:   Jackie Liu <jackieliu@byteisland.com>
In-Reply-To: <c44dd55c-79b9-78c0-06ad-45f7d47fdd5f@gmail.com>
Date:   Mon, 25 Nov 2019 08:43:23 +0800
Cc:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <BEEAB31A-9949-4375-93EF-0D55D8100045@byteisland.com>
References: <cover.1574585281.git.asml.silence@gmail.com>
 <620023b272fef0fd76d0f91ff1876fa64864caa6.1574585281.git.asml.silence@gmail.com>
 <6a2fcf67-1267-a02a-98ce-435bbb2ca9bb@kernel.dk>
 <c44dd55c-79b9-78c0-06ad-45f7d47fdd5f@gmail.com>
To:     Pavel Begunkov <asml.silence@gmail.com>
X-Mailer: Apple Mail (2.3601.0.10)
X-QQ-SENDSIZE: 520
Feedback-ID: Xesmtp:byteisland.com:bgweb:bgweb1
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org



> 2019年11月25日 01:52，Pavel Begunkov <asml.silence@gmail.com> 写道：
> 
> On 24/11/2019 20:10, Jens Axboe wrote:
>> On 11/24/19 1:58 AM, Pavel Begunkov wrote:
>>> Read/write requests to devices without implemented read/write_iter
>>> using fixed buffers causes general protection fault, which totally
>>> hangs a machine.
>>> 
>>> io_import_fixed() initialises iov_iter with bvec, but loop_rw_iter()
>>> accesses it as iovec, so dereferencing random address.
>>> 
>>> kmap() page by page in this case
>> 
>> This looks good to me, much cleaner/simpler. I've added a few pipe fixed
>> buffer tests to liburing as well. Didn't crash for me, but obvious
>> garbage coming out. I've flagged this for stable as well.
>> 
> The problem I have is that __user pointer is meant to be checked
> for not being a kernel address. I suspect, it could fail in some
> device, which double checks the pointer after vfs (e.g. using access_ok()).
> Am I wrong? Not a fault at least...
> 
> #define access_ok(...) __range_not_ok(addr, user_addr_max());
> 
> BTW, is there anybody testing it for non x86-64 arch?
> 

I have some aarch64 platform, What test do you want me to do?

--
Jackie Liu
