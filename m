Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262356AbUFJSpQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262356AbUFJSpQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 14:45:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262370AbUFJSpP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 14:45:15 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:13074 "EHLO
	zircon.austin.ibm.com") by vger.kernel.org with ESMTP
	id S262356AbUFJSpH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 14:45:07 -0400
Subject: Re: [PATCH][RFC] Spinlock-timeout
From: Jake Moilanen <moilanen@austin.ibm.com>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040605205117.GD20632@lug-owl.de>
References: <1086467486.20906.59.camel@dhcp-client215.upt.austin.ibm.com>
	 <20040605205117.GD20632@lug-owl.de>
Content-Type: text/plain
Message-Id: <1086893091.3476.37.camel@dyn95394175.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 10 Jun 2004 13:44:52 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-06-05 at 15:51, Jan-Benedict Glaw wrote:
> On Sat, 2004-06-05 15:31:26 -0500, Jake Moilanen <moilanen@austin.ibm.com>
> wrote in message <1086467486.20906.59.camel@dhcp-client215.upt.austin.ibm.com>:
> > Here's a patch that will BUG() when a spinlock is held for longer then X
> > seconds.  It is useful for catching deadlocks since not all archs have a
> > NMI watchdog.  
> 
> I like the idea. However, I don't like touching all arch's Kconfig
> files. I think it's better to either put this into ./lib/Kconfig (well,
> doesn't really fit there), ot (even better:) put it into the Debug
> Kconfig file.
> 

I think you're right that lib/Kconfig would not be the right place, but
I don't think there is a debug Kconfig.  I tried keeping the Kconfig
additions w/ CONFIG_DEBUG_SPINLOCK.  The other option is to make a debug
Kconfig, but every arch seems pretty different in what they have for
their debug section.

> I'd say just include <linux/jiffies.h> and drop the whole #ifdef/#endif
> block.

You're right, I'll take this out.

> > @@ -218,11 +228,27 @@
> >  } while (0)
> >  
> >  #else
> > +#if defined(CONFIG_SPINLOCK_TIMEOUT)
> > +
> > +static inline void spin_lock(spinlock_t * lock) {
> > +	unsigned long jiffy_timeout = jiffies + (SPINLOCK_TIMEOUT * HZ); 
> > +
> > +	preempt_disable(); 
> > +	do { 
> > +		if (jiffies >= jiffy_timeout) 
> > +		        BUG();
> > +	} while (!_raw_spin_trylock(lock)); 
> > +}
> > +
> > +#else /* CONFIG_SPINLOCK_TIMEOUT */
> > +
> >  #define spin_lock(lock)	\
> >  do { \
> >  	preempt_disable(); \
> >  	_raw_spin_lock(lock); \
> >  } while(0)
> > +
> > +#endif /* CONFIG_SPINLOCK_TIMEOUT */
> >  
> >  #define write_lock(lock) \
> >  do { \
> 
> Also, printing out ->module, ->owner and ->oline might help additionally
> to just BUG()ing. So you see the (former) owner of the lock.

I think this would give us some extra info, but ->module, ->owner, and
->oline is only used for !SMP.  I could add that in for all the arch's
spinlock_t in their asm/spinlock.h.  I'm not sure how well that would be
received to increase the size of everyones spinlock_t even though it
would only be when CONFIG_DEBUG_SPINLOCK is on.

Thanks,
Jake

