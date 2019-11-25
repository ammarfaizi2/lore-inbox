Return-Path: <SRS0=pC3Y=ZR=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4BB9C432C0
	for <io-uring@archiver.kernel.org>; Mon, 25 Nov 2019 10:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A9902071E
	for <io-uring@archiver.kernel.org>; Mon, 25 Nov 2019 10:12:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AlaiD99w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbfKYKMT (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Mon, 25 Nov 2019 05:12:19 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36362 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727360AbfKYKMT (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Mon, 25 Nov 2019 05:12:19 -0500
Received: by mail-lf1-f67.google.com with SMTP id f16so10552257lfm.3
        for <io-uring@vger.kernel.org>; Mon, 25 Nov 2019 02:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VQDbZOvOfIFt7I4wbUc86fotgAlSxRfJ4exG2xL6KL0=;
        b=AlaiD99w3fJs8QbSqPlDb5ppjhVCZumJe9744P429JZSj1OR4AuV355My+tQaXGZKJ
         CEZ8GT8uR6lwkf6WQtzlss3kjhHdrP625jlWfI297yrfqWiVS3xGdF+BWnzxReadQdwe
         J7aNXHJigtoQ3uS6QxBHCnhOVYThdYI2Hdy5PtXNdgwnOjk4BHS82KBxWb2+8gPZQvXF
         u7awY3g61c5dymTcx8wWe0Vznz0FMQVlUPbCCK8hcn4Qd00ZEHo95RHIg8XiiPT7KZV/
         UMGS/1iNFIvqYdpe0oj9jgaOOdN7vy6poat29nekzXxcWgvhwV964OwKc63YichurEt7
         k/Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VQDbZOvOfIFt7I4wbUc86fotgAlSxRfJ4exG2xL6KL0=;
        b=SMFqJUMbB7XnsI0Xvy2cP6j20Wi+R+UvG9nqzznAIVHp2w90S+hsb1cp692pZXOXBZ
         bo7fLHC9olekFK8o/66M+Rv/NDl46Inm97W21Q7GNH2YvUcaZHUJXTSF21vT6nGtW+BC
         ytu8Y62KAuJmImDoz8+4iOgoOuzXqrRT03PLZrXaNheqfJ9BjBL58wj8VMaCFZ6Yb07A
         PCx+HOa1hHrweXL8i6D6MjMEe88GunMvurtanSmmmvEpWHsTrcDn8tPKECi+Ks4geemr
         qpMWP4C4UexlvpRqTtF217na+8sWWanDR9IxKvWC3aH1KfUbcoaZNiwyizG7M12AEGyd
         oTyg==
X-Gm-Message-State: APjAAAWhe99hxGpRGrVFHdnMU6cZJzNW9xisAz0SMTnaPG0nm0IAJdE5
        4cGhb4osh1jwTwNuVeZ9hqFmOp54UTA=
X-Google-Smtp-Source: APXvYqxVsZRULaUOv5Ol0cwMrFbCTGXGkM9iLf998U6v1cnXnzIkFakkI1lkOLu1Jb7rU4WzlO5g6A==
X-Received: by 2002:ac2:5b0f:: with SMTP id v15mr9315941lfn.99.1574676736723;
        Mon, 25 Nov 2019 02:12:16 -0800 (PST)
Received: from [172.31.190.83] ([86.57.146.226])
        by smtp.gmail.com with ESMTPSA id d26sm4191508ljo.54.2019.11.25.02.12.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Nov 2019 02:12:16 -0800 (PST)
Subject: Re: [PATCH v2] io_uring: fix dead-hung for non-iter fixed rw
To:     Jackie Liu <jackieliu@byteisland.com>, Jens Axboe <axboe@kernel.dk>
Cc:     io-uring@vger.kernel.org
References: <cover.1574585281.git.asml.silence@gmail.com>
 <620023b272fef0fd76d0f91ff1876fa64864caa6.1574585281.git.asml.silence@gmail.com>
 <6a2fcf67-1267-a02a-98ce-435bbb2ca9bb@kernel.dk>
 <c44dd55c-79b9-78c0-06ad-45f7d47fdd5f@gmail.com>
 <BEEAB31A-9949-4375-93EF-0D55D8100045@byteisland.com>
 <838a574f-e118-cda2-5412-c21af85c512b@kernel.dk>
 <107FEF05-A0E6-4E81-BD0A-BB360CD7F628@byteisland.com>
From:   Pavel Begunkov <asml.silence@gmail.com>
Message-ID: <a294eff8-f19c-aeac-b587-333330b2e118@gmail.com>
Date:   Mon, 25 Nov 2019 13:12:14 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <107FEF05-A0E6-4E81-BD0A-BB360CD7F628@byteisland.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

>>> I have some aarch64 platform, What test do you want me to do?
>>
>> A basic one to try would be:
>>
>> axboe@x1:/home/axboe/git/liburing $ test/stdout 
>> This is a pipe test
>> This is a fixed pipe test
>>
>> But in general I'd just run make runtests in the liburing directory
>> and go through all of them.
>>
> 
> For test/stdout is PASS. Tested-by: Jackie Liu <liuyun01@kylinos.cn>
>
Great, thanks!

-- 
Pavel Begunkov
