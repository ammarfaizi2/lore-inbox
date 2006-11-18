Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755261AbWKRWNS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755261AbWKRWNS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 17:13:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755268AbWKRWNS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 17:13:18 -0500
Received: from firewall.rowland.harvard.edu ([140.247.233.35]:9812 "HELO
	netrider.rowland.org") by vger.kernel.org with SMTP
	id S1755261AbWKRWNR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 17:13:17 -0500
Date: Sat, 18 Nov 2006 17:13:16 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Oleg Nesterov <oleg@tv-sign.ru>
cc: "Paul E. McKenney" <paulmck@us.ibm.com>,
       "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [patch] cpufreq: mark cpufreq_tsc() as core_initcall_sync
In-Reply-To: <20061118212542.GA235@oleg>
Message-ID: <Pine.LNX.4.44L0.0611181656230.23270-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Nov 2006, Oleg Nesterov wrote:

> On 11/18, Alan Stern wrote:
> >
> > By the way, I think the fastpath for synchronize_srcu() should be safe, 
> > now that you have added the memory barriers into srcu_read_lock() and 
> > srcu_read_unlock().  You might as well try putting it in.
> 
> I still think the fastpath should do mb() unconditionally to be correct.

Yes, it definitely should.

> > Although now that I look at it again, you have forgotten to put smp_mb()
> > after the atomic_inc() call and before the atomic_dec().
> 
> As I see it, currently we don't need this barrier because synchronize_srcu()
> does synchronize_sched() before reading ->hardluckref.
> 
> But if we add the fastpath into synchronize_srcu() then yes, we need mb()
> after atomic_inc().
> 
> Unless I totally confused :)

Put it this way: If the missing memory barrier in srcu_read_lock() after
the atomic_inc call isn't needed, then neither is the existing memory
barrier after the per-cpu counter gets incremented.  Likewise, if a memory
barrier isn't needed before the atomic_dec in srcu_read_unlock(), then
neither is the memory barrier before the per-cpu counter gets decremented.

What you're ignoring is the synchronize_sched() call at the end of
synchronize_srcu(), which has been replaced with smp_mb().  The smp_mb()
needs to pair against a memory barrier on the read side, and that memory
barrier has to occur after srcu_read_lock() has incremented the counter
and before the read-side critical section begins.  Otherwise code in the
critical section might leak out to before the counter is incremented.

Alan Stern

