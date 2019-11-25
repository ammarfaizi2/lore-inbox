Return-Path: <SRS0=pC3Y=ZR=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98AA6C432C3
	for <io-uring@archiver.kernel.org>; Mon, 25 Nov 2019 02:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68D712073F
	for <io-uring@archiver.kernel.org>; Mon, 25 Nov 2019 02:38:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="PJMCPg1X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbfKYCis (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sun, 24 Nov 2019 21:38:48 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:40454 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbfKYCir (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sun, 24 Nov 2019 21:38:47 -0500
Received: by mail-pj1-f67.google.com with SMTP id ep1so5881858pjb.7
        for <io-uring@vger.kernel.org>; Sun, 24 Nov 2019 18:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=h4g3p0r/URLgceda6oneY+W+5GgwJK5bezfgsk7dapU=;
        b=PJMCPg1XEAU/Shf5pPha06+luSJfqiPX3ETi/C4b+OiTjFq7hFo92mfvCN3aE44kaV
         OlBwWcpyGVHSGj7Jz6x3KgZXSzYVMUYj9BekZt5EVoGzzGPbQRUycLPlXeAdmlMUdAJM
         5IRW1DEqpldpErPFWP7jG8tShjtf3QUa8ehTgaKmyDs+ds7BlnlMpDSWoDZeJ3l2rSSc
         fkCvSyS/AqhGT+F1z1muJjFtYdBRoCYYUQbtgG0deiw3mAvgmtVxEP+NfoxIgrpb7m06
         6FBAS5vyxdri5rAHHY5YUDIVY45o9HJIkCqUrXTAJRMv6rE/cOfH1I0dRZiKoscBjVEE
         e1XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=h4g3p0r/URLgceda6oneY+W+5GgwJK5bezfgsk7dapU=;
        b=jRrIb+F1X57nbUhfEyOxHC/JTdArQU9UWFLH1LSB/PA6P9bSoaxvx4ahhtY4Ssdvhr
         xjM8DL7fQQFsdkDU0jUoTQ74f858Ai/MgXu7ApGaYByXyiWQyErzWyC61fntR751WpNA
         CMEXV/m35o7LZhsprCUvayBof0jk1YQeixidc2BwtFuP+L9hkm4j5/cCJEsfRzZeiPjl
         MQF7NNOW8Z7NdELFsWo9+e7gbP61j0H0S0zOwKRBBM9QwfQ+pGaunlfuUEqlNWw4VIYY
         StWW25a0RMWG0SmL9rkl542zXOtWsAq4MkYk6xzW434uEejyt5SUvuvlFI1vOnnlZtS7
         tRmQ==
X-Gm-Message-State: APjAAAXJcHLb+/Yjvx1RU1PXkzpPnDoxRidFeTupuDHSRITCnyvxja6s
        s10HdStvBTZlzAhSJea48stO/EEEKyw93w==
X-Google-Smtp-Source: APXvYqx3XSGhcILtSjukwezpvkZt4T502tse6oTVccnDyfSCk/gXJojI6d6De2PqyM3aAzl4QUe1Hw==
X-Received: by 2002:a17:90a:8995:: with SMTP id v21mr36167806pjn.109.1574649525526;
        Sun, 24 Nov 2019 18:38:45 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id a23sm5918431pjv.26.2019.11.24.18.38.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Nov 2019 18:38:44 -0800 (PST)
Subject: Re: [PATCH v2] io_uring: fix dead-hung for non-iter fixed rw
To:     Jackie Liu <jackieliu@byteisland.com>,
        Pavel Begunkov <asml.silence@gmail.com>
Cc:     io-uring@vger.kernel.org
References: <cover.1574585281.git.asml.silence@gmail.com>
 <620023b272fef0fd76d0f91ff1876fa64864caa6.1574585281.git.asml.silence@gmail.com>
 <6a2fcf67-1267-a02a-98ce-435bbb2ca9bb@kernel.dk>
 <c44dd55c-79b9-78c0-06ad-45f7d47fdd5f@gmail.com>
 <BEEAB31A-9949-4375-93EF-0D55D8100045@byteisland.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <838a574f-e118-cda2-5412-c21af85c512b@kernel.dk>
Date:   Sun, 24 Nov 2019 19:38:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <BEEAB31A-9949-4375-93EF-0D55D8100045@byteisland.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/24/19 5:43 PM, Jackie Liu wrote:
> 
> 
>> 2019年11月25日 01:52，Pavel Begunkov <asml.silence@gmail.com> 写道：
>>
>> On 24/11/2019 20:10, Jens Axboe wrote:
>>> On 11/24/19 1:58 AM, Pavel Begunkov wrote:
>>>> Read/write requests to devices without implemented read/write_iter
>>>> using fixed buffers causes general protection fault, which totally
>>>> hangs a machine.
>>>>
>>>> io_import_fixed() initialises iov_iter with bvec, but loop_rw_iter()
>>>> accesses it as iovec, so dereferencing random address.
>>>>
>>>> kmap() page by page in this case
>>>
>>> This looks good to me, much cleaner/simpler. I've added a few pipe fixed
>>> buffer tests to liburing as well. Didn't crash for me, but obvious
>>> garbage coming out. I've flagged this for stable as well.
>>>
>> The problem I have is that __user pointer is meant to be checked
>> for not being a kernel address. I suspect, it could fail in some
>> device, which double checks the pointer after vfs (e.g. using access_ok()).
>> Am I wrong? Not a fault at least...
>>
>> #define access_ok(...) __range_not_ok(addr, user_addr_max());
>>
>> BTW, is there anybody testing it for non x86-64 arch?
>>
> 
> I have some aarch64 platform, What test do you want me to do?

A basic one to try would be:

axboe@x1:/home/axboe/git/liburing $ test/stdout 
This is a pipe test
This is a fixed pipe test

But in general I'd just run make runtests in the liburing directory
and go through all of them.

-- 
Jens Axboe

