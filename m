Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264360AbUD2MTA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264360AbUD2MTA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 08:19:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264348AbUD2MRr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 08:17:47 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21677 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264332AbUD2MQa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 08:16:30 -0400
Date: Thu, 29 Apr 2004 09:17:39 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Chris Wright <chrisw@osdl.org>
Cc: Manfred Spraul <manfred@colorfullife.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Jakub Jelinek <jakub@redhat.com>
Subject: Re: [PATCH] per-user signal pending and message queue limits
Message-ID: <20040429121739.GB18352@logos.cnet>
References: <20040420141319.GB13259@logos.cnet> <20040420130439.23fae566.akpm@osdl.org> <20040420231351.GB13826@logos.cnet> <20040420163443.7347da48.akpm@osdl.org> <20040421203456.GC16891@logos.cnet> <40875944.4060405@colorfullife.com> <20040427145424.GA10530@logos.cnet> <408EA1DF.6050303@colorfullife.com> <20040428170932.GA14993@logos.cnet> <20040428183315.T22989@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040428183315.T22989@build.pdx.osdl.net>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2004 at 06:33:15PM -0700, Chris Wright wrote:
> * Marcelo Tosatti (marcelo.tosatti@cyclades.com) wrote:
> > This should be OK for inclusion into -mm now, if no other comment is made.
> 
> This patch doesn't account for sigqueue bits properly.  The allocations
> aren't always made in task context.  So, it's trivial to illegitimately
> drain off the new signal_pending counter, leaving the potential for the
> original DoS unfixed. 

How?

>  And the setuid issues still seem to be there,
> right?

The setuid issues are not there anymore in mqueue (because of find_user(info->creator_id) at 
mqueue_delete_inode() time. The issue is still present with signal accounting, but 
we have a "> 0" check for that. And usually only root/CAP_SET_SUID is able to hurt himself (get 
unaccountable values in its quota). I dont think this really matters yet. 
 
> Couple other nits below:
> 
> Some bits need to be converted to tabs from spaces.

Yeap, there are some places where the "MAX_USER_SIGNALS" "MAX_USER_MSGQUEUE" names
get too big in the RLIM_INIT resource.h definition. I'm bad at coming up with names. 
Any better suggestion for that (has to be smaller and meaningful). It means "maximum 
pending signals per user".

> Ditto.

Alright, needs to be fixed.

> > +++ linux-2.6.5/include/linux/signal.h	2004-04-27 08:32:46.000000000 -0300
> > @@ -7,6 +7,10 @@
> >  #include <asm/siginfo.h>
> >  
> >  #ifdef __KERNEL__
> > +
> > +#define MAX_QUEUED_SIGNALS	4096
> 
> Besides right below, is this really used anymore?
> 
> > +#define MAX_USER_SIGNALS	(MAX_QUEUED_SIGNALS/4)
> 
> here.

Not really. Can replace with MAX_USER_SIGNALS 1024...

> > diff -Nur --show-c-function a/linux-2.6.5/kernel/signal.c linux-2.6.5/kernel/signal.c
> > --- a/linux-2.6.5/kernel/signal.c	2004-04-27 09:53:24.000000000 -0300
> > +++ linux-2.6.5/kernel/signal.c	2004-04-27 11:05:08.000000000 -0300
> > @@ -31,8 +31,7 @@
> >  
> >  static kmem_cache_t *sigqueue_cachep;
> >  
> > -atomic_t nr_queued_signals;
> > -int max_queued_signals = 1024;
> > +int max_queued_signals = MAX_QUEUED_SIGNALS;
> 
> and here, but max_queued_signals is no longer really relevant, right?
> Should we removed both nr_queued_signals and max_queued_signals and the
> associated sysctl's?  Or leave it, and give CAP_SYS_RESOURCE the ability
> to do a full override?  I chose the latter, although I'm inclined to
> drop that bit.
> 
> >  static void flush_sigqueue(struct sigpending *queue)
> > @@ -700,11 +707,13 @@ static int send_signal(int sig, struct s
> >  	   make sure at least one signal gets delivered and don't
> >  	   pass on the info struct.  */
> >  
> > -	if (atomic_read(&nr_queued_signals) < max_queued_signals)
> > +	if (atomic_read(&current->user->signal_pending) <=
> 
> current may not be valid here.
> 
> I have a diff between your patch and what I'm testing, but it's
> cluttered a bit by the fact that I've also merged it up to 2.6.6-rc3
> I can send you the full patch if that's easier.

Please do so. Thanks!!
