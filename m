Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262328AbVC3QrF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbVC3QrF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 11:47:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262333AbVC3QrF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 11:47:05 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:45566 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262328AbVC3Qqs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 11:46:48 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-07
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Esben Nielsen <simlo@phys.au.dk>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20050330065011.GA18417@elte.hu>
References: <Pine.OSF.4.05.10503242307330.25274-100000@da410.phys.au.dk>
	 <Pine.LNX.4.58.0503261047190.27746@localhost.localdomain>
	 <1112164313.3691.100.camel@localhost.localdomain>
	 <20050330065011.GA18417@elte.hu>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Wed, 30 Mar 2005 11:46:34 -0500
Message-Id: <1112201194.3691.128.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-03-30 at 08:50 +0200, Ingo Molnar wrote:
> * Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > OK, I'm declaring defeat here. I've been fighting race conditions all 
> > day, and it's now 1 in the morning where I live. It looks like this 
> > implementation has no other choice but to have the waking up "pending 
> > owner" take the wait_list lock once again.  How heavy of a overhead is 
> > that really?
> 
> as i mentioned it before, taking a lock is not a big issue at all. Since 
> you have to touch the lock data structure anyway (and all of it fits 
> into a single cacheline), it doesnt really matter whether it's atomic 
> flag setting/clearing, or raw spinlock based.c0267ad4
> 

OK, I've implemented adding the write_lock, but I still have a nasty
race condition, and I finally figured out why!

The damn BKL!  Here's the situation I'm having.

Process A grabs BKL then tries to grab another semaphore (say sem X)
But process B has sem X so process A sleeps.
Since semaphores don't have the restriction of saving the BKL, the BKL
   gets released from process A.
Process C comes along and grabs the BKL.
Finally B releases sem X and process A becomes the new "pending owner" 
  and wakes up.
When A schedules in it tries to grab the BKL but blocks. Now it is at
  the point where A doesn't actually own either the BKL or sem X. 
When C releases the BKL and gives it to A, A is now the pending owner
  of both the BKL and sem X.

When this occurs, all hell breaks loose. 

I believe I can solve this by making the BKL a special case and not
implement the pending owner at all for it.

> later on, once things are stable and well-understood, we can still 
> attempt to micro-optimize it.
> 

Heck, I'll make it bloat city till I get it working, and then tone it
down a little :-)  And maybe later we can have a better solution for the
BKL.

-- Steve


