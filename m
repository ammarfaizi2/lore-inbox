Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261452AbUKIOOL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261452AbUKIOOL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 09:14:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261471AbUKIOOL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 09:14:11 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:34552 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261452AbUKIONx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 09:13:53 -0500
Date: Tue, 9 Nov 2004 20:01:18 +0530
From: Dinakar Guniguntala <dino@in.ibm.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Sripathi Kodi <sripathik@in.ibm.com>, linux-kernel@vger.kernel.org,
       Roland McGrath <roland@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] do_wait fix for 2.6.10-rc1
Message-ID: <20041109143118.GA8961@in.ibm.com>
Reply-To: dino@in.ibm.com
References: <418B4E86.4010709@in.ibm.com> <Pine.LNX.4.58.0411051101500.30457@ppc970.osdl.org> <418F826C.2060500@in.ibm.com> <Pine.LNX.4.58.0411080744320.24286@ppc970.osdl.org> <Pine.LNX.4.58.0411080806400.24286@ppc970.osdl.org> <Pine.LNX.4.58.0411080820110.24286@ppc970.osdl.org> <Pine.LNX.4.58.0411081708000.2301@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0411081708000.2301@ppc970.osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

All of your patches address the TASK_STOPPED case, whereas the current
problem that Sripathi reported does not have a task in the stopped state.
So the problem still remains.  Let me restate the problem


Thread A (PID 1)                Thread B (PID 1)        PID 2

                                   fork()
                                                        do something

   wait()                          wait()               exit()


   do_wait()                       do_wait()


   switch(p->state)              switch(p->state)
     -> default                    -> default
        (EXIT_ZOMBIE)                 (EXIT_ZOMBIE)


   wait_task_zombie()            wait_task_zombie()


   state = EXIT_DEAD
    (wins race)                     (loses race)
                                    return 0
    reap child

                                 since flag is set,
                              this thread will now hang



Hence the patches Sripathi sent which did fix the problem, but they end up 
busy looping because of schedule. The only clean solution seems to be to 
wake up the siblings if there are any in the case we reap a process from 
wait_task_zombie. What do you think?

Regards,

Dinakar


On Mon, Nov 08, 2004 at 05:09:59PM -0800, Linus Torvalds wrote:
> 
> 
> Ok, I haven't gotten any response on this one, but I'm running it in my 
> tree, and look as I might, it still seems right to me. It should fix not 
> only the problem Sripathi Kodi saw (can we verify that?), but also a more 
> fundamental problem with the access of stale memory.
> 
> I'll commit it. I would still prefer to have somebody else check out my 
> logic (or lack there-of).
> 
> 		Linus
> 
> On Mon, 8 Nov 2004, Linus Torvalds wrote:
> > 
> > Anyway, if I'm right, the suggested fix would be something like this (this 
> > replaces the earlier patches, since it also makes the zero return case go 
> > away - we don't need to mark anything runnable, since we restart the whole 
> > loop).
> > 
> > NOTE! -EAGAIN should be safe, because the other routines involved can only
> > return -EFAULT as an error, so this is all unique to the "try again"  
> > case.
> > 
> > Ok, three patches for the same piece of code withing minutes. Please tell 
> > me this one is not also broken..
> > 
> > 			Linus
> > 
> > ----
> > ===== kernel/exit.c 1.166 vs edited =====
> > --- 1.166/kernel/exit.c	2004-11-04 11:13:19 -08:00
> > +++ edited/kernel/exit.c	2004-11-08 08:34:37 -08:00
> > @@ -1201,8 +1201,15 @@
> >  		write_unlock_irq(&tasklist_lock);
> >  bail_ref:
> >  		put_task_struct(p);
> > -		read_lock(&tasklist_lock);
> > -		return 0;
> > +		/*
> > +		 * We are returning to the wait loop without having successfully
> > +		 * removed the process and having released the lock. We cannot
> > +		 * continue, since the "p" task pointer is potentially stale.
> > +		 *
> > +		 * Return -EAGAIN, and do_wait() will restart the loop from the
> > +		 * beginning. Do _not_ re-acquire the lock.
> > +		 */
> > +		return -EAGAIN;
> >  	}
> >  
> >  	/* move to end of parent's list to avoid starvation */
> > @@ -1343,6 +1350,8 @@
> >  							   (options & WNOWAIT),
> >  							   infop,
> >  							   stat_addr, ru);
> > +				if (retval == -EAGAIN)
> > +					goto repeat;
> >  				if (retval != 0) /* He released the lock.  */
> >  					goto end;
> >  				break;
> > 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
