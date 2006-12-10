Return-Path: <linux-kernel-owner+w=401wt.eu-S934424AbWLJVtu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934424AbWLJVtu (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 16:49:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934487AbWLJVtu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 16:49:50 -0500
Received: from customer-domains.icp-qv1-irony14.iinet.net.au ([203.59.1.169]:22049
	"EHLO customer-domains.icp-qv1-irony14.iinet.net.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934424AbWLJVtt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 16:49:49 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ao8CAJsPfEXKoRUQXWdsb2JhbACNRCw
X-IronPort-AV: i="4.09,518,1157299200"; 
   d="scan'208"; a="49445289:sNHT24748542"
Message-ID: <457C80F0.2080902@eyal.emu.id.au>
Date: Mon, 11 Dec 2006 08:49:36 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
User-Agent: Debian Thunderbird 1.0.2 (X11/20061113)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Folkert van Heusden <folkert@vanheusden.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: optimalisation for strlcpy (lib/string.c)
References: <20061210212350.GC30197@vanheusden.com>
In-Reply-To: <20061210212350.GC30197@vanheusden.com>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folkert van Heusden wrote:
> Hi,
> 
> Like the other patch (by that other person), I think it is faster to not
> do a strlen first.
> E.g. replace this:
> ize_t strlcpy(char *dest, const char *src, size_t size)
> {
>         size_t ret = strlen(src);
> 
>         if (size) {
>                 size_t len = (ret >= size) ? size - 1 : ret;
>                 memcpy(dest, src, len);
>                 dest[len] = '\0';
>         }
>         return ret;
> }
> by this:
> size_t strlcpy(char *dest, const char *src, size_t size)
> {
>         char *tmp = dest;
> 
>         for(;;)
>         {
>                 *dest = *src;
>                 if (!*src)
>                         break;
> 
>                 if (--size == 0)
>                         break;
> 
>                 dest++;
>                 src++;
>         }
> 
>         *dest = 0x00;
> 
>         return dest - tmp;
> }
> patch:
> diff -uNrBbd lib/string.c string-new.c
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
>  }
>  EXPORT_SYMBOL(strlcpy);
>  #endif
> 
> 
> I've tested the speed difference with this:
> http://www.vanheusden.com/misc/kernel-strlcpy-opt-test.c
> and the speed difference is quite a bit on a P4: 28% faster.
> 
> 
> Signed-off by: Folkert van Heusden <folkert@vanheusden.com>
> 
> 
> Folkert van Heusden

The two do not do exactly the same. The first one handles 'size == 0'
(should not happen?) safely while the other does not.

-- 
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
	attach .zip as .dat
