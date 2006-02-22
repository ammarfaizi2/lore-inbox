Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932483AbWBVBoI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932483AbWBVBoI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 20:44:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932497AbWBVBoI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 20:44:08 -0500
Received: from smtp104.mail.mud.yahoo.com ([209.191.85.214]:11133 "HELO
	smtp104.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932483AbWBVBoH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 20:44:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=WRuhmuJMNSUgk7hh4vwtYgwMEJEiq0z8UFuJCLPSMoJx8BGj6dDFqHSblOhvQ76sOPb6OINJVg6pm/YWsc6jbxOvh3RspQo8CTVZk2AD1D1R20tHK0fUsZKbGG3Lm0VBo0peFMuB+nH9yHQZK4K2LUlRCCh4UUCqts7GbX/4UkM=  ;
Message-ID: <43FBB441.1010209@yahoo.com.au>
Date: Wed, 22 Feb 2006 11:45:53 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ravikiran G Thirumalai <kiran@scalex86.org>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>
Subject: Re: [patch] Cache align futex hash buckets
References: <20060220233242.GC3594@localhost.localdomain> <43FA8938.70006@yahoo.com.au> <20060221202024.GA3635@localhost.localdomain>
In-Reply-To: <20060221202024.GA3635@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ravikiran G Thirumalai wrote:
> On Tue, Feb 21, 2006 at 02:30:00PM +1100, Nick Piggin wrote:
> 
>>Ravikiran G Thirumalai wrote:
>>
>>>Following change places each element of the futex_queues hashtable on a 
>>>different cacheline.  Spinlocks of adjacent hash buckets lie on the same 
>>>cacheline otherwise.
>>>
>>
>>It does not make sense to add swaths of unused memory into a hashtable for
>>this purpose, does it?
> 
> 
> I don't know if having two (or more) spinlocks on the same cacheline is a good 
> idea.  Right now, on a 128 B cacheline we have 10 spinlocks on the
> same cacheline here!! Things get worse if two futexes from different nodes 
> hash on to adjacent, or even nearly adjacent hash buckets.
> 

It is no worse than having a hash collision and having to take the same lock.

(as I said, a really good solution might just use a single lock per cacheline,
but that would make hash indexing a bit more difficult.)

> 
>>For a minimal, naive solution you just increase the size of the hash table.
>>This will (given a decent hash function) provide the same reduction in
>>cacheline contention, while also reducing collisions.
> 
> 
> Given a decent hash function.  I am not sure the hashing function is smart 
> enough as of now.  Hashing is not a function of nodeid, and we have some 
> instrumentation results which show hashing on NUMA is not good as yet, and
> there are collisions from other nodes onto the same hashbucket; Nearby 
> buckets have high hit rates too.
> 

But it is decent in that it is random. The probability of an address hashing
to the same cacheline as another should be more or less the same as with your
padded scheme.

> I think some sort of NUMA friendly hashing, where futexes from same nodes
> hash onto a node local hash table, would be a decent solution here.
> As I mentioned earlier, we are working on that, and we can probably allocate
> the spinlock from nodelocal memory then and avoid this bloat.
> We are hoping to have this as a stop gap fix until we get there.
> 

But my point still stands that it never makes sense to add empty space into
a hash table. Add hash slots instead and you (for free) get shorter hash
chains.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
