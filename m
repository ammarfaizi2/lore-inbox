Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272234AbTHIDRS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 23:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272239AbTHIDRS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 23:17:18 -0400
Received: from mail.suse.de ([213.95.15.193]:43273 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S272234AbTHIDRQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 23:17:16 -0400
Date: Sat, 9 Aug 2003 05:17:15 +0200 (CEST)
From: Andreas Gruenbacher <agruen@suse.de>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4: Fix steal_locks race
In-Reply-To: <20030809030409.GA11867@gondor.apana.org.au>
Message-ID: <Pine.LNX.4.53.0308090514430.18879@Chaos.suse.de>
References: <20030808105321.GA5096@gondor.apana.org.au>
 <Pine.LNX.4.53.0308090451380.18879@Chaos.suse.de> <20030809030409.GA11867@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Aug 2003, Herbert Xu wrote:

> On Sat, Aug 09, 2003 at 04:59:03AM +0200, Andreas Gruenbacher wrote:
> >
> > @@ -714,18 +715,16 @@ static int load_elf_binary(struct linux_
> >  			elf_entry = load_elf_interp(&interp_elf_ex,
> >  						    interpreter,
> >  						    &interp_load_addr);
> > -
> > -		allow_write_access(interpreter);
> > -		fput(interpreter);
> > -		kfree(elf_interpreter);
> > -
> >  		if (BAD_ADDR(elf_entry)) {
> >  			printk(KERN_ERR "Unable to load interpreter\n");
> > -			kfree(elf_phdata);
> >  			send_sig(SIGSEGV, current, 0);
> >  			retval = -ENOEXEC; /* Nobody gets to see this, but.. */
> > -			goto out;
> > +			goto out_free_dentry;
> >  		}
> > +
> > +		allow_write_access(interpreter);
> > +		fput(interpreter);
> > +		kfree(elf_interpreter);
> >  	}
>
> This looks bad since you're past the point of no return.

This is an equivalence transformation except for the explicit
sys_close(elf_exec_fileno) in the unwind code, which would eventually
happen, anyway.
