Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267297AbRGKMST>; Wed, 11 Jul 2001 08:18:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267296AbRGKMSJ>; Wed, 11 Jul 2001 08:18:09 -0400
Received: from picard.csihq.com ([204.17.222.1]:15791 "EHLO picard.csihq.com")
	by vger.kernel.org with ESMTP id <S267294AbRGKMRw>;
	Wed, 11 Jul 2001 08:17:52 -0400
Message-ID: <021801c10a03$62434540$e1de11cc@csihq.com>
From: "Mike Black" <mblack@csihq.com>
To: "Andrew Morton" <andrewm@uow.edu.au>
Cc: "linux-kernel@vger.kernel.or" <linux-kernel@vger.kernel.org>,
        <ext2-devel@lists.sourceforge.net>
In-Reply-To: <02ae01c10925$4b791170$e1de11cc@csihq.com> <3B4BD13F.6CC25B6F@uow.edu.au>
Subject: Re: 2.4.6 and ext3-2.4-0.9.1-246
Date: Wed, 11 Jul 2001 08:16:58 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My system is:
Dual 1Ghz PIII
2G RAM
2x2G swapfiles
And I ran tiobench as tiobench.pl --size 4000 (twice memory)

Me thinkst SMP is probably the biggest difference in this list.

I ran this on another "smaller" memory (still dual CPU though) machine and
noticed this on top:

12983 root      15   0   548  544   448 D    73.6  0.2   0:11 tiotest
    3 root      18   0     0    0     0 SW   72.6  0.0   0:52 kswapd

kswapd is taking an awful lot of CPU time.  Not sure why it should be
hitting swap at all.
I noticed a similar behavior even with NO swap -- kswapd still chewing up
time.

________________________________________
Michael D. Black   Principal Engineer
mblack@csihq.com  321-676-2923,x203
http://www.csihq.com  Computer Science Innovations
http://www.csihq.com/~mike  My home page
FAX 321-676-2355
----- Original Message -----
From: "Andrew Morton" <andrewm@uow.edu.au>
To: "Mike Black" <mblack@csihq.com>
Cc: "linux-kernel@vger.kernel.or" <linux-kernel@vger.kernel.org>;
<ext2-devel@lists.sourceforge.net>
Sent: Wednesday, July 11, 2001 12:08 AM
Subject: Re: 2.4.6 and ext3-2.4-0.9.1-246


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



--- linux-2.4.6/mm/vmscan.c Wed Jul  4 18:21:32 2001
+++ lk-ext3/mm/vmscan.c Wed Jul 11 14:03:10 2001
@@ -852,6 +870,9 @@ static int do_try_to_free_pages(unsigned
  * list, so this is a relatively cheap operation.
  */
  if (free_shortage()) {
+ extern void shrink_journal_memory(void);
+
+ shrink_journal_memory();
  ret += page_launder(gfp_mask, user);
  shrink_dcache_memory(DEF_PRIORITY, gfp_mask);
  shrink_icache_memory(DEF_PRIORITY, gfp_mask);

