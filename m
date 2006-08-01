Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932074AbWHANVw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074AbWHANVw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 09:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932524AbWHANVw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 09:21:52 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:35318 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932074AbWHANVw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 09:21:52 -0400
Subject: Re: rt_mutex_timed_lock() vs hrtimer_wakeup() race ?
From: Steven Rostedt <rostedt@goodmis.org>
To: tglx@linutronix.de
Cc: Oleg Nesterov <oleg@tv-sign.ru>, Ingo Molnar <mingo@elte.hu>,
       Esben Nielsen <nielsen.esben@googlemail.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1154436721.5932.60.camel@localhost.localdomain>
References: <20060730043605.GA2894@oleg>
	 <1154419117.5932.55.camel@localhost.localdomain>
	 <1154434031.25445.14.camel@localhost.localdomain>
	 <1154436721.5932.60.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 01 Aug 2006 09:21:42 -0400
Message-Id: <1154438502.25445.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-01 at 14:52 +0200, Thomas Gleixner wrote:
> On Tue, 2006-08-01 at 08:07 -0400, Steven Rostedt wrote:
> > > We hold lock->wait_lock. The owner of this lock can be blocked itself,
> > > which makes it necessary to do the chain walk. The indicator is
> > > owner->pi_blocked_on. This field is only protected by owner->pi_lock.
> > > 
> > > If we look at this field outside of owner->pi_lock, then we might miss a
> > > chain walk.
> > > 
> > 
> > Actually Thomas, not counting the debug case, his patch wont miss a
> > chain walk.  That is because the boost is read _after_ the owner's prio
> > is adjusted.  So the only thing the lock is doing for us is to prevent
> > us from walking the chain twice for the same lock grab. (btw. I'm
> > looking at 2.6.18-rc2, and not the -rt patch, just to make things
> > clear).
> 
> So what do we win, when we drop the lock before we check for boosting ?
> In the worst case we do a redundant chain walk.
> 

I'm not saying that it was correct to drop the lock before checking for
boosting. I'm just saying that it won't miss a chain walk.  But we might
do two of them. I think I'll send my patch again that fixes this up a
little.  I'll make two patches: one for mainline, and one for -rt.

In the debug case, we really don't even need to grab the lock.
(see patch -- coming soon)

-- Steve


