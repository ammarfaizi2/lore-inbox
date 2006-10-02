Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750910AbWJBIVJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750910AbWJBIVJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 04:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750927AbWJBIVJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 04:21:09 -0400
Received: from rs384.securehostserver.com ([72.22.69.69]:64004 "HELO
	rs384.securehostserver.com") by vger.kernel.org with SMTP
	id S1750923AbWJBIVF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 04:21:05 -0400
Subject: Re: [RFC][PATCH 0/2] Swap token re-tuned
From: Ashwin Chaugule <ashwin.chaugule@celunite.com>
Reply-To: ashwin.chaugule@celunite.com
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Rik van Riel <riel@redhat.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>
In-Reply-To: <20061001155608.0a464d4c.akpm@osdl.org>
References: <1159555312.2141.13.camel@localhost.localdomain>
	 <20061001155608.0a464d4c.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 02 Oct 2006 13:50:23 +0530
Message-Id: <1159777224.5559.33.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-10-01 at 15:56 -0700, Andrew Morton wrote:
> On Sat, 30 Sep 2006 00:11:51 +0530
> Ashwin Chaugule <ashwin.chaugule@celunite.com> wrote:
> 
> > 
> > Hi, 
> > Here's a brief up on the next two mails. 
> 
> When preparing patches, please give each one's email a different and
> meaningful Subject:, and try to put the description of the patch within the
> email which  contains that patch, thanks.

Yep, will remember that.


> > PATCH 2: 
> > 
> > Instead of using TIMEOUT as a parameter to transfer the token, I think a
> > better solution is to hand it over to a process that proves its
> > eligibilty. 
> > 
> > What my scheme does, is to find out how frequently a process is calling
> > these functions. The processes that call these more frequently get a
> > higher priority. 
> > The idea is to guarantee that a high priority process gets the token.
> > The priority of a process is determined by the number of consecutive
> > calls to swap-in and no-page. I mean "consecutive" not from the
> > scheduler point of view, but from the process point of view. In other
> > words, if the task called these functions every time it was scheduled,
> > it means it is not getting any further with its execution. 
> > 
> > This way, its a matter of simple comparison of task priorities, to
> > decide whether to transfer the token or not. 
> 
> Does this introduce the possibility of starvation?  Where the
> fast-allocating process hogs the system and everything else makes no
> progress?
> 
> 

A fast allocating process will start to increase its RSS and the
assumption is that such a process will finish its execution faster and
relinquish the token. Meanwhile, when such a process is allocating, the
other processes pages will be marked as "true LRU" pages and in the
event that they get swaped out, when those processes get scheduled,
their priorities will also be increased. So effectively, chances of
starvation are quite minimal. The key is to grant the token to the most
deserving process, so in other words, when a task tries to hog up the
system by allocations and swap-in's , some other process is getting
hampered and when the affected process gets scheduled, the algorithm
will make sure it gets the immunity from generating false LRU pages.
Also, when the fast allocating process stops its continuous allocation ,
or continues its allocation sporadically ie. ((global_faults -
current->mm->faultstamp) > FAULTSTAMP_DIFF) , its priority keeps getting
decremented too. 


> qsbench gives quite unstable results in my experience.  How stable is the
> above result (say, average across ten runs?)
> 

True. I did run the qsbench test several times, and the results were
always better off by atleast 10 seconds with my changes.

> It's quite easy to make changes in this area which speed qsbench up with
> one set of arguments, and which slow it down with a different set.  Did you
> try mixing the tests up a bit?

I ran another vmstress app, which spawns several other threads each
dedicated to either only malloc, or io only etc

Results:

Upstream:

time stress --cpu 2 --io 14 --vm 5 --vm-bytes 50M --timeout 10s --hdd 2
stress: info: [4331] dispatching hogs: 2 cpu, 14 io, 5 vm, 2 hdd
stress: info: [4331] successful run completed in 19s

real    0m19.358s 
user    0m9.850s
sys     0m0.210s


My changes:

time stress --cpu 2 --io 14 --vm 5 --vm-bytes 50M --timeout 10s --hdd 2
stress: info: [4498] dispatching hogs: 2 cpu, 14 io, 5 vm, 2 hdd
stress: info: [4498] successful run completed in 16s

real    0m16.813s
user    0m9.850s
sys     0m0.100s

Havent tested this enough to average out, but it did show improvements
everytime I ran it.

> 
> Also, qsbench isn't really a very good test for swap-intensive workloads -
> it's re-referencing and locality patterns seem fairly artificial.

True. In theory, my algo should give better results. The earlier TIMEOUT
was unfair to processes. In the pre-thrashing stages, it was detrimental
to processes badly in need of the token. Thus their execution didnt get
any futher, which is addressed here. I was hoping that people would have
some other intsrumentation tools for VM, I tried vmregress, but it didnt
build against 2.6.18, needs some mm api fixes.
> 
> Another workload which it would be useful to benchmark is a kernel compile
> - say, boot with `mem=16M' and time `make -j4 vmlinux' (numbers may need
> tuning).
> 
Will test this and post it up.

Thanks !
Ashwin

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

