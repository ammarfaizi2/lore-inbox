Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263177AbUDPNge (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 09:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263174AbUDPNgZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 09:36:25 -0400
Received: from mail.cyclades.com ([64.186.161.6]:49360 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S263165AbUDPNgF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 09:36:05 -0400
Date: Fri, 16 Apr 2004 10:13:34 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Andrew Morton <akpm@osdl.org>
Cc: manfred@colorfullife.com, linux-kernel@vger.kernel.org
Subject: Re: message queue limits
Message-ID: <20040416131334.GA1485@logos.cnet>
References: <407A2DAC.3080802@redhat.com> <20040415145350.GF2085@logos.cnet> <20040415122411.0bcb9195.akpm@osdl.org> <20040415195430.GB3568@logos.cnet> <20040415214632.GA4402@logos.cnet> <20040415155408.0902a0c0.akpm@osdl.org> <20040416001028.GA1373@logos.cnet> <20040415184825.21e7499b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline
In-Reply-To: <20040415184825.21e7499b.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1i
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


On Thu, Apr 15, 2004 at 06:48:25PM -0700, Andrew Morton wrote:
> > On Thu, Apr 15, 2004 at 03:54:08PM -0700, Andrew Morton wrote:
> > > Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
> > > >
> > > > This adds a new "RLIMIT_SIGPENDING" limit, which is used to limit
> > > > per-uid pending signals. Currently an unpriviledged user can queue 
> > > > more than maximum of allowed signals and cause overall system 
> > > > malfunction.
> > > 
> > > So now it takes two users to gang up and do the same thing.  
> > 
> > Decrease rlim_cur then. Usually people dont have several accounts 
> > on the same box.
> 
> You underestimate the deviousness of university students.
> 
> > > We should either exempt root from the global check or simply remove the global > limit
> > > altogether.
> > 
> > Then allow for unlimited pending signals? Are you sure?
> 
> I think so.  If
> 
> 	(number of users * rlimit(RLIMIT_SIGPENDING) * sizeof(struct sigqueue))
> 
> is a significant proportion of available lowmem then someone screwed up.
> 
> Given that we're currently allowing 1024 sigqueues kernel-wide, it seems
> reasonable to permit 128 per user, and infinity for root.  At 144 bytes
> each, that's 17k of pinned memory per user.  No big deal.

I'm not sure about "infinity" for root. That allows bad behaving apps (I know, very 
odd, but still) to exhaust system memory. I know, you can screwup as root anyway, but...

My personal preference is to keep a global limit (can be much higher than the  
per-user, like 131072). 

Are you sure about the removal of global limit ?

> In fact I'd be inclined to allow 1024 per user as a default, just to be
> sure that existing installations will not break.  Think: a machine running
> a single application which wants all 1024.

Indeed, 1024 is the default right now and we should keep it like that.

> > > Is it possible for a process to do setuid() with outstanding signals?  If
> > > so, they may end up with a negative current->user->signal_pending?
> > 
> > Nice catch, root can do that and I think current->user->signal_pending can get
> > negative. Not completly sure though.
> 
> Me not sure either.  I've noticed that anything with "signal" in the
> subject seems to cause kernel developers' "Reply" buttons to malfunction. 
> Funny, that.

Hehe.

> > > You need to initialise ->signal_pending in alloc_uid().
> > 
> > --- signal.c.orig	2004-04-15 20:44:17.458438104 -0300
> > +++ signal.c	2004-04-15 20:45:36.850368696 -0300
> > @@ -288,7 +288,8 @@
> >  		return;
> >  	kmem_cache_free(sigqueue_cachep, q);
> >  	atomic_dec(&nr_queued_signals);
> > -	atomic_dec(&current->user->signal_pending);
> > +	if (atomic_read(&current->user->signal_pending) > 0)
> > +		atomic_dec(&current->user->signal_pending);
> >  }
> 
> hrm.  I guess that's OK.  It does mean that there's a window in which the
> user won't be able to queue as many signals as he expected to, but he was
> doing weird stuff anyway.
> 
> It needs a comment though.

Now after a while I think that transferring the pending count 
at switch_uid() to the new "user_struct" may make sense. This way
we can remove the "if(atomic_read(&current->user->signal_pending)" 
in __free_sigqueue. Two options:

- setuid/friends can fail if the transferred pending signals plus
the current pending signals for the new user is higher than
rlimit[SIGPENDING]

- copy the pending signal count to the new user_struct->signal_pending
without checking for limits (so the signal_pending for this new 
user will be higher than the rlimit[SIGPENDING] and new sigqueue 
allocations will fail.

But maybe thats just "too much care" about this rare 
"setuid() with signal pending" case?

What you think?

> > > What are you doing for testing of this?
> > 
> > Simple app posted by Nikita (attached) together with MySQL and 
> > sql-bench for creating mysql threads.
> > The setuid() was added by me now.
> 
> OK, but you haven't tested dropping the rlimit?

I did now, it works. Look at the attached test program.

> Hey, I just discovered something.  In both bash and zsh you can do
> 
> 	ulimit 4 1024
> 
> and it sets RLIMIT_CORE for you.  How very sensible.

Not here: 

[root@yage root]# ulimit -a
core file size        (blocks, -c) 0
data seg size         (kbytes, -d) unlimited
file size             (blocks, -f) unlimited
max locked memory     (kbytes, -l) unlimited
max memory size       (kbytes, -m) unlimited
<snip>
[root@yage root]# ulimit 4 1024
[root@yage root]# ulimit -a
core file size        (blocks, -c) 0
data seg size         (kbytes, -d) unlimited
file size             (blocks, -f) 4
max locked memory     (kbytes, -l) unlimited
max memory size       (kbytes, -m) unlimited

It sets file size to 4:

GNU bash, version 2.05b.0(1)-release (i686-pc-linux-gnu)

Ah, the "files" member of struct user is unused. What is going on?


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="getrlimit.c"

#include <sys/time.h>
#include <sys/resource.h>
#include <unistd.h>

#define RLIMIT_SIGPENDING 11

void main() {
	struct rlimit rlim;

	if(getrlimit(RLIMIT_SIGPENDING, &rlim)) {
		perror();
	}

	rlim.rlim_cur = 128;

	setrlimit(RLIMIT_SIGPENDING, &rlim);

	printf("cur: %d\n", rlim.rlim_cur);
	printf("max: %d\n", rlim.rlim_max);

	execve("signal", NULL, NULL);

}


--mYCpIKhGyMATD0i+--
