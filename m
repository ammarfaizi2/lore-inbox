Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129812AbRAQXki>; Wed, 17 Jan 2001 18:40:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129830AbRAQXk1>; Wed, 17 Jan 2001 18:40:27 -0500
Received: from ns1.SuSE.com ([202.58.118.2]:62990 "HELO ns1.suse.com")
	by vger.kernel.org with SMTP id <S129812AbRAQXkU>;
	Wed, 17 Jan 2001 18:40:20 -0500
Date: Wed, 17 Jan 2001 15:40:26 -0800 (PST)
From: James Simmons <jsimmons@suse.com>
To: Andrew Morton <andrewm@uow.edu.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        FrameBuffer List <linux-fbdev@vuser.vu.union.edu>,
        Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: Re: console spin_lock
In-Reply-To: <3A65A2F1.690CD6CF@uow.edu.au>
Message-ID: <Pine.LNX.4.21.0101171514050.266-100000@euclid.oak.suse.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> heh.
> 
> I'm actually planning on grabbing console_lock and thoroughly strangling
> it

Ha Ha!!

> - Use a semaphore for serialisation.

I think this would be the best solution as well.

> - For printk in interrupt context, grab the
>   semaphore (yes, you can do this).

Don't forget about the idle task also. How is this done? By reintializing
the semaphore.

> - If it couldn't be acquired from interrupt context,
>   buffer the text in the log buffer and return.  The text will be
>   printed by whoever holds the semaphore before they
>   drop it.

By you saying couldn't be acquired from interrupt context do you mean
from a process context or do you mean it failed to aquire it while in 
the interrupt context?

> - Special "system booting" mode which bypasses all this
>   stuff.

This wouldn't be to hard to do for VTs using the fact that keybaords 
are not initialized right away. As for serial consoles well that is
another story. Of course we could have this flag set/cleared in
start_kernel. 

> - Special "oops in progress" mode which just
>   punches through everything.

You already developed the framework for this.

> - Get rid of the special printk buffer - share the
>   log buffer.  (Implies writes to console
>   devices will be broken into two writes when they
>   wrap around).
> - Teach vsprintf to print into a circular buffer
>   (snprintf thus comes for free).

> - Get rid of all the printk deadlock opportunities (fourth
>   attempt).

Good luck.

> - Get rid of console_tasklet.  Do it in process context callback
>   or just do it synchronously.

What about multidesktop systems? I have vgacon and mdacon working fine 
along each other. Each one has their own tasklet to allow them to work
independent of each other. Meaning no race condition when both VC switch
at the same time.  
 
> Assumption:
> - Once the system is up and running, it's always safe to
>   call down() when in_interrupt() returns false - probably
>   not the case in parts of the exit path - tough.

Don't forget the idle_task case as well. exit path?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
