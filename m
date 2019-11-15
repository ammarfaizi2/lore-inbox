Return-Path: <SRS0=yjkE=ZH=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AABC2C432C3
	for <io-uring@archiver.kernel.org>; Fri, 15 Nov 2019 16:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78B3B2077B
	for <io-uring@archiver.kernel.org>; Fri, 15 Nov 2019 16:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ejI9PeWn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbfKOQgJ (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 15 Nov 2019 11:36:09 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37662 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727531AbfKOQgI (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Fri, 15 Nov 2019 11:36:08 -0500
Received: by mail-wr1-f65.google.com with SMTP id t1so11670972wrv.4
        for <io-uring@vger.kernel.org>; Fri, 15 Nov 2019 08:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=6mzduWxyG+hJf+e3KUo+jGMAipWF2xkVlOKcRNsVZ/8=;
        b=ejI9PeWn/rP3jIN8jDGHLA8GJatQPUL7KN4CKConLmI+TKnQzmFgPa8r7jzzWfzx4T
         LgNO64IuPnOUOKhh2zaLkOVi5dRRUMQzsTyPXM1CC7Juw6na2k2KEswGhwJRsQJndoG0
         BIvntEQYJ0a47rb0lhvh64iyyYEZYfAXbmGW7tsnqF0bgRwcI5aXTBDCgIJNP44A9LHK
         /0oAiTPYXg6kppmtbUV6tOeoHXO1J9tORyRmnBzH+WNDtafrAwwFqy08BxVhIwuhGSs5
         +lwJuYsIIOoj6Mu7XqAKLAoe3Zquq0v8zovPuGvH3SvO3f3eWG9Zt7pIZyR6MVKYMxnu
         DDyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=6mzduWxyG+hJf+e3KUo+jGMAipWF2xkVlOKcRNsVZ/8=;
        b=g+HzeG1AWq/JNuW/qqsYOFfMxMN5+Np3UyF9IuPE2YAyH5jlUnkxzK3ybXNUH61ssK
         HmcRQ5oCw1nwg0tkfF6TvCS/yKWOapA73t+w5nufFFClXsSSN0jf5FrtTaCdMizKIypp
         8VFw8mlnqjrJ8YuLsV6h7bPnfI0GNwfOB8oztY+83xqIMt+bzeUol8xMXbM1dD+AE0pp
         zLG6Go2/OXjO1/tsYBJv7CWdy97uaTxhea2P00+urBXC03BDSY1RQEXFEYttIkl9fTG8
         DwK9OFlfdAmQem8Eo7imGMJi4zAVhOAoUiIRbTeBdCcjMxEzdNF7jfWKwO33yyS7mdLa
         19kA==
X-Gm-Message-State: APjAAAU8Q0+2YredbFQsu2o5o20cmyGJlMwGl+BAeAZfLACvaPFHMWsx
        ZApi2p+pKP4KomwhALiarvDF+9wC
X-Google-Smtp-Source: APXvYqybCi3bG5O8tz21HTJT5E9QXHEgiyySHaV7P21GUf6++olD7XK2RJHsb/7ApuStI31aGvlpDg==
X-Received: by 2002:adf:df09:: with SMTP id y9mr16878493wrl.25.1573835765761;
        Fri, 15 Nov 2019 08:36:05 -0800 (PST)
Received: from [192.168.43.69] ([109.126.151.234])
        by smtp.gmail.com with ESMTPSA id x205sm11972525wmb.5.2019.11.15.08.36.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2019 08:36:04 -0800 (PST)
Subject: Re: [PATCH] io_uring: fix duplicated increase of cached_cq_overflow
To:     Bob Liu <bob.liu@oracle.com>, axboe@kernel.dk
Cc:     io-uring@vger.kernel.org
References: <20191115093733.18396-1-bob.liu@oracle.com>
 <9ba5abd2-94c2-585a-b55c-d97dc5f429a6@gmail.com>
 <7ed5d143-c9ba-7d0a-03fe-57af65e88a54@oracle.com>
 <c88f9b89-4749-fd3b-0ac8-e6824077ec26@gmail.com>
 <e09c3cb3-1368-1e77-6207-78487b31ffe1@oracle.com>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Message-ID: <e7fe841d-6103-b6e8-a37b-9a368ad801c5@gmail.com>
Date:   Fri, 15 Nov 2019 19:35:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <e09c3cb3-1368-1e77-6207-78487b31ffe1@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="eOObdFf5oH1V963wD2KNBO1fhyJWU2aUT"
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eOObdFf5oH1V963wD2KNBO1fhyJWU2aUT
Content-Type: multipart/mixed; boundary="x8r3cQpHCDBGRNncBpNShLexWGHCnLyy3";
 protected-headers="v1"
From: Pavel Begunkov <asml.silence@gmail.com>
To: Bob Liu <bob.liu@oracle.com>, axboe@kernel.dk
Cc: io-uring@vger.kernel.org
Message-ID: <e7fe841d-6103-b6e8-a37b-9a368ad801c5@gmail.com>
Subject: Re: [PATCH] io_uring: fix duplicated increase of cached_cq_overflow
References: <20191115093733.18396-1-bob.liu@oracle.com>
 <9ba5abd2-94c2-585a-b55c-d97dc5f429a6@gmail.com>
 <7ed5d143-c9ba-7d0a-03fe-57af65e88a54@oracle.com>
 <c88f9b89-4749-fd3b-0ac8-e6824077ec26@gmail.com>
 <e09c3cb3-1368-1e77-6207-78487b31ffe1@oracle.com>
In-Reply-To: <e09c3cb3-1368-1e77-6207-78487b31ffe1@oracle.com>

--x8r3cQpHCDBGRNncBpNShLexWGHCnLyy3
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 15/11/2019 16:10, Bob Liu wrote:
>>> io_cqring_overflow_flush(force=3Dtrue) must have been called when thi=
s branch is executed,
>>> since io_cqring_overflow_flush() is the only place can set 'ctx->cq_o=
verflow_flushed' to true.
>>>
>> Yes, it should have been called, but it sets this flag for the future
>> users of io_cqring_fill_event(), so any _new_ requests in
>> io_cqring_fill_event() will overflow instead of being added to
>> @overflow_list.
>>
>=20
> Oh, I see..Thanks for the kindly explanation.
>=20
Sure, no problem

--=20
Pavel Begunkov


--x8r3cQpHCDBGRNncBpNShLexWGHCnLyy3--

--eOObdFf5oH1V963wD2KNBO1fhyJWU2aUT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+6JuPTjTbx479o3OWt5b1Glr+6UFAl3O0+YACgkQWt5b1Glr
+6Ui0RAAguaCP/5zfFLXdGxAc5gypWmOQIyEZwQTrzCkkZw2EW9T+tXkuYYe8KaJ
kaXta4o1Cz4c9F+R32esxjema+moJmrvFP7GOLvC54qOCPC75ODHTW9aoroHFimN
RS9VEGH0cMqVWSvAKSMqcf0FRswoKtisd0FGQhXUcWwlzcMkf4aaVlUHJIbDLT/U
vrCAPB1EvjOdubzKkhlVhVHu1CkE/82/mIRqwBDaOv6HUvBsTUgTXtvlmcN1MDZ7
9q2yQAMQe/l2tXlYQCJ+oQk5rda3cjPnYe63FyJ2Wo93+mQVo6kSYPrrJnCiKe5v
PJ0nJW+6+Hy33/dyn9VC+HrGm2jslQYXw9mKs6BlFvBY6B1lT/Qc4ummHiM5kHQr
ndOH4VyYz56WrtAPRudSjug1dW/RB/sdofFeg6Ehj/3nNboJL0a2kJ2rDvZqGe69
Os9lMXHKlOGorwdTGELQMKC3YYHFNxE+rR0QSF2++GYHB5/QfB8C10aL8m5H8rA8
UFJagdCfNLldSMWkGXZDK5sn7dOIROTcV7Jma6XRsWrP5xTCuq2aUD8RD0DY4BMM
Dt4aWkucpao59DO4Bs/oq320CQivvTppwPNCCO8Kc0fCGhQijojIF0GuVZu8plXf
A7WkCbHWEGXlYOKTLzJbbgADhs9tbdkJr6lZWuI1Z1LSs0QtWJo=
=KDpt
-----END PGP SIGNATURE-----

--eOObdFf5oH1V963wD2KNBO1fhyJWU2aUT--
