Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316946AbSEWQ1C>; Thu, 23 May 2002 12:27:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316947AbSEWQ1A>; Thu, 23 May 2002 12:27:00 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:50686 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S316946AbSEWQ0z>;
	Thu, 23 May 2002 12:26:55 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15597.6222.724619.443491@napali.hpl.hp.com>
Date: Thu, 23 May 2002 09:26:54 -0700
To: Hugh Dickins <hugh@veritas.com>
Cc: linux-kernel@vger.kernel.org, Andrea Arcangeli <andrea@suse.de>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Q: PREFETCH_STRIDE/16
In-Reply-To: <Pine.LNX.4.21.0205231554090.1304-100000@localhost.localdomain>
X-Mailer: VM 7.03 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Thu, 23 May 2002 16:12:16 +0100 (BST), Hugh Dickins <hugh@veritas.com> said:

  Hugh> Could anyone please shed light on PREFETCH_STRIDE, and in
  Hugh> particular its sole use:
  Hugh> prefetchw(pmd+j+(PREFETCH_STRIDE/16)); in mm/memory.c:
  Hugh> free_one_pgd().

  Hugh> That looks to me suspiciously like something inserted to suit
  Hugh> one particular architecture - ia64? is it really suitable for
  Hugh> others? is 4*L1_CACHE_SIZE really right for PREFETCH_STRIDE on
  Hugh> anything that prefetches except ia64? what's the "/ 16"?
  Hugh> shouldn't there be a "/ sizeof(pmd_t)" somewhere (PAE or not)?
  Hugh> is it right to prefetch each time around that loop? isn't it
  Hugh> appropriate only to the exit_mm (0 to TASK_SIZE) clearance?

  Hugh> All in all, I'm thinking that line shouldn't be there, or not
  Hugh> without a substantial comment...

That code certainly wasn't optimized for ia64.  Furthermore, I also do
not like the prefetch distance it's using.  In fact, in my ia64-patch,
I use the following code instead:

		prefetchw(pmd + j + PREFETCH_STRIDE/sizeof(*pmd));

This is more sensible (because it really does prefetch by the
PREFETCH_STRIDE distance) and it also happens to run (slightly) faster
on Itanium.

	--david
