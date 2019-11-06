Return-Path: <SRS0=PUae=Y6=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C91C43331
	for <io-uring@archiver.kernel.org>; Wed,  6 Nov 2019 22:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 379AB217D7
	for <io-uring@archiver.kernel.org>; Wed,  6 Nov 2019 22:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YCb3k9Bs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbfKFWrd (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 6 Nov 2019 17:47:33 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38881 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbfKFWrc (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 6 Nov 2019 17:47:32 -0500
Received: by mail-wr1-f65.google.com with SMTP id j15so576717wrw.5;
        Wed, 06 Nov 2019 14:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=HRoZbWXF/itXHz7vmXt3vb3C5iZ9BDV084Le6Y07qwQ=;
        b=YCb3k9BsDDCkP4+p5IOG7qE8m0ygk2qMO722ciJiwTiTtTaRmMENFA/nyzlRACYNjF
         /8OjIV2uW68T3TOLOrrduiylkP2CYZfJ2kWgGu+9kQG1OqVkxzj6zwJzN72dv/kNFTiG
         QKUOSDRBOknnilme5XzMMIbulCQDT3BFxsTpcl4J+Si56YjeOce2of2/igkemlCVlCHF
         uyJcPXGtwZkYCCLtZKBMNISADFoWxKV8j9qtCvBSr+2ktm8Pdnfzsq0KGH8ZcMzgMMM+
         oEBRxWBoaFcWrI/WiqZd3ZzqNPfiARo4f66fCk5yTlj/NnMm/KuN93lD9TFUhzzfWZ0f
         IA5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to;
        bh=HRoZbWXF/itXHz7vmXt3vb3C5iZ9BDV084Le6Y07qwQ=;
        b=i/bc2WVJjLWrbxqdbqiTi9q4Eg5YAtLkjxI2cEdut2SEHCb1LMUxjd6debPQexvMMs
         XdhYObfjZ5/DD3IynyTLnrCy1bqpdB5wYXFfMm7hLLyJO8ORxiiVsEIHkGYnZNVagule
         2tXTg6Hn8rel8swqhmhlxkdyqvLoxm6IxEqbKGOb4UXQpHJFIqysTxbW3oA6yZQMAK61
         VItSy/5olvbphRv8cNBd/M16IL81GujjDKXDnR5IcC3c6SM1q7SLwkcv8StlM5Y1hqzs
         FlPip3dkgZf89sjWuhpYTh8RarbNG5zgryLH0MyEz/evNnmwW7elQ5m7dFFfvRPUDPyU
         ttGQ==
X-Gm-Message-State: APjAAAV2a38M/1UzLL6G4HgwaefL5A3pnA301n+RhEdife9yF8lciyC5
        Dm0A2jVrPVEoOrP6ByC4YeNs7s4zm3M=
X-Google-Smtp-Source: APXvYqx4zsE7Mo4aoZtsjjanuLMXunn3LdmdrcM2zsuwTrwDGHge1fvd5BrqiezSgKni0HfRbGiq5Q==
X-Received: by 2002:adf:e944:: with SMTP id m4mr5107588wrn.49.1573080449757;
        Wed, 06 Nov 2019 14:47:29 -0800 (PST)
Received: from [192.168.43.132] ([109.126.141.164])
        by smtp.gmail.com with ESMTPSA id f188sm51585wmf.3.2019.11.06.14.47.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2019 14:47:29 -0800 (PST)
Subject: Re: [PATCH v3 1/3] io_uring: allocate io_kiocb upfront
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org
References: <cover.1573079844.git.asml.silence@gmail.com>
 <b787787e16af14f03df2ee1ac0d57b81b367cb4c.1573079844.git.asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Message-ID: <09d804b1-1bb8-1ecc-91f7-6aa7a766c90e@gmail.com>
Date:   Thu, 7 Nov 2019 01:47:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <b787787e16af14f03df2ee1ac0d57b81b367cb4c.1573079844.git.asml.silence@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="jDa9Hp0Mskxe0GllsGrCbcPfR0TG9o6OO"
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jDa9Hp0Mskxe0GllsGrCbcPfR0TG9o6OO
Content-Type: multipart/mixed; boundary="yUdv798Pvaf62AwmVxVNeNfSMGgNQc7Vn";
 protected-headers="v1"
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
 linux-block@vger.kernel.org
Message-ID: <09d804b1-1bb8-1ecc-91f7-6aa7a766c90e@gmail.com>
Subject: Re: [PATCH v3 1/3] io_uring: allocate io_kiocb upfront
References: <cover.1573079844.git.asml.silence@gmail.com>
 <b787787e16af14f03df2ee1ac0d57b81b367cb4c.1573079844.git.asml.silence@gmail.com>
In-Reply-To: <b787787e16af14f03df2ee1ac0d57b81b367cb4c.1573079844.git.asml.silence@gmail.com>

--yUdv798Pvaf62AwmVxVNeNfSMGgNQc7Vn
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 07/11/2019 01:41, Pavel Begunkov wrote:
> Let io_submit_sqes() to allocate io_kiocb before fetching an sqe.
>=20
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> ---
>  fs/io_uring.c | 27 ++++++++++++++-------------
>  1 file changed, 14 insertions(+), 13 deletions(-)
>=20
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index 6524898831e0..ceb616dbe710 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -2551,30 +2551,23 @@ static int io_queue_link_head(struct io_ring_ct=
x *ctx, struct io_kiocb *req,
> =20
>  #define SQE_VALID_FLAGS	(IOSQE_FIXED_FILE|IOSQE_IO_DRAIN|IOSQE_IO_LINK=
)
> =20
> -static void io_submit_sqe(struct io_ring_ctx *ctx, struct sqe_submit *=
s,
> -			  struct io_submit_state *state, struct io_kiocb **link)
> +static void io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *re=
q,
> +			  struct sqe_submit *s, struct io_submit_state *state,
> +			  struct io_kiocb **link)
>  {
>  	struct io_uring_sqe *sqe_copy;
> -	struct io_kiocb *req;
>  	int ret;
> =20
>  	/* enforce forwards compatibility on users */
>  	if (unlikely(s->sqe->flags & ~SQE_VALID_FLAGS)) {
>  		ret =3D -EINVAL;
> -		goto err;
> -	}
> -
> -	req =3D io_get_req(ctx, state);
> -	if (unlikely(!req)) {
> -		ret =3D -EAGAIN;
> -		goto err;
> +		goto err_req;
>  	}
> =20
>  	ret =3D io_req_set_file(ctx, s, state, req);
>  	if (unlikely(ret)) {
>  err_req:
>  		io_free_req(req, NULL);
> -err:
>  		io_cqring_add_event(ctx, s->sqe->user_data, ret);
>  		return;
>  	}
> @@ -2710,9 +2703,15 @@ static int io_submit_sqes(struct io_ring_ctx *ct=
x, unsigned int nr,
> =20
>  	for (i =3D 0; i < nr; i++) {
>  		struct sqe_submit s;
> +		struct io_kiocb *req;
> =20
> -		if (!io_get_sqring(ctx, &s))
> +		req =3D io_get_req(ctx, statep);
> +		if (unlikely(!req))
>  			break;
> +		if (!io_get_sqring(ctx, &s)) {
> +			__io_free_req(req);
> +			break;
> +		}
> =20
>  		if (io_sqe_needs_user(s.sqe) && !*mm) {
>  			mm_fault =3D mm_fault || !mmget_not_zero(ctx->sqo_mm);
> @@ -2740,7 +2739,7 @@ static int io_submit_sqes(struct io_ring_ctx *ctx=
, unsigned int nr,
>  		s.in_async =3D async;
>  		s.needs_fixed_file =3D async;
>  		trace_io_uring_submit_sqe(ctx, s.sqe->user_data, true, async);
> -		io_submit_sqe(ctx, &s, statep, &link);
> +		io_submit_sqe(ctx, req, &s, statep, &link);
>  		submitted++;
> =20
>  		/*
> @@ -4009,6 +4008,8 @@ SYSCALL_DEFINE6(io_uring_enter, unsigned int, fd,=
 u32, to_submit,
>  		cur_mm =3D ctx->sqo_mm;
>  		submitted =3D io_submit_sqes(ctx, to_submit, f.file, fd,
>  					   &cur_mm, false);
> +		if (!submitted)
> +			submitted =3D -EAGAIN;

Need to say, that left io_submit_sqes() errors of more priority than ones=
 of
poll/wait.


>  		mutex_unlock(&ctx->uring_lock);
>  	}
>  	if (flags & IORING_ENTER_GETEVENTS) {
>=20

--=20
Pavel Begunkov


--yUdv798Pvaf62AwmVxVNeNfSMGgNQc7Vn--

--jDa9Hp0Mskxe0GllsGrCbcPfR0TG9o6OO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+6JuPTjTbx479o3OWt5b1Glr+6UFAl3DTXYACgkQWt5b1Glr
+6W1GRAAmIRp/2vh3fNuC8P7O/8+sC/94oCFPQcxI9E9e3zbzJd6Oha4crCLABPX
RXYLOeP8poMzIzqaJDAhrqI+6dq2YkJvysTkZyZnCXHN+cWHcCchVfyyyfgE2Eoq
WjvLeudhA0wuAgnMr1pnDCPD7yHV8jfi/3OsZ9df9+AM4m5jCYMnD14Zt04pqpIS
8ej+0ls4SYCsrfxMuPqnopJKrmszxVHgJM5ws3SnK3JLB5kGKZJaa+kuwsPD8dKk
ORyCBrSiNK9k6bUGklbWwcyVWAag9gyCcWr6ym/okspjV5xhIQBXa+akskERpCrq
/HJbTdRUgm4DmnuMALwAnHlNn89rK1ybcFxlRM4R7qw0+5GZ5XY3PYQVj9UqTCEx
c6yQZGNMWnVazZ8h5ljuvzXCTomzo4tODfx9Ha94XYGGjSipk2qlPB1Q1CdgwbNk
eK48plA1UOsYUdU9qud8P+UGLPosPgKr1Lge7mwxGHsYKumY25H6gtlRranupGz/
FKpTA6/iamlq+ywZE5UNvX3ANCP275KCucaGJfW94nmagc/uWiagQ04l00Zgje5w
x+yo0u/C7FNTALVr2wXnAHVvUz/mALQF+c4orhM00EHMULIED0nsRbK7CuvFaAXA
6ig/7GCdH4QMvJB8MIbJS9VM9leI3EYkVcOEPZ55EyOFvuC4V18=
=5UmZ
-----END PGP SIGNATURE-----

--jDa9Hp0Mskxe0GllsGrCbcPfR0TG9o6OO--
