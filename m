Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266119AbUBCV5K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 16:57:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266156AbUBCV5K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 16:57:10 -0500
Received: from smtp2.wanadoo.fr ([193.252.22.29]:13426 "EHLO
	mwinf0202.wanadoo.fr") by vger.kernel.org with ESMTP
	id S266119AbUBCV5F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 16:57:05 -0500
Date: Tue, 3 Feb 2004 23:14:21 +0000
From: Philippe Elie <phil.el@wanadoo.fr>
To: Kronos <kronos@kronoz.cjb.net>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [Compile Regression in 2.4.25-pre8][PATCH 37/42]
Message-ID: <20040203231421.GC10009@zaniah>
References: <20040130204956.GA21643@dreamland.darkstar.lan> <Pine.LNX.4.58L.0401301855410.3140@logos.cnet> <20040202180940.GA6367@dreamland.darkstar.lan> <20040202200344.GK6785@dreamland.darkstar.lan> <Pine.GSO.4.58.0402022207240.19699@waterleaf.sonytel.be> <20040203210738.GB1337@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040203210738.GB1337@dreamland.darkstar.lan>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 03 Feb 2004 at 22:07 +0000, Kronos wrote:

> Ok, I cooked up this patch. BUG() is a function marked as noreturn that is
> always inlined. Unfortunately, gcc prior to 3.x does not support
> __always_inline__ attribute, so I had to revert to the old macro with older
> compiler.
> 
> The patch fixes warnings with newer compiler, but not with older ones.
> Note that the while(1) is needed, otherwise gcc will say that the
> function marked as noreturn does actually return.
> 
> Comments?
> 
> diff -Nru -X dontdiff linux-2.4-vanilla/include/asm-i386/page.h linux-2.4/include/asm-i386/page.h
> --- linux-2.4-vanilla/include/asm-i386/page.h	Tue Nov 11 18:05:52 2003
> +++ linux-2.4/include/asm-i386/page.h	Tue Feb  3 07:26:04 2004
> @@ -10,6 +10,7 @@
>  #ifndef __ASSEMBLY__
>  
>  #include <linux/config.h>
> +#include <linux/compiler.h>
>  
>  #ifdef CONFIG_X86_USE_3DNOW
>  
> @@ -94,6 +95,26 @@
>   * The offending file and line are encoded after the "officially
>   * undefined" opcode for parsing in the trap handler.
>   */
> +#ifdef __bug
> +#if 1	/* Set to zero for a slightly smaller kernel */
> +__bug void __bugfn(void) {
> +	while(1) {
> +		 __asm__ __volatile__(	"ud2\n"
> +					"\t.word %c0\n"
> +					"\t.long %c1\n"
> +					: : "i" (__LINE__), "i" (__FILE__));
> + 	}
> +}

You must pass __LINE__ and __FILE__ as parameter to this function.

regards,
Philippe Elie
