Return-Path: <SRS0=Zbil=33=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20046C2BA83
	for <io-uring@archiver.kernel.org>; Fri,  7 Feb 2020 16:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E56FE20720
	for <io-uring@archiver.kernel.org>; Fri,  7 Feb 2020 16:24:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="K+AaRPUc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbgBGQYr (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 7 Feb 2020 11:24:47 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:44489 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbgBGQYr (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Fri, 7 Feb 2020 11:24:47 -0500
Received: by mail-io1-f65.google.com with SMTP id z16so98149iod.11
        for <io-uring@vger.kernel.org>; Fri, 07 Feb 2020 08:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=oaZ9JMBYMQp3FTZFmmJehg30E/joUSZmPBIdJwaWZcE=;
        b=K+AaRPUcBaRxMnqoqSxl8XqiVSSGhp9Hba0qQcp93YqG5WlrzpIKfL66dSU26cBeFL
         1Z+UH0A+EVF1hzJk29oYELetTF86BkjK3MNB10rW+dmSXkNDvZFgqjwJINvvwPr7dlbJ
         mGb4hmnOSE0HpU0TtRzEDYLbxbF+v+0Tik5/OyNngbXAT7LKDblbN2G3qyApDfDm/XlN
         NjfXDVOF6ykIY7nTxm50hoeOpUqUvWJO34UtBfjENaXom4U1af+tizDyiOLrg0dsm/Zp
         iTnHqxFwANLYsovvXPV5pm1EooY8b0gqE3morJd+55GvJtjm+COZi06mGH4oNLiDt1H8
         MKbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oaZ9JMBYMQp3FTZFmmJehg30E/joUSZmPBIdJwaWZcE=;
        b=lS6RC2YSjflVuaxNwPkGivIfUSltTGKGRsktjyXWMeCDvzYeBIa/xKlOQmCODGLVmP
         OW3Ry2z9PRBQcXWY34V4DAmH7Mb9WiE0BInrtAKgLdJoKCQjUC9/TEj3E8mJb3YKA4Bu
         QPHyW3TNpQ/0Jre3Jn7WjIegovNAeGUyHNkM9cDnAi6wXpQ6ZzbbQLHOR9Eerd8hUWS3
         xh5BQp+UHsvArqdB41ojan2lkn2IhnPhiMsBwE754/DYGSMbjW+CtR3SaE5C6kNwUeqZ
         ztmJm1AZ5QNkqQcbfFJFjunR58T4hJ0KAZmDy5WlhNjHSMckRq6aaX8uv2gtuiCbWi5z
         vsOA==
X-Gm-Message-State: APjAAAVsuTvOp2DoCZrO9EG/AJagNb2HLofFkBvVyTgfTauZpSM3yrxN
        YEyq94JB1QCQjDuJaIqBH1rp40N2o1k=
X-Google-Smtp-Source: APXvYqz7vYKMRfLs+Z82pe2GF4PpKOK1ZJNlN1mESgr+Bq1Hj6XEa2c4LC8ihmHneeEYj8yhWHF1wg==
X-Received: by 2002:a6b:9188:: with SMTP id t130mr108805iod.215.1581092685219;
        Fri, 07 Feb 2020 08:24:45 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id d69sm1417976ill.15.2020.02.07.08.24.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Feb 2020 08:24:44 -0800 (PST)
Subject: Re: [PATCH v2] Fix liburing.so symlink source if libdir != libdevdir
To:     Stefan Metzmacher <metze@samba.org>, io-uring@vger.kernel.org
References: <35cb2c1e-5985-13a8-1719-1bfa9aeb65a4@samba.org>
 <20200207144212.4212-1-metze@samba.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e12311f9-9ea1-b405-4663-8789c687eed4@kernel.dk>
Date:   Fri, 7 Feb 2020 09:24:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200207144212.4212-1-metze@samba.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 2/7/20 7:42 AM, Stefan Metzmacher wrote:
> Signed-off-by: Stefan Metzmacher <metze@samba.org>
> ---
>  Makefile         | 6 +++++-
>  configure        | 8 +++++++-
>  debian/changelog | 6 ++++++
>  src/Makefile     | 2 +-
>  4 files changed, 19 insertions(+), 3 deletions(-)

Thanks, applied on top.

-- 
Jens Axboe

