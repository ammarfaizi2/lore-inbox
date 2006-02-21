Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932549AbWBUSjq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932549AbWBUSjq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 13:39:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932581AbWBUSjq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 13:39:46 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:9107 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932549AbWBUSjp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 13:39:45 -0500
Date: Tue, 21 Feb 2006 10:40:17 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] introduce sig_needs_tasklist() helper
Message-ID: <20060221184017.GD1295@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <43F76374.EDA3ED9D@tv-sign.ru> <20060221021302.GR1480@us.ibm.com> <43FB5B15.F88FF5A8@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43FB5B15.F88FF5A8@tv-sign.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2006 at 09:25:25PM +0300, Oleg Nesterov wrote:
> "Paul E. McKenney" wrote:
> > 
> > On Sat, Feb 18, 2006 at 09:12:04PM +0300, Oleg Nesterov wrote:
> > > +#define sig_needs_tasklist(sig) \
> > > +             (((sig) < SIGRTMIN)  && T(sig, SIG_KERNEL_STOP_MASK | M(SIGCONT)))
> > > +
> > 
> > Seems to me to be an improvement, but why not also encapsulate the
> > lock acquisition, something like:
> > 
> >         static inline int sig_tasklist_lock(int sig)
> >         {
> >                 if (unlikely(sig_needs_tasklist(sig)) {
> >                         read_lock(&tasklist_lock);
> >                         return 1;
> >                 }
> >                 return 0;
> >         }
> > 
> >         static inline void sig_tasklist_unlock(int acquired_tasklist_lock)
> >         {
> >                 if (acquired_tasklist_lock)
> >                         read_unlock(&tasklist_lock);
> >         }
> 
> I hope we will have
> 
> 	#define sig_needs_tasklist(sig)	  (sig == SIGCONT)
> 
> really soon (I planned to submit the final bits today, but
> for some stupid reasons I can't do anything till weekend),
> so I think it's better to kill 'acquired_tasklist_lock' and
> just do:
> 
> 	void sig_tasklist_lock(sig)
> 	{
> 		if (sig_needs_tasklist(sig))
> 			read_lock(&tasklist_lock);
> 	}
> 
> 	void sig_tasklist_unlock(sig)
> 	{
> 		if (sig_needs_tasklist(sig));
> 			read_unlock(&tasklist_lock);
> 	}

Even better!

						Thanx, Paul
