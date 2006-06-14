Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964909AbWFNNOw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964909AbWFNNOw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 09:14:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964910AbWFNNOw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 09:14:52 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:12162 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S964909AbWFNNOv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 09:14:51 -0400
Subject: Re: NPTL mutex and the scheduling priority
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: Jakub Jelinek <jakub@redhat.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@redhat.com>,
       Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
       Ulrich Drepper <drepper@redhat.com>, linux-kernel@vger.kernel.org,
       Pierre PEIFFER <pierre.peiffer@bull.net>
In-Reply-To: <20060613125603.GQ3115@devserv.devel.redhat.com>
References: <20060612.171035.108739746.nemoto@toshiba-tops.co.jp>
	 <1150115008.3131.106.camel@laptopd505.fenrus.org>
	 <20060612124406.GZ3115@devserv.devel.redhat.com>
	 <1150125869.3835.12.camel@frecb000686>
	 <20060613084819.GL3115@devserv.devel.redhat.com>
	 <1150200272.3835.33.camel@frecb000686>
	 <20060613125603.GQ3115@devserv.devel.redhat.com>
Date: Wed, 14 Jun 2006 15:19:40 +0200
Message-Id: <1150291180.3835.59.camel@frecb000686>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 14/06/2006 15:18:33,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 14/06/2006 15:18:34,
	Serialize complete at 14/06/2006 15:18:34
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-13 at 08:56 -0400, Jakub Jelinek wrote:
> On Tue, Jun 13, 2006 at 02:04:32PM +0200, S?bastien Dugu? wrote:
> > > Now not sure what do you mean by "use PI futexes all along in glibc",
> > > certainly you don't mean using them for normal mutexes, right? 
> > > FUTEX_LOCK_PI has effects the normal futexes shouldn't have.
> > > The condvars can be also used with PP mutexes and using PI for the cv
> > > internal lock unconditionally wouldn't be the right thing either.
> > 
> >   I effectively meant using a PI futex for the cv __data.__futex but now
> > I realize it's a Really Bad Idea.
> 
> For __data.__futex?  That is not just a really bad idea, that's not possible
> at all.  PI futex has a hardcoded format (owner tid plus 2 control bits in
> the MSB), while cv in __data.__futex needs to have an application controlled
> format (a counter).

  Darn right, overlooked that!

> 
> >   To summarize (correct me if I'm wrong), we need a way in the broadcast
> > case to promote the cv __data.__futex type to the type of the external
> > mutex (PI, PP, normal) in the requeue path. Therefore we need the
> > ability to requeue waiters on a regular futex onto a PI futex.
> 
> We need more things:
> Have FUTEX_WAKE/FUTEX_REQUEUE/FUTEX_WAKE_OP honor the scheduling policy/priorities
> rather than use FIFO (this is needed not just for proper behavior
> of pthread_mutex_unlock, but also for __data.__futex).

  Well, this is what I tried to achieve by using plists.

> 
> FUTEX_REQUEUE is used by pthread_cond_signal to requeue the __data.__futex
> onto __data.__lock.

  You meant FUTEX_WAKE_OP, I guess. I could not find any place still 
using FUTEX_REQUEUE in glibc 2.4.

>   So it all depends on what futex type is used by the
> __data.__lock.

  OK.

>   A CV doesn't have a mutex associated to it at all times,
> when there is no contention on it, it really doesn't matter.

  Right.

>   Maybe
> it would be possible to use PI futex always (well, if FUTEX_LOCK_PI is
> supported, otherwise of course only use normal lock) for the internal lock
> though.  All we want to ensure is that for the short time it is held
> (no blocking operation should be done while __data.__lock is held
> unless interrupted by signal) if the owning thread of __data.__lock is
> scheduled away (or interrupted by signal) it doesn't cause priority
> inversion.  That even includes e.g. two threads with different priorities
> calling pthread_signal or pthread_broadcast concurrently (and in that
> case, we might not have an associated mutex at all).
> But, for PI __data.__lock, we need:
> 1) FUTEX_REQUEUE being able to requeue non-PI futex to PI futex

  We're trying to look into that right now.

> 2) FUTEX_WAKE_OP alternative that allows the target futex be a PI futex:
>    ATM NPTL uses FUTEX_OP_CLEAR_WAKE_IF_GT_ONE   ((4 << 24) | 1)
>    FUTEX_WAKE_OP operation, i.e. atomically
>    FUTEX_WAKE (futex); int old = *lock; *lock = 0; if (old > 1) FUTEX_WAKE (lock);
>    but with PI __data.__lock, we want instead atomically:
>    FUTEX_WAKE (futex); /* This one is normal, non-PI */ FUTEX_UNLOCK_PI (lock);
>    (or perhaps:
>    FUTEX_WAKE (futex); int old = *lock;
>    if (old & FUTEX_WAITERS)
>      FUTEX_UNLOCK_PI (lock);
>    else if (old == gettid ())
>      *lock = 0;
>    else
>      FUTEX_UNLOCK_PI (lock);
>    ).

  Understood.

  Thanks a lot for the info.

  Sébastien.


