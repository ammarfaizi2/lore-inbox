Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275098AbRJJJBA>; Wed, 10 Oct 2001 05:01:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275110AbRJJJAm>; Wed, 10 Oct 2001 05:00:42 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:50828 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S275098AbRJJJAf>; Wed, 10 Oct 2001 05:00:35 -0400
Date: Wed, 10 Oct 2001 14:36:24 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: BALBIR SINGH <balbir.singh@wipro.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: RFC: patch to allow lock-free traversal of lists with insertion
Message-ID: <20011010143624.A16959@in.ibm.com>
Reply-To: dipankar@in.ibm.com
In-Reply-To: <20011010123603.A17043@in.ibm.com> <3BC3F6E1.4060309@wipro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3BC3F6E1.4060309@wipro.com>; from balbir.singh@wipro.com on Wed, Oct 10, 2001 at 12:51:05PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2001 at 12:51:05PM +0530, BALBIR SINGH wrote:
> Dipankar Sarma wrote:
> >One example of where it is useful is maintenance of route information
> >in either storage or network. Route information changes infrequently but
> >needs to be looked up for every I/O and being able to do lockless
> >lookup here is a good gain.
> >
> I have a question, can this kind of locking used in cases where an interrupt
> context may be involved. For example looking through the list of timers, we
> disable interrupts and grab a lock using spin_lock_irqsave(&timerlist_lock, flags)

I don't know about this specific case (timer list), but in general,
yes, you can use lockless traversal with involvement of interrupt
context as long as you can make sure that you see a consistent list
if interrupted by the relevant interrupt during any point.

> 
> Should we just use __cli() with the RCU or something similar? or  can RCU
> be used in such cases?

You can use RCU without blocking the relevant interrupt as long as you
can make sure that the interrupt cannot find the list in an inconsistent
state. For example, if you insert an entry by updating a single
"next" pointer, you should be safe. Any interrupt happening before
this instruction would see the old copy of data and the ones after
the instruction would see the new copy.

As far as deletion using RCU is concerned, it is safe. If you see
the old copy of the data in the interrupt handler, that means this 
CPU was interrupted before the "deletion" was scheduled. If it is 
the new copy, you don't care.

Thanks
Dipankar
-- 
Dipankar Sarma  <dipankar@in.ibm.com> Project: http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
