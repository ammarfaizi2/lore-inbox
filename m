Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751833AbWHATTO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751833AbWHATTO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 15:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751829AbWHATTO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 15:19:14 -0400
Received: from cantor2.suse.de ([195.135.220.15]:61382 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751833AbWHATTM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 15:19:12 -0400
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: <linux-kernel@vger.kernel.org>, Horms <horms@verge.net.au>,
       Jan Kratochvil <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       Vivek Goyal <vgoyal@in.ibm.com>, Linda Wang <lwang@redhat.com>
Subject: Re: [PATCH 9/33] i386 boot: Add serial output support to the decompressor
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
	<115443023544-git-send-email-ebiederm@xmission.com>
From: Andi Kleen <ak@suse.de>
Date: 01 Aug 2006 21:19:03 +0200
In-Reply-To: <115443023544-git-send-email-ebiederm@xmission.com>
Message-ID: <p73zmeoz2l4.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric W. Biederman" <ebiederm@xmission.com> writes:
>  			}
> @@ -200,6 +224,178 @@ static void putstr(const char *s)
>  	outb_p(0xff & (pos >> 1), vidport+1);
>  }
>  
> +static void vid_console_init(void)

Please just use early_printk instead of reimplementing this. 
I think it should work in this context too.

> +static inline int tolower(int ch)
> +{
> +	return ch | 0x20;
> +}
> +
> +static inline int isdigit(int ch)
> +{
> +	return (ch >= '0') && (ch <= '9');
> +}
> +
> +static inline int isxdigit(int ch)
> +{
> +	ch = tolower(ch);
> +	return isdigit(ch) || ((ch >= 'a') && (ch <= 'f'));
> +}

And please reuse the Linux code here.


Actually the best way to reuse would be to first do 64bit uncompressor
and linker directly, but short of that #includes would be fine too.


> +
> +
> +static inline int digval(int ch)
> +{
> +	return isdigit(ch)? (ch - '0') : tolower(ch) - 'a' + 10;
> +}
> +
> +/**
> + * simple_strtou - convert a string to an unsigned
> + * @cp: The start of the string
> + * @endp: A pointer to the end of the parsed string will be placed here
> + * @base: The number base to use
> + */
> +static unsigned simple_strtou(const char *cp, char **endp, unsigned base)
> +{
> +	unsigned result = 0,value;
> +
> +	if (!base) {
> +		base = 10;
> +		if (*cp == '0') {
> +			base = 8;
> +			cp++;
> +			if ((tolower(*cp) == 'x') && isxdigit(cp[1])) {
> +				cp++;
> +				base = 16;
> +			}
> +		}
> +	} else if (base == 16) {
> +		if (cp[0] == '0' && tolower(cp[1]) == 'x')
> +			cp += 2;
> +	}
> +	while (isxdigit(*cp) && ((value = digval(*cp)) < base)) {
> +		result = result*base + value;
> +		cp++;
> +	}
> +	if (endp)
> +		*endp = (char *)cp;
> +	return result;
> +}

Can you please somehow reuse the Linux one? 

> +
>  static void* memset(void* s, int c, unsigned n)
>  {
>  	int i;
> @@ -218,6 +414,29 @@ static void* memcpy(void* dest, const vo
>  	return dest;
>  }
>  
> +static int memcmp(const void *s1, const void *s2, unsigned n)
> +{
> +	const unsigned char *str1 = s1, *str2 = s2;
> +	size_t i;
> +	int result = 0;
> +	for(i = 0; (result == 0) && (i < n); i++) {
> +		result = *str1++ - *str2++;
> +		}
> +	return result;
> +}
> +
> +char *strstr(const char *haystack, const char *needle)
> +{
> +	size_t len;
> +	len = strlen(needle);
> +	while(*haystack) {
> +		if (memcmp(haystack, needle, len) == 0)
> +			return (char *)haystack;
> +		haystack++;
> +	}
> +	return NULL;


Would be better to just pull in lib/string.c

-Andi

