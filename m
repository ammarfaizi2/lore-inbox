Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265512AbTL3Hck (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 02:32:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265689AbTL3Hck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 02:32:40 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:55706 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265512AbTL3Hca
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 02:32:30 -0500
Message-ID: <3FF129F9.7080703@pobox.com>
Date: Tue, 30 Dec 2003 02:32:09 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: manfred@colorfullife.com, akpm@osdl.org
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] optimize ia32 memmove
References: <200312300713.hBU7DGC4024213@hera.kernel.org>
In-Reply-To: <200312300713.hBU7DGC4024213@hera.kernel.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Mailing List wrote:
> ChangeSet 1.1496.22.32, 2003/12/29 21:45:30-08:00, akpm@osdl.org
> 
> 	[PATCH] optimize ia32 memmove
> 	
> 	From: Manfred Spraul <manfred@colorfullife.com>
> 	
> 	The memmove implementation of i386 is not optimized: it uses movsb, which is
> 	far slower than movsd.  The optimization is trivial: if dest is less than
> 	source, then call memcpy().  markw tried it on a 4xXeon with dbt2, it saved
> 	around 300 million cpu ticks in cache_flusharray():
[...]
> diff -Nru a/include/asm-i386/string.h b/include/asm-i386/string.h
> --- a/include/asm-i386/string.h	Mon Dec 29 23:13:20 2003
> +++ b/include/asm-i386/string.h	Mon Dec 29 23:13:20 2003
> @@ -299,14 +299,9 @@
>  static inline void * memmove(void * dest,const void * src, size_t n)
>  {
>  int d0, d1, d2;
> -if (dest<src)
> -__asm__ __volatile__(
> -	"rep\n\t"
> -	"movsb"
> -	: "=&c" (d0), "=&S" (d1), "=&D" (d2)
> -	:"0" (n),"1" (src),"2" (dest)
> -	: "memory");
> -else
> +if (dest<src) {
> +	memcpy(dest,src,n);
> +} else
>  __asm__ __volatile__(
>  	"std\n\t"
>  	"rep\n\t"

Dumb question, though...   what about the overlap case, when dest<src ? 
  It seems to me this change is ignoring that.

	Jeff



