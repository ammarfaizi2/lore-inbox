Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030730AbWK3REs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030730AbWK3REs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 12:04:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030742AbWK3REr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 12:04:47 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:682 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030736AbWK3REq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 12:04:46 -0500
Date: Thu, 30 Nov 2006 09:05:41 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
       Andrew Morton <akpm@osdl.org>, Jens Axboe <jens.axboe@oracle.com>,
       Alan Stern <stern@rowland.harvard.edu>,
       Josh Triplett <josh@freedesktop.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC, PATCH 1/2] qrcu: "quick" srcu implementation
Message-ID: <20061130170541.GA1869@us.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <20061129235303.GA1118@oleg> <20061130015714.GC1350@oleg> <20061130024621.GL2335@us.ibm.com> <20061130032252.GA4101@oleg> <20061130033757.GA4110@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061130033757.GA4110@oleg>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2006 at 06:37:57AM +0300, Oleg Nesterov wrote:
> On 11/30, Oleg Nesterov wrote:
> >
> > On 11/29, Paul E. McKenney wrote:
> > >
> > > Hmmm...  Now I am wondering if the memory barriers inherent in the
> > > __wait_event() suffice for this last barrier...  :-/  Thoughts?
> > >
> > > > +	smp_mb();
> >
> > Fastpath skips __wait_event(), and it is possible that the reader does
> > lock/unlock between the first 'mb()' and 'if (atomic_read() == 1)'.
> 
> In fact, a slow path needs (I think) it too. We can have an unrelated
> wakeup, and then the reader does unlock() before we check !atomic_read()
> in the __wait_event()'s loop. The reader removes us from ->wq, in that
> case finish_wait() does nothing.

Good point -- I was forgetting about the fastpath checks in __wait_event().

How about something like this?

	/*
	 * The following memory barrier is needed to perserve ordering
	 * in the case where __wait_event() follows its fastpath,
	 * which includes neither locks nor memory barriers.
	 */

						Thanx, Paul
