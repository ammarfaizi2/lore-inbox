Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261968AbVANXBm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261968AbVANXBm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 18:01:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261945AbVANXAZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 18:00:25 -0500
Received: from igw2.watson.ibm.com ([129.34.20.6]:24819 "EHLO
	igw2.watson.ibm.com") by vger.kernel.org with ESMTP id S261917AbVANW6N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 17:58:13 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Fri, 14 Jan 2005 17:57:21 -0500 (EST)
To: greg@kroah.com
Cc: trz@us.ibm.com, karim@opersys.com, richardj_moore@uk.ibm.com,
       michel.dagenais@polymtl.ca, linux-kernel@vger.kernel.org,
       ltt-dev@shafik.org
Subject: Re: [PATCH 3/4] relayfs for 2.6.10: locking/lockless implementation
X-Mailer: VM 6.43 under 20.4 "Emerald" XEmacs  Lucid
Message-ID: <16872.19899.179380.51583@kix.watson.ibm.com>
From: Robert Wisniewski <bob@watson.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg,
     There are a couple variables used throughout relayfs code that could
be modified at any point "simultaneously" by different processes.  These
variables were not declared volatile, thus when we modify them we need to
tell the compiler to refetch from memory as another process could have
changed out from under the current stream of execution since the last time
there were accessed in the function.  An alternative would be to mark the
variables that we care about as volatile.  I am not sure how best to make
that tradeoff (i.e., always forcing a refetch by marking a variable
volatile or only at points were we know we need to by memory clobbering) or
on what side the Linux community comes down on.  We certainly would be
happy to go either way with the relayfs code, i.e., mark them variable and
used the standard atomic operations.  That explains compare_and_store,
atomic_add, and atomic_sub.  It does not explain the memory clobbering
around the atomic set operation, which I'm guessing was there just to be
consistent with the other operations, and could, I believe, be removed.
Hopefully that helps answer the question.  If it doesn't please feel free
to ask more.  Thanks.

-bob

Robert Wisniewski
The K42 MP OS Project
Advanced Operating Systems
Scalable Parallel Systems
IBM T.J. Watson Research Center
914-945-3181
http://www.research.ibm.com/K42/
bob@watson.ibm.com

----

On Thu, Jan 13, 2005 at 10:04:33PM -0500, Karim Yaghmour wrote:
> +/**
> + *	compare_and_store_volatile - self-explicit
> + *	@ptr: ptr to the word that will receive the new value
> + *	@oval: the value we think is currently in *ptr
> + *	@nval: the value *ptr will get if we were right
> + */
> +inline int
> +compare_and_store_volatile(volatile u32 *ptr,
> +			   u32 oval,
> +			   u32 nval)
> +{
> +	u32 prev;
> +
> +	barrier();
> +	prev = cmpxchg(ptr, oval, nval);
> +	barrier();
> +
> +	return (prev == oval);
> +}

Why is this function needed?  What's wrong with the "normal" cmpxchg?




> +/**
> + *	atomic_set_volatile - atomically set the value in ptr to nval.
> + *	@ptr: ptr to the word that will receive the new value
> + *	@nval: the new value
> + */
> +inline void
> +atomic_set_volatile(atomic_t *ptr,
> +		    u32 nval)
> +{
> +	barrier();
> +	atomic_set(ptr, (int)nval);
> +	barrier();
> +}

Same here, what's wrong with the normal atomic_set()?

Same question also goes for the other functions like this in this file.

thanks,

greg k-h
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


--------------080309080704060007080707--
