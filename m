Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130300AbRBUAw0>; Tue, 20 Feb 2001 19:52:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131158AbRBUAwR>; Tue, 20 Feb 2001 19:52:17 -0500
Received: from mail1.mail.iol.ie ([194.125.2.192]:12552 "EHLO mail.iol.ie")
	by vger.kernel.org with ESMTP id <S130300AbRBUAwA>;
	Tue, 20 Feb 2001 19:52:00 -0500
Date: Wed, 21 Feb 2001 00:51:03 +0000
From: Kenn Humborg <kenn@linux.ie>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>,
        Philipp Rumpf <prumpf@mandrakesoft.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Andrew Morton <andrewm@uow.edu.au>
Subject: Re: kernel_thread() & thread starting
Message-ID: <20010221005103.A17420@excalibur.research.wombat.ie>
In-Reply-To: <20010218222416.D22176@excalibur.research.wombat.ie> <200102182253.f1IMrHp17404@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200102182253.f1IMrHp17404@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Sun, Feb 18, 2001 at 10:53:16PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 18, 2001 at 10:53:16PM +0000, Russell King wrote:
> Kenn Humborg writes:
> > When starting bdflush and kupdated, bdflush_init() uses a semaphore to
> > make sure that the threads have run before continuing.  Shouldn't
> > start_context_thread() do something similar?
> 
> I think this would be a good idea.  Here is a patch to try.  Please report
> back if it works so that it can be forwarded to Linus.  Thanks.

Works perfectly for me.  

I'll leave it up to you guys to decide what's the right way to deal with 
this and pass a patch to Linus/Alan.  Meanwhile, I'll keep Russell's 
patch below in our CVS tree.

Thanks,
Kenn

> --- orig/kernel/context.c	Tue Jan 30 13:31:11 2001
> +++ linux/kernel/context.c	Sun Feb 18 22:51:56 2001
> @@ -63,7 +63,7 @@
>  	return ret;
>  }
>  
> -static int context_thread(void *dummy)
> +static int context_thread(void *sem)
>  {
>  	struct task_struct *curtask = current;
>  	DECLARE_WAITQUEUE(wait, curtask);
> @@ -79,6 +79,8 @@
>  	recalc_sigpending(curtask);
>  	spin_unlock_irq(&curtask->sigmask_lock);
>  
> +	up((struct semaphore *)sem);
> +
>  	/* Install a handler so SIGCLD is delivered */
>  	sa.sa.sa_handler = SIG_IGN;
>  	sa.sa.sa_flags = 0;
> @@ -148,7 +150,9 @@
>  	
>  int start_context_thread(void)
>  {
> -	kernel_thread(context_thread, NULL, CLONE_FS | CLONE_FILES);
> +	DECLARE_MUTEX_LOCKED(sem);
> +	kernel_thread(context_thread, &sem, CLONE_FS | CLONE_FILES);
> +	down(&sem);
>  	return 0;
>  }
>  
> 
> 
> --
> Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
>              http://www.arm.linux.org.uk/personal/aboutme.html
