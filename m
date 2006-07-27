Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750805AbWG0ICs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805AbWG0ICs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 04:02:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750836AbWG0ICs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 04:02:48 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:56265
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750805AbWG0ICr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 04:02:47 -0400
Date: Thu, 27 Jul 2006 01:02:55 -0700 (PDT)
Message-Id: <20060727.010255.87351515.davem@davemloft.net>
To: johnpol@2ka.mipt.ru
Cc: drepper@redhat.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: async network I/O, event channels, etc
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060727074902.GC5490@2ka.mipt.ru>
References: <20060726062817.GA20636@2ka.mipt.ru>
	<20060726.231055.121220029.davem@davemloft.net>
	<20060727074902.GC5490@2ka.mipt.ru>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Date: Thu, 27 Jul 2006 11:49:02 +0400

> I.e. map skb's data to userspace? Not a good idea especially with it's
> tricky lifetime and unability for userspace to inform kernel when it
> finished and skb can be freed (without additional syscall).

Hmmm...

If it is paged based, I do not see the problem.  Events and calls to
AIO I/O routines make transfer of buffer ownership.  The fact that
while kernel (and thus networking stack) "owns" the buffer for an AIO
call, the user can have a valid mapping to it is a unimportant detail.

If the user will scramble a piece of data that is in flight to or from
the network card, it is his problem.

If we are using a primitive network card that does not support
scatter-gather I/O and thus not page based SKBs, we will make
copies.  But this is transparent to the user.

The idea is that DMA mappings have page granularity.

At least on transmit it should work well.  Receive side is more
difficult and initial implementation will need to copy.

> I did it with af_tlb zero-copy sniffer (but I substitute mapped pages
> with physical skb->data pages), and it was not very good.

Trying to be too clever with skb->data has always been catastrophic. :)

> Well, I think preallocate some buffers and use that in AIO setup is a
> plus, since in that case user does not care about when it is possible to
> reuse the same buffer - when appropriate kevent is completed, that means
> that provided buffer is no longer in use by kernel, and user can reuse
> it.

We now enter the most interesting topic of AIO buffer pool management
and where it belongs. :-)  We are assuming up to this point that the
user manages this stuff with explicit DMA calls for allocation, then
passes the key based references to those buffers as arguments to the
AIO I/O calls.

But I want to suggest another possibility.  What if the kernel managed
the AIO buffer pool for a task?  It could grow this dynamically based
upon need.  The only implementation road block is how large to we
allow this to grow, but I think normal VM mechanisms can take care
of it.

On transmit this is not straightforward, but for receive it has really
nice possibilities. :)

