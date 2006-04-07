Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964908AbWDGTbl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964908AbWDGTbl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 15:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964910AbWDGTbl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 15:31:41 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:31883 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S964908AbWDGTbl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 15:31:41 -0400
Date: Sat, 8 Apr 2006 03:28:38 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Andrew Morton <akpm@osdl.org>, "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>, "Paul E. McKenney" <paulmck@us.ibm.com>,
       Roland McGrath <roland@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] coredump: speedup SIGKILL sending
Message-ID: <20060407232838.GA11460@oleg>
References: <20060406220628.GA237@oleg> <1144352758.2866.105.camel@mindpipe> <20060406235519.GA331@oleg> <1144354065.2866.116.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1144354065.2866.116.camel@mindpipe>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/06, Lee Revell wrote:
> On Fri, 2006-04-07 at 03:55 +0400, Oleg Nesterov wrote:
> > On 04/06, Lee Revell wrote:
> > > On Fri, 2006-04-07 at 02:06 +0400, Oleg Nesterov wrote:
> > > > With this patch a thread group is killed atomically under ->siglock.
> > > > This is faster because we can use sigaddset() instead of force_sig_info()
> > > > and this is used in further patches.
> > > >
> > > > Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>
> > >
> > > Won't this cause huge latencies when a process with lots of threads is
> > > killed?
> >
> > Yes, irqs are disabled. But this is not worse than 'kill -9 pid', note
> > that __group_complete_signal() or zap_other_threads() do the same.
>
> Those have been problematic in the past.  I am just wondering if this
> will be a latency regression, or if changes elsewhere in your patch
> negate the effect.

zap_process() disables irqs while traversing ->thread_group list.
So yes, if a process has a lot of threads it will be a latency regression.
(but again, __group_complete_signal() does the same while delivering this
signal, so I don't think this change can make things worse).

However this allows us to avoid tasklist_lock in zap_threads() so I think
it is worth it. Please note that tasklist_lock was held while iterating
over _all_ threads in system, not only current's thread group.

Oleg.

