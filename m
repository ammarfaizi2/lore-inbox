Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751237AbWA3Ezj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751237AbWA3Ezj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 23:55:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751242AbWA3Ezj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 23:55:39 -0500
Received: from mf00.sitadelle.com ([212.94.174.67]:31414 "EHLO
	smtp.cegetel.net") by vger.kernel.org with ESMTP id S1751237AbWA3Ezi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 23:55:38 -0500
Message-ID: <43DD9C49.4000000@cosmosbay.com>
Date: Mon, 30 Jan 2006 05:55:37 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: paulmck@us.ibm.com
Cc: dipankar@in.ibm.com, Lee Revell <rlrevell@joe-job.com>,
       Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: RCU latency regression in 2.6.16-rc1
References: <20060124162846.GA7139@in.ibm.com> <20060124213802.GC7139@in.ibm.com> <1138224506.3087.22.camel@mindpipe> <20060126191809.GC6182@us.ibm.com> <1138388123.3131.26.camel@mindpipe> <20060128170302.GB5633@in.ibm.com> <1138471203.2799.13.camel@mindpipe> <1138474283.2799.24.camel@mindpipe> <20060128193412.GH5633@in.ibm.com> <43DBCB62.7030308@cosmosbay.com> <20060130043604.GF16585@us.ibm.com>
In-Reply-To: <20060130043604.GF16585@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul E. McKenney a écrit :
> On Sat, Jan 28, 2006 at 08:52:02PM +0100, Eric Dumazet wrote:
>> Dipankar Sarma a écrit :
>>> On Sat, Jan 28, 2006 at 01:51:23PM -0500, Lee Revell wrote:
>>>> On Sat, 2006-01-28 at 13:00 -0500, Lee Revell wrote:
>>>>> OK, now we are making progress.
>>>> I spoke too soon, it's not fixed:
>>>>
>>>> preemption latency trace v1.1.5 on 2.6.16-rc1
>>>> --------------------------------------------------------------------
>>>> latency: 4183 us, #3676/3676, CPU#0 | (M:rt VP:0, KP:0, SP:0 HP:0)
>>>>    -----------------
>>>> evolutio-2877  0d.s.   97us : local_bh_enable (rt_run_flush)
>>>> evolutio-2877  0d.s.   98us : local_bh_enable (rt_run_flush)
>>>> evolutio-2877  0d.s.   99us : local_bh_enable (rt_run_flush)
>>>> evolutio-2877  0d.s.  100us : local_bh_enable (rt_run_flush)
>>>> evolutio-2877  0d.s.  101us : local_bh_enable (rt_run_flush)
>>>>
>>>> [ etc ]
>>>>
>>>> evolutio-2877  0d.s. 4079us : local_bh_enable (rt_run_flush)
>>>> evolutio-2877  0d.s. 4080us : local_bh_enable (rt_run_flush)
>>> I am not sure if I am interpreting the latency trace right,
>>> but it seems that there is a difference between the problem
>>> you were seeing earlier and now.
>>>
>>> In one of your earlier traces, I saw  -
>>>
>>>  <idle>-0     0d.s.  182us : dst_destroy (dst_rcu_free)
>>>  <idle>-0     0d.s.  183us : ipv4_dst_destroy (dst_destroy)
>>>
>>> [ etc - zillions of dst_rcu_free()s deleted ]
>>>
>>>  <idle>-0     0d.s. 13403us : dst_rcu_free (__rcu_process_callbacks)
>>>  <idle>-0     0d.s. 13403us : dst_destroy (dst_rcu_free)
>>>
>>> This points to latency increase caused by lots and lots of
>>> RCU callbacks doing dst_rcu_free(). Do you still see those ?
>>>
>>> Your new trace shows that we are held up in in rt_run_flush(). 
>>> I guess we need to investigate why we spend so much time in rt_run_flush(),
>>> because of a big route table or the lock acquisitions.
>> Some machines have millions of entries in their route cache.
>>
>> I suspect we cannot queue all them (or only hash heads as your previous 
>> patch) by RCU. Latencies and/or OOM can occur.
>>
>> What can be done is :
>>
>> in rt_run_flush(), allocate a new empty hash table, and exchange the hash 
>> tables.
>>
>> Then wait a quiescent/grace RCU period (may be the exact term is not this 
>> one, sorry, I'm not RCU expert)
>>
>> Then free all the entries from the old hash table (direclty of course, no 
>> need for RCU grace period), and free the hash table.
>>
>> As the hash table can be huge, we might need allocate it at boot time, just 
>> in case a flush is needed (it usually is :) ). If we choose dynamic 
>> allocation and this allocation fails, then fallback to what is done today.
> 
> Interesting approach!
> 
> If I remember correctly, the point of all of this is to perturb the hash
> function periodically in order to avoid DoS attacks.  It will likely
> be necessary to avoid a big performance hit during the transition.
> One way of doing this, given your two-table scheme, would be to:
> 
> o	Allocate both tables at boot time, as you suggest above.
> 
> o	Keep the following additional state:
> 
> 	o	Pointer to the table that is the current table.
> 
> 	o	First valid index (fvl) into the current table -- all
> 		indexes below the fvl correspond to hash buckets that
> 		have been transferred into the non-current table.
> 		In the normal case where the tables are not being
> 		switched, fvl==-1.
> 
> 		(To make the RCU searches work without requiring
> 		tons of explicit memory barriers, there needs to
> 		be a separate fvl for each of the tables.)
> 
> 	o	Parameters defining the hash functions for the current
> 		table and for the non-current table.
> 
> o	When it is time to switch tables, start removing the entries
> 	in hash bucket #fvl of the current table.  Optionally put them
> 	into the non-current table (or just let them be added as they
> 	are needed.  Only remove a limited number of entries (or,
> 	alternatively, stop removing them after a limited amount of
> 	time).
> 
> 	When the current hash bucket has been completely emptied,
> 	increment fvl, and, if we have not already hit the limit,
> 	continue on the new hash bucket.
> 
> 	When fvl runs off the end of the table, you are done with
> 	the switch.  Update the pointer to reference the other
> 	table.  Important -- do -not- start another switch until
> 	a grace period has elapsed!!!  Otherwise, you will end
> 	up fatally confusing slow readers.
> 
> o	When searching, if the hash function gives a value less
> 	than fvl, search the non-current table.
> 
> 	If the hash function gives a value equal to fvl, search
> 	the current table, and, if not found, search the non-current
> 	table.
> 
> 	If the hash function gives a value greater than fvl, search
> 	only the current table.  (It may also be necessary to search
> 	the non-current table to allow for races with fvl update.)
> 
> Does this seem reasonable?
> 
> 						Thanx, Paul

Well, if as a bonus we are able to expand the size of the hash table, it could 
be very very good : As of today, the boot time sizing of this hash table is 
somewhat problematic.

If the size is expanded by a 2 factor (or a power of too), can your proposal 
works ?

Eric
