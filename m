Return-Path: <SRS0=BBHt=ZN=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E435DC432C3
	for <io-uring@archiver.kernel.org>; Thu, 21 Nov 2019 15:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8DA9206F4
	for <io-uring@archiver.kernel.org>; Thu, 21 Nov 2019 15:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="kPjbYopq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbfKUPMt (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 21 Nov 2019 10:12:49 -0500
Received: from mail-io1-f48.google.com ([209.85.166.48]:43728 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbfKUPMt (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 21 Nov 2019 10:12:49 -0500
Received: by mail-io1-f48.google.com with SMTP id r2so3768828iot.10
        for <io-uring@vger.kernel.org>; Thu, 21 Nov 2019 07:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FKmA1dj5ul8c9B7/AW1SeCE2cpRR3rxrM0o5i/Y/WKw=;
        b=kPjbYopquByXxCpTTv4yW6ae0DzuMCCGFTqwC83zxvmsyx8WrHMiEdgOaJr24m5K0Z
         AG/KSf0wjRpe06+EIKYX2SPxBwqicHeWqeiOBBACFSN1+adFlpUm4zfDob5aAruGwTkh
         HDamk9xy8JroO5Sahk4I5I651OaxVlxlpNBbbuRvuTgdav+K3kYZwKop/a7K/MC4jk18
         c5yI1apmxjtDvfiBxRiS19n80FR/n/azXeb6PH/PGgDJ3ByG0YZLiMmarajeJVfyuTya
         DPXCMxV0EQ62vBolL6QxQGuoz6Sy/ulpVal1Y/uRSdMGxt8aDRIs/fweW2Tz9OFu2/IQ
         eYdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FKmA1dj5ul8c9B7/AW1SeCE2cpRR3rxrM0o5i/Y/WKw=;
        b=RyBCdmiutUC7VxKimkw2GTyfgkrcxueTIotR21LomM7yRtqGIc6GfiQc9/TywxNBAS
         lCb2mtS2wA4S8SW5B2J6wHEGSaMmP1fxpgR+uGZ8dZWsafBWVhnStg6uD8GxWNCLk4mI
         VpXC4gYBluXWWlsDrDWqsD76mKG393Be7sPqON/S4fyR3eXMT0Gnl+H4hHnjo5gqId3L
         6QewNvVabI1k0sKV5BPqQKT6zY40v8eEVziwdpLUVUeQIBIX9lgfDz968PtfZaYjTA0W
         82tRbJ3h7+DdauEIfygKRK8DuLrGBoJHqA0iO4QQ/V5MvOmGehcrFoxCDhx6syECxObT
         AQLg==
X-Gm-Message-State: APjAAAVQVjtOzFrnRsQLoY3HGAXKbzubVCDzEPBgR27tVVbxuJg6gQfy
        5tz9waD/R47gePiGQV+nBqskE8icaFzFaA==
X-Google-Smtp-Source: APXvYqxEdS90T8xK24DILdvLmLtAXt1mypIl4z907MN6f4VHjxfG7Uo1byqt/5792BYm3irrfWg9Cg==
X-Received: by 2002:a5d:8555:: with SMTP id b21mr8346818ios.22.1574349167334;
        Thu, 21 Nov 2019 07:12:47 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id r18sm1264449ilq.75.2019.11.21.07.12.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2019 07:12:46 -0800 (PST)
Subject: Re: [PATCH] io_uring: drain next sqe instead of shadowing
To:     Jackie Liu <liuyun01@kylinos.cn>,
        Pavel Begunkov <asml.silence@gmail.com>
Cc:     io-uring@vger.kernel.org
References: <2005c339-5ed3-6c2e-f011-5bc89dac3f5c@kernel.dk>
 <5e8a8176e29a61ec79004521bc2ef28e4d9715b1.1574325863.git.asml.silence@gmail.com>
 <A12FD0FF-3C4F-46BE-8ABB-AA732002A9CA@kylinos.cn>
 <bb367887-ed2c-1da3-59f5-c66f12ab7c5c@gmail.com>
 <5dd68282.1c69fb81.110a.43a7SMTPIN_ADDED_BROKEN@mx.google.com>
 <6da3585e-b419-ea9b-4246-1ee5ca14f5b9@gmail.com>
 <5dd68820.1c69fb81.64e0b.4340SMTPIN_ADDED_BROKEN@mx.google.com>
 <b129f1ba-b82c-d8cf-7dbd-efd14fd3fe8f@kernel.dk>
 <5dd69c7f.1c69fb81.8868.e3c2SMTPIN_ADDED_BROKEN@mx.google.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4b90e56e-1190-eeb5-f61a-c8d3a0f2d969@kernel.dk>
Date:   Thu, 21 Nov 2019 06:54:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <5dd69c7f.1c69fb81.8868.e3c2SMTPIN_ADDED_BROKEN@mx.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/21/19 7:16 AM, Jackie Liu wrote:
> 在 2019/11/21 21:47, Jens Axboe 写道:
>> On 11/21/19 5:49 AM, Jackie Liu wrote:
>>>
>>>
>>> On 2019/11/21 20:40, Pavel Begunkov wrote:
>>>>> 在 2019/11/21 17:43, Pavel Begunkov 写道:
>>>>>> On 11/21/2019 12:26 PM, Jackie Liu wrote:
>>>>>>> 2019年11月21日 16:54，Pavel Begunkov <asml.silence@gmail.com> 写道：
>>>>>>>>
>>>>>>>> If there is a DRAIN in the middle of a link, it uses shadow req. Defer
>>>>>>>> the next request/link instead. This:
>>>>>>>>
>>>>>>>> Pros:
>>>>>>>> 1. removes semi-duplicated code
>>>>>>>> 2. doesn't allocate memory for shadows
>>>>>>>> 3. works better if only the head marked for drain
>>>>>>>
>>>>>>> I thought about this before, just only drain the head, but if the
>>>>>>> latter IO depends
>>>>>>> on the link-list, then latter IO will run in front of the link-list.
>>>>>>> If we think it
>>>>>>> is acceptable, then I think it is ok for me.
>>>>>>
>>>>>> If I got your point right, latter requests won't run ahead of the
>>>>>> link-list. There shouldn't be change of behaviour.
>>>>>>
>>>>>> The purpose of shadow requests is to mark some request right ahead of
>>>>>> the link for draining. This patch uses not a specially added shadow
>>>>>> request, but the following regular one. And, as drained IO shouldn't be
>>>>>> issued until every request behind completed, this should give the same
>>>>>> effect.
>>>>>>
>>>>>> Am I missed something?
>>>>>
>>>>> Thanks for explaining. This is also correct, if I understand
>>>>> correctly, It seems that other IOs will wait for all the links are
>>>>> done. this is a little different, is it?
>>>>
>>>> Yes, you're right, it also was briefly stated in the patch description
>>>> (see Cons). I hope, links + drain in the middle is an uncommon case.
>>>> But it can be added back, but may become a little bit uglier.
>>>>
>>>> What do you think, should we care about this case?
>>>
>>> Yes, this is a very tiny scene. When I first time wrote this part of the
>>> code, my suggestion was to ban it directly.
>>>
>>> For this patch, I am fine, Jens, what do you think.
>>
>> I am fine with it as well, it'd be nice to get rid of needing that
>> extra request.
>>
>> Was that a reviewed-by from you? It'd be nice to get these more
>> formally so I can add the attributes. I'll drop the other patch.
> 
> I want to do more tests. There is no test machine at this time, at least
> until tomorrow morning.

OK, no worries, for the record I did run it through testing this morning
and it passes for me. Before this (or my) patch, we'd stall pretty
quickly in the link_drain tested if run repeatedly.

>>> The mailing list always rejects my mail, is my smtp server IP banned?
>>
>> Probably because you have text/html in your email, the list is pretty
>> picky when it comes to anything that isn't just text/plain.
> 
> I don't know, I use thunderbird to write emails, and it has been set to
> plain text, perhaps because of the signature, I have to check my mail
> client.

Feel free to try and send an email to me personally, then I can see what
it looks like.

-- 
Jens Axboe

