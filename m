Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262698AbVDAKno@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262698AbVDAKno (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 05:43:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262699AbVDAKno
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 05:43:44 -0500
Received: from fire.osdl.org ([65.172.181.4]:2235 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262698AbVDAKnj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 05:43:39 -0500
Date: Fri, 1 Apr 2005 02:43:12 -0800
From: Andrew Morton <akpm@osdl.org>
To: johnpol@2ka.mipt.ru
Cc: linux-kernel@vger.kernel.org
Subject: Re: cn_queue.c
Message-Id: <20050401024312.641946e2.akpm@osdl.org>
In-Reply-To: <1112351791.9334.208.camel@uganda>
References: <20050331173215.49c959a0.akpm@osdl.org>
	<1112341236.9334.97.camel@uganda>
	<20050331235706.5b5981db.akpm@osdl.org>
	<1112344811.9334.146.camel@uganda>
	<20050401004804.52519e17.akpm@osdl.org>
	<1112348048.9334.174.camel@uganda>
	<20050401015027.047783eb.akpm@osdl.org>
	<1112351791.9334.208.camel@uganda>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
>
> On Fri, 2005-04-01 at 01:50 -0800, Andrew Morton wrote:
> > Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> > >
> > > cn_queue_free_dev() will wait until dev->refcnt hits zero 
> > >  before freeing any resources,
> > >  but it can happen only after cn_queue_del_callback() does 
> > >  it's work on given callback device [actually when all callbacks 
> > >  are removed].
> > >  When new callback is added into device, it's refcnt is incremented
> > >  [before adition btw, if addition fails in the middle, reference is
> > >  decremented], when callbak is removed, device's reference counter
> > >  is decremented aromically after all work is finished.
> > 
> > hm.
> > 
> > How come cn_queue_del_callback() uses all those barriers if no other CPU
> > can grab new references against cbq->cb->refcnt?
> 
> The work may be already assigned to that callback device, 
> new work cant, barriers are there to ensure that
> reference counters are updated in proper places, but not 
> before.

What are the "proper places"?  What other control paths could be inspecting
the refcount at this time?  (That's the problem with barriers - you can't
tell what they are barriering against).

> It would be a bug to update dev->refcnt before assigned work is finished
> and callback removed.
> 
> > cn_queue_free_callback() forgot to do flush_workqueue(), so
> > cn_queue_wrapper() can still be running while cn_queue_free_callback()
> > frees up the cn_callback_entry, I think.
> 
> cn_queue_wrapper() atomically increments cbq->cb->refcnt if runs, so it
> will
> be caught in 
> while (atomic_read(&cbq->cb->refcnt)) 
>   msleep(1000);
> in cn_queue_free_callback().
> If it does not run, then all will be ok.

But there's a time window on entry to cn_queue_wrapper() where the recsount
hasn't been incremented yet, and there's no locking.  If
cn_queue_free_callback() inspects the refcount in that window it will free
the cn_callback_entry() while cn_queue_wrapper() is playing with it?

> Btw, it looks like comments for del_timer_sync() and cancel_delayed_work
> ()
> are controversial - del_timer_sync() says that pending timer
> can not run on different CPU after returning, 
> but cancel_delayed_work() says, that work to be cancelled still 
> can run after returning.

Not controversial - the timer can have expired and have been successfully
deleted but the work_struct which the timer handler scheduled is still
pending, or has just started to run.

