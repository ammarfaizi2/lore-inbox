Return-Path: <SRS0=BBHt=ZN=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D30DC432C0
	for <io-uring@archiver.kernel.org>; Thu, 21 Nov 2019 09:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4A4F20715
	for <io-uring@archiver.kernel.org>; Thu, 21 Nov 2019 09:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IAGBFmHl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbfKUJni (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 21 Nov 2019 04:43:38 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34082 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfKUJni (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 21 Nov 2019 04:43:38 -0500
Received: by mail-lj1-f194.google.com with SMTP id 139so2488216ljf.1
        for <io-uring@vger.kernel.org>; Thu, 21 Nov 2019 01:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=d8C4COCHdUfMkNNF+UZ2Z23FrvAAYrm9caqn0nPdEQk=;
        b=IAGBFmHll0XtotOsUypWYwuBpSCDs3XOw/ZzlMFiUSyX06GNRCNpfOt2wv3xnk7f8m
         lTo9KdZL1j2gWhezR4t6BcppEgrBQ9yyG8o29jcJPz3T2uZJUrKItUXFzLXsDBgxH9My
         6cNGNPhtCZf4IuEMvFRdDBhWVLlO44ncRXWcUYt5FS9EDfwL0E59IzynPdOzQMhFTimE
         BeiTyrpoT3jqtJ0RY96KxcsEtv6AgxOhuUlhuGv81UJsI6iZL6R5NBRZITKADA8L4vvy
         8Apj5oqepubDRAwAhQ4bxfhOmk1GfWT6SOSMbXCy+oEZiTTiKJEluYESdnxabuy3JaIt
         D3HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d8C4COCHdUfMkNNF+UZ2Z23FrvAAYrm9caqn0nPdEQk=;
        b=LXW+Jlt3WFBhVR5dqsC1sxiOYMKAhJxoiYryXnrNyczFhDml0yg9SfhbK1+8PfcUHJ
         IZFoCxXJwss9ShLCrYc9/6JLBSLhS9heT334oTUuetzXDJcgfMVeLcheXBOnIOtxIbq6
         T323GkOY+ZfQ8tjixSVH7RQp0bwwGg08rP/K63zwZgwdgBjMAJ0hEaw3h9ZEFPLviChl
         R78ROA6+tkya1f5vNXfYw6hBNDuyzEGo6pMySLatbBuD2nMCiWDqQU5nZbI3NophGeJU
         6D73mDTK0yAAli+fQ0JJTTKTvzRIAOsx6qKoKYrwO1L3+aIwo8jKrl+EbP4mIIlm8TlM
         T5Pw==
X-Gm-Message-State: APjAAAW/CfirXDf33BiWExaI192ldKaDdEc7z2pZKaKI7swstz4C0USy
        8yHDQpALGzxUThKqXCZbAOmNy6Y//sc=
X-Google-Smtp-Source: APXvYqzjO5WiFfXuRvVUDjjEfR2Ip/2Q8S70KSDyH7UYsluuR0e9U8DIB+0QLICAlHCfz65oFqPH1w==
X-Received: by 2002:a2e:98c6:: with SMTP id s6mr5952895ljj.235.1574329416093;
        Thu, 21 Nov 2019 01:43:36 -0800 (PST)
Received: from [172.31.190.83] ([86.57.146.226])
        by smtp.gmail.com with ESMTPSA id d28sm1035533lfn.33.2019.11.21.01.43.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2019 01:43:35 -0800 (PST)
Subject: Re: [PATCH] io_uring: drain next sqe instead of shadowing
To:     Jackie Liu <liuyun01@kylinos.cn>
Cc:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
References: <2005c339-5ed3-6c2e-f011-5bc89dac3f5c@kernel.dk>
 <5e8a8176e29a61ec79004521bc2ef28e4d9715b1.1574325863.git.asml.silence@gmail.com>
 <A12FD0FF-3C4F-46BE-8ABB-AA732002A9CA@kylinos.cn>
From:   Pavel Begunkov <asml.silence@gmail.com>
Message-ID: <bb367887-ed2c-1da3-59f5-c66f12ab7c5c@gmail.com>
Date:   Thu, 21 Nov 2019 12:43:34 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <A12FD0FF-3C4F-46BE-8ABB-AA732002A9CA@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/21/2019 12:26 PM, Jackie Liu wrote:
> 2019年11月21日 16:54，Pavel Begunkov <asml.silence@gmail.com> 写道：
>>
>> If there is a DRAIN in the middle of a link, it uses shadow req. Defer
>> the next request/link instead. This:
>>
>> Pros:
>> 1. removes semi-duplicated code
>> 2. doesn't allocate memory for shadows
>> 3. works better if only the head marked for drain
> 
> I thought about this before, just only drain the head, but if the latter IO depends
> on the link-list, then latter IO will run in front of the link-list. If we think it
> is acceptable, then I think it is ok for me.

If I got your point right, latter requests won't run ahead of the
link-list. There shouldn't be change of behaviour.

The purpose of shadow requests is to mark some request right ahead of
the link for draining. This patch uses not a specially added shadow
request, but the following regular one. And, as drained IO shouldn't be
issued until every request behind completed, this should give the same
effect.

Am I missed something?

Just to notice, @drain_next is in @ctx, so it's preserved across
multiple io_enter_uring().
> --
> BR, Jackie Liu
> 

-- 
Pavel Begunkov
