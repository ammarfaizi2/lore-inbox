Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262283AbTLHUnf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 15:43:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262308AbTLHUnf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 15:43:35 -0500
Received: from pirx.hexapodia.org ([65.103.12.242]:14238 "EHLO
	pirx.hexapodia.org") by vger.kernel.org with ESMTP id S262283AbTLHUnd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 15:43:33 -0500
Date: Mon, 8 Dec 2003 14:43:32 -0600
From: Andy Isaacson <adi@hexapodia.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sparse file performance (was Re: Is there a "make hole" (truncate in middle) syscall?)
Message-ID: <20031208144332.A8094@hexapodia.org>
References: <200312041432.23907.rob@landley.net> <20031204172348.A14054@hexapodia.org> <20031205150008.B14054@hexapodia.org> <Pine.LNX.4.58.0312051309390.9125@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.58.0312051309390.9125@home.osdl.org>; from torvalds@osdl.org on Fri, Dec 05, 2003 at 01:12:21PM -0800
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 05, 2003 at 01:12:21PM -0800, Linus Torvalds wrote:
> On Fri, 5 Dec 2003, Andy Isaacson wrote:
> > I got curious enough to run some tests, and was suprised at the results.
> > My machine (Athlon XP 2400+, 2030 MHz, 512 MB, KT400, 2.4.22) can read
> > out of buffer cache at 234 MB/s, and off of its IDE disk at 40 MB/s.
> > I'd assumed that read(2)ing a holey file would go faster than reading
> > out of buffer cache; in theory you could do it completely in L1 cache
> > (with a 4KB buffer, it's just a ton of syscalls, some page table
> > manipulation, and a bunch of memcpy() out of a single zero page).  But
> > it turns out that reading a hole is *slower* than reading data from
> > buffer cache, just 195 MB/s.
> 
> That's because we actually instantiate the page cache pages even for
> holes. We have to, or we'd have to special-case them no end (and quite
> frankly, "hole read performance" is not something worth special casing,
> since it just isn't done under any real load).
> 
> So reading a hole implies creating the page cache entry and _clearing_ it.
> For each page. So while you may read from the L1, you also have to do
> writeback of the _previous_ pages from the L1 into the L2 and eventually
> out to memory.
> 
> (And eventually the VM also has to get rid of the pages etc, of course).

Thanks for the explanation, Linus.

I modified my benchmark to use mmap(2) instead of read(2) and the
results are broadly comparable.  With a 10MB window, I get 331 MB/s
reading out of buffer cache and 185 MB/s reading a hole.  Reading a file
too large to cache is about the same (disk-limited) speed, 43 MB/s.

-andy
