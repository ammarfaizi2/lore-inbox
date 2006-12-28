Return-Path: <linux-kernel-owner+w=401wt.eu-S964959AbWL1JPs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964959AbWL1JPs (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 04:15:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964965AbWL1JPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 04:15:48 -0500
Received: from mga05.intel.com ([192.55.52.89]:1351 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S964957AbWL1JPr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 04:15:47 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.12,215,1165219200"; 
   d="scan'208"; a="182380540:sNHT2363167758"
Subject: Re: [PATCH] mm: fix page_mkclean_one
From: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Miller <davem@davemloft.net>, ranma@tdiedrich.de,
       gordonfarquharson@gmail.com, tbm@cyrius.com,
       Peter Zijlstra <a.p.zijlstra@chello.nl>, andrei.popa@i-neo.ro,
       Andrew Morton <akpm@osdl.org>, hugh@veritas.com,
       nickpiggin@yahoo.com.au, arjan@infradead.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0612271835410.4473@woody.osdl.org>
References: <20061226.205518.63739038.davem@davemloft.net>
	 <Pine.LNX.4.64.0612271601430.4473@woody.osdl.org>
	 <Pine.LNX.4.64.0612271636540.4473@woody.osdl.org>
	 <20061227.165246.112622837.davem@davemloft.net>
	 <Pine.LNX.4.64.0612271835410.4473@woody.osdl.org>
Content-Type: text/plain; charset=utf-8
Date: Thu, 28 Dec 2006 17:15:49 +0800
Message-Id: <1167297349.15989.171.camel@ymzhang>
Mime-Version: 1.0
X-Mailer: Evolution 2.9.2 (2.9.2-2.fc7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-12-27 at 19:04 -0800, Linus Torvalds wrote:
> 
> On Wed, 27 Dec 2006, David Miller wrote:
> > > 
> > > I still don't see _why_, though. But maybe smarter people than me can see 
> > > it..
> > 
> > FWIW this program definitely triggers the bug for me.
> 
> Ok, now that I have something simple to do repeatable stuff with, I can 
> say what the pattern is.. It's not all that surprising, but it's still 
> worth just stating for the record.
> 
> What happens is that when I do the "packetized writes" in random order, 
> the _last_ write to a page occasionally just goes missing. It's not always 
> at the end of a page, as shown by for example:
> 
>  - A whole chunk got dropped:
> 
> 	Chunk 2094 corrupted (0-1459)  (1624-3083)
> 	Expected 46, got 0
> 	Written as (30912)55414(10000)
> 
>    That "Written as (x)y(z)" line means that the corrupted chunk was 
>    written as chunk #y, and the preceding and following chunks (that were 
>    _not_ corrupt) on the page was written as #x and #z respectively.
> 
>    In other words, the missing chunk (which is still zero) was written 
>    much later than the ones that were ok, and never hit the disk. It's a 
>    contiguous chunk in the middle of the page (chunks are 1460 bytes in 
>    size)
> 
>    The first line means that all bytes of the chunk (0-1459) were 
>    corrupted, and the values in parenthesis are the offsets within a page. 
>    In other words, this was a chunk in the _middle_ of a page.
> 
>  - The missing data can also be at the beginning or ends of pages:
> 
>    Beginning of the chunk missing, it was at the end of a page (page 
>    offsets 3288-4095) and the _next_ page got written out fine:
> 
> 	Chunk 2126 corrupted (0-807)  (3288-4095)
> 	Expected 78, got 0
> 	Written as (32713)55573(14301)
> 
>    End of a chunk missing, it was the beginning of a page (and the 
>    _previous_ page that contained the beginning of the chunk was written 
>    out fine)
> 
> 	Chunk 2179 corrupted (1252-1459)  (0-207)
> 	Expected 131, got 0
> 	Written as (45189)55489(15515)
> 
> Now, the reason I say this isn't surprising is that this is entirely 
> consistent with the dirty bit being dropped on the floor somewhere, and 
> likely through some interaction with the previous changes being in the 
> process of being written out.
> 
> Something (incorrectly) ends up deciding that it doesn't need to write the 
> page, since it's already written, or alternatively clears the dirty bit 
> too late (clears it because an _earlier_ write finished, never mind that 
> the new dirty data didn't make it).
There might be a narrow race between set_page_dirty and clear_page_dirty.

The test program is a process to write/read data. pdflush might write data
to disk asynchronously. After pdflush writes a page to disk, it will call (either by
softirq) clear_page_dirty to clear the dirty bit after getting the interrupt
notification. But just after the page is written to disk and before the interrupt
reports the result, the test process might change the data and unmap the area. When
the area is unmapped, the page is marked as dirty again, but just after that, the
interrupt arrives and the dirty bit is cleared, so the late data will not be written
to disk.

Function zap_pte_range checks pte to set page dirty if needed, but it doesn't
hold page lock. If the page lock is held before set page dirty, the race might
be avoided.

Yanmin
