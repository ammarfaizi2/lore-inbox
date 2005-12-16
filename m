Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964815AbVLPWzT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964815AbVLPWzT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 17:55:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932562AbVLPWzT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 17:55:19 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:45519
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932560AbVLPWzR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 17:55:17 -0500
Date: Fri, 16 Dec 2005 14:53:06 -0800 (PST)
Message-Id: <20051216.145306.132052494.davem@davemloft.net>
To: torvalds@osdl.org
Cc: dhowells@redhat.com, nickpiggin@yahoo.com.au, arjan@infradead.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, cfriesen@nortel.com,
       hch@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation 
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.64.0512161429500.3698@g5.osdl.org>
References: <Pine.LNX.4.64.0512160829180.3060@g5.osdl.org>
	<20051216.142349.89717140.davem@davemloft.net>
	<Pine.LNX.4.64.0512161429500.3698@g5.osdl.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@osdl.org>
Date: Fri, 16 Dec 2005 14:38:47 -0800 (PST)

> A number of architectures have a "prefetch for write ownership" 
> instruction that you can use for this. Exactly because "ld+cas" should 
> not get a shared line initially.
> 
> I though sparc had an ASI to do the same? No?

No, no special ASI exists to do that, although it would be nice. :-)
I'd have to use a prefetch for write.

BTW, it is interesting that you can use CAS to get a cache line into
the local processor in Owned state with %100 certainty (unlike
prefetch for write which might get cancelled) by doing something like:

	CAS	[MEM], ZERO, ZERO

and you can do this to any valid memory address without changing the
contents.  This is useful for doing things like resetting parity bits
while doing memory error recorvery.

> It would seem to be the obvious thing to do for better lock performance, 
> and I'd assume that locks are some of the most common cases of real cache 
> interactions, so maybe the shared case only effectively happens if two 
> CPU's are reading at the same time.
> 
> Somebody who looks at cache protocol diagrams could check. I'm too lazy.

For both MOESI and MOSI cache coherency protocols, misses on loads
result in a Shared state cache line when another processor has the
data in it's cache too, regardless of whether that line in the other
cpu is dirty or not.

When the write comes along, the next transaction occurs to kick it
out the other cpu(s) caches and then the local line is placed into
Owned state.

I'll have to add "put write prefetch in CAS sequences" onto my sparc64
TODO list :-)
