Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316961AbSEWRQS>; Thu, 23 May 2002 13:16:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316962AbSEWRQR>; Thu, 23 May 2002 13:16:17 -0400
Received: from pizda.ninka.net ([216.101.162.242]:15330 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316961AbSEWRQQ>;
	Thu, 23 May 2002 13:16:16 -0400
Date: Thu, 23 May 2002 10:00:58 -0700 (PDT)
Message-Id: <20020523.100058.12299944.davem@redhat.com>
To: davidm@hpl.hp.com, davidm@napali.hpl.hp.com
Cc: hugh@veritas.com, linux-kernel@vger.kernel.org, andrea@suse.de,
        torvalds@transmeta.com
Subject: Re: Q: PREFETCH_STRIDE/16
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <15597.8361.533679.563624@napali.hpl.hp.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: David Mosberger <davidm@napali.hpl.hp.com>
   Date: Thu, 23 May 2002 10:02:33 -0700

   Sounds like something worth experimenting with.  I doubt you could
   really avoid (effectively) flushing the caches, but even if there are
   just a few zero bits in the bitmap at the time of the tear-down, a
   fair amount of time could be saved.

You'd be surprised how many 0 bits there will be in the average
process.  Even if you bring in all of emacs, glibc, X11R6 libs
etc. and the anonymous memory, there are still a HUGE portion of the
address space totally unused.

But like you said, worth experimenting with :-) First test would be,
start with 1 unsigned long as the bitmask in mm_context_t.  Just
implement the bit setting part.  Then at exit() count how many 0 bits
are left, record this into some counter table which has one counter
for 0 --> N_BITS_IN_LONG.  Make some debug /proc thing which spits the
table out.  (hint: at fork, clear out the child's bitmask before
copy_page_range is run for best results :-)

You can use this to do vaious things and see how much there is to gain
by going to two unsigned longs, three, etc.

Then you can hack up the actual clear_page_tables optimization (to
start) and measure the result.
