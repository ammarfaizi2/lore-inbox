Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261698AbVF0CAg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261698AbVF0CAg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 22:00:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261707AbVF0CAe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 22:00:34 -0400
Received: from gate.crashing.org ([63.228.1.57]:14979 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261698AbVF0CAW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 22:00:22 -0400
Subject: Re: increased translation cache footprint in v2.6
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: marcelo.tosatti@cyclades.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       bcrl@kvack.org
In-Reply-To: <20050626.173338.41634345.davem@davemloft.net>
References: <20050626172334.GA5786@logos.cnet>
	 <20050626164939.2f457bf6.akpm@osdl.org> <20050626185210.GB6091@logos.cnet>
	 <20050626.173338.41634345.davem@davemloft.net>
Content-Type: text/plain
Date: Mon, 27 Jun 2005 11:55:24 +1000
Message-Id: <1119837324.5133.74.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-06-26 at 17:33 -0700, David S. Miller wrote:
> From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
> Date: Sun, 26 Jun 2005 15:52:10 -0300
> 
> > Well, a TLB entry might cache different sized pages. The platform
> > support 4kb, 16kb and 8Mb (IIRC, maybe some other size also).  The
> > bigger pages (8Mb) are only used to map 8Mbytes of instruction at
> > KERNELBASE, 24Mbytes of data (3 8Mbyte entries) also at KERNELBASE
> > and another 8Mbytes of the configuration registers memory space,
> > which lives outside RAM space.
> 
> Why don't you use 8MB TLB entries when there is a miss to
> one of the PAGE_OFFSET pages?  I'm not saying to lock them,
> just to use large 8MB TLB entries when a miss is taken for
> kernel data accesses to where the kernel maps all of lowmem.

Looks like the right thing to do indeed. Should be fairly easy, just
test if the address if negative (you'll never use >2Gb address space on
these) and ... heh, you already do it in your 8xx TLB miss handlers to
separate user page tables from kernel page tables :) So I doubt the
normal user TLB miss path will be any different and the kernel TLB miss
path though be separate and faster due to having much less misses.

Also, you may want to bump the whole page size to 64k on these,
interesting exercise but probably not very difficult. Our ABI is already
clean at the userland level for up to 64k. We did some experiments on
ppc64 with pseudo-64k pages (emulating them in software) and common
ppc32 userland is just fine.

Using a larger page size makes a lot of sense of those embedded CPUs
with small TLBs where you usually don't use much or no swap at all.

Ben.


