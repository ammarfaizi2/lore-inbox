Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932243AbWJTTyj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932243AbWJTTyj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 15:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932281AbWJTTyj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 15:54:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18129 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932243AbWJTTyi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 15:54:38 -0400
Date: Fri, 20 Oct 2006 12:54:17 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: David Miller <davem@davemloft.net>
cc: nickpiggin@yahoo.com.au, ralf@linux-mips.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, anemo@mba.ocn.ne.jp
Subject: Re: [PATCH 1/3] Fix COW D-cache aliasing on fork
In-Reply-To: <20061020.123635.95058911.davem@davemloft.net>
Message-ID: <Pine.LNX.4.64.0610201251440.3962@g5.osdl.org>
References: <20061019.155939.48528489.davem@davemloft.net> <4538DFAC.1090206@yahoo.com.au>
 <Pine.LNX.4.64.0610200846260.3962@g5.osdl.org> <20061020.123635.95058911.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 20 Oct 2006, David Miller wrote:
> 
> You get an asynchronous fault from the L2 cache, and that's also what
> happens when the TLB entry is missing during L2 writeback too.  You
> get a level 15 non-maskable IRQ when these asynchronous errors happen.

Well, sparc always was crud. I can see the missing tlb entry, but if it's 
been turned read-only, the write-back should still work (it clearly _was_ 
writable when the write that dirtied the cacheline happened).

Anyway, if you cannot flush a read-only mapping, then the "flush at COW 
fault time" won't work _either_, since the original mapping is still 
read-only.

So regardless, the COW-time flush cannot work. But the "flush before the 
TLB flush, and then flush after in case we had a race" approach should 
work as well as it can in practice, no?

			Linus
