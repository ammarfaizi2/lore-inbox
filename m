Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750835AbWHTQYq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750835AbWHTQYq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 12:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750864AbWHTQYq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 12:24:46 -0400
Received: from 1wt.eu ([62.212.114.60]:50960 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1750835AbWHTQYp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 12:24:45 -0400
Date: Sun, 20 Aug 2006 18:23:52 +0200
From: Willy Tarreau <w@1wt.eu>
To: Solar Designer <solar@openwall.com>
Cc: linux-kernel@vger.kernel.org, Chuck Ebbert <76306.1226@compuserve.com>,
       Andrew Morton <akpm@osdl.org>, Ernie Petrides <petrides@redhat.com>
Subject: Re: [PATCH] binfmt_elf.c : the BAD_ADDR macro again
Message-ID: <20060820162352.GJ602@1wt.eu>
References: <20060820020417.GA17450@openwall.com> <20060820091515.GC602@1wt.eu> <20060820155122.GA20108@openwall.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060820155122.GA20108@openwall.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 20, 2006 at 07:51:22PM +0400, Solar Designer wrote:
> On Sun, Aug 20, 2006 at 11:15:15AM +0200, Willy Tarreau wrote:
> > The proper fix would then be :
> [...]
> > -#define BAD_ADDR(x)	((unsigned long)(x) > TASK_SIZE)
> > +#define BAD_ADDR(x)	((unsigned long)(x) >= TASK_SIZE)
> [...]
> > -	    if (k > TASK_SIZE || eppnt->p_filesz > eppnt->p_memsz ||
> > +	    if (BAD_ADDR(k) || eppnt->p_filesz > eppnt->p_memsz ||
> [...]
> > -		if (k > TASK_SIZE || elf_ppnt->p_filesz > elf_ppnt->p_memsz ||
> > +		if (BAD_ADDR(k) || elf_ppnt->p_filesz > elf_ppnt->p_memsz ||
> 
> Looks OK to me.
> 
> > And even then, I'm not happy with this test :
> > 
> >    TASK_SIZE - elf_ppnt->p_memsz < k
> > 
> > because it means that we only raise the error when
> > 
> >    k + elf_ppnt->p_memsz > TASK_SIZE
> > 
> > I really think that we want to check this instead :
> > 
> >    k + elf_ppnt->p_memsz >= TASK_SIZE
> > 
> > Otherwise we leave a window where this is undetected :
> > 
> >    load_addr + eppnt->p_vaddr == TASK_SIZE - eppnt->p_memsz
> > 
> > This will later lead to last_bss getting readjusted to TASK_SIZE, which I
> > don't think is expected at all :
> > 
> >             k = load_addr + eppnt->p_memsz + eppnt->p_vaddr;
> >             if (k > last_bss)
> >                 last_bss = k;
> > 
> > Then I think we should change this at both places :
> > 
> > - 		    TASK_SIZE - elf_ppnt->p_memsz < k) {
> > +		    BAD_ADDR(k + elf_ppnt->p_memsz)) {
> 
> I am not sure about these re-arrangements - I'd need to review them in
> full context to make sure that we don't inadvertently change things as
> it relates to behavior on integer overflows, which I presently do not
> have the time for.  I'll trust that you do such a review with integer
> overflows and variable type differences (size, signedness) in mind now
> that I've mentioned this potential danger. ;-)  Alternatively, you can
> simply change the comparisons from < to <= and from > to >= rather than
> use the BAD_ADDR() macro.

Well, I have for a principle that if a change requires too many brain usage
to check for validity when we can avoid it, let's avoid it. I'm fine with
just changing the operator. But before this, I'd like to get comments from
the people who discussed the subject recently.

> Thanks,
> 
> Alexander

Regards,
Willy

