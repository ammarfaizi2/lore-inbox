Return-Path: <SRS0=KKPr=ZF=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74AAAC432C3
	for <io-uring@archiver.kernel.org>; Wed, 13 Nov 2019 21:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6400A206E5
	for <io-uring@archiver.kernel.org>; Wed, 13 Nov 2019 21:48:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aew1/uTs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbfKMVsL (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 13 Nov 2019 16:48:11 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41532 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfKMVsK (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 13 Nov 2019 16:48:10 -0500
Received: by mail-wr1-f65.google.com with SMTP id b18so2652113wrj.8
        for <io-uring@vger.kernel.org>; Wed, 13 Nov 2019 13:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=Gj+SroMmY/ONbAThgQGzSSJfhjZ6BsVZHu3KtS76/SY=;
        b=aew1/uTsPq+odIIGUioysaRwIyHGaor+r7bArLWt9e6BU99YIahY0ujKCfcHTmHKs1
         0WTvm5Gw+/+V+qqb+gbYavHuojLHAqO1C2fW3lTiMvNHpSkgICq1xuAJZoesIdoJAGwG
         YSqgkSjmPEVHN1JdmrMUYnQ4vuPtnDxIv7qPyneP8Seyd0nhBD7rwqMnDbBZe+BL+Uxj
         RPIbXT+j/27tCVmHFpiFa+vfuD8NGWadt018wOhmzU7eU/iCOIqLPW4xlfUUBJIvGLmK
         b4upZBUvKdJ8ZYgMb+JQZNoyGcjUVRH0igVK1Hzew6BV0OP5omNJYp0DDYWHfYQNuWxk
         ljvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to;
        bh=Gj+SroMmY/ONbAThgQGzSSJfhjZ6BsVZHu3KtS76/SY=;
        b=daXSxIo9nE6r8adTtil69sCDPWJ0Bq7QrdnZFP8erPGZAd/Tzi6xrnwsuqr6cl7P6K
         FqXDHVtZpTYgj18pPR4ulFRmHy88mN10rqJqszoOB9/t9hv4ODVn4ALIxPaP7DO8wXKG
         OB9mv4bP1/pd1a3JNUo3diJEoRZ5CnKUdttlOpnXou6PqWubE4RLxi1MJDhgZZDL6Ca8
         D5aVYXhu5OHnEW4jhDeQWQRIK54G13odpPWkv2sYXP0FQ9ETA9GUfX9y9jqAfYqigaIL
         BO6tv//SdtQsCJ5RdkBLkJWVcU7wRLgcxXiIENDmeAd5p1Y2/oCpxrJWdv0IC7K5brke
         pBgQ==
X-Gm-Message-State: APjAAAX7BgliN64P1rUennVmHyzNPVuaFRjaQXTweP1NgtgueH2xVJv/
        UsacQEQVxP64XdN5r7fQ9M9Ogwet
X-Google-Smtp-Source: APXvYqxDjO8k4QyopteRgGp2uJoGCLzy2lly2Kfmwf5u/RjvffQasNYY/NSXgecxkwG05HON3ZuiRQ==
X-Received: by 2002:adf:aa92:: with SMTP id h18mr5218960wrc.150.1573681687050;
        Wed, 13 Nov 2019 13:48:07 -0800 (PST)
Received: from [192.168.43.29] ([109.126.149.223])
        by smtp.gmail.com with ESMTPSA id o187sm3763912wmo.20.2019.11.13.13.48.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2019 13:48:06 -0800 (PST)
Subject: Re: [PATCH] io_uring: Fix getting file for timeout
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
References: <f07037aafc5e272343fbf5f9eeb554d51a4353df.1573679112.git.asml.silence@gmail.com>
 <1bf6b2ce-4af6-1f3a-d576-85258256388e@kernel.dk>
 <44d1d4d3-41e0-684c-8dcb-853f335b8fd4@kernel.dk>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Message-ID: <5b145d14-59e8-041e-9b8a-21ec1d71e082@gmail.com>
Date:   Thu, 14 Nov 2019 00:47:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <44d1d4d3-41e0-684c-8dcb-853f335b8fd4@kernel.dk>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="TdSN34I17iDc2153vwca9yzWH8dqSM79S"
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TdSN34I17iDc2153vwca9yzWH8dqSM79S
Content-Type: multipart/mixed; boundary="MZdQ8Q5hqUFY5IBPO8CfqEn5FOPLCiGDX";
 protected-headers="v1"
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Message-ID: <5b145d14-59e8-041e-9b8a-21ec1d71e082@gmail.com>
Subject: Re: [PATCH] io_uring: Fix getting file for timeout
References: <f07037aafc5e272343fbf5f9eeb554d51a4353df.1573679112.git.asml.silence@gmail.com>
 <1bf6b2ce-4af6-1f3a-d576-85258256388e@kernel.dk>
 <44d1d4d3-41e0-684c-8dcb-853f335b8fd4@kernel.dk>
In-Reply-To: <44d1d4d3-41e0-684c-8dcb-853f335b8fd4@kernel.dk>

--MZdQ8Q5hqUFY5IBPO8CfqEn5FOPLCiGDX
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 14/11/2019 00:37, Jens Axboe wrote:
> On 11/13/19 2:33 PM, Jens Axboe wrote:
>> On 11/13/19 2:11 PM, Pavel Begunkov wrote:
>>> For timeout requests and bunch of others io_uring tries to grab a fil=
e
>>> with specified fd, which is usually stdin/fd=3D0.
>>> Update io_op_needs_file()
>>
>> Good catch, thanks, applied.
>=20
> Care to send one asap for 5.4 as well? It'd just be TIMEOUT for that
> one, but we need it fixed there, too.
>=20
Sure, I'll split this into 2 incremental patches then

--=20
Pavel Begunkov


--MZdQ8Q5hqUFY5IBPO8CfqEn5FOPLCiGDX--

--TdSN34I17iDc2153vwca9yzWH8dqSM79S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+6JuPTjTbx479o3OWt5b1Glr+6UFAl3Mef4ACgkQWt5b1Glr
+6UTiBAArAZjf4+Wams78zWpMzmdicRe5LPiayVGghuhFND9WXZKP+NcFsw2o2o4
dJxo8bqr1SwsapapJZShtFl2O/r86vx6FggGf1bB8dpeIAuFKv7Av/DbtRm4htHR
31mbv8sY1V8CyZMaX6o572RWccx+lvhjdY/EHjObtj0zi5IYK4RsBgcLd/6Vtktz
mPxGE2GBRc4bDBjZeFzfUx2k2zC7Gb1c+Qd6GwkbHyujo6TPNhGc1VEXVLLNwEo8
cQnovPCKJGLZVJah9aDmmCzssY5vCpmdbURReZVKlwyJ/mrg1JQbMxu4GeiP571B
0PJ26iFuMAGtF1nOKeNLEwze/Wv53Mv+/8CYpFMJvXsFiEH+BTDqLKtGxNZKXF2W
qMchrzxGwifyC/hFMsARUZoDiKU6BMB5jqt6k4F2qtioSE//b4wmsDgTqp3I3xCN
PqV/AFH765d+01e9TCSBbNRewsZOxzQZGJojgKDk8X/CScuQIavsc0j5SgxGjCMi
hUPoHCe9qNlzQskhn0LGfMK2IJFin5s7zCcz0+n7/zpC2ArEQDC60qdrz5ylACE0
nuncWsbnbPrOtGd6q/h5OO3hncePJd12nWEZ2CJ7cPdBU0vkSWgf3QK1mju8BPf/
9XqyJ22CXWQj1Jn72gM1TyfuJcqFUw1lOAg7ZHZWtksPC5Jp14Q=
=sPcg
-----END PGP SIGNATURE-----

--TdSN34I17iDc2153vwca9yzWH8dqSM79S--
