Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750819AbWHTPz0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750819AbWHTPz0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 11:55:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750828AbWHTPzZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 11:55:25 -0400
Received: from mother.openwall.net ([195.42.179.200]:61632 "HELO
	mother.openwall.net") by vger.kernel.org with SMTP id S1750819AbWHTPzZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 11:55:25 -0400
Date: Sun, 20 Aug 2006 19:51:22 +0400
From: Solar Designer <solar@openwall.com>
To: Willy Tarreau <w@1wt.eu>
Cc: linux-kernel@vger.kernel.org, Chuck Ebbert <76306.1226@compuserve.com>,
       Andrew Morton <akpm@osdl.org>, Ernie Petrides <petrides@redhat.com>
Subject: Re: [PATCH] binfmt_elf.c : the BAD_ADDR macro again
Message-ID: <20060820155122.GA20108@openwall.com>
References: <20060820020417.GA17450@openwall.com> <20060820091515.GC602@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060820091515.GC602@1wt.eu>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 20, 2006 at 11:15:15AM +0200, Willy Tarreau wrote:
> The proper fix would then be :
[...]
> -#define BAD_ADDR(x)	((unsigned long)(x) > TASK_SIZE)
> +#define BAD_ADDR(x)	((unsigned long)(x) >= TASK_SIZE)
[...]
> -	    if (k > TASK_SIZE || eppnt->p_filesz > eppnt->p_memsz ||
> +	    if (BAD_ADDR(k) || eppnt->p_filesz > eppnt->p_memsz ||
[...]
> -		if (k > TASK_SIZE || elf_ppnt->p_filesz > elf_ppnt->p_memsz ||
> +		if (BAD_ADDR(k) || elf_ppnt->p_filesz > elf_ppnt->p_memsz ||

Looks OK to me.

> And even then, I'm not happy with this test :
> 
>    TASK_SIZE - elf_ppnt->p_memsz < k
> 
> because it means that we only raise the error when
> 
>    k + elf_ppnt->p_memsz > TASK_SIZE
> 
> I really think that we want to check this instead :
> 
>    k + elf_ppnt->p_memsz >= TASK_SIZE
> 
> Otherwise we leave a window where this is undetected :
> 
>    load_addr + eppnt->p_vaddr == TASK_SIZE - eppnt->p_memsz
> 
> This will later lead to last_bss getting readjusted to TASK_SIZE, which I
> don't think is expected at all :
> 
>             k = load_addr + eppnt->p_memsz + eppnt->p_vaddr;
>             if (k > last_bss)
>                 last_bss = k;
> 
> Then I think we should change this at both places :
> 
> - 		    TASK_SIZE - elf_ppnt->p_memsz < k) {
> +		    BAD_ADDR(k + elf_ppnt->p_memsz)) {

I am not sure about these re-arrangements - I'd need to review them in
full context to make sure that we don't inadvertently change things as
it relates to behavior on integer overflows, which I presently do not
have the time for.  I'll trust that you do such a review with integer
overflows and variable type differences (size, signedness) in mind now
that I've mentioned this potential danger. ;-)  Alternatively, you can
simply change the comparisons from < to <= and from > to >= rather than
use the BAD_ADDR() macro.

Thanks,

Alexander
