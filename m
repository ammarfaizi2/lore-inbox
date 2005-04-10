Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261533AbVDJRlj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261533AbVDJRlj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 13:41:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261534AbVDJRlj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 13:41:39 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:11441 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261533AbVDJRlR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 13:41:17 -0400
Date: Sun, 10 Apr 2005 10:38:05 -0700
From: Paul Jackson <pj@engr.sgi.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: cw@f00f.org, torvalds@osdl.org, davem@davemloft.net, andrea@suse.de,
       mbp@sourcefrog.net, linux-kernel@vger.kernel.org,
       dlang@digitalinsight.com
Subject: Re: Kernel SCM saga..
Message-Id: <20050410103805.7eee2fea.pj@engr.sgi.com>
In-Reply-To: <20050410120331.GA8878@elte.hu>
References: <1112939769.29544.161.camel@hope>
	<Pine.LNX.4.58.0504072334310.28951@ppc970.osdl.org>
	<20050408083839.GC3957@opteron.random>
	<Pine.LNX.4.58.0504081647510.28951@ppc970.osdl.org>
	<20050409022701.GA14085@opteron.random>
	<Pine.LNX.4.58.0504082240460.28951@ppc970.osdl.org>
	<20050409155511.7432d5c7.davem@davemloft.net>
	<Pine.LNX.4.58.0504091611570.1267@ppc970.osdl.org>
	<20050410001435.GA23401@taniwha.stupidest.org>
	<20050409185636.0945abdf.pj@engr.sgi.com>
	<20050410120331.GA8878@elte.hu>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo wrote:
> With default gzip it's 3.3 seconds though,
> and that still compresses it down to 57 MB.

Interesting.  I'm surprised how much a bunch of separate, modest sized
files can be compressed.

I'm unclear what matters most here.

Space on disk certainly isn't much of an issue.  Even with Andrew Morton
on our side, we still can't grow the kernel as fast as the disk drive
manufacturers can grow disk sizes.

Main memory size of the compressed history matters to Linus and his top
20 lieutenants doing full kernel source patching as a primary mission if
they can't fit the source _history_ in main memory.  But those people
are running 1 GByte or more of RAM - so whether it is 95, 57 or 45
MBytes, it fits fine.  The rest of us are mostly concerned with whether
a kernel build fits in memory.

Looking at an arch i386 kernel build tree I have at hand, I see the
following disk usage:

	102 MBytes - BitKeeper/*
	287 MBytes - */SCCS/* (outside of already counted BitKeeper/*)
	232 MBytes - checked out source files
	 94 MBytes - ELF and other build byproducts
	---
	715 MBytes - Total

Converting from bk to git, I guess this becomes:

	 97 MBytes - git (zlib)
	232 MBytes - checked out source files
	 94 MBytes - ELF and other build byproducts
	---
	423 MBytes - Total

Size matters when its a two to one difference, but when we are down to a
10% to 15% difference in the Total, its presentation that matters.  The
above numbers tell me that this is not a pure size issue for local disk
or memory usage.

What does matter that I can see:

 1) Linus explicitly stated he wanted "a raw zlib compressed blob,
    not a gzipped file", to encourage everyone to use the git tools to
    access this data.  He did not "want people editing repostitory files
    by hand."  I'm not sure what he gains here - it did annoy me for a
    couple hours before I decided fixing my supper was more important.

 2) The time to compress will be noticed by users as a delay when
    checking in changes (I'm guessing zlib compresses relatively faster).

 3) The time to copy compressed data over the internet will be
    noticed by users when upgrading kernel versions (gzip can
    compress smaller).

 4) Decompress times are smaller so don't matter as much.

 5) Zlib has a nice library, and is patent free.  I don't know about gzip.

 6) As you note, zlib has rsync-friendly, recovery-friendly Z_PARTIAL_FLUSH.
    I don't know about gzip.

My guess is that Linus finds (2) and (3) to balance each other, and that
(1) decides the point, in favor of zlib.  Well, that or a simpler
hypothesis, that he found the nice library (5) convenient, and (1)
sealed the deal, with the other tradeoffs passing through his
subconscious faster than he bothered to verbalize them.

You (Ingo) seem in your second message to be encouraging further
consideration of gzip, for its improved compression.

How will that matter to us, day to day?

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
