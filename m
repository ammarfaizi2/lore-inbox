Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965152AbWJBRZZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965152AbWJBRZZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 13:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965157AbWJBRZY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 13:25:24 -0400
Received: from pfx2.jmh.fr ([194.153.89.55]:28601 "EHLO pfx2.jmh.fr")
	by vger.kernel.org with ESMTP id S965152AbWJBRZX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 13:25:23 -0400
From: Eric Dumazet <dada1@cosmosbay.com>
To: Vadim Lobanov <vlobanov@speakeasy.net>
Subject: Re: [PATCH 4/4] fdtable: Implement new pagesize-based fdtable allocation scheme.
Date: Mon, 2 Oct 2006 19:25:18 +0200
User-Agent: KMail/1.9.4
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
References: <200610011414.30443.vlobanov@speakeasy.net> <200610021052.35731.dada1@cosmosbay.com> <200610021000.00768.vlobanov@speakeasy.net>
In-Reply-To: <200610021000.00768.vlobanov@speakeasy.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610021925.19069.dada1@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 02 October 2006 19:00, Vadim Lobanov wrote:
> On Monday 02 October 2006 01:52, Eric Dumazet wrote:
>
> > Current scheme is to allocate power of two sizes, and not 'the smallest
> > that accommodates the requested fd count'. This is for a good reason,
> > because we don't want to call vmalloc()/vfree() each time a process opens
> > 512 or 1024 more files (x86_64 or ia32)
>
> Yep, that is most definitely a consideration. I was balancing it against
> the fact that, when the table becomes big, growing it by a power of two
> regardless of the size results in massive memory usage deltas. The worry
> here is that an application may likely cause the table to grow by a huge
> amount, due to the power-of-two increase, and then actually use only a
> modest number of further fds, wasting the rest of the allocated table
> memory.
>
> Which applications open so many file handles so quickly? Do they actually
> need the amortized power-of-two table area increase? In those cases, would
> the actual process of opening these files take more time than growing the
> table in fixed-size steps? Or at least outweigh it enough that it would be
> more preferable to try to reduce memory waste instead of improve file open
> time?

I think that for such applications, the 'waste' of ram for fd table is nothing 
compared to the ram cost of opened files/sockets/dentries/inodes.

>
> Is it really true that it will create less fragmentation? It seems to me
> that this will only be the true if most of the other heavy users of vmalloc
> also tried to use power-of-two allocation sizes.

I am quite sure that on my machines, big vmalloc users are fdtable most of the 
time.

>
> What do you think of Andi Kleen's follow-up suggestion about eliminating
> vmalloc use altogether?

It would be interesting, but would need one indirection level, that could kill 
performance of said huge applications... For such applications, the cost of 
expanding fdtable is nothing compared to the cost of 
open()/close()/poll()/read()/write() calls. This is because fdtable never 
shrinks. So adding one indirection (if you use a table of pointers to PAGES 
containing 1024 or 512 (struct file *)). 

At least, expanding fdtable by 1024 slots would need to reallocate the first 
table (adding one void *), and allocating one PAGE only. No need to copy 
previous pages, this is a win.

Of course, big fdset still need vmalloc(), or else we cannot use 
find_next_zero_bit() anymore... And for such applications, the time and 
memory scanned to find a zero bit at open() time is probably the killer 
(touching a large part of cpu caches). One million bits is 128 KB...

Eric
