Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751139AbWHUVXz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbWHUVXz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 17:23:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751144AbWHUVXz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 17:23:55 -0400
Received: from 1wt.eu ([62.212.114.60]:7697 "EHLO 1wt.eu") by vger.kernel.org
	with ESMTP id S1751139AbWHUVXy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 17:23:54 -0400
Date: Mon, 21 Aug 2006 23:11:04 +0200
From: Willy Tarreau <w@1wt.eu>
To: Ernie Petrides <petrides@redhat.com>
Cc: Solar Designer <solar@openwall.com>,
       Chuck Ebbert <76306.1226@compuserve.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] binfmt_elf.c : the BAD_ADDR macro again
Message-ID: <20060821211104.GA7790@1wt.eu>
References: <20060820162352.GJ602@1wt.eu> <200608212035.k7LKZlCQ007334@pasta.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608212035.k7LKZlCQ007334@pasta.boston.redhat.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2006 at 04:35:47PM -0400, Ernie Petrides wrote:
> On Sunday, 20-Aug-2006 at 18:23 +0200, Willy Tarreau wrote:
> 
> > On Sun, Aug 20, 2006 at 07:51:22PM +0400, Solar Designer wrote:
> > > On Sun, Aug 20, 2006 at 11:15:15AM +0200, Willy Tarreau wrote:
> > > > The proper fix would then be :
> > > [...]
> > > > -#define BAD_ADDR(x)	((unsigned long)(x) > TASK_SIZE)
> > > > +#define BAD_ADDR(x)	((unsigned long)(x) >= TASK_SIZE)
> > > [...]
> > > > -	    if (k > TASK_SIZE || eppnt->p_filesz > eppnt->p_memsz ||
> > > > +	    if (BAD_ADDR(k) || eppnt->p_filesz > eppnt->p_memsz ||
> > > [...]
> > > > -		if (k > TASK_SIZE || elf_ppnt->p_filesz > elf_ppnt->p_memsz ||
> > > > +		if (BAD_ADDR(k) || elf_ppnt->p_filesz > elf_ppnt->p_memsz ||
> > > 
> > > Looks OK to me.
> 
> These are all correct.

OK.

> > > > And even then, I'm not happy with this test :
> > > > 
> > > >    TASK_SIZE - elf_ppnt->p_memsz < k
> > > > 
> > > > because it means that we only raise the error when
> > > > 
> > > >    k + elf_ppnt->p_memsz > TASK_SIZE
> > > > 
> > > > I really think that we want to check this instead :
> > > > 
> > > >    k + elf_ppnt->p_memsz >= TASK_SIZE
> > > > 
> > > > Otherwise we leave a window where this is undetected :
> > > > 
> > > >    load_addr + eppnt->p_vaddr == TASK_SIZE - eppnt->p_memsz
> 
> The reason I did not propose changing these is because these are
> end-point checks (as opposed to starting address checks).  I think
> that the following "equals" condition is conceptually valid:
> 
> 	(starting-address + region-size == TASK_SIZE)

Agreed.
 
> > > > This will later lead to last_bss getting readjusted to TASK_SIZE, which I
> > > > don't think is expected at all :
> > > > 
> > > >             k = load_addr + eppnt->p_memsz + eppnt->p_vaddr;
> > > >             if (k > last_bss)
> > > >                 last_bss = k;
> 
> This is an interesting case, but I think the error checking works okay.
> 
> After the ELF phdr loop, the resulting "last_bss" is used as follows:
> 
> 	/* Map the last of the bss segment */
> 	if (last_bss > elf_bss) {
> 		down_write(&current->mm->mmap_sem);
> 		error = do_brk(elf_bss, last_bss - elf_bss);
> 		up_write(&current->mm->mmap_sem);
> 		if (BAD_ADDR(error))
> 			goto out_close;
> 	}
> 
> The variable "last_bss" is used to compute the size argument in the
> call to do_brk().  If the section extends beyond TASK_SIZE, then do_brk()
> will return -EINVAL.  If the do_brk() call succeeds but "elf_bss" is itself
> exactly at TASK_SIZE, then the BAD_ADDR() call above will catch it.

OK. Thanks for the explanation.

> > [...]   But before this, I'd like to get comments from
> > the people who discussed the subject recently.
> 
> Thus, I think that both 2.4.33 and 2.6.<latest> are okay without any
> further changes.

At least 2.4 needs the fix to use the correct BAD_ADDR (which is not
OK in 2.4.33 yet).

> Cheers.  -ernie

Thanks Ernie,
Willy

