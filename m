Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261723AbUEKJhP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261723AbUEKJhP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 05:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262648AbUEKJhP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 05:37:15 -0400
Received: from mx1.elte.hu ([157.181.1.137]:32668 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261723AbUEKJhM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 05:37:12 -0400
Date: Tue, 11 May 2004 11:39:13 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] fix init_idle() locking problem
Message-ID: <20040511093913.GA17185@elte.hu>
References: <200405101032.18508.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405101032.18508.bjorn.helgaas@hp.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:

> When starting up secondary CPUs, most architectures do something like
> this:
> 
> 	do_boot_cpu(int cpu)
> 	{
> 		idle = fork_by_hand();
> 		wake_up_forked_process(idle);
> 		init_idle(idle, cpu);
> 
> init_idle() removes "idle" from its runqueue, but there's a window
> between looking up the runqueue and locking it, where another CPU can
> move "idle" to a different runqueue, i.e., via load_balance().

the sched-domains patches that are now in BK solve this problem in a
cleaner way: the rule is that no cross-CPU balancing is allowed until
all CPUs have booted up.

This is enforced by having a boot-time sched-domains tree (initialized
very early on, prior setting up any IRQ sources, in sched_init()), that
isolates each and every CPU from each other - so load_balance() cannot
balance away an idle task. Once all CPUs have booted up the arch can
'cross-connect' all the CPUs and scheduling will begin for real.

this two-phase approach enabled us to reduce alot of the early-boot
scheduling nastiness.

[ btw., your patch does not seem to be correct anyway - if an online CPU
'steals' the new idle task then it will also most likely run it - and
that is disastrous for any CLONE_IDLETASK task. (e.g. on x86 the EIP has
random content, most likely crashing that CPU.) ]

the hotplug CPU code of course must be (and is) extra careful about
installing the new idle task.

	Ingo
