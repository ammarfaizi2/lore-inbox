Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932504AbWEPSfZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932504AbWEPSfZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 14:35:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932507AbWEPSfZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 14:35:25 -0400
Received: from relay00.pair.com ([209.68.5.9]:28173 "HELO relay00.pair.com")
	by vger.kernel.org with SMTP id S932504AbWEPSfY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 14:35:24 -0400
X-pair-Authenticated: 71.197.50.189
Date: Tue, 16 May 2006 13:35:12 -0500 (CDT)
From: Chase Venters <chase.venters@clientec.com>
X-X-Sender: root@turbotaz.ourhouse
To: Martin Peschke <mp3@de.ibm.com>
cc: linux-kernel@vger.kernel.org, akpm@osdl.org, ak@suse.de, hch@infradead.org,
       arjan@infradead.org, James.Smart@Emulex.Com,
       James.Bottomley@SteelEye.com
Subject: Re: [RFC] [Patch 2/8] statistics infrastructure - prerequisite:
 parser enhancement
In-Reply-To: <446A0FBE.2030105@de.ibm.com>
Message-ID: <Pine.LNX.4.64.0605161332270.32181@turbotaz.ourhouse>
References: <446A0FBE.2030105@de.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 May 2006, Martin Peschke wrote:

> This patch adds two match_* derivates for 64 bit operands to the parser
> library.
>
> Signed-off-by: Martin Peschke <mp3@de.ibm.com>
> ---
>
>  include/linux/parser.h |    2 +
>  lib/parser.c           |   60
>  +++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 62 insertions(+)
>
> diff -Nurp a/include/linux/parser.h b/include/linux/parser.h
> --- a/include/linux/parser.h	2006-03-20 06:53:29.000000000 +0100
> +++ b/include/linux/parser.h	2006-05-15 17:56:25.000000000 +0200
> @@ -31,3 +31,5 @@ int match_octal(substring_t *, int *resu
>  int match_hex(substring_t *, int *result);
>  void match_strcpy(char *, substring_t *);
>  char *match_strdup(substring_t *);
> +int match_u64(substring_t *, u64 *result, int);
> +int match_s64(substring_t *, s64 *result, int);
> diff -Nurp a/lib/parser.c b/lib/parser.c
> --- a/lib/parser.c	2006-03-20 06:53:29.000000000 +0100
> +++ b/lib/parser.c	2006-05-15 17:56:25.000000000 +0200
> @@ -140,6 +140,64 @@ static int match_number(substring_t *s,
>  }
>
> /**
> + * match_u64: scan a number in the given base from a substring_t
> + * @s: substring to be scanned
> + * @result: resulting integer on success
> + * @base: base to use when converting string
> + *
> + * Description: Given a &substring_t and a base, attempts to parse the 
> substring
> + * as a number in that base. On success, sets @result to the u64 represented
> + * by the string and returns 0. Returns either -ENOMEM or -EINVAL on 
> failure.
> + */
> +int match_u64(substring_t *s, u64 *result, int base)
> +{
> +	char *endp;
> +	char *buf;
> +	int ret;
> +
> +	buf = kmalloc(s->to - s->from + 1, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +	memcpy(buf, s->from, s->to - s->from);
> +	buf[s->to - s->from] = '\0';

Why not match_strdup:

 	buf = match_strdup(s);
 	if (unlikely(!buf))
 		return -ENOMEM;

> +	*result = simple_strtoull(buf, &endp, base);
> +	ret = 0;
> +	if (endp == buf)
> +		ret = -EINVAL;
> +	kfree(buf);
> +	return ret;
> +}
> +
> +/**
> + * match_s64: scan a number in the given base from a substring_t
> + * @s: substring to be scanned
> + * @result: resulting integer on success
> + * @base: base to use when converting string
> + *
> + * Description: Given a &substring_t and a base, attempts to parse the 
> substring
> + * as a number in that base. On success, sets @result to the s64 represented
> + * by the string and returns 0. Returns either -ENOMEM or -EINVAL on 
> failure.
> + */
> +int match_s64(substring_t *s, s64 *result, int base)
> +{
> +	char *endp;
> +	char *buf;
> +	int ret;
> +
> +	buf = kmalloc(s->to - s->from + 1, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +	memcpy(buf, s->from, s->to - s->from);
> +	buf[s->to - s->from] = '\0';

Same story here.

> +	*result = simple_strtoll(buf, &endp, base);
> +	ret = 0;
> +	if (endp == buf)
> +		ret = -EINVAL;
> +	kfree(buf);
> +	return ret;
> +}
> +
> +/**
>   * match_int: - scan a decimal representation of an integer from a
>   substring_t
>   * @s: substring_t to be scanned
>   * @result: resulting integer on success
> @@ -218,3 +276,5 @@ EXPORT_SYMBOL(match_octal);
>  EXPORT_SYMBOL(match_hex);
>  EXPORT_SYMBOL(match_strcpy);
>  EXPORT_SYMBOL(match_strdup);
> +EXPORT_SYMBOL(match_u64);
> +EXPORT_SYMBOL(match_s64);

Thanks,
Chase
