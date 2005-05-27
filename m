Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261958AbVE0HhL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261958AbVE0HhL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 03:37:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261953AbVE0HcG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 03:32:06 -0400
Received: from mx1.elte.hu ([157.181.1.137]:22760 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261941AbVE0H3b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 03:29:31 -0400
Date: Fri, 27 May 2005 09:25:34 +0200
From: Ingo Molnar <mingo@elte.hu>
To: john cooper <john.cooper@timesys.com>
Cc: Daniel Walker <dwalker@mvista.com>, linux-kernel@vger.kernel.org
Subject: Re: RT and Cascade interrupts
Message-ID: <20050527072534.GA8172@elte.hu>
References: <Pine.LNX.4.44.0505120740270.31369-100000@dhcp153.mvista.com> <20050513074439.GB25458@elte.hu> <4284A7B6.4090408@timesys.com> <42935715.2000505@timesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42935715.2000505@timesys.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* john cooper <john.cooper@timesys.com> wrote:

> john cooper wrote:
> >I'm seeing the BUG assert in kernel/timers.c:cascade()
> >kick in (tmp->base is somehow 0) during a test which
> >creates a few tasks of priority higher than ksoftirqd.
> >This race doesn't happen if ksoftirqd's priority is
> >elevated (eg: chrt -f -p 75 2) so the -RT patch might
> >be opening up a window here.
> 
> There is a window in rpc_run_timer() which allows
> it to lose track of timer ownership when ksoftirqd
> (and thus itself) are preempted.  This doesn't
> immediately cause a problem but does corrupt
> the timer cascade list when the timer struct is
> recycled/requeued.  This shows up some time later
> as the list is processed.  The failure mode is cascade()
> attempting to percolate a timer with poisoned
> next/prev *s and a NULL base causing the assertion
> BUG(tmp->base != base) to kick in.
> 
> The RPC code is attempting to replicate state of
> timer ownership for a given rpc_task via RPC_TASK_HAS_TIMER
> in rpc_task.tk_runstate.  Besides not working
> correctly in the case of preemptable context it is
> a replication of state of a timer pending in the
> cascade structure (ie: timer->base).  The fix
> changes the RPC code to use timer->base when
> deciding whether an outstanding timer registration
> exists during rpc_task tear down.
> 
> Note: this failure occurred in the 40-04 version of
> the patch though it applies to more current versions.
> It was seen when executing stress tests on a number
> of PPC targets running on an NFS mounted root though
> was not observed on a x86 target under similar
> conditions.

should this fix go upstream too?

	Ingo
