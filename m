Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264353AbTLEVMb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 16:12:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264376AbTLEVMa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 16:12:30 -0500
Received: from fw.osdl.org ([65.172.181.6]:32653 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264353AbTLEVM3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 16:12:29 -0500
Date: Fri, 5 Dec 2003 13:12:21 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andy Isaacson <adi@hexapodia.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: sparse file performance (was Re: Is there a "make hole" (truncate
 in middle) syscall?)
In-Reply-To: <20031205150008.B14054@hexapodia.org>
Message-ID: <Pine.LNX.4.58.0312051309390.9125@home.osdl.org>
References: <200312041432.23907.rob@landley.net> <20031204172348.A14054@hexapodia.org>
 <20031205150008.B14054@hexapodia.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 5 Dec 2003, Andy Isaacson wrote:
>
> I got curious enough to run some tests, and was suprised at the results.
> My machine (Athlon XP 2400+, 2030 MHz, 512 MB, KT400, 2.4.22) can read
> out of buffer cache at 234 MB/s, and off of its IDE disk at 40 MB/s.
> I'd assumed that read(2)ing a holey file would go faster than reading
> out of buffer cache; in theory you could do it completely in L1 cache
> (with a 4KB buffer, it's just a ton of syscalls, some page table
> manipulation, and a bunch of memcpy() out of a single zero page).  But
> it turns out that reading a hole is *slower* than reading data from
> buffer cache, just 195 MB/s.

That's because we actually instantiate the page cache pages even for
holes. We have to, or we'd have to special-case them no end (and quite
frankly, "hole read performance" is not something worth special casing,
since it just isn't done under any real load).

So reading a hole implies creating the page cache entry and _clearing_ it.
For each page. So while you may read from the L1, you also have to do
writeback of the _previous_ pages from the L1 into the L2 and eventually
out to memory.

(And eventually the VM also has to get rid of the pages etc, of course).

			Linus
