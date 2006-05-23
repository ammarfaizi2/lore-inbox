Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932196AbWEWMyn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932196AbWEWMyn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 08:54:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932201AbWEWMyn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 08:54:43 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:44665 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932196AbWEWMym convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 08:54:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=f3l4sHXHWBJifqWGV6n+GuLkZZVYkoXVxcSsiNy9Y29eOFATLTGB8BuYrrSecRay9v708dAnOhzAARo+h7Xhs15gtf1hu6qj5073Qm2ueI1guMr0rF+bclJGS9Uj01gha1P3vKm8b+LEDHVwRyuiyS0l3HU4tyCjJmqWdAvIISw=
Message-ID: <661de9470605230554y1703fba9j2f2da0609fc3695e@mail.gmail.com>
Date: Tue, 23 May 2006 18:24:41 +0530
From: "Balbir Singh" <bsingharora@gmail.com>
To: "Martin Peschke" <mp3@de.ibm.com>
Subject: Re: [Patch 2/6] statistics infrastructure - prerequisite: parser enhancement
Cc: "Andrew Morton" <akpm@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <1148055023.2974.14.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1148055023.2974.14.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/19/06, Martin Peschke <mp3@de.ibm.com> wrote:
> This patch adds a match_* derivate for 64 bit operands to the parser library.
>
> Signed-off-by: Martin Peschke <mp3@de.ibm.com>
> ---
>
>  include/linux/parser.h |    1 +
>  lib/parser.c           |   30 ++++++++++++++++++++++++++++++
>  2 files changed, 31 insertions(+)
>
> diff -Nurp a/lib/parser.c b/lib/parser.c
> --- a/lib/parser.c      2006-03-20 06:53:29.000000000 +0100
> +++ b/lib/parser.c      2006-05-19 16:01:48.000000000 +0200
> @@ -140,6 +140,35 @@ static int match_number(substring_t *s,
>  }
>
>  /**
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
> +       char *endp;
> +       char *buf;
> +       int ret;
> +
> +       buf = kmalloc(s->to - s->from + 1, GFP_KERNEL);
> +       if (!buf)
> +               return -ENOMEM;
> +       memcpy(buf, s->from, s->to - s->from);
> +       buf[s->to - s->from] = '\0';
> +       *result = simple_strtoll(buf, &endp, base);
> +       ret = 0;
> +       if (endp == buf)
> +               ret = -EINVAL;
> +       kfree(buf);
> +       return ret;
> +}
> +
> +/**
>   * match_int: - scan a decimal representation of an integer from a substring_t
>   * @s: substring_t to be scanned
>   * @result: resulting integer on success
> @@ -218,3 +247,4 @@ EXPORT_SYMBOL(match_octal);
>  EXPORT_SYMBOL(match_hex);
>  EXPORT_SYMBOL(match_strcpy);
>  EXPORT_SYMBOL(match_strdup);
> +EXPORT_SYMBOL(match_s64);
> diff -Nurp a/include/linux/parser.h b/include/linux/parser.h
> --- a/include/linux/parser.h    2006-03-20 06:53:29.000000000 +0100
> +++ b/include/linux/parser.h    2006-05-19 16:01:48.000000000 +0200
> @@ -31,3 +31,4 @@ int match_octal(substring_t *, int *resu
>  int match_hex(substring_t *, int *result);
>  void match_strcpy(char *, substring_t *);
>  char *match_strdup(substring_t *);
> +int match_s64(substring_t *, s64 *result, int);
>

Sorry for the delay in reviewing. I am just catching up with pending items.
I wonder if makes sense to fold this along with match_u64(). 90% of
their code is common. We can avoid text replication by folding the
code and the common code is easier to maintain.

Regards,
Balbir
Linux Technology Center,
India Software Labs,
Bangalore
