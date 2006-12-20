Return-Path: <linux-kernel-owner+w=401wt.eu-S932757AbWLTUoG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932757AbWLTUoG (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 15:44:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932795AbWLTUoF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 15:44:05 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:31630 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932757AbWLTUoC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 15:44:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=tzNvTUJfo9D/XqPTKryMlmn+1V8+OZscT5whIPLTt49oVZ+tipJ8sEeQeVFc5CVfXQD+Bge4caN7Kj/sa7bmxrJNItLxWY58fEiNY7MnszjrgCB22S3Cgt0WOLgGR+30wMGkMs0LGggk9GAZa/bsPzJC9hWODpaMgJ+dAtPtEuk=
Date: Wed, 20 Dec 2006 20:42:26 +0000
From: Frederik Deweerdt <deweerdt@free.fr>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Morton <akpm@osdl.org>,
       "Andrew J. Barr" <andrew.james.barr@gmail.com>,
       linux-kernel@vger.kernel.org, Jan Beulich <jbeulich@novell.com>,
       Andi Kleen <ak@suse.de>, "Eric W. Biederman" <ebiederm@xmission.com>,
       walt <w41ter@gmail.com>
Subject: Re: [-mm patch] ptrace: Fix EFL_OFFSET value according to i386 pda changes (was Re: BUG on 2.6.20-rc1 when using gdb)
Message-ID: <20061220204226.GB28900@slug>
References: <1166406918.17143.5.camel@r51.oakcourt.dyndns.org> <20061219164214.4bc92d77.akpm@osdl.org> <45891CD1.4050506@goop.org> <20061220183521.GA28900@slug> <45898D4E.1030507@goop.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45898D4E.1030507@goop.org>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 20, 2006 at 11:21:50AM -0800, Jeremy Fitzhardinge wrote:
> Frederik Deweerdt wrote:
> > Same problems here with 2.6.20-rc1-mm1 (ie with the %gs->%fs patch).
> > It seems to me that the problem comes from the EFL_OFFSET no longer
> > beeing accurate.
> > The following patch fixes the problem for me.
> >   
> 
> Thanks Frederik; that's exactly the kind of thing I thought it might
> be.  I wonder if there's some way we can make this more robust
> though...  Does this work for you?  I did a slightly larger cleanup
> which should make it less fragile and more comprehensible.
> 
It works too, thanks. BTW, I wondered if the "case GS:" in getreg() made
sense now?

Frederik
>     J
> 
> diff -r e775f6e42258 arch/i386/kernel/ptrace.c
> --- a/arch/i386/kernel/ptrace.c	Tue Dec 19 10:32:40 2006 -0800
> +++ b/arch/i386/kernel/ptrace.c	Wed Dec 20 11:18:56 2006 -0800
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
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
