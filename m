Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261991AbUCXVhL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 16:37:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262017AbUCXVhL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 16:37:11 -0500
Received: from mail.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:59349 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S261991AbUCXVhB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 16:37:01 -0500
Date: Wed, 24 Mar 2004 22:36:48 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Andrew Morton <akpm@osdl.org>, matthias.andree@gmx.de, andrea@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.25 SMP - BUG at page_alloc.c:105
Message-ID: <20040324213648.GA17896@merlin.emma.line.org>
Mail-Followup-To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	Andrew Morton <akpm@osdl.org>, andrea@suse.de,
	linux-kernel@vger.kernel.org
References: <20040324205811.GB6572@logos.cnet> <20040324122806.4015d3d6.akpm@osdl.org> <20040324215112.GA6931@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040324215112.GA6931@logos.cnet>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Mar 2004, Marcelo Tosatti wrote:

> This should work. Matthias, please apply and try to reproduce.

Didn't compile. I have changed that line 119 to bad_page(__FUNCTION__,
page); instead. If the first argument must be something else, let me
know. It doesn't immedately make sense with just one caller, but I know
nothing better right now.

As I don't know a specific scenario to reproduce the crash, it may take
longer (possibly weeks) until I can come up with results.

Here's the error:

gcc -D__KERNEL__ -I/usr/src/linux-2.4.25/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=athlon -nostdinc -iwithprefix include -DKBUILD_BASENAME=page_alloc -DEXPORT_SYMTAB -c page_alloc.c
page_alloc.c: In function `__free_pages_ok':
page_alloc.c:119: warning: passing arg 1 of `bad_page' from incompatible pointer type
page_alloc.c:119: error: too few arguments to function `bad_page'
make[2]: *** [page_alloc.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.4.25/mm'

The relevant parts of the patch were:

> --- mm/page_alloc.c.orig	2004-03-24 18:42:53.693251224 -0300
> +++ mm/page_alloc.c	2004-03-24 18:47:52.484828000 -0300
> @@ -81,6 +81,20 @@
>   * -- wli
>   */
>  
> +static void bad_page(const char *function, struct page *page)
> +{
> +        printk("Bad page state at %s\n", function);
...
> @@ -101,8 +115,8 @@
>  
>  	if (page->buffers)
>  		BUG();
> -	if (page->mapping)
> -		BUG();
> +	if (page->mapping) 
> +		bad_page(page);
>  	if (!VALID_PAGE(page))
>  		BUG();
>  	if (PageLocked(page))

-- 
Matthias Andree

Encrypt your mail: my GnuPG key ID is 0x052E7D95
