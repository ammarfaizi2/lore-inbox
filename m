Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932233AbWGXRYh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932233AbWGXRYh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 13:24:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbWGXRYh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 13:24:37 -0400
Received: from adsl-69-232-92-238.dsl.sndg02.pacbell.net ([69.232.92.238]:1720
	"EHLO gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id S932233AbWGXRYg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 13:24:36 -0400
Date: Mon, 24 Jul 2006 10:24:20 -0700
To: Esben Nielsen <nielsen.esben@googlemail.com>
Cc: Mathieu Desnoyers <compudj@krystal.dyndns.org>,
       "Paul E. McKenney" <pmckenne@us.ibm.com>, linux-kernel@vger.kernel.org,
       "Bill Huey (hui)" <billh@gnuppy.monkey.org>
Subject: Re: NMI reentrant RCU list for -rt kernels
Message-ID: <20060724172420.GA5395@gnuppy.monkey.org>
References: <20060722152933.GA17148@Krystal> <Pine.LNX.4.64.0607221837420.11861@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0607221837420.11861@localhost.localdomain>
User-Agent: Mutt/1.5.11+cvs20060403
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 22, 2006 at 07:14:22PM +0100, Esben Nielsen wrote:
> On Sat, 22 Jul 2006, Mathieu Desnoyers wrote:
> >So, basically, the idea is to have two RCU API that could take names like :
> >atomic_rcu_* and rcu_*
> >
> >Does this idea make sense ?
> 
> No,
> 
> 1) Can you readily identify the very short code pathes? What about future 
> code added to the kernel?
> 2) Having two parellel systems is a bad idea.
> 3) I believe RCU can be made much cheaper than the 
> current implementation which look horrible.
> 
> I remember once discussing RCU on the list. I came up with the idea 
> rcu_read_lock()/unlock() to be implemented as a per-task counter just as
> preempt_disable()/disable(). The run-queue then has a sum of all the 
> counters of tasks on that cpu (minus the counter for the current task).
> I even made some sample code...
> The only reason this wasn't considered working was the migration from CPU 
> to CPU. I frankly can't see why this couldn't be fixed.
> 
> So the answer to you is: No. Fix the preemptible RCU instead. You have an 
> idea above.

Hello,

For Mathieu's uses, it's critical to have a short a path as possible in his
instrumentation code since the results can be effected by it as well as general
impact on the kernel.

The reason why the old RCU read-side logic is ok is that in the -rt kernel RCU
is use to protect things like dcache_lock and other large kernel subsystems. A
non-preemptible RCU would otherwise make all locks in the file system with a
RCU critical section above it in the lock graph non-preemptible or else it
violates the locking rules resulting in dead locking. Since Mathieu's NMI code
doesn't take other kernel locks outside of his own code, it won't create a
situation where it forces parts of the -rt system back below an RCU read-side
section to be non-preemptible.

A preempt_disable/enable should be good enough to restore the previous RCU
behavior just for Mathieu's NMI code with maybe a different function for RCU
synchronization. Making RCU safe for NMI isn't really necessary, but I'm sure
it won't stop you (Paul) from trying. :)

bill

