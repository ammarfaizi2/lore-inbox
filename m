Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264353AbTKZWjh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 17:39:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264358AbTKZWjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 17:39:37 -0500
Received: from ns.suse.de ([195.135.220.2]:9677 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264353AbTKZWje (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 17:39:34 -0500
Date: Wed, 26 Nov 2003 23:39:18 +0100
From: Andi Kleen <ak@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fire Engine??
Message-Id: <20031126233918.2af3aae5.ak@suse.de>
In-Reply-To: <20031126113040.3b774360.davem@redhat.com>
References: <BAY1-DAV15JU71pROHD000040e2@hotmail.com.suse.lists.linux.kernel>
	<20031125183035.1c17185a.davem@redhat.com.suse.lists.linux.kernel>
	<p73fzgbzca6.fsf@verdi.suse.de>
	<20031126113040.3b774360.davem@redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Nov 2003 11:30:40 -0800
"David S. Miller" <davem@redhat.com> wrote:

>
> > - On TX we are inefficient for the same reason. TCP builds one packet
> > at a time and then goes down through all layers taking all locks (queue,
> > device driver etc.) and submits the single packet. Then repeats that for 
> > lots of packets because many TCP writes are > MTU. Batching that would 
> > likely help a lot, like it was done in the 2.6 VFS. I think it could 
> > also make hard_start_xmit in many drivers significantly faster.
> 
> This is tricky, because of getting all of the queueing stuff right.
> All of the packet scheduler APIs would need to change, as would
> the classification stuff, not to mention netfilter et al.

You only need to do a fast path for the default scheduler at the beginning.
Every complicated "slow" API like advanced queuing or netfilter can still fallback to 
one packet at a time until cleaned up (similar strategy as was done with the 
non linear skbs) 
 
> You're talking about basically redoing the whole TX path if you
> want to really support this.
> 
> I'm not saying "don't do this", just that we should be sure we know
> what we're getting if we invest the time into this.

In some profiling I did some time ago queue locks and device driver
locks were the biggest offenders on TX after copy. 

The only tricky part is to get the state machine in tcp_do_sendmsg()
right that decides when to flush.

 > - user copy and checksum could probably also done faster if they were
> > batched for multiple packets. It is hard to optimize properly for 
> > <= 1.5K copies.
> > This is especially true for 4/4 split kernels which will eat an 
> > page table look up + lock for each individual copy, but also for others.
> 
> I disagree partially, especially in the presence of a chip that provides
> proper implementations of software initiated prefetching.

Especially for prefetching having a list of packets helps because you
can prefetch the next while you're working on the current one. The CPU
hardware prefetcher cannot do that for you.

I did look seriously at faster csum-copy/copy-to-user for K8, but the conclusion
was that all the tricks are only worth it when you can work with bigger amounts of data.
1.5K at a time is just too small.

Ah yes:

- Investigate more performance through explicit prefetching 
(e.g. in the device drivers to optimize eth_type_trans() when you can classify the packet 
just by looking at the RX ring state. Instead do a prefetch on the packet data
and hope the data is already in cache when the IP stack gets around to look at it) 

could be also added to the list

-Andi (who shuts up now because I don't have any time to code on any of this :-( ) 
