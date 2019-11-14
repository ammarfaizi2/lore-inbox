Return-Path: <SRS0=FaGP=ZG=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DED3C432C3
	for <io-uring@archiver.kernel.org>; Thu, 14 Nov 2019 21:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E41A20715
	for <io-uring@archiver.kernel.org>; Thu, 14 Nov 2019 21:31:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qJYqdt5m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfKNVbv (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 14 Nov 2019 16:31:51 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51429 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbfKNVbu (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 14 Nov 2019 16:31:50 -0500
Received: by mail-wm1-f65.google.com with SMTP id q70so7429746wme.1
        for <io-uring@vger.kernel.org>; Thu, 14 Nov 2019 13:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=POzG/Y7bEoPQPnF5f2syx0cQnEWzUQQO9uVjIwMkfQ0=;
        b=qJYqdt5mceSJzj0nM4KekKmWUHmg0+Hmidj4TYKQTTr0rKn8CzQFeh5zLKENkmZI5f
         HulKr3i2CoHvfS6KB3DDFalN/p8+C45akhHby3zRagGCPY0FWVmSG55MxwkP6u21rx07
         aO1kUpVgyYkbX4xMEgvaIE8T4q75Zq7I7Yl7zwoLGZl8yv5UK0Mx50WH+PGMe9YbJnXt
         FX4sw7kvv57lrnX/4YgpEH92Ga8zGzsubtf9QpIcqWSog6B3dr6+WEdq6X/t/TIJO83o
         63ZUPfc6/rBJyE0TklMWJjPWsONNePr66his+QRpwZijTJglkDf9/Ap6v1A4eU5jBYhB
         qTFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to;
        bh=POzG/Y7bEoPQPnF5f2syx0cQnEWzUQQO9uVjIwMkfQ0=;
        b=n3x7x51wBpz+70k4b9XwynQSWfUsvG5zwdwaZsgD7jV3zv9fO9u+hCAlsBOIN6e2m3
         P2LHC5fsTJTOM0YBa+nYMhFTcJtzGxoT5aW+ILd5Zi+8qheEBAHn80G9c2luqwZnU3py
         MnUwKN7fatGLA4UiipHCZ8Chb87jGGVjDgviMM1I3cBvCCpS6tq9SrcMSVPQ7vUjHRuh
         BIJSqDV/pQbk8z7XPjDdo2H7JQlZQnzoTiOIpC+xvRfg0NQqEJkc5b8NFnFlGaNpE2+D
         XMXMYEnT44yQLnmWXxFTMjz0jv235PzmA9kxnK/GA2gLguSMJ7928tWVwNUIIFvKwafw
         UMMw==
X-Gm-Message-State: APjAAAWVlc83MbQrNFxSWfHz2liYhDXSXiKkHvD1d3xUQ4UW3HxV9B6R
        4RoWe9Sx9lKlAICYFr6lskBm8IxO
X-Google-Smtp-Source: APXvYqwKCrAHmpLWxu21gzor29sDcEKjtxZf+wnVDliUqDNCIuGgszkAcPC+kbmMNzE+FeF8UNwtnw==
X-Received: by 2002:a7b:c748:: with SMTP id w8mr11164683wmk.114.1573767107757;
        Thu, 14 Nov 2019 13:31:47 -0800 (PST)
Received: from [192.168.43.69] ([109.126.151.234])
        by smtp.gmail.com with ESMTPSA id w10sm7206721wmd.26.2019.11.14.13.31.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2019 13:31:46 -0800 (PST)
Subject: Re: [PATCH] io_uring: Fix LINK_TIMEOUT checks
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
References: <9a5eef46f7ed9f52f8de67d314651cd4a4234572.1573766402.git.asml.silence@gmail.com>
 <ef655254-b8ce-8ee3-a776-d44803557ad9@kernel.dk>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Message-ID: <6b558629-d64d-f356-aea0-4a928220e3b3@gmail.com>
Date:   Fri, 15 Nov 2019 00:31:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <ef655254-b8ce-8ee3-a776-d44803557ad9@kernel.dk>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="IkQX9DrMcP0T0J2keHIq1ot2c3enIPIdm"
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IkQX9DrMcP0T0J2keHIq1ot2c3enIPIdm
Content-Type: multipart/mixed; boundary="PmOqThP5nK671e5aEn9RRl6SlqTnbTqqi";
 protected-headers="v1"
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Message-ID: <6b558629-d64d-f356-aea0-4a928220e3b3@gmail.com>
Subject: Re: [PATCH] io_uring: Fix LINK_TIMEOUT checks
References: <9a5eef46f7ed9f52f8de67d314651cd4a4234572.1573766402.git.asml.silence@gmail.com>
 <ef655254-b8ce-8ee3-a776-d44803557ad9@kernel.dk>
In-Reply-To: <ef655254-b8ce-8ee3-a776-d44803557ad9@kernel.dk>

--PmOqThP5nK671e5aEn9RRl6SlqTnbTqqi
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 15/11/2019 00:25, Jens Axboe wrote:
> On 11/14/19 2:20 PM, Pavel Begunkov wrote:
>> If IORING_OP_LINK_TIMEOUT request is a head of a link or an individual=

>> request, pass it further through the submission path, where it will
>> eventually fail in __io_submit_sqe(). So respecting links and drains.
>>
>> The case, which is really need to be checked, is if a
>> IORING_OP_LINK_TIMEOUT request is 3rd or later in a link, that is
>> invalid from the user API perspective (judging by the code). Moreover,=

>> put/free and friends will try to io_link_cancel_timeout() such request=
,
>> even though it wasn't initialised.
>=20
> Care to add a test case for these to liburings test/link-timeout.c?
>=20
I'll add it a bit later

--=20
Pavel Begunkov


--PmOqThP5nK671e5aEn9RRl6SlqTnbTqqi--

--IkQX9DrMcP0T0J2keHIq1ot2c3enIPIdm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+6JuPTjTbx479o3OWt5b1Glr+6UFAl3Nx6wACgkQWt5b1Glr
+6VsTBAAoZjqJEQgGXVjZ/wbWgmL/KnaZszN1bQt9MD2giFbRHy9KB58/tq80pQr
5/irpO/oH5s1mv2CUQi7zh06ow3uFOPz9vUpgI1nMdzYcoriShjJL63HE+OcyBDH
JAx8WI4fQ5knkpUnS86vuIDNkrziWxYP3MjfE1ayW4TqezP3RopNXLm9UY7rgfv1
nUYX8ROfAvXnyHA9CH+l0dwQhMkJmFr3nqpEhg2a/MH8BvawsY0at4f2ZFHEyQe2
LTTqyMe/BxhrtelGJ2+97ywqpK2kRbeUqdjfDcoRhJtZ2meElV4RAopxEdRsITEr
4g5h6qW9A6Sl41x/tUWElBy3hkZihc38OPNk+5OGrzBXvAmA92URuVSqDM67vkbs
XsJSbouu/zSMs3Tv+bpWppX05Enjnk4b5iaKduqx1M5dpyrof7TC4+aw+a0xutTF
jgQq2U7Sfwbhd6mAoBB6Rf588hR5oWggCvrddrjca0ZQWYBJDdSJsLWj5zDCspoP
jEXh7CBbo+JofMKIdCa6FqdSx0aLqpZzfjP9KyDYLtb1+R58r0m6sA11kj+Vh9HV
F0E8xcLFyPLqkoVxMh3bHuGFTIW59Yqz3bc/HtDkswyfMLj4vOpqDh5+2+rvvca5
HbS7BmtQOjtEIMg40bAiQkEMTweH0Wj5AMp+5bJ1783gKx1V2ZA=
=LnFn
-----END PGP SIGNATURE-----

--IkQX9DrMcP0T0J2keHIq1ot2c3enIPIdm--
