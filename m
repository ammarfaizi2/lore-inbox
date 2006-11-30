Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936178AbWK3DXG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936178AbWK3DXG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 22:23:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936179AbWK3DXG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 22:23:06 -0500
Received: from host-233-54.several.ru ([213.234.233.54]:65168 "EHLO
	mail.screens.ru") by vger.kernel.org with ESMTP id S936178AbWK3DXE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 22:23:04 -0500
Date: Thu, 30 Nov 2006 06:22:52 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Jens Axboe <jens.axboe@oracle.com>,
       Alan Stern <stern@rowland.harvard.edu>,
       Josh Triplett <josh@freedesktop.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC, PATCH 1/2] qrcu: "quick" srcu implementation
Message-ID: <20061130032252.GA4101@oleg>
References: <20061129235303.GA1118@oleg> <20061130015714.GC1350@oleg> <20061130024621.GL2335@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061130024621.GL2335@us.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29, Paul E. McKenney wrote:
>
> On Thu, Nov 30, 2006 at 04:57:14AM +0300, Oleg Nesterov wrote:
> > (the same patch + comments from Paul)
> > 
> With the addition of a comment for the smp_mb() at the beginning of
> synchronize_qrcu(), shown below:
> 
> Acked-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

Thanks!

> 	/*
> 	 * The following memory barrier is needed to ensure that
> 	 * and subsequent freeing of data elements previously
> 	 * removed is seen by other CPUs after the wait completes.
> 	 */

I think we have another reason for mb(), but I can't suggest a clear
comment.

	struct data {
		...
		int in_use;
		...
	}

	void free_data(struct data *p)
	{
		BUG_ON(p->in_use);
		kfree(p);
	}

	struct data *DATA;

Reader:

	qrcu_read_lock();
	data = rcu_dereference(DATA);

	data->in_use = 1;
	do_something(data);
	data->in_use = 0;

	qrcu_read_unlock();

Writer:

	old = DATA;
	DATA = alloc_new_data();
	
	synchronize_qrcu();
	free_data(old);

qrcu_read_unlock() does (implicit) mb() on reader's side, but we must pair
it on our side, otherwise we can't be sure (of course, _only_ in theory) we
are seeing all the changes (->in_use == 0) made by the reader.

> Hmmm...  Now I am wondering if the memory barriers inherent in the
> __wait_event() suffice for this last barrier...  :-/  Thoughts?
> 
> > +	smp_mb();

Fastpath skips __wait_event(), and it is possible that the reader does
lock/unlock between the first 'mb()' and 'if (atomic_read() == 1)'.

Oleg.

