Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750807AbWEPSJQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbWEPSJQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 14:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751442AbWEPSJQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 14:09:16 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12513 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750807AbWEPSJP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 14:09:15 -0400
Date: Tue, 16 May 2006 11:11:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: Martin Peschke <mp3@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, ak@suse.de, hch@infradead.org,
       arjan@infradead.org, James.Smart@Emulex.Com,
       James.Bottomley@SteelEye.com
Subject: Re: [RFC] [Patch 2/8] statistics infrastructure - prerequisite:
 parser enhancement
Message-Id: <20060516111141.1cff68e9.akpm@osdl.org>
In-Reply-To: <446A0FBE.2030105@de.ibm.com>
References: <446A0FBE.2030105@de.ibm.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Peschke <mp3@de.ibm.com> wrote:
>
> This patch adds two match_* derivates for 64 bit operands to the parser
> library.
> 
>   void match_strcpy(char *, substring_t *);
>   char *match_strdup(substring_t *);
> +int match_u64(substring_t *, u64 *result, int);
> +int match_s64(substring_t *, s64 *result, int);

Your email client does space-stuffing, so this won't apply (ok, it might
apply if my email client knew how to space-unstuff, but it doesn't).

> diff -Nurp a/lib/parser.c b/lib/parser.c
> --- a/lib/parser.c	2006-03-20 06:53:29.000000000 +0100
> +++ b/lib/parser.c	2006-05-15 17:56:25.000000000 +0200
> @@ -140,6 +140,64 @@ static int match_number(substring_t *s,
>   }
> 
>   /**
> + * match_u64: scan a number in the given base from a substring_t
> + * @s: substring to be scanned
> + * @result: resulting integer on success
> + * @base: base to use when converting string
> + *
> + * Description: Given a &substring_t and a base, attempts to parse the substring
> + * as a number in that base. On success, sets @result to the u64 represented
> + * by the string and returns 0. Returns either -ENOMEM or -EINVAL on failure.
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
> + * Description: Given a &substring_t and a base, attempts to parse the substring
> + * as a number in that base. On success, sets @result to the s64 represented
> + * by the string and returns 0. Returns either -ENOMEM or -EINVAL on failure.
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
> +	*result = simple_strtoll(buf, &endp, base);
> +	ret = 0;
> +	if (endp == buf)
> +		ret = -EINVAL;
> +	kfree(buf);
> +	return ret;
> +}

These are identical.  If we _really_ need one for signed and one for
unsigned then we could at least do

match_s64(..., s64 *result, ...)
{
	return match_u64(..., (u64 *)result, ...);
}

That's if we do need one for signed and one for unsigned..
