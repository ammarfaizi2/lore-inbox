Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932510AbWDOWqF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932510AbWDOWqF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 18:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932512AbWDOWqF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 18:46:05 -0400
Received: from smtp.osdl.org ([65.172.181.4]:6322 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932510AbWDOWqD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 18:46:03 -0400
Date: Sat, 15 Apr 2006 15:45:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Martin J. Bligh" <mbligh@google.com>
Cc: linux-kernel@vger.kernel.org, apw@shadowen.org,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: Clear performance regression on reaim7 in 2.6.15-git6
Message-Id: <20060415154518.6a5a0c52.akpm@osdl.org>
In-Reply-To: <444173EE.4060602@google.com>
References: <4441452F.3060009@google.com>
	<20060415141744.042231a8.akpm@osdl.org>
	<44416616.10908@google.com>
	<20060415145227.5d1249bd.akpm@osdl.org>
	<444173EE.4060602@google.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@google.com> wrote:
>
> Andrew Morton wrote:
> > "Martin J. Bligh" <mbligh@google.com> wrote:
> > 
> >>drilling down into the results directories can get you the command line,
> >> looks like "reaim -f workfile.short -s 1 -e 10 -i 2" to me. Buggered if
> >> I can recall what that did though.
> >>
> >> (http://test.kernel.org/abat/20229/004.reaim.test/results/cmdline)
> >>
> >> I *think* it's only ia32 NUMA boxes, at least as far as I can see from
> >> a quick poke around. Which would make me guess at scheduler code. Gitweb
> >> would be nice to use, but it doesn't tag the -git snapshots, AFAICS, 
> >> which is a real shame. Nor does the git snapshot include the git tag,
> >> as far as I know. Grrrr. I guess I'll download the snapshots and diff
> >> them, and try to pull out the sched changes by hand. Much suckage.
> > 
> > 
> > The diffstat for 2.6.15-git5 -> 2.6.15-git6 is at
> > http://www.zip.com.au/~akpm/linux/patches/stuff/2 - only a single line
> > changed in sched.c:
> > 
> > diff -uNr 2.6.15-git5/kernel/sched.c 2.6.15-git6/kernel/sched.c
> > --- 2.6.15-git5/kernel/sched.c	2006-04-15 14:10:43.000000000 -0700
> > +++ 2.6.15-git6/kernel/sched.c	2006-04-15 14:10:52.000000000 -0700
> > @@ -4386,6 +4386,7 @@
> >  	} while_each_thread(g, p);
> >  
> >  	read_unlock(&tasklist_lock);
> > +	mutex_debug_show_all_locks();
> >  }
> 
> Hmm. whilst it's probably not that call, it does look like mutex 
> debugging. Look at the profiles from reaim between -git5 and -git6:
> 
> before:
> http://test.kernel.org/abat/20115/004.reaim.test/profiling/profile.text
> 
> after:
> http://test.kernel.org/abat/20229/004.reaim.test/profiling/profile.text
> 
>   1262 kfree                                      3.5056
>     820 mutex_lock_interruptible                 164.0000
>     752 __mutex_lock_slowpath                      0.8754
>      43 schedule                                   0.0284
>      35 _spin_lock                                 2.3333
>      25 debug_mutex_set_owner                      0.1613
>      23 debug_mutex_add_waiter                     0.1586

hm.

> /me hugs his huge stacks of data.
> 
> --------------------------------
> 
> config DEBUG_MUTEXES
>          bool "Mutex debugging, deadlock detection"
>          default y
>          depends on DEBUG_KERNEL
>          help
>           This allows mutex semantics violations and mutex related deadlocks
>           (lockups) to be detected and reported automatically.
> 
> --------------------------------
> 
> Hmmm. Who the hell thought defaulting that to 'y' was a good plan????

Ingo ;)

> It's still broken in 17-rc1 ... will send you a patch in a sec.

I already have kconfigdebug-set-debug_mutex-to-off-by-default.patch queued up.
