Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316981AbSEWSck>; Thu, 23 May 2002 14:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316982AbSEWScj>; Thu, 23 May 2002 14:32:39 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:26618 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S316979AbSEWSci>;
	Thu, 23 May 2002 14:32:38 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15597.13752.344276.648677@napali.hpl.hp.com>
Date: Thu, 23 May 2002 11:32:24 -0700
To: "David S. Miller" <davem@redhat.com>
Cc: davidm@hpl.hp.com, davidm@napali.hpl.hp.com, hugh@veritas.com,
        linux-kernel@vger.kernel.org, andrea@suse.de, torvalds@transmeta.com
Subject: Re: Q: PREFETCH_STRIDE/16
In-Reply-To: <20020523.100058.12299944.davem@redhat.com>
X-Mailer: VM 7.03 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Thu, 23 May 2002 10:00:58 -0700 (PDT), "David S. Miller" <davem@redhat.com> said:

  DaveM> You'd be surprised how many 0 bits there will be in the
  DaveM> average process.  Even if you bring in all of emacs, glibc,
  DaveM> X11R6 libs etc. and the anonymous memory, there are still a
  DaveM> HUGE portion of the address space totally unused.

But don't confuse the portion of address space used with the number of
page tables in use!  Even if you use a teeny tiny portion of a 64-bit
address space, you can still have hundreds and thousands of page table
pages.

Also, we should not ignore the advantages of the current scheme:

 o It's so straight-forward, it's virtually impossible to screw it up
   (with the hashed scheme, forgetting to set a bit just once could
   lead to very difficult-to-track-down bugs; been there, done that,
   in a slightly different context, and it was ugly...).

 o Performance is very predicable (basically linear in virtual address
   space in use).  There is a danger that a hashed scheme would be
   optimized for today's workloads.  As the working sets increase over
   the years, the hashed scheme could eventually break down and the
   worst part would be that it would be very hard to notice (only
   effect is bad performance for very large tasks; few benchmarks
   would probably catch such worse-than-optimal performance).

  DaveM> But like you said, worth experimenting with :-) First test
  DaveM> would be, start with 1 unsigned long as the bitmask in
  DaveM> mm_context_t.  Just implement the bit setting part.  Then at
  DaveM> exit() count how many 0 bits are left, record this into some
  DaveM> counter table which has one counter for 0 --> N_BITS_IN_LONG.
  DaveM> Make some debug /proc thing which spits the table out.
  DaveM> (hint: at fork, clear out the child's bitmask before
  DaveM> copy_page_range is run for best results :-)

  DaveM> You can use this to do vaious things and see how much there
  DaveM> is to gain by going to two unsigned longs, three, etc.

  DaveM> Then you can hack up the actual clear_page_tables
  DaveM> optimization (to start) and measure the result.

Yes.  Hopefully, someone with some spare time at hand can play with
this.

	--david
