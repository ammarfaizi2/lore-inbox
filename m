Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261258AbUDPBss (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 21:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261322AbUDPBss
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 21:48:48 -0400
Received: from fw.osdl.org ([65.172.181.6]:64656 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261258AbUDPBsp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 21:48:45 -0400
Date: Thu, 15 Apr 2004 18:48:25 -0700
From: Andrew Morton <akpm@osdl.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: manfred@colorfullife.com, linux-kernel@vger.kernel.org
Subject: Re: message queue limits
Message-Id: <20040415184825.21e7499b.akpm@osdl.org>
In-Reply-To: <20040416001028.GA1373@logos.cnet>
References: <407A2DAC.3080802@redhat.com>
	<20040415145350.GF2085@logos.cnet>
	<20040415122411.0bcb9195.akpm@osdl.org>
	<20040415195430.GB3568@logos.cnet>
	<20040415214632.GA4402@logos.cnet>
	<20040415155408.0902a0c0.akpm@osdl.org>
	<20040416001028.GA1373@logos.cnet>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
>
> 
> Hi Andrew!
> 
> On Thu, Apr 15, 2004 at 03:54:08PM -0700, Andrew Morton wrote:
> > Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
> > >
> > > This adds a new "RLIMIT_SIGPENDING" limit, which is used to limit
> > > per-uid pending signals. Currently an unpriviledged user can queue 
> > > more than maximum of allowed signals and cause overall system 
> > > malfunction.
> > 
> > So now it takes two users to gang up and do the same thing.  
> 
> Decrease rlim_cur then. Usually people dont have several accounts 
> on the same box.

You underestimate the deviousness of university students.

> > We should either exempt root from the global check or simply remove the global > limit
> > altogether.
> 
> Then allow for unlimited pending signals? Are you sure?

I think so.  If

	(number of users * rlimit(RLIMIT_SIGPENDING) * sizeof(struct sigqueue))

is a significant proportion of available lowmem then someone screwed up.

Given that we're currently allowing 1024 sigqueues kernel-wide, it seems
reasonable to permit 128 per user, and infinity for root.  At 144 bytes
each, that's 17k of pinned memory per user.  No big deal.

In fact I'd be inclined to allow 1024 per user as a default, just to be
sure that existing installations will not break.  Think: a machine running
a single application which wants all 1024.

> > Is it possible for a process to do setuid() with outstanding signals?  If
> > so, they may end up with a negative current->user->signal_pending?
> 
> Nice catch, root can do that and I think current->user->signal_pending can get
> negative. Not completly sure though.

Me not sure either.  I've noticed that anything with "signal" in the
subject seems to cause kernel developers' "Reply" buttons to malfunction. 
Funny, that.

> > You need to initialise ->signal_pending in alloc_uid().
> 
> --- signal.c.orig	2004-04-15 20:44:17.458438104 -0300
> +++ signal.c	2004-04-15 20:45:36.850368696 -0300
> @@ -288,7 +288,8 @@
>  		return;
>  	kmem_cache_free(sigqueue_cachep, q);
>  	atomic_dec(&nr_queued_signals);
> -	atomic_dec(&current->user->signal_pending);
> +	if (atomic_read(&current->user->signal_pending) > 0)
> +		atomic_dec(&current->user->signal_pending);
>  }

hrm.  I guess that's OK.  It does mean that there's a window in which the
user won't be able to queue as many signals as he expected to, but he was
doing weird stuff anyway.

It needs a comment though.

> > What are you doing for testing of this?
> 
> Simple app posted by Nikita (attached) together with MySQL and 
> sql-bench for creating mysql threads.
> The setuid() was added by me now.

OK, but you haven't tested dropping the rlimit?

Hey, I just discovered something.  In both bash and zsh you can do

	ulimit 4 1024

and it sets RLIMIT_CORE for you.  How very sensible.
