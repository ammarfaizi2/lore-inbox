Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265335AbSJXHkD>; Thu, 24 Oct 2002 03:40:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265336AbSJXHkD>; Thu, 24 Oct 2002 03:40:03 -0400
Received: from [202.88.156.6] ([202.88.156.6]:60848 "EHLO
	saraswati.hathway.com") by vger.kernel.org with ESMTP
	id <S265335AbSJXHkC>; Thu, 24 Oct 2002 03:40:02 -0400
Date: Thu, 24 Oct 2002 13:11:03 +0530
From: Dipankar Sarma <dipankar@gamebox.net>
To: Corey Minyard <cminyard@mvista.com>
Cc: linux-kernel@vger.kernel.org, John Levon <levon@movementarian.org>
Subject: Re: [PATCH] NMI request/release, version 4
Message-ID: <20021024131103.E27739@dikhow>
Reply-To: dipankar@gamebox.net
References: <20021022233853.B25716@dikhow> <3DB59923.9050002@mvista.com> <20021022190818.GA84745@compsoc.man.ac.uk> <3DB5C4F3.5030102@mvista.com> <20021023230327.A27020@dikhow> <3DB6E45F.5010402@mvista.com> <20021024002741.A27739@dikhow> <3DB7033C.1090807@mvista.com> <20021024022026.D27739@dikhow> <3DB71A5E.5010907@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DB71A5E.5010907@mvista.com>; from cminyard@mvista.com on Wed, Oct 23, 2002 at 04:53:34PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2002 at 04:53:34PM -0500, Corey Minyard wrote:
> >After local_irq_count() went away, the idle CPU check was broken
> >and that meant that if you had an idle CPU, it could hold up RCU
> >grace period completion.
> >
> Ah, much better.  That seems to fix it.

Great! Do you have any latency numbers ? Just curious.

> 
> >It might just be simpler to use completions instead -
> >
> >	call_rcu(&(handler->rcu), free_nmi_handler, handler);
> >	init_completion(&handler->completion);
> >	spin_unlock_irqrestore(&nmi_handler_lock, flags);
> >	wait_for_completion(&handler->completion);
> >
> >and do
> >
> >	complete(&handler->completion);
> >
> >in the  the RCU callback.
> >
> I was working under the assumption that the spinlocks were needed.  But 
> now I see that there are spinlocks in wait_for_completion.  You did get 
> init_completion() and call_rcu() backwards, they would need to be the 
> opposite order, I think.

AFAICS, the ordering of call_rcu() and init_completion should not matter
because the CPU that is executing them would not have gone
through a quiescent state and thus the RCU callback cannot happen.
Only after a context swtich in wait_for_completion(), the callback
is possible.


> 
> >Also, now I think your original idea of "Don't do this!" :) was right.
> >Waiting until an nmi handler is seen unlinked could make a task
> >block for a long time if another task re-installs it. You should
> >probably just fail installation of a busy handler (checked under
> >lock).
> >
> Since just about all of these will be in modules at unload time, I'm 
> thinking that the way it is now is better.  Otherwise, someone will mess 
> it up.  IMHO, it's much more likely that someone doesn't handle the 
> callback correctly than someone reused the value before the call that 
> releases it returns.  I'd prefer to leave it the way it is now.

Oh, I didn't mean the part about waiting in release_nmi() until
the release is complete (RCU callback done). That is absolutely
necessary. I was talking about looping until the handler is
not busy any more. I think it is safe to just do a wait_for_completion()
and return in release_nmi().

Thanks
Dipankar

