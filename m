Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262964AbVBDLev@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262964AbVBDLev (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 06:34:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263274AbVBDLev
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 06:34:51 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:52754 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S263201AbVBDLeZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 06:34:25 -0500
Date: Fri, 4 Feb 2005 22:33:05 +1100
To: "David S. Miller" <davem@davemloft.net>
Cc: Anton Blanchard <anton@samba.org>, okir@suse.de, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arp_queue: serializing unlink + kfree_skb
Message-ID: <20050204113305.GA12764@gondor.apana.org.au>
References: <20050131102920.GC4170@suse.de> <E1CvZo6-0001Bz-00@gondolin.me.apana.org.au> <20050203142705.GA11318@krispykreme.ozlabs.ibm.com> <20050203150821.2321130b.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050203150821.2321130b.davem@davemloft.net>
User-Agent: Mutt/1.5.6+20040722i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2005 at 03:08:21PM -0800, David S. Miller wrote:
> 
> Ok, here goes nothing.  Can someone run with this?  It should
> be rather complete, and require only minor editorial work.

Thanks.  It's a very nice piece of work.
 
> A missing memory barrier in the cases where they are required
> by the atomic_t implementation above can have disasterous
> results.  Here is an example, which follows a pattern occuring
> frequently in the Linux kernel.  It is the use of atomic counters
> to implement reference counting, and it works such that once
> the counter falls to zero it can be guarenteed that no other
> entity can be accessing the object.   Observe:
> 
> 	list_del(&obj->list);
> 	if (atomic_dec_and_test(&obj->ref_count))
> 		kfree(obj);
> 
> Here, the list (say it is some linked list on which object
> searches are performed) creates the reference to the object.
> The insertion code probably looks something like this:
> 
> 	atomic_inc(&obj->ref_count);
> 	list_add(&obj->list, &global_obj_list);

I think you should probably note that some sort of locking or RCU
scheme is required to make this safe.  As it is the atomic_inc
and the list_add can be reordered such that the atomic_inc occurs
after the atomic_dec_and_test.

Either that or you can modify the example to add an
smp_mb__after_atomic_inc().  That'd be a good way to
demonstrate its use.

> And searches look something like:
> 
> 	for_each(obj, &global_obj_list) {
> 		if (key_compare(obj->key, key)) {
> 			atomic_inc(&obj->ref_count);
> 			return obj;
> 		}
> 	}
> 	return NULL;

Locking or RCU is definitely needed here.

> the object is still visible for lookup on the linked list.  So
> we'd get a bogus sequence like this:
> 
> 	cpu 0				cpu 1
> 	list_del(&obj->list);
> 	... visibility delayed ...
> 					lookup and find obj on
> 					global_obj_list

The visibility only needs to be delayed up until this point for
the crash to occur.

> 	atomic_dec_and_test();
> 	obj refcount hits zero, this
> 	is visible globally
> 					atomic_inc()
> 					obj refcount incremented
> 					to one
> 	list_del() becomes visible
> 
> 	kfree(obj);
> 					obj is now freed up memory
> 					--> CRASH
> 
> With the memory barrier semantics required of the atomic_t
> operations which return values, the above sequence of memory
> visibility can never happen.

So this isn't exactly correct.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
