Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266558AbUGPPvx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266558AbUGPPvx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 11:51:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266560AbUGPPvx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 11:51:53 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:13219 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S266558AbUGPPvv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 11:51:51 -0400
Date: Fri, 16 Jul 2004 21:20:49 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, dipankar@in.ibm.com
Subject: Re: [RFC] Refcounting of objects part of a lockfree collection
Message-ID: <20040716155049.GC1257@obelix.in.ibm.com>
References: <20040714045345.GA1220@obelix.in.ibm.com> <20040714070700.GA12579@kroah.com> <20040714085758.GA4165@obelix.in.ibm.com> <20040714170800.GC4636@kroah.com> <20040715080204.GC1312@obelix.in.ibm.com> <20040716143235.GC8282@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040716143235.GC8282@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 16, 2004 at 07:32:35AM -0700, Greg KH wrote:
>... 
> > We (Dipankar and myslef) had a discussion
> > and decided:
> > 1. I will make a patch to shrink kref and feed it to Greg
> > 2. Add new set kref api for lockfree refcounting --
> > 	kref_lf_xxx.  (kref_lf_get, kref_lf_get_rcu etc.,)
> 
> kref_*_rcu() as Dipankar noted is much nicer.

Do you mean Dipankar had noted as in:

<Dipankar's earlier post>
> Would this work -
> 
> kref_get - just atomic inc
> kref_put - just atomic dec
> kref_get_rcu - cmpxchg if arch has or hashed spinlock
> kref_put_rcu - dec if has cmpxchg else hashed spinlock

> If the object has lock-free look-up, it must use kref_get_rcu.
> You can use kref_get on such an object if the look-up is being
> done with lock. Is there a situation that is not covered by this ?

</>

If that is what you want, the api cannot work well.
The problem with this case is I cannot use hashed spinlock _just_ for
kref_get_rcu as Dipankar mentions above.  If I do that the atomic_inc s
in kref_get will race with the 'hashed spinlock' kref_get_rcu when 
both have to be used on the same refcounter.  (I mentioned this in an 
earlier post).  So I have to take the same hashed spinlock for kref_gets as 
well to maintain correctness -- obviously not a good thing for arches 
with no cmpxchg which use krefs for non lock free purposes only.  
Hence, the proposal now is to add kref_lf_get, kref_lf_put, kref_lf_get_rcu 
to the kref api.  kref_lf_xxx is to be used when the kref refcounter
is used atleast one place lock free -- that is kref_lf_get_rcu is used
at atleast once on the struct kref.  Does that sound ok?

Thanks,
Kiran
