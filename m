Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031369AbWK3UYs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031369AbWK3UYs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 15:24:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031375AbWK3UYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 15:24:48 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:7598 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1031369AbWK3UYr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 15:24:47 -0500
Date: Thu, 30 Nov 2006 21:24:11 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Gautham R Shenoy <ego@in.ibm.com>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, davej@redhat.com, dipankar@in.ibm.com,
       vatsa@in.ibm.com
Subject: Re: CPUFREQ-CPUHOTPLUG: Possible circular locking dependency
Message-ID: <20061130202411.GC14696@elte.hu>
References: <20061129152404.GA7082@in.ibm.com> <20061130083144.GC29609@elte.hu> <20061130102410.GB23354@in.ibm.com> <20061130110315.GA30460@elte.hu> <20061130031933.5d30ec09.akpm@osdl.org> <20061130114617.GA2324@elte.hu> <20061130114009.ed473fc0.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061130114009.ed473fc0.akpm@osdl.org>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -4.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-4.5 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	1.4 AWL                    AWL: From: address is in the auto white-list
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> > Even with complex inter-subsystem interactions, hotplugging could be 
> > effectively and scalably controlled via a self-recursive per-CPU 
> > mutex, and a pointer to it embedded in task_struct:

> So what I would propose is that rather than going ahead and piling 
> more complexity on top of the existing poo-pile in an attempt to make 
> it seem to work, we should simply rip all the cpu-hotplug locking out 
> of cpufreq (there's a davej patch for that in -mm) and then just redo 
> it all in an organised fashion.

actually, that's precisely what i'm suggesting too, i wrote it to 
Gautham in one of the previous mails:

|| that would flatten the whole locking. Only one kind of lock taken, 
|| recursive and scalable.
||
|| Then the mechanism that changes CPU frequency should take all these 
|| hotplug locks on all (online) CPUs, and then first stop all 
|| processing on all CPUs, and then do the frequency change, atomically. 
|| This is with interrupts disabled everywhere /first/, and /without any 
|| additional locking/. That would prevent any sort of interaction from 
|| other CPUs - they'd all be sitting still with interrupts disabled.

no other locking, only the CPU hotplug lock and the (existing) ability 
to 'do stuff' with nothing else running on any other CPU.

	Ingo
