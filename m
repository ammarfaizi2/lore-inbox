Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264134AbTKZKru (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 05:47:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264141AbTKZKru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 05:47:50 -0500
Received: from ns.suse.de ([195.135.220.2]:1453 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264134AbTKZKrq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 05:47:46 -0500
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fire Engine??
References: <BAY1-DAV15JU71pROHD000040e2@hotmail.com.suse.lists.linux.kernel>
	<20031125183035.1c17185a.davem@redhat.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 26 Nov 2003 10:53:21 +0100
In-Reply-To: <20031125183035.1c17185a.davem@redhat.com.suse.lists.linux.kernel>
Message-ID: <p73fzgbzca6.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com> writes:
> 
> So his claim is that, in their mesaurements, "CPU utilization"
> was lower in their stack.  Was he using 2.6.x and TSO capable
> cards on the Linux side?  If not, it's not apples to apples
> against are current upcoming technology.

Maybe they just have a better copy_to_user(). That eats most time anyways.

I think there are definitely areas of improvements left in current TCP.
It has gotten quite fat over the last years.

Some issues just from the top of my head. I have not done detailed profiling
recently and don't know if any of this would help significantly. It is 
just what I remember right now.

- Window computation for incoming packets is quite dumbly coded right now
and could be optimized
- I suspect the copy/process-in--user-context setup needs to be rethought/
rebenchmarked in Gigabit setups.  There was at least one test case
where tcp_low_latency=1 helped. It just adds latency that might hurt
and is not very useful when you have hardware checksums anyways
- If they tested TCP-over-NFS then I'm pretty sure Linux lost badly because
the current paths for that are just awfully inefficient.
- Overall IP/TCP could probably have some more instructions and hopefully
cache misses shaved off with some careful going over the fast paths.
- There are too many locks. That hurts when you have slow atomic operations
(like on P4) and together with the next issue. 
- We do most things one packet at a time. This means locking and multiple
layer overhead multiplies. Most network operations come in packet bursts
and it would be much more efficient to batch operations: always process
lists of packets instead of single packets. This could probably lower
locking overhead a lot.
- On TX we are inefficient for the same reason. TCP builds one packet
at a time and then goes down through all layers taking all locks (queue,
device driver etc.) and submits the single packet. Then repeats that for 
lots of packets because many TCP writes are > MTU. Batching that would 
likely help a lot, like it was done in the 2.6 VFS. I think it could 
also make hard_start_xmit in many drivers significantly faster.
- The hash tables are too big. This causes unnecessary cache misses all the 
time.
- Doing gettimeofday on each incoming packet is just dumb, especially
when you have gettimeofday backed with a slow southbridge timer.
This shows quite badly on many profile logs.
I still think right solution for that would be to only take time stamps
when there is any user for it (= no timestamps in 99% of all systems) 
- user copy and checksum could probably also done faster if they were
batched for multiple packets. It is hard to optimize properly for 
<= 1.5K copies.
This is especially true for 4/4 split kernels which will eat an 
page table look up + lock for each individual copy, but also for others.

-Andi
