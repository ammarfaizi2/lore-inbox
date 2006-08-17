Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932572AbWHQS4K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932572AbWHQS4K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 14:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932574AbWHQS4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 14:56:09 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:55521 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S932572AbWHQS4I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 14:56:08 -0400
Date: Thu, 17 Aug 2006 22:42:09 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Daniel Phillips <phillips@google.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>,
       David Miller <davem@davemloft.net>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC][PATCH 0/9] Network receive deadlock prevention for NBD
Message-ID: <20060817184206.GA2873@2ka.mipt.ru>
References: <1155127040.12225.25.camel@twins> <20060809130752.GA17953@2ka.mipt.ru> <1155130353.12225.53.camel@twins> <20060809.165431.118952392.davem@davemloft.net> <1155189988.12225.100.camel@twins> <44DF888F.1010601@google.com> <20060814051323.GA1335@2ka.mipt.ru> <44E3F525.3060303@google.com> <20060817053636.GA30920@2ka.mipt.ru> <44E4AF10.5030308@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <44E4AF10.5030308@google.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Thu, 17 Aug 2006 22:43:18 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2006 at 11:01:52AM -0700, Daniel Phillips (phillips@google.com) wrote:
> *** The system is not OOM, it is in reclaim, a transient condition ***

It does not matter how condition when not every user can get memory is
called. And actually no one can know in advance how long it will be.

> Which Peter already told you!  Please, let's get our facts straight,
> then we can look intelligently at whether your work is appropriate to
> solve the block IO network starvation problem that Peter and I are
> working on.

I got openssh as example of situation when system does not know in 
advance, what sockets must be marked as critical.
OpenSSH works with network and unix sockets in parallel, so you need to
hack openssh code to be able to allow it to use reserve when there is 
not enough memory. Actually all sockets must be able to get data, since
kernel can not diffirentiate between telnetd and a process which will 
receive an ack for swapped page or other significant information.
So network must behave separately from main allocator in that period of 
time, but since it is possible that reserve can be not filled or has not
enough space or something other, it must be preallocated in far advance
and should be quite big, but then why netwrok should use it at all, when
being separated from main allocations solves the problem?

I do not argue that your approach is bad or does not solve the problem,
I'm just trying to show that further evolution of that idea eventually
ends up in separated allocator (as long as all most robust systems
separate operations), which can improve things in a lot of other sides
too.


> Regards,
> 
> Daniel

-- 
	Evgeniy Polyakov
