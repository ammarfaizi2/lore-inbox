Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263981AbTCUUMq>; Fri, 21 Mar 2003 15:12:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263979AbTCUULj>; Fri, 21 Mar 2003 15:11:39 -0500
Received: from mailout01.sul.t-online.com ([194.25.134.80]:64437 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S263975AbTCUUK4>; Fri, 21 Mar 2003 15:10:56 -0500
Date: Fri, 21 Mar 2003 20:30:27 +0100
From: Andi Kleen <ak@muc.de>
To: mingo@elte.hu
Cc: linux-kernel@vger.kernel.org
Subject: raid5 xor functions and caches
Message-ID: <20030321193027.GA22994@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I tuned the xor.h functions for x86-64 a bit. One of the changes I did
was to use streaming stores, which are usually faster.  But it's actually
slower in the test it does a booting because that tests cache hot behaviour.
NTI will invalidate the cache line, so it's eating a lot of cache misses.

Does it make sense to test cache hot behaviour? iirc RAID checksumming
should be done without polluting caches. I'm considering to change it
to benchmark a few MB of data buffers to avoid caching effects. 

Also I'm not quite sure about the logic between XOR_SELECT_TEMPLATE prefering
SSE :- if the CPU supports SSE2 then all functions including integer can be 
compiled with NTA prefetches and NTI stores (on some CPUs an integer NTI
store is not a good idea though) For distribution kernels
they can be duplicated. If integer is really faster for some things
it should be used this way.

Another thing I noticed is that the prefetch distance for the SSE
functions is a bit too short. On modern CPUs 256 bytes is not long enough
(on P4 that would be only two cachelines), it needs more (3-4 cachelines at
least). 

-Andi

