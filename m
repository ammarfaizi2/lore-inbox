Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271620AbRHPTPF>; Thu, 16 Aug 2001 15:15:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271623AbRHPTOq>; Thu, 16 Aug 2001 15:14:46 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:2567 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S271620AbRHPTOo>; Thu, 16 Aug 2001 15:14:44 -0400
Message-ID: <3B7C1B8F.708CBB9@zip.com.au>
Date: Thu, 16 Aug 2001 12:14:23 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.8-ac5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Mark Hemment <markhe@veritas.com>, Juergen Doelle <JDOELLE@de.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Align VM locks
In-Reply-To: <Pine.LNX.4.33.0108161839180.3340-100000@alloc.wat.veritas.com>,
		<Pine.LNX.4.33.0108161839180.3340-100000@alloc.wat.veritas.com>; from markhe@veritas.com on Thu, Aug 16, 2001 at 06:41:08PM +0100 <20010816202606.B8726@athlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> On Thu, Aug 16, 2001 at 06:41:08PM +0100, Mark Hemment wrote:
> > Hi,
> >
> >   The patch below ensures the pagecache_lock and pagemap_lru_lock aren't
> > sharing an L1 cacheline with anyone else - espically each other!
> 
> This is the right one:
> 
>         ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.8aa1/00_cachelinealigned-in-smp-1
> 

Problem with this approach is that it doesn't prevent the linker
from placing other data in the same cacheline as the aligned
lock, at higher addresses.

The work which Juergen Doelle did recently addresses this - just
special-case the five hot spinlocks with additional padding at
the end.

http://www.geocrawler.com/archives/3/5312/2001/7/0/6271339/

With the toolchain I'm using, with latest -ac kernels,
we happened to get lucky:

00000000c03053c0 D pagecache_lock
00000000c03053e0 D pagemap_lru_lock
00000000c03053e4 d file_shared_mmap
00000000c03053f0 d file_private_mmap

The linker decided to not put anything in pagecache_lock's line,
and vm_operations_struct is read-only....

Juergen demonstrated a 17% speedup of RAM-only dbench on an 8-way with
his patch.

And we perhaps should do something about these:

00000000c0305e64 d hash_table_lock
00000000c0305e68 d lru_list_lock
00000000c0305e6c d unused_list_lock

All in the same cacheline.  These tend to be taken back-to-back,
so splitting these apart may be less effective.  Be interesting
to measure these independently.

Juergen, I'd suggest you dust off that patch, add the conditionals
which make it a no-op on uniprocessor and submit it.  It's such a
simple, easy way to gain significant performance improvement - it's
worth doing.

-
