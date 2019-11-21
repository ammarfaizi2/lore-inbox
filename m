Return-Path: <SRS0=BBHt=ZN=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE29C43215
	for <io-uring@archiver.kernel.org>; Thu, 21 Nov 2019 14:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 072BB206CB
	for <io-uring@archiver.kernel.org>; Thu, 21 Nov 2019 14:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mSBrccgq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbfKUO20 (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 21 Nov 2019 09:28:26 -0500
Received: from mail-lj1-f171.google.com ([209.85.208.171]:47033 "EHLO
        mail-lj1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbfKUO20 (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 21 Nov 2019 09:28:26 -0500
Received: by mail-lj1-f171.google.com with SMTP id e9so3396466ljp.13
        for <io-uring@vger.kernel.org>; Thu, 21 Nov 2019 06:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dtoFs32uaz1CaXJN1y0LTyYGnlzxmum4YOUtTAFge6Q=;
        b=mSBrccgqki7VPL5dzwQNanaeABOqhKHGsBzkQ+4WZFN3bJHXQuZycmgcALQ8/BkH6Z
         dlwWchV4xpOC2ORrCciizjiC91XCBk37YQgWNI8KkCGwC8s9oaLOWrnZAT/HnmbaaAwD
         yAiRUNzY7TgHcbaW++IRCR+xhYhEDUWw7OtifqDqIerL+uYSpVOHIbtlCB/iMd0y8Ajk
         74Aw3NnA2n1fBLdSu3a9YJudBURrVdzaisGj9Q11k78w7iSFitbEmL3M1q0LMnbbWJY5
         EfMHSC88noiG1sg7xwyMmCcBI6xhVDejlPDq3q9SCdL30N5u6n+SbNSDqR+Wcnt65Min
         uqHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dtoFs32uaz1CaXJN1y0LTyYGnlzxmum4YOUtTAFge6Q=;
        b=WsgsNMDGCFom/62NEc2yzAjOeG6uviQ+Qk5Fe8wntpjSwQfswW6Dc/fBy+cZd3sgbX
         FLU0Xl+PGiufH3okUeFoI/CpNpOo/HPv/p40TRZfSvi/nl4NszH5Y+3B9v243ebAZ0EH
         F0SWa0mzEefRNQoW3j8K/n8H0sV5cKXGPkFPsQR4bQ5V74orrrfbv/WEa6yfq6dTqRAK
         /l/NgCTv6WrE2vo5CD7fP7PaYaxt4evSgIrUAzm/ZQ9JC5o8E0iXjJzaMYElkLYzwjaz
         3zPPZZYs73WDNlkJbYVBnUcnQOC5nljiV/5FhObX7iQjdYEaS3BlVVKdZmgq+b+DuIj4
         MsgQ==
X-Gm-Message-State: APjAAAXHD90smakTyTTi25UCzYQqP2InC8iH+gWy8DfgNdE7iql9vSfj
        Oft2nL1pUj39vXEVXeRXktctWA3dvvk=
X-Google-Smtp-Source: APXvYqw/xwS4BsW2I40AzJjJLB9pxTrtQxgFGAZjLBeyy1XZDRiwOTQnIdCfiQt0E2+YyhMVWLluZQ==
X-Received: by 2002:a05:651c:38f:: with SMTP id e15mr7680331ljp.107.1574346500003;
        Thu, 21 Nov 2019 06:28:20 -0800 (PST)
Received: from [172.31.190.83] ([86.57.146.226])
        by smtp.gmail.com with ESMTPSA id l28sm1640365lfp.63.2019.11.21.06.28.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2019 06:28:19 -0800 (PST)
Subject: Re: [PATCH] io_uring: drain next sqe instead of shadowing
To:     Jackie Liu <liuyun01@kylinos.cn>, Jens Axboe <axboe@kernel.dk>
Cc:     io-uring@vger.kernel.org
References: <2005c339-5ed3-6c2e-f011-5bc89dac3f5c@kernel.dk>
 <5e8a8176e29a61ec79004521bc2ef28e4d9715b1.1574325863.git.asml.silence@gmail.com>
 <A12FD0FF-3C4F-46BE-8ABB-AA732002A9CA@kylinos.cn>
 <bb367887-ed2c-1da3-59f5-c66f12ab7c5c@gmail.com>
 <5dd68282.1c69fb81.110a.43a7SMTPIN_ADDED_BROKEN@mx.google.com>
 <6da3585e-b419-ea9b-4246-1ee5ca14f5b9@gmail.com>
 <5dd68820.1c69fb81.64e0b.4340SMTPIN_ADDED_BROKEN@mx.google.com>
 <b129f1ba-b82c-d8cf-7dbd-efd14fd3fe8f@kernel.dk>
 <5dd69c43.1c69fb81.6589a.b4f1SMTPIN_ADDED_BROKEN@mx.google.com>
From:   Pavel Begunkov <asml.silence@gmail.com>
Message-ID: <1feba72a-08f9-14c3-91c6-7efe4d5b1d8b@gmail.com>
Date:   Thu, 21 Nov 2019 17:28:18 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <5dd69c43.1c69fb81.6589a.b4f1SMTPIN_ADDED_BROKEN@mx.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

>>
>> Was that a reviewed-by from you? It'd be nice to get these more
>> formally so I can add the attributes. I'll drop the other patch.
> 
> I want to do more tests. There is no test machine at this time, at least
> until tomorrow morning.
> 
BTW, aside from the locking problem, that it fixes another one. If
allocation for a shadow req is failed, io_submit_sqes() just continues
without it ignoring draining.

>>
>>> The mailing list always rejects my mail, is my smtp server IP banned?
>>
>> Probably because you have text/html in your email, the list is pretty
>> picky when it comes to anything that isn't just text/plain.
> 
> I don't know, I use thunderbird to write emails, and it has been set to
> plain text, perhaps because of the signature, I have to check my mail
> client.
> 
> -- 
> Jackie Liu
> 
> 
