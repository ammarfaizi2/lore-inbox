Return-Path: <linux-kernel-owner+w=401wt.eu-S1758738AbWLJXM4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758738AbWLJXM4 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 18:12:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759143AbWLJXM4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 18:12:56 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:1332 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1758738AbWLJXM4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 18:12:56 -0500
Date: Mon, 11 Dec 2006 00:13:05 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Folkert van Heusden <folkert@vanheusden.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: optimalisation for strlcpy (lib/string.c)
Message-ID: <20061210231305.GG10351@stusta.de>
References: <20061210212350.GC30197@vanheusden.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061210212350.GC30197@vanheusden.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 10, 2006 at 10:23:51PM +0100, Folkert van Heusden wrote:
> Hi,
> 
> Like the other patch (by that other person), I think it is faster to not
> do a strlen first.
>...
> --- lib/string.c        2006-11-04 02:33:58.000000000 +0100
> +++ string-new.c        2006-12-10 22:22:08.000000000 +0100
> @@ -121,14 +121,24 @@
>   */
>  size_t strlcpy(char *dest, const char *src, size_t size)
>  {
> -       size_t ret = strlen(src);
> +        char *tmp = dest;
> 
> -       if (size) {
> -               size_t len = (ret >= size) ? size - 1 : ret;
> -               memcpy(dest, src, len);
> -               dest[len] = '\0';
> +        for(;;)
> +        {
> +                *dest = *src;
> +                if (!*src)
> +                        break;
> +
> +                if (--size == 0)
> +                        break;
> +
> +                dest++;
> +                src++;
>         }
> -       return ret;
> +
> +        *dest = 0x00;
> +
> +        return dest - tmp;
>...

Two bugs in your code:
- you copy a maximum of size bytes _plus_ \0
- size == 0 is no longer handled correctly

> I've tested the speed difference with this:
> http://www.vanheusden.com/misc/kernel-strlcpy-opt-test.c
> and the speed difference is quite a bit on a P4: 28% faster.
>...

My Athlon says:
org: 2.400000
new: 6.710000

IOW, your version is much slower.

But the main question is actually:
Does the performance of this function matter anywhere inside the kernel?
Is strlcpy() used in any fast path?
If not, there's no point in trying to optimize it.

> Folkert van Heusden

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

