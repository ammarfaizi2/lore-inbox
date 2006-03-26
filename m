Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750869AbWCZWJ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750869AbWCZWJ3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 17:09:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751101AbWCZWJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 17:09:28 -0500
Received: from www.osadl.org ([213.239.205.134]:16514 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1750869AbWCZWJ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 17:09:28 -0500
Subject: Re: [patch 2/2] hrtimer
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu,
       Oleg Nesterov <oleg@tv-sign.ru>
In-Reply-To: <20060325183213.63ab667c.akpm@osdl.org>
References: <20060325121219.172731000@localhost.localdomain>
	 <20060325121223.966390000@localhost.localdomain>
	 <20060325183213.63ab667c.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 27 Mar 2006 00:10:16 +0200
Message-Id: <1143411016.5344.139.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-03-25 at 18:32 -0800, Andrew Morton wrote:

> This all looks vaguely racy.  hrtimer_wakeup() will set t->task to NULL
> without barriers, locks or anything.  And the waiter here can break out of
> schedule() due to signal delivery while a wakeup is in progress.

We set task = NULL before wake_up_process() which acts as a barrier.

> So the value of t->task here is fairly meaningless.  Ot just depends on how
> far the waker has got through hrtimer_wakeup().
> 
> Maybe that doesn't matter, because hrtimer_cancel() will spin until
> hrtimer_wakeup() has completed anyway, but could you please recheck and
> confirm that this is all solid?

Right, either it waits for the running timer or in case the wakeup
happens between

if (unlikely(t->task)) {

and

	hrtimer_cancel(&t->timer);

then hrtimer_cancel will see that the timer is inactive and we drop out
of the loop because the while(t->task) condition is not longer true. 

	tglx



