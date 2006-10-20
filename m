Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946389AbWJTLyR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946389AbWJTLyR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 07:54:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946390AbWJTLyQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 07:54:16 -0400
Received: from mx1.suse.de ([195.135.220.2]:9197 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1946389AbWJTLyQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 07:54:16 -0400
Date: Fri, 20 Oct 2006 13:54:14 +0200
From: Marcus Meissner <meissner@suse.de>
To: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] binfmt_elf: randomize PIE binaries
Message-ID: <20061020115414.GA14448@suse.de>
References: <20061019143547.GA8586@suse.de> <20061019202354.GI26530@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061019202354.GI26530@redhat.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2006 at 04:23:54PM -0400, Dave Jones wrote:
> On Thu, Oct 19, 2006 at 04:35:47PM +0200, Marcus Meissner wrote:
> 
>  > --- linux-2.6.18/fs/binfmt_elf.c.xx	2006-10-19 11:21:49.000000000 +0200
>  > +++ linux-2.6.18/fs/binfmt_elf.c	2006-10-19 11:24:58.000000000 +0200
>  > @@ -856,7 +856,12 @@ static int load_elf_binary(struct linux_
>  >  			 * default mmap base, as well as whatever program they
>  >  			 * might try to exec.  This is because the brk will
>  >  			 * follow the loader, and is not movable.  */
>  > -			load_bias = ELF_PAGESTART(ELF_ET_DYN_BASE - vaddr);
>  > +			if (current->flags & PF_RANDOMIZE)
>  > +				load_bias = randomize_range(0, ELF_ET_DYN_BASE,
>  > +							    vaddr);
>  > +			else
>  > +				load_bias = ELF_ET_DYN_BASE - vaddr;
>  > +			load_bias = ELF_PAGESTART(load_bias);
>  >  		}
>  >  
>  >  		error = elf_map(bprm->file, load_bias + vaddr, elf_ppnt,
> 
> 
> vaddr seems odd to be using as the len for randomize_range doesn't it ?
> Should that be randomize_range(0, ELF_ET_DYN_BASE, ELF_ET_DYN_BASE - vaddr); 
> 
> maybe ?

> Also, when we get to the elf_map(), we add vaddr back again, but in the
> randomize_range case, we never subtracted it.  hmm?

Yes, the code was not really doing what I actually intended. (It was working,
but the range always started at vaddr).

I am using randomize_range (PAGE_SIZE, ELF_ET_DYN_BASE,0) (- vaddr) now
after further comments from Arjan.

Any other good ideas for a range to do the randomization in are welcome.

Ciao, Marcus
