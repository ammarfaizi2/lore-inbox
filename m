Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264918AbUFAUox@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264918AbUFAUox (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 16:44:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264932AbUFAUox
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 16:44:53 -0400
Received: from mx1.elte.hu ([157.181.1.137]:4783 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S264918AbUFAUov (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 16:44:51 -0400
Date: Tue, 1 Jun 2004 22:46:03 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] active_load_balance() deadlock
Message-ID: <20040601204603.GA20535@elte.hu>
References: <200406011409.54478.bjorn.helgaas@hp.com> <Pine.LNX.4.58.0406011316190.14095@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0406011316190.14095@ppc970.osdl.org>
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


* Linus Torvalds <torvalds@osdl.org> wrote:

> On Tue, 1 Jun 2004, Bjorn Helgaas wrote:
> >
> > active_load_balance() looks susceptible to deadlock when busiest==rq.
> > Without the following patch, my 128-way box deadlocks consistently
> > during boot-time driver init.
> 
> Makes sense. The regular "load_balance()" already has that test,
> although it also makes it a WARN_ON() for some unexplained reason (I
> assume find_busiest_group() isn't supposed to find the local group,
> although it doesn't seem to be documented anywhere).
> 
> Ingo, Andrew?

looks good to me. The condition is 'impossible', but the whole balancing
code is (intentionally) a bit racy:

                cpus_and(tmp, group->cpumask, cpu_online_map);
                if (!cpus_weight(tmp))
                        goto next_group;

                for_each_cpu_mask(i, tmp) {
                        if (!idle_cpu(i))
                                goto next_group;
                        push_cpu = i;
                }

                rq = cpu_rq(push_cpu);
                double_lock_balance(busiest, rq);
                move_tasks(rq, push_cpu, busiest, 1, sd, IDLE);

in the for_each_cpu_mask() loop we specifically check for each CPU in
the target group to be idle - so push_cpu's runqueue == busiest [==
current runqueue] cannot be true because the current CPU is not idle, we
are running in the migration thread ... But this is not a real problem,
load-balancing we do in a racy way to reduce overhead [and it's all
statistics anyway so absolute accuracy is impossible], and active
balancing itself is somewhat racy due to the migration-thread wakeup
(and the active_balance flag) going outside the runqueue locks [for
similar reasons].

so it all looks quite plausible - the normal SMP boxes dont trigger it,
but Bjorn's 128-CPU setup with a non-trivial domain hiearachy triggers
it.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

	Ingo
