Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314050AbSDSB2A>; Thu, 18 Apr 2002 21:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314205AbSDSB17>; Thu, 18 Apr 2002 21:27:59 -0400
Received: from web14305.mail.yahoo.com ([216.136.173.81]:60167 "HELO
	web14305.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S314050AbSDSB16>; Thu, 18 Apr 2002 21:27:58 -0400
Message-ID: <20020419012757.24839.qmail@web14305.mail.yahoo.com>
Date: Thu, 18 Apr 2002 18:27:57 -0700 (PDT)
From: Kanoj Sarcar <kanojsarcar@yahoo.com>
Subject: Re: bug in fork failure path?
To: Colin Gibbs <colin@gibbs.dhs.org>, linux-kernel@vger.kernel.org
Cc: sparclinux@vger.kernel.org
In-Reply-To: <1019178622.25887.630.camel@monolith>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Colin Gibbs <colin@gibbs.dhs.org> wrote:
> Hi, 
> 
> I came across this bug hacking on sparc32. If fork
> fails in copy_mm ->
> dup_mmap, destroy_context is called on the new mm
> before
> init_new_context. 

Yes, this definitely sounds like a bug. I added the
init_new_context() call for mips64 in 2.3. With the
way the current code is, I belive even mips64 has
a problem.

Kanoj

> 
> fork.c:330 
> 	retval = -ENOMEM; 
> 	mm = allocate_mm(); 
> 	if (!mm) 
> 		goto fail_nomem; 
> 
> 	/* Copy the current MM stuff.. */ 
> 	memcpy(mm, oldmm, sizeof(*mm)); 
> 	if (!mm_init(mm)) 
> 		goto fail_nomem; 
> 
> Failure is ok here. We don't try to do an mmput, but
> we have memcpy'd
> the mm struct context and all. 
> 
> 	down_write(&oldmm->mmap_sem); 
> 	retval = dup_mmap(mm); 
> 	up_write(&oldmm->mmap_sem); 
> 
> 	if (retval) 
> 		goto free_pt; 
> 
> If we fail and call mmput, destroy_context gets
> called before
> init_new_context below. This removes the parent
> process's context since
> it was just memcpy'd from the parent's mm struct. 
> 
> 	/* 
> 	 * child gets a private LDT (if there was an LDT in
> the parent) 
> 	 */ 
> 	copy_segments(tsk, mm); 
> 
> 	if (init_new_context(tsk,mm)) 
> 		goto free_pt; 
> 
> Can we move the init_new_context to just after the
> mm_init call? Works
> nicely on sparc. Most archs have a fairly trivial
> init_new_context
> anyway. 
> 
> Colin 
> 
> --- 2.4.19-pre4/kernel/fork.c	Thu Mar 28 19:49:36
> 2002
> +++ tortoise-19-pre4/kernel/fork.c	Wed Apr 17
> 23:26:20 2002
> @@ -336,6 +336,9 @@
>  	if (!mm_init(mm))
>  		goto fail_nomem;
>  
> +	if (init_new_context(tsk,mm))
> +		goto free_pt;
> +
>  	down_write(&oldmm->mmap_sem);
>  	retval = dup_mmap(mm);
>  	up_write(&oldmm->mmap_sem);
> @@ -347,9 +350,6 @@
>  	 * child gets a private LDT (if there was an LDT
> in the parent)
>  	 */
>  	copy_segments(tsk, mm);
> -
> -	if (init_new_context(tsk,mm))
> -		goto free_pt;
>  
>  good_mm:
>  	tsk->mm = mm;
> 
> -
> To unsubscribe from this list: send the line
> "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
http://vger.kernel.org/majordomo-info.html


__________________________________________________
Do You Yahoo!?
Yahoo! Tax Center - online filing with TurboTax
http://taxes.yahoo.com/
