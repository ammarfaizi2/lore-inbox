Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266129AbUGOG5A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266129AbUGOG5A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 02:57:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266131AbUGOG5A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 02:57:00 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:65507 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S266129AbUGOG4u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 02:56:50 -0400
Date: Thu, 15 Jul 2004 12:26:28 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Ravikiran G Thirumalai <kiran@in.ibm.com>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, oleg@tv-sign.ru
Subject: Re: [RFC] Refcounting of objects part of a lockfree collection
Message-ID: <20040715065627.GA6377@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20040714045345.GA1220@obelix.in.ibm.com> <20040714070700.GA12579@kroah.com> <20040714082621.GA4291@in.ibm.com> <20040714142614.GA15742@kroah.com> <20040715062102.GA1312@obelix.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040715062102.GA1312@obelix.in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2004 at 11:51:04AM +0530, Ravikiran G Thirumalai wrote:
> Now it would have been nice if we did not have to use cmpxchg 
> for refcount_get_rcu, or atleast if all arches implemented cmpxchg in
> hardware.  Since neither is true, for arches with no cmpxchg, we use
> the hashed spinlock method.  When we use hashed spinlock for 
> refcount_get_rcu method, we need to use the same spinlock to protect the
> refcount for the usual refcount_gets too.  So no atomic_inc for
> refcount_gets on arches with no cmpxchg.  
> Now why refcount_get when you are using refcount_get_rcu for a refcount one 
> might ask. With the fd patch, there are places where the refcount_get 
> happens with traditional serialisation, and places where refcount_get 
> happens lockfree.  So it makes sense for performance sake to have a 
> simple atomic_inc (refcount_get) instead of and the whole cmpxchg shebang
> for the same refcounter when traditional locking is held.  Hence the
> refcount_get infrastructure.  The whole refcount infrastructure 
> provided is _not_ meant for traditinal refcounting ...which kref 
> accomplishes.  If it is used for traditional refcounting (i.e refcount_get
> on a refcounter is used without any refcount_get_rcus for the same
> counter), arches with nocmpxchg will end up using hashed spinlocks for
> simple refcount_gets :).  A Note was included in the header file as
> a warning:

Would this work -

kref_get - just atomic inc
kref_put - just atomic dec
kref_get_rcu - cmpxchg if arch has or hashed spinlock
kref_put_rcu - dec if has cmpxchg else hashed spinlock

If the object has lock-free look-up, it must use kref_get_rcu.
You can use kref_get on such an object if the look-up is being
done with lock. Is there a situation that is not covered by this ?

Thanks
Dipankar
