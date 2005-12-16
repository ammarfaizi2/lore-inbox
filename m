Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964800AbVLPWjZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964800AbVLPWjZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 17:39:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932543AbVLPWjZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 17:39:25 -0500
Received: from smtp.osdl.org ([65.172.181.4]:7075 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932554AbVLPWjY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 17:39:24 -0500
Date: Fri, 16 Dec 2005 14:38:47 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "David S. Miller" <davem@davemloft.net>
cc: dhowells@redhat.com, nickpiggin@yahoo.com.au, arjan@infradead.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, cfriesen@nortel.com,
       hch@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation 
In-Reply-To: <20051216.142349.89717140.davem@davemloft.net>
Message-ID: <Pine.LNX.4.64.0512161429500.3698@g5.osdl.org>
References: <15412.1134561432@warthog.cambridge.redhat.com>
 <12186.1134732601@warthog.cambridge.redhat.com> <Pine.LNX.4.64.0512160829180.3060@g5.osdl.org>
 <20051216.142349.89717140.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 16 Dec 2005, David S. Miller wrote:
> 
> Actually, this points out a problem with "compare and swap".  The
> typical loop is of the form:
> 
> 	LOAD [MEM], REG1
> 	OP   REG1, X, REG2
> 	CAS  [MEM], REG1, REG2
> 
> That first LOAD instruction, if it misses in the L2, causes the cache
> line to be requested for sharing.  Then the CAS instruction will need
> to issue another cache coherency transaction to get the cache line
> into owned state.

A number of architectures have a "prefetch for write ownership" 
instruction that you can use for this. Exactly because "ld+cas" should 
not get a shared line initially.

I though sparc had an ASI to do the same? No?

> (Are there any CPUs that peek forward and look for the CAS
>  instruction to decide to issue the more appropriate request
>  for the cache line in Owned state?  That would be cool...)

I don't think anybody does, although it wouldn't be impossible. Any OoO 
processor would _tend_ to have enough visibility that they could see any 
stores that are "close" (not just a cas) and might be clever enough to 
modify a memory read to be a read-with-intent-to-write op.

Of course, if it was in memory (as opposed to somebody elses caches), I 
think most cache protocols will start it up in exclusive state anyway. 
Same may or may not happen when you have a dirty hit on another CPU that 
requires a write-back (ie the other CPU would always invalidate on 
writeback).

It would seem to be the obvious thing to do for better lock performance, 
and I'd assume that locks are some of the most common cases of real cache 
interactions, so maybe the shared case only effectively happens if two 
CPU's are reading at the same time.

Somebody who looks at cache protocol diagrams could check. I'm too lazy.

		Linus
