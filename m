Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750712AbWAITPG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbWAITPG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 14:15:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750715AbWAITPF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 14:15:05 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:9153 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1750712AbWAITPE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 14:15:04 -0500
Message-ID: <43C2C818.65238C30@tv-sign.ru>
Date: Mon, 09 Jan 2006 23:31:20 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: paulmck@us.ibm.com
Cc: linux-kernel@vger.kernel.org, Dipankar Sarma <dipankar@in.ibm.com>,
       Manfred Spraul <manfred@colorfullife.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2/5] rcu: don't check ->donelist in __rcu_pending()
References: <43C165BC.F7C6DCF5@tv-sign.ru> <20060109185944.GB15083@us.ibm.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Paul E. McKenney" wrote:
> 
> On Sun, Jan 08, 2006 at 10:19:24PM +0300, Oleg Nesterov wrote:
> > ->donelist becomes != NULL only in rcu_process_callbacks().
> >
> > rcu_process_callbacks() always calls rcu_do_batch() when
> > ->donelist != NULL.
> >
> > rcu_do_batch() schedules rcu_process_callbacks() again if
> > ->donelist was not flushed entirely.
> >
> > So ->donelist != NULL means that rcu_tasklet is either
> > TASKLET_STATE_SCHED or TASKLET_STATE_RUN, we don't need to
> > check it in __rcu_pending().
> 
> As Vatsa noted, this is needed if the CPU-hotplug case moves
> from ->donelist to ->donelist.  It could be omitted if CPU-hotplug
> instead moves from ->donelist to ->nextlist, as is the case in Oleg's
> patch.  The extra grace-period delay should not be a problem for the
> presumably rare hotplug case, but:

Just to be sure. So do you agree that CPU-hotplug is buggy now (without
that patch) ?

> o       the extra test in __rcu_pending() should be quite inexpensive,
>         since the cacheline is already loaded given the earlier tests.

Yes, it was a cleanup, not an optimization.

> o       although tasklet_schedule() looks to be perfectly reliable
>         right now, and although any bugs in tasklet_schedule() must
>         be fixed, having RCU leakage be the major symptom of
>         tasklet_schedule() failure sounds quite unfriendly to me.
> 
> So I am not (yet) convinced that this patch is the way to go.

Ok, I agree.

Oleg.
