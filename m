Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268199AbUJJIpN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268199AbUJJIpN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 04:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268203AbUJJIpN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 04:45:13 -0400
Received: from mx2.elte.hu ([157.181.151.9]:7828 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S268199AbUJJIpE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 04:45:04 -0400
Date: Sun, 10 Oct 2004 10:46:33 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Sven-Thorsten Dietrich <sdietrich@mvista.com>
Cc: linux-kernel@vger.kernel.org,
       Alexander Batyrshin <abatyrshin@ru.mvista.com>,
       "Amakarov@Ru. Mvista. Com" <amakarov@ru.mvista.com>,
       Daniel Walker <dwalker@mvista.com>,
       "Eugeny S. Mints" <emints@ru.mvista.com>,
       "Ext-Rt-Dev@Mvista. Com" <ext-rt-dev@mvista.com>,
       New Zhang Haitao <hzhang@ch.mvista.com>,
       "Yyang@Ch. Mvista. Com" <yyang@ch.mvista.com>
Subject: Re: [ANNOUNCE] Linux 2.6 Real Time Kernel
Message-ID: <20041010084633.GA13391@elte.hu>
References: <41677E4D.1030403@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41677E4D.1030403@mvista.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Sven-Thorsten Dietrich <sdietrich@mvista.com> wrote:

> Announcing the availability of prototype real-time (RT)
> enhancements to the Linux 2.6 kernel.
> 
> We will submit 3 additional emails following this one, containing
> the remaining 3 patches (of 4) inline, with their descriptions.

cool! Basically the biggest problem is not the technology itself, but
its proper integration into Linux. As it can be seen from the 2.4 RT
patches (TimeSys and yours), just walking the path towards a fully
preemptible kernel is not fruitful because it generates lots of huge,
intrusive patches that end up being unmaintainable forks of the Linux
tree.

the other approach is what i'm currently doing with the
voluntary-preempt patchset: to improve the generic kernel for latency
purposes without actually adding too many extra features. Here is what
is happening in the -mm tree right now:

 - the generic irq subsystem: irq threading is a simple ~200-lines,
   architecture-independent add-on to this. It makes no sense to offer 3
   different implementations - pick one and help make it work well.

 - preemptible BKL. Related to this is new debugging infrastructure in
   -mm that allows the safe and slow conversion of spinlocks to mutexes. 
   In the case of the BKL this conversion is expected to be permanent, 
   for most of the other spinlocks it will be optional - but the 
   debugging code can still be used.

 - various fixes and latency improvements. A mutex based kernel is of
   little use if the only code you can execute reliably is user-space
   code and the moment you hit kernel-space your RT app is exposed to
   high latencies.

A couple of suggestions wrt. how to speed up the integration effort: you
might want to rebase this stuff to the -mm tree. Also, what i dont see
in your (and others') patches (yet?) is some of the harder stuff:

 - the handling of per-CPU data structures (get_cpu_var())

 - RCU and softirq data structures

 - the handling of the IRQ flag

These are basic correctness issues that affect UP just as much as SMP.
Without these the kernel is still not a "fully preemptible" kernel. 
These need infrastructure changes too, so they must preceed any addition
of a spinlock -> mutex conversion feature.

So the mutex patch will probably the one that can go upstream _last_,
which will do the "final step" of making the kernel fully preemptible.

	Ingo
