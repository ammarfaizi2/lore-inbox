Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130443AbQKZVay>; Sun, 26 Nov 2000 16:30:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131399AbQKZVao>; Sun, 26 Nov 2000 16:30:44 -0500
Received: from mta5-win.server.ntli.net ([62.253.164.45]:32901 "EHLO
        mta5-svc.virgin.net") by vger.kernel.org with ESMTP
        id <S130443AbQKZVae>; Sun, 26 Nov 2000 16:30:34 -0500
Date: Sun, 26 Nov 2000 21:00:34 +0000
From: Mark Ellis <mark.uzumati@virgin.net>
To: Andrew Morton <andrewm@uow.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: OOPS on bringing down ppp
Message-ID: <20001126210034.A546@ElCapitan>
In-Reply-To: <20001124105539.A18945@ElCapitan> <3A1E5EFC.16E7625A@uow.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <3A1E5EFC.16E7625A@uow.edu.au>; from andrewm@uow.edu.au on Fri, Nov 24, 2000 at 12:28:44 +0000
X-Mailer: Balsa 1.0.pre5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Nope that didn't help. I'm using gcc 2.95.2, didn't think of it before
since it has never caused me any problems. I'll get around to trying
2.91.66 at some point.

A quick aside, anyone know of a problem with the list, I seem to be being
cut off at random intervals :)

Mark

On Fri, 24 Nov 2000 12:28:44 Andrew Morton wrote:
> Mark Ellis wrote:
> > 
> > Hi all, consistently getting the following when pppd is terminated.
> 
> When pppd downs the ppp0 device, unregister_netdevice() is
> trying to run /sbin/hotplug in a new kernel thread.  That
> thread's `files' structure is copied from pppd, but it is
> NULL.  Presumably pppd's files pointer was also NULL.
> 
> Try this:
> 
> --- linux-2.4.0-test11-ac2/kernel/kmod.c	Tue Nov 21 20:11:21 2000
> +++ linux-akpm/kernel/kmod.c	Fri Nov 24 23:03:34 2000
> @@ -99,8 +99,10 @@
>  	flush_signal_handlers(current);
>  	spin_unlock_irq(&current->sigmask_lock);
>  
> -	for (i = 0; i < current->files->max_fds; i++ ) {
> -		if (current->files->fd[i]) close(i);
> +	if (current->files) {
> +		for (i = 0; i < current->files->max_fds; i++ ) {
> +			if (current->files->fd[i]) close(i);
> +		}
>  	}
>  
>  	/* Drop the "current user" thing */
> 
> 
> Not my area, but I don't think exec_usermodehelper() should assume
> that current->files is always valid.
> 
> Al, is this correct?  If so, does daemonize() also need this test?
> If not, then how did this thread get (current->files == NULL)?
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
