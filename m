Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275322AbTHMTRq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 15:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275328AbTHMTRq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 15:17:46 -0400
Received: from chaos.analogic.com ([204.178.40.224]:22917 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S275322AbTHMTRm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 15:17:42 -0400
Date: Wed, 13 Aug 2003 15:20:32 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Stephen Hemminger <shemminger@osdl.org>
cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] get rid of bcopy warning
In-Reply-To: <20030813113635.3d3b71ce.shemminger@osdl.org>
Message-ID: <Pine.LNX.4.53.0308131506540.18802@chaos>
References: <20030813113635.3d3b71ce.shemminger@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Aug 2003, Stephen Hemminger wrote:

> Get rid of warning because internal definition of bcopy
> conflicts with builtin.  The warning is probably a bogus
> bug of GCC 3.2.3, but the workaround is simple.
>
> Almost no driver really uses bcopy anyway, and no code
> uses the return value.

There should never have been a return value from a function
called bcopy() anyway.

>
> diff -Nru a/lib/string.c b/lib/string.c
> --- a/lib/string.c	Wed Aug 13 11:31:13 2003
> +++ b/lib/string.c	Wed Aug 13 11:31:13 2003
> @@ -432,14 +432,13 @@
>   * You should not use this function to access IO space, use memcpy_toio()
>   * or memcpy_fromio() instead.
>   */
> -char * bcopy(const char * src, char * dest, int count)
> +void bcopy(const void * src, void * dest, size_t count)
>  {
> + 	const char *s = src;
>  	char *tmp = dest;
>
>  	while (count--)
> -		*tmp++ = *src++;
> -
> -	return dest;
> +		*tmp++ = *s++;
>  }
>  #endif
>

This whole thing is bogus. bcopy() is supposed to handle
copies of overlapping buffers (IEEE Std 1003.1-2001).

This means that if destination is at a greater offset than the
source, the data has to be copied backwards. The code above
is broken.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.

