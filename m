Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317451AbSF1PCf>; Fri, 28 Jun 2002 11:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317452AbSF1PCe>; Fri, 28 Jun 2002 11:02:34 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:3463 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S317451AbSF1PCc>;
	Fri, 28 Jun 2002 11:02:32 -0400
Date: Fri, 28 Jun 2002 08:04:37 -0700 (PDT)
From: Nivedita Singhvi <niv@us.ibm.com>
X-X-Sender: <nivedita@w-nivedita2.des.beaverton.ibm.com>
To: Andi Kleen <ak@suse.de>
cc: Nivedita Singhvi <niv@us.ibm.com>, <hurwitz@lanl.gov>,
       <linux-kernel@vger.kernel.org>
Subject: Re: zero-copy networking & a performance drop
In-Reply-To: <p73n0tgm7l3.fsf@oldwotan.suse.de>
Message-ID: <Pine.LNX.4.33.0206280741490.17593-100000@w-nivedita2.des.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 Jun 2002, Andi Kleen wrote:

> 
> Nivedita Singhvi <niv@us.ibm.com> writes:
> > 	
> > there are possibly many different scenario's here, and
> > I'm probably missing the most obvious causes...
> 
> There is one problem with the TCP csum-copy to user RX implementation. 
> When the fast path misses (process not scheduling in time for some 
> reason) the remaining packet is taken care of by the delack timer. 
> This adds considerable latency to the ACK generation (worst case 1/50s), 
> because the stack does not generate send the ack earlier when 
> 2*rcvmss data is received  and can be visible as latency to user space 
> in protocols that send lots of small messages.

Yes!! delayed and _very_ delayed acks were killing performance
for a certain workloads (unidirectional, small packet sends).

The current stack is (naturally) optimized for heavy continuous
tcp traffic, and shows up well in benchmarks like netperf tcp
stream tests, which blast full sized packets out (well, msg
size permitting), and SpecWeb99..

> csum-copy-to-user makes only sense when the NIC doesn't support hardware
> checksumming, otherwise it is better to just queue and do a normal copy
> and avoid these latencies.
> 
> I'm using this patch (should apply to any 2.4.4+ and 2.5). It essentially
> disables most of the RX user context TCP for NICs with hardware checksums
> (except for the usual processing as part of socket lock). IMHO the user 
> context code (prequeue etc.) is not too useful because of the latencies it 
> adds and it would be best to drop it. Most NICs should have hardware 
> checksumming these days and those that don't are likely slow enough (old 
> Realtek) to not need any special hacks.

Thanks, will try it out (back in the office july 8).. 

> With that patch it also makes even more sense to go for a SSE optimized
> copy-to-user to get more speed out of networking.
> 
> Regarding the RX slowdown: I think there was some slowdown in chatroom
> when the zero-copy TX stack was introduced. chatroom is horrible 
> benchmark in itself, but the stack work should not have slowed it down.
> It's possible that it is fixed by this patch too; i haven't checked.
> 
> -Andi

I dont recall seeing a large number of delayed acks in
the profile (only seen one profile tho). Possibly a large 
number of threads sending out packets? (Although the delayed ack
count is incremented only when the timer goes off, so 
only full delayed acks count. Partial delays can also
add up when we schedule them very frequently)...

thanks,
Nivedita


