Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263463AbTKZTbV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 14:31:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264283AbTKZTbV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 14:31:21 -0500
Received: from pizda.ninka.net ([216.101.162.242]:33430 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263463AbTKZTbS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 14:31:18 -0500
Date: Wed, 26 Nov 2003 11:30:40 -0800
From: "David S. Miller" <davem@redhat.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fire Engine??
Message-Id: <20031126113040.3b774360.davem@redhat.com>
In-Reply-To: <p73fzgbzca6.fsf@verdi.suse.de>
References: <BAY1-DAV15JU71pROHD000040e2@hotmail.com.suse.lists.linux.kernel>
	<20031125183035.1c17185a.davem@redhat.com.suse.lists.linux.kernel>
	<p73fzgbzca6.fsf@verdi.suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 Nov 2003 10:53:21 +0100
Andi Kleen <ak@suse.de> wrote:

> Some issues just from the top of my head. I have not done detailed profiling
> recently and don't know if any of this would help significantly. It is 
> just what I remember right now.

Thanks for the list Andi, I'll keep it around.  I'd like
to comment on one entry though.

> - On TX we are inefficient for the same reason. TCP builds one packet
> at a time and then goes down through all layers taking all locks (queue,
> device driver etc.) and submits the single packet. Then repeats that for 
> lots of packets because many TCP writes are > MTU. Batching that would 
> likely help a lot, like it was done in the 2.6 VFS. I think it could 
> also make hard_start_xmit in many drivers significantly faster.

This is tricky, because of getting all of the queueing stuff right.
All of the packet scheduler APIs would need to change, as would
the classification stuff, not to mention netfilter et al.

You're talking about basically redoing the whole TX path if you
want to really support this.

I'm not saying "don't do this", just that we should be sure we know
what we're getting if we invest the time into this.

> - The hash tables are too big. This causes unnecessary cache misses all the 
> time.

I agree.  See my comments on this topic in another recent linux-kernel
thread wrt. huge hash tables on numa systems.

> - Doing gettimeofday on each incoming packet is just dumb, especially
> when you have gettimeofday backed with a slow southbridge timer.
> This shows quite badly on many profile logs.
> I still think right solution for that would be to only take time stamps
> when there is any user for it (= no timestamps in 99% of all systems) 

Andi, I know this is a problem, but for the millionth time your idea
does not work because we don't know if the user asked for the timestamp
until we are deep within the recvmsg() processing, which is long after
the packet has arrived.

> - user copy and checksum could probably also done faster if they were
> batched for multiple packets. It is hard to optimize properly for 
> <= 1.5K copies.
> This is especially true for 4/4 split kernels which will eat an 
> page table look up + lock for each individual copy, but also for others.

I disagree partially, especially in the presence of a chip that provides
proper implementations of software initiated prefetching.
