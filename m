Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272167AbTHIDE5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 23:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272168AbTHIDE5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 23:04:57 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:45586 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S272167AbTHIDEz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 23:04:55 -0400
Date: Sat, 9 Aug 2003 13:04:09 +1000
To: Andreas Gruenbacher <agruen@suse.de>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4: Fix steal_locks race
Message-ID: <20030809030409.GA11867@gondor.apana.org.au>
References: <20030808105321.GA5096@gondor.apana.org.au> <Pine.LNX.4.53.0308090451380.18879@Chaos.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0308090451380.18879@Chaos.suse.de>
User-Agent: Mutt/1.5.4i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 09, 2003 at 04:59:03AM +0200, Andreas Gruenbacher wrote:
>
> @@ -714,18 +715,16 @@ static int load_elf_binary(struct linux_
>  			elf_entry = load_elf_interp(&interp_elf_ex,
>  						    interpreter,
>  						    &interp_load_addr);
> -
> -		allow_write_access(interpreter);
> -		fput(interpreter);
> -		kfree(elf_interpreter);
> -
>  		if (BAD_ADDR(elf_entry)) {
>  			printk(KERN_ERR "Unable to load interpreter\n");
> -			kfree(elf_phdata);
>  			send_sig(SIGSEGV, current, 0);
>  			retval = -ENOEXEC; /* Nobody gets to see this, but.. */
> -			goto out;
> +			goto out_free_dentry;
>  		}
> +
> +		allow_write_access(interpreter);
> +		fput(interpreter);
> +		kfree(elf_interpreter);
>  	}

This looks bad since you're past the point of no return.
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
