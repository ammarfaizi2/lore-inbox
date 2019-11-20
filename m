Return-Path: <SRS0=jdTg=ZM=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0333EC432C3
	for <io-uring@archiver.kernel.org>; Wed, 20 Nov 2019 03:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBA2E22419
	for <io-uring@archiver.kernel.org>; Wed, 20 Nov 2019 03:36:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="J5StNGNa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbfKTDgT (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 19 Nov 2019 22:36:19 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41346 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbfKTDgT (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 19 Nov 2019 22:36:19 -0500
Received: by mail-pf1-f195.google.com with SMTP id p26so13482367pfq.8
        for <io-uring@vger.kernel.org>; Tue, 19 Nov 2019 19:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iO2m5sJniUGg9u/om7AwfJk32vjGE7/18nVndHdFnV0=;
        b=J5StNGNa4B0SMTMi+sabngR4rbujDLSBfM9TpR27xx57BKlzi1RIRAZBwq8SiXT7T+
         69/bhOumgOPE4KEIxDyW3W0EuNwLVJq9e/ZH0kaK5lmE0VZ6Arr0BZ6YOEdajXzMVF/s
         45tb02V5pSlgk9Xz+A8X8ncKbd8loMJLY0Cx3f7WxEXTr+OC4887eaebdIQD55SddyhJ
         PTZcascJgsd4b2viQPXxkqqPvAHpw1qvfHSy2I98i4a0yN1b1agyZTkWiE6kxCfuDSp7
         sfQAqVJRWJJNKqdsBRBM178BJhFm94296FuWRj5Hp8dzOf4MJcOmeE44JOmTWILgOVvi
         I2mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iO2m5sJniUGg9u/om7AwfJk32vjGE7/18nVndHdFnV0=;
        b=dK17slqnpVwJstvN9Q4D13+1yJ1x+GUhXmaNe4XvkpXaN46bZCBnqNpvTsfGV5l3Kx
         iRyK58fwzfyqf0eyqgMSGWfS4vsorzy9/pY8U3BvTs3whdxw+pi72EkxOeuHSt1Sc8RA
         FC8jCz3edrYWd0ET1mArmXFnwGW3vnL+1mGv+dvEY+M9dcfvcIZTQ8a1PmysSAdPr2/j
         sknSdFjtobmETqm2vaJWlJH9zshMe3PrWh5a7Q7QwUBSOm8W0k8vDtaJlIPDEDnv8AMC
         FY4S3lpO/01Xc7g2PusgNE/hZcSt16uk7S5lOGY64mgUlzHhJrhkagO8R7MMcLofSfZw
         axPw==
X-Gm-Message-State: APjAAAUnD5cEdC+lNyF9EO2u36aKuoveMuMOTiPo2G2nM662f4n1zU9x
        MKeLmxaCDAHbvSZy/Ufqi5/T1iLE++GSww==
X-Google-Smtp-Source: APXvYqxUjfcMEru6oh3UAykA0xuks7OU7NIhHjLT6iC8jLgCTlsMOIppEZpcL5QIb3PhBq5KyNTT2w==
X-Received: by 2002:aa7:8d8b:: with SMTP id i11mr1247647pfr.45.1574220978195;
        Tue, 19 Nov 2019 19:36:18 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id c64sm27922154pfb.177.2019.11.19.19.36.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Nov 2019 19:36:17 -0800 (PST)
Subject: Re: [PATCH liburing 1/3] mktemp is dangerous, better use mkostemp
To:     Jackie Liu <liuyun01@kylinos.cn>
Cc:     io-uring@vger.kernel.org
References: <20191120031422.49382-1-liuyun01@kylinos.cn>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e0974e62-91ab-28de-3c7e-2319785cac7f@kernel.dk>
Date:   Tue, 19 Nov 2019 20:36:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191120031422.49382-1-liuyun01@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/19/19 8:14 PM, Jackie Liu wrote:
> jackieliu@aarch64:~/liburing$ make -C test
> ...
> /tmp/ccoJ4CQ4.o: In function `main':
> /home/jackieliu/liburing/test/500f9fbadef8-test.c:41: warning: the use of `mktemp' is dangerous, better use `mkstemp' or `mkdtemp'

Applied 1-3, thanks.

-- 
Jens Axboe

