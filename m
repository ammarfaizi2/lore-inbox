Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267163AbRGKEH1>; Wed, 11 Jul 2001 00:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267196AbRGKEHR>; Wed, 11 Jul 2001 00:07:17 -0400
Received: from horus.its.uow.edu.au ([130.130.68.25]:22742 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S267195AbRGKEHN>; Wed, 11 Jul 2001 00:07:13 -0400
Message-ID: <3B4BD13F.6CC25B6F@uow.edu.au>
Date: Wed, 11 Jul 2001 14:08:31 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Black <mblack@csihq.com>
CC: "linux-kernel@vger.kernel.or" <linux-kernel@vger.kernel.org>,
        ext2-devel@lists.sourceforge.net
Subject: Re: 2.4.6 and ext3-2.4-0.9.1-246
In-Reply-To: <02ae01c10925$4b791170$e1de11cc@csihq.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Black wrote:
> 
> I started testing 2.4.6 with ext3-2.4-0.9.1-246 yesterday morning and
> immediately hit a wall.
> 
> Testing on a an SMP kernel -- dual IDE RAID1 set the system temporarily
> locked up (telnet window stops until disk I/O is complete).

Mike, we're going to need a lot more detail to reproduce this.

Let me describe how I didn't reproduce it and perhaps
you can point out any differences:

- Kernel 2.4.6+ext3-2.4-0.9.1.

- Two 4gig IDE partitions on separate disks combined into a
  RADI1 device.

- 64 megs of memory (32meg lowmem, 32meg highmem)

- 1 gig swapfile on the ext3 raid device.

- Ran  ./tiobench.pl --threads 16

That's a *lot* more aggressive than your setup, yet
it ran to completion quite happily.

I'd be particularly interested in knowing how much memory
you're using.  It certainly sounds like you're experiencing
memory exhaustion.  ext3's ability to recover from out-of-memory
situations was weakened recently so as to reduce our impact
on core kernel code.  I'll be generating an incremental patch
which puts that code back in.

In the meantime, could you please retest with this somewhat lame
alternative?



--- linux-2.4.6/mm/vmscan.c	Wed Jul  4 18:21:32 2001
+++ lk-ext3/mm/vmscan.c	Wed Jul 11 14:03:10 2001
@@ -852,6 +870,9 @@ static int do_try_to_free_pages(unsigned
 	 * list, so this is a relatively cheap operation.
 	 */
 	if (free_shortage()) {
+		extern void shrink_journal_memory(void);
+
+		shrink_journal_memory();
 		ret += page_launder(gfp_mask, user);
 		shrink_dcache_memory(DEF_PRIORITY, gfp_mask);
 		shrink_icache_memory(DEF_PRIORITY, gfp_mask);
