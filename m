Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316947AbSEWQtf>; Thu, 23 May 2002 12:49:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316957AbSEWQte>; Thu, 23 May 2002 12:49:34 -0400
Received: from pizda.ninka.net ([216.101.162.242]:57313 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316947AbSEWQtd>;
	Thu, 23 May 2002 12:49:33 -0400
Date: Thu, 23 May 2002 09:34:16 -0700 (PDT)
Message-Id: <20020523.093416.133929379.davem@redhat.com>
To: davidm@hpl.hp.com, davidm@napali.hpl.hp.com
Cc: hugh@veritas.com, linux-kernel@vger.kernel.org, andrea@suse.de,
        torvalds@transmeta.com
Subject: Re: Q: PREFETCH_STRIDE/16
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <15597.7242.995639.291333@napali.hpl.hp.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: David Mosberger <davidm@napali.hpl.hp.com>
   Date: Thu, 23 May 2002 09:43:54 -0700

     DaveM> All of these particular prefetches are amusing, with or
     DaveM> without your fix, considering there are other more powerful
     DaveM> ways to optimize this stuff. :-)
   
   What do you have in mind?

I mentioned this 1 or 2 days ago in the TLB thread with
Linus, you pessimistically maintain a tiny bitmap per
mm_struct which keeps track of where mappings actually
are.  You use some hash function on the virtual address
to determine the bit.  You clear it when the mm_struct is
new, and you just set bits when mappings are installed.
Very simple.

Then all of these "walk all valid page tables" loops that scan entire
mostly empty pages of pgd/pmd/pte entries for no reason can just check
the bitmap instead.

Most of the exit overhead is in clear_page_tables walking over entire
pages.  It effectively flushes the cache unless all you are doing is
fork/exit/fork/exit
