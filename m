Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261173AbVA1L5S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261173AbVA1L5S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 06:57:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261297AbVA1L5S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 06:57:18 -0500
Received: from holomorphy.com ([66.93.40.71]:10209 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261173AbVA1L5N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 06:57:13 -0500
Date: Fri, 28 Jan 2005 03:56:40 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Esben Nielsen <simlo@phys.au.dk>, Rui Nuno Capela <rncbc@rncbc.org>,
       "K.R. Foley" <kr@cybsft.com>,
       Fernando Lopez-Lezcano <nando@ccrma.stanford.edu>,
       mark_h_johnson@raytheon.com, Amit Shah <amit.shah@codito.com>,
       Karsten Wiese <annabellesgarden@yahoo.de>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, emann@mrv.com,
       Gunther Persoons <gunther_persoons@spymac.com>,
       linux-kernel@vger.kernel.org, Florian Schmidt <mista.tapas@gmx.net>,
       Lee Revell <rlrevell@joe-job.com>, Shane Shrybman <shrybman@aei.ca>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Subject: Re: Real-time rw-locks (Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-15)
Message-ID: <20050128115640.GP10843@holomorphy.com>
References: <20041214113519.GA21790@elte.hu> <Pine.OSF.4.05.10412271404440.25730-100000@da410.ifa.au.dk> <20050128073856.GA2186@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050128073856.GA2186@elte.hu>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Esben Nielsen <simlo@phys.au.dk> wrote:
>> [...] I wanted to start looking at fixing that because it ought to
>> hurt scalability quite a bit - and even on UP create a few unneeded
>> task-switchs. [...]

On Fri, Jan 28, 2005 at 08:38:56AM +0100, Ingo Molnar wrote:
> no, it's not a big scalability problem. rwlocks are really a mistake -
> if you want scalability and spinlocks/semaphores are not enough then one
> should either use per-CPU locks or lockless structures. rwlocks/rwsems
> will very unlikely help much.

I wouldn't be so sure about that. SGI is already implicitly relying on
the parallel holding of rwsems for the lockless pagefaulting, and
Oracle has been pushing on mapping->tree_lock becoming an rwlock for a
while, both for large performance gains.


* Esben Nielsen <simlo@phys.au.dk> wrote:
>> However, the more I think about it the bigger the problem:

On Fri, Jan 28, 2005 at 08:38:56AM +0100, Ingo Molnar wrote:
> yes, that complexity to get it perform in a deterministic manner is why
> i introduced this (major!) simplification of locking. It turns out that
> most of the time the actual use of rwlocks matches this simplified
> 'owner-recursive exclusive lock' semantics, so we are lucky.
> look at what kind of worst-case scenarios there may already be with
> multiple spinlocks (blocker.c). With rwlocks that just gets insane.

tasklist_lock is one large exception; it's meant for concurrency there,
and it even gets sufficient concurrency to starve the write side.

Try test_remap.c on mainline vs. -mm to get a microbenchmark-level
notion of the importance of mapping->tree_lock being an rwlock (IIRC
you were cc:'d in at least some of those threads).

net/ has numerous rwlocks, which appear to frequently be associated
with hashtables, and at least some have some relevance to performance.

Are you suggesting that lockless alternatives to mapping->tree_lock,
mm->mmap_sem, and tasklist_lock should be pursued now?


-- wli
