Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932080AbWE2XJ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932080AbWE2XJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 19:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932083AbWE2XJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 19:09:28 -0400
Received: from mx1.redhat.com ([66.187.233.31]:10639 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932080AbWE2XJ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 19:09:28 -0400
Date: Mon, 29 May 2006 19:09:08 -0400
From: Dave Jones <davej@redhat.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 00/61] ANNOUNCE: lock validator -V1
Message-ID: <20060529230908.GC333@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Ingo Molnar <mingo@elte.hu>,
	Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
	linux-kernel@vger.kernel.org,
	Arjan van de Ven <arjan@infradead.org>,
	Andrew Morton <akpm@osdl.org>
References: <20060529212109.GA2058@elte.hu> <6bffcb0e0605291528qe24a0a3r3841c37c5323de6a@mail.gmail.com> <20060529224107.GA6037@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060529224107.GA6037@elte.hu>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2006 at 12:41:08AM +0200, Ingo Molnar wrote:

 > > =====================================================
 > > [ BUG: possible circular locking deadlock detected! ]
 > > -----------------------------------------------------
 > > modprobe/1942 is trying to acquire lock:
 > > (&anon_vma->lock){--..}, at: [<c10609cf>] anon_vma_link+0x1d/0xc9
 > > 
 > > but task is already holding lock:
 > > (&mm->mmap_sem/1){--..}, at: [<c101e5a0>] copy_process+0xbc6/0x1519
 > > 
 > > which lock already depends on the new lock,
 > > which could lead to circular deadlocks!
 > 
 > hm, this one could perhaps be a real bug. Dave: lockdep complains about 
 > having observed:
 > 
 > 	anon_vma->lock  =>   mm->mmap_sem
 > 	mm->mmap_sem    =>   anon_vma->lock
 > 
 > locking sequences, in the cpufreq code. Is there some special runtime 
 > behavior that still makes this safe, or is it a real bug?

I'm feeling a bit overwhelmed by the voluminous output of this checker.
Especially as (directly at least) cpufreq doesn't touch vma's, or mmap's.

The first stack trace it shows has us down in the bowels of cpu hotplug,
where we're taking the cpucontrol sem.  The second stack trace shows
us in cpufreq_update_policy taking a per-cpu data->lock semaphore.

Now, I notice this is modprobe triggering this, and this *looks* like
we're loading two modules simultaneously (the first trace is from a
scaling driver like powernow-k8 or the like, whilst the second trace
is from cpufreq-stats).  

How on earth did we get into this situation? module loading is supposed
to be serialised on the module_mutex no ?

It's been a while since a debug patch has sent me in search of paracetamol ;)

		Dave

-- 
http://www.codemonkey.org.uk
