Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423368AbWF1OoV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423368AbWF1OoV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 10:44:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423370AbWF1OoV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 10:44:21 -0400
Received: from smtp-out.google.com ([216.239.45.12]:44513 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1423368AbWF1OoU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 10:44:20 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=R3KEnTpEn28C7IuWRb4JOdnow8vPvJrqTfpLq2mGL4MAHEcQubgKXUjcWvjSY9kT/
	M70994sWeinRPPVEbeYIg==
Message-ID: <44A29582.7050403@google.com>
Date: Wed, 28 Jun 2006 07:43:14 -0700
From: "Martin J. Bligh" <mbligh@google.com>
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: mbligh@mbligh.org, jeremy@goop.org, linux-kernel@vger.kernel.org,
       apw@shadowen.org, linuxppc64-dev@ozlabs.org, drfickle@us.ibm.com
Subject: Re: 2.6.17-mm2
References: <449D5D36.3040102@google.com>	<449FF3A2.8010907@mbligh.org>	<44A150C9.7020809@mbligh.org>	<20060628034215.c3008299.akpm@osdl.org> <20060628034748.018eecac.akpm@osdl.org>
In-Reply-To: <20060628034748.018eecac.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Wed, 28 Jun 2006 03:42:15 -0700
> Andrew Morton <akpm@osdl.org> wrote:
> 
> 
>>his is caused by the vsprintf() changes.  Right now, if you do
>>
>>	snprintf(buf, 4, "1111111111111");
>>
>>the memory at `buf' gets [31 31 31 31 00], which is not good.
>>
>>This'll plug it, but I didn't check very hard whether it still has any
>>off-by-ones, or if breaks the intent of Jeremy's patch.  I think it's OK..

Aha, you're a genius! How the hell did you figure that one out?

Andy / Steve ... any chance one of you could kick this through the
harness? Against -git10 or so, I'd think

Thanks,

M.

> That diff was against an older kernel and doesn't apply.  This is against
> mainline:
> 
> --- a/lib/vsprintf.c~vsnprintf-fix
> +++ a/lib/vsprintf.c
> @@ -259,7 +259,9 @@ int vsnprintf(char *buf, size_t size, co
>  	int len;
>  	unsigned long long num;
>  	int i, base;
> -	char *str, *end, c;
> +	char *str;		/* Where we're writing to */
> +	char *end;		/* The last byte we can write to */
> +	char c;
>  	const char *s;
>  
>  	int flags;		/* flags to number() */
> @@ -283,12 +285,12 @@ int vsnprintf(char *buf, size_t size, co
>  	}
>  
>  	str = buf;
> -	end = buf + size;
> +	end = buf + size - 1;
>  
>  	/* Make sure end is always >= buf */
> -	if (end < buf) {
> +	if (end < buf - 1) {
>  		end = ((void *)-1);
> -		size = end - buf;
> +		size = end - buf + 1;
>  	}
>  
>  	for (; *fmt ; ++fmt) {
> @@ -494,7 +496,6 @@ int vsnprintf(char *buf, size_t size, co
>  	/* the trailing null byte doesn't count towards the total */
>  	return str-buf;
>  }
> -
>  EXPORT_SYMBOL(vsnprintf);
>  
>  /**
> _
> 

