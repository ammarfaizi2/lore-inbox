Return-Path: <linux-kernel-owner+w=401wt.eu-S1423180AbWLVGIJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423180AbWLVGIJ (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 01:08:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423182AbWLVGII
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 01:08:08 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:56721 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423180AbWLVGIF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 01:08:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=E/kDVFWM6wg0oIiauF1VvmebhuoT9Q/55aQ5AGIYRi5g4VDo5sYZZeokYt+Zy7vd7BC4lQ2VHN0I+3TyCqeV+LpBvzNhu62PN/ewM7irE5WlXDoXRpk6EiktQppjlYThwXxM2kYkL62iKMcIESJbpwXQY/xK1pLRwr2fHjZShSg=
Date: Fri, 22 Dec 2006 06:06:18 +0000
From: Frederik Deweerdt <deweerdt@free.fr>
To: Andrew Morton <akpm@osdl.org>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, linux-kernel@vger.kernel.org
Subject: Re: [-mm patch] ptrace: make {put,get}reg work again for gs and fs
Message-ID: <20061222060618.GD18827@slug>
References: <20061214225913.3338f677.akpm@osdl.org> <20061221183518.GA18827@slug> <458ADEDD.8010903@goop.org> <20061221215942.GC18827@slug> <458B3C51.4030905@goop.org> <20061221181108.6cede9ba.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061221181108.6cede9ba.akpm@osdl.org>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 21, 2006 at 06:11:08PM -0800, Andrew Morton wrote:
> On Thu, 21 Dec 2006 18:00:49 -0800
> Jeremy Fitzhardinge <jeremy@goop.org> wrote:
> 
> > Frederik Deweerdt wrote:
> > > This is a -mm1 kernel + your efl_offset fix + the attached patch.
> > > So the problem came from putreg still saving %gs to the stack where
> > > there's no slot for it, whereas getreg got things right.
> > >   
> > 
> > That patch looks good, but I think it is already effectively in Andrew's
> > queue, because I noticed some problems in there when I reviewed  the
> > convert-to-%fs patch.
> > 
> 
> The below is what I have queued for urgent mainlining to address these
> problems.
> 
> Is it sufficient?
> 
No, it's not. The patch below fixes the place where we get eflags, this
triggered the "BUG while gdb'ing" reports.
The one I sent was to fix a problem that only I reported, AFAIK: when
you use gdb/ptrace to modify %fs, the value gets written in the wrong
place (see gdb sessions). So, unless you have another patch fixing the
way putreg() writes %fs, the patch[1] I sent should also be queued for
mainline.

Regards,
Frederik

[1] http://lkml.org/lkml/2006/12/21/267
> 
> 
> 
> From: Jeremy Fitzhardinge <jeremy@goop.org>
> 
> The PDA patches introduced a bug in ptrace: it reads eflags from the wrong
> place on the target's stack, but writes it back to the correct place.  The
> result is a corrupted eflags, which is most visible when it turns interrupts
> off unexpectedly.
> 
> This patch fixes this by making the ptrace code a little less fragile.  It
> changes [gs]et_stack_long to take a straightforward byte offset into struct
> pt_regs, rather than requiring all callers to do a sizeof(struct pt_regs)
> offset adjustment.  This means that the eflag's offset (EFL_OFFSET) on the
> target stack can be simply computed with offsetof().
> 
> Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
> Cc: Frederik Deweerdt <deweerdt@free.fr>
> Cc: Andi Kleen <ak@suse.de>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
> 
>  arch/i386/kernel/ptrace.c |   21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
> 
> diff -puN arch/i386/kernel/ptrace.c~ptrace-fix-efl_offset-value-according-to-i386-pda-changes arch/i386/kernel/ptrace.c
> --- a/arch/i386/kernel/ptrace.c~ptrace-fix-efl_offset-value-according-to-i386-pda-changes
> +++ a/arch/i386/kernel/ptrace.c
> @@ -45,7 +45,7 @@
>  /*
>   * Offset of eflags on child stack..
>   */
> -#define EFL_OFFSET ((EFL-2)*4-sizeof(struct pt_regs))
> +#define EFL_OFFSET offsetof(struct pt_regs, eflags)
>  
>  static inline struct pt_regs *get_child_regs(struct task_struct *task)
>  {
> @@ -54,24 +54,24 @@ static inline struct pt_regs *get_child_
>  }
>  
>  /*
> - * this routine will get a word off of the processes privileged stack. 
> - * the offset is how far from the base addr as stored in the TSS.  
> - * this routine assumes that all the privileged stacks are in our
> + * This routine will get a word off of the processes privileged stack.
> + * the offset is bytes into the pt_regs structure on the stack.
> + * This routine assumes that all the privileged stacks are in our
>   * data space.
>   */   
>  static inline int get_stack_long(struct task_struct *task, int offset)
>  {
>  	unsigned char *stack;
>  
> -	stack = (unsigned char *)task->thread.esp0;
> +	stack = (unsigned char *)task->thread.esp0 - sizeof(struct pt_regs);
>  	stack += offset;
>  	return (*((int *)stack));
>  }
>  
>  /*
> - * this routine will put a word on the processes privileged stack. 
> - * the offset is how far from the base addr as stored in the TSS.  
> - * this routine assumes that all the privileged stacks are in our
> + * This routine will put a word on the processes privileged stack.
> + * the offset is bytes into the pt_regs structure on the stack.
> + * This routine assumes that all the privileged stacks are in our
>   * data space.
>   */
>  static inline int put_stack_long(struct task_struct *task, int offset,
> @@ -79,7 +79,7 @@ static inline int put_stack_long(struct 
>  {
>  	unsigned char * stack;
>  
> -	stack = (unsigned char *) task->thread.esp0;
> +	stack = (unsigned char *)task->thread.esp0 - sizeof(struct pt_regs);
>  	stack += offset;
>  	*(unsigned long *) stack = data;
>  	return 0;
> @@ -114,7 +114,7 @@ static int putreg(struct task_struct *ch
>  	}
>  	if (regno > ES*4)
>  		regno -= 1*4;
> -	put_stack_long(child, regno - sizeof(struct pt_regs), value);
> +	put_stack_long(child, regno, value);
>  	return 0;
>  }
>  
> @@ -137,7 +137,6 @@ static unsigned long getreg(struct task_
>  		default:
>  			if (regno > ES*4)
>  				regno -= 1*4;
> -			regno = regno - sizeof(struct pt_regs);
>  			retval &= get_stack_long(child, regno);
>  	}
>  	return retval;
> _
> 
> 
