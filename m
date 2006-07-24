Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932187AbWGXRfw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932187AbWGXRfw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 13:35:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932231AbWGXRfw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 13:35:52 -0400
Received: from adsl-69-232-92-238.dsl.sndg02.pacbell.net ([69.232.92.238]:4821
	"EHLO gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id S932187AbWGXRfv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 13:35:51 -0400
Date: Mon, 24 Jul 2006 10:35:43 -0700
To: Esben Nielsen <nielsen.esben@googlemail.com>
Cc: Mathieu Desnoyers <compudj@krystal.dyndns.org>,
       "Paul E. McKenney" <pmckenne@us.ibm.com>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: NMI reentrant RCU list for -rt kernels
Message-ID: <20060724173543.GB5395@gnuppy.monkey.org>
References: <20060722152933.GA17148@Krystal> <Pine.LNX.4.64.0607221837420.11861@localhost.localdomain> <20060724172420.GA5395@gnuppy.monkey.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060724172420.GA5395@gnuppy.monkey.org>
User-Agent: Mutt/1.5.11+cvs20060403
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2006 at 10:24:20AM -0700, Bill Huey wrote:
> On Sat, Jul 22, 2006 at 07:14:22PM +0100, Esben Nielsen wrote:
> > On Sat, 22 Jul 2006, Mathieu Desnoyers wrote:

[discussion about making preemptible RCU both safe and fast for use in
NMI]

> > I remember once discussing RCU on the list. I came up with the idea 
> > rcu_read_lock()/unlock() to be implemented as a per-task counter just as
> > preempt_disable()/disable(). The run-queue then has a sum of all the 
> > counters of tasks on that cpu (minus the counter for the current task).
> > I even made some sample code...
> > The only reason this wasn't considered working was the migration from CPU 
> > to CPU. I frankly can't see why this couldn't be fixed.

Forgot to mention that after talking to Paul that one of his ideas for
NMI safe preemptible RCU was very close to what preemption threshold (threadX
RTOS) and that if he was going to go that route that he should think about if
he should generalize it for the scheduler.

> > So the answer to you is: No. Fix the preemptible RCU instead. You have an 
> > idea above.
> 
> Hello,
> 
> For Mathieu's uses, it's critical to have a short a path as possible in his
> instrumentation code since the results can be effected by it as well as general
> impact on the kernel.
> 
> The reason why the old RCU read-side logic is ok is that in the -rt kernel RCU
> is use to protect things like dcache_lock and other large kernel subsystems. A
> non-preemptible RCU would otherwise make all locks in the file system with a
> RCU critical section above it in the lock graph non-preemptible or else it
> violates the locking rules resulting in dead locking. Since Mathieu's NMI code
> doesn't take other kernel locks outside of his own code, it won't create a
> situation where it forces parts of the -rt system back below an RCU read-side
> section to be non-preemptible.
> 
> A preempt_disable/enable should be good enough to restore the previous RCU
> behavior just for Mathieu's NMI code with maybe a different function for RCU
> synchronization. Making RCU safe for NMI isn't really necessary, but I'm sure
> it won't stop you (Paul) from trying. :)

bill

