Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030834AbWFOQqk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030834AbWFOQqk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 12:46:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030822AbWFOQqk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 12:46:40 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:23222 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1030821AbWFOQqj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 12:46:39 -0400
Message-ID: <44918EE5.2060302@bull.net>
Date: Thu, 15 Jun 2006 18:46:29 +0200
From: Zoltan Menyhart <Zoltan.Menyhart@bull.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en, fr, hu
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
Cc: akpm@osdl.org, ak@suse.de, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: light weight counters: race free through local_t?
References: <Pine.LNX.4.64.0606092212200.4875@schroedinger.engr.sgi.com> <449033B0.1020206@bull.net> <Pine.LNX.4.64.0606140928500.4030@schroedinger.engr.sgi.com> <44915110.2050100@bull.net> <Pine.LNX.4.64.0606150855410.9137@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0606150855410.9137@schroedinger.engr.sgi.com>
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 15/06/2006 18:50:22,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 15/06/2006 18:50:23,
	Serialize complete at 15/06/2006 18:50:23
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:

> Good to know. But we would run into trouble if the atomic counters would 
> be contended.

Why do you think an atomic operation is more expensive in a contended case?

Let's take the following assumption:
Every time when a CPU wants to increment the counter, it's cache line is
in someone other's cache.

Case of an atomic operation:

1. Issuing an atomic operation (apparently can be absorbed)
2. Goes down by the OzQ of the L2 (no L1 action)
   (assuming the queue is "sufficiently empty")
3. L2 miss
4. Fetching data, obtaining exclusivity - very long
5. L2 is ready - do the atomic operation to the L2 entry - modified state
   (min 5 clock cycles for normal L2 access + 5 for the atomic operation)

Case of __get_per_cpu(var)++:

1. Issuing an "ld4" can be absorbed
2. Goes down by the OzQ of the L2 (L1 miss)
   (assuming the queue is "sufficiently empty")
3. L2 miss
4. Fetching data, shared state - very long
5. L2 is ready - copy to L1 - into rx
   (min 5 clock cycle due to the L2)
6. Increment (1 cycle)
7. Post store to the OzQ of the L2 (L1 updated)
   (assuming the queue is "sufficiently empty")
8. L2 hit - obtain exclusivity - moderately long
9. L2 is ready - update it - modified state
   (min 5 clock cycles)

Please note
- the additional bus operation (address only) in step 8
- a 3rd CPU can kill our data between steps 5 - 8
  (very low probability)

(In case of strong contention, efforts have to be made to avoid cache
line sharing with other frequently used data - as usually...)

> Hmm... What about side effects such as pipeline stalls? fetchadd is 
> semaphore operation. Typically we use acquire semantics for volatiles. 
> Here the fetchadd has release semantics.

> If we would use release semantics then the fetchadd would require all 
> prior accesses to be complete.

... or ".rel".
Yes, it is a one-direction barrier.
However, if there is not too many stuff in the OzQ, it has not too much
impact.
(It is very difficult to fill in the OzQ: SW pipe-line, N independent
loads / stores without ";;" - not very much frequent in the kernel)

> Acquire semantics may be easier. But the best would be a fetchadd without 
> any serialization that would be like the inc/dec memory on i386, which 
> does not exist in the IA64 instruction set.

A second though about the case of __get_per_cpu(var)++:

If it is coded by hand, I can use "ld4.bias" to obtain immediately
the exclusivity - no need for step 8.
However, you cannot avoid the cost of the protection around this
incitement.

I still prefer the atomic operations.

Regard,

Zoltan


