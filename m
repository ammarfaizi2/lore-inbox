Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262682AbREOIeU>; Tue, 15 May 2001 04:34:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262680AbREOIeK>; Tue, 15 May 2001 04:34:10 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:17032 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262684AbREOId7>;
	Tue, 15 May 2001 04:33:59 -0400
Date: Tue, 15 May 2001 04:33:57 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Chris Wedgwood <cw@f00f.org>, Richard Gooch <rgooch@ras.ucalgary.ca>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Getting FS access events
In-Reply-To: <Pine.LNX.4.31.0105150058370.22938-100000@p4.transmeta.com>
Message-ID: <Pine.GSO.4.21.0105150424310.19333-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 15 May 2001, Linus Torvalds wrote:

> Looks like there are 19 filesystems that use the buffer cache right now:
> 
> 	grep -l bread fs/*/*.c | cut -d/ -f2 | sort -u | wc
> 
> So quite a bit of work involved.

UNIX-like ones (and that includes QNX) are easy. HFS is hopeless - it won't
be fixed unless authors will do it. Tigran will probably fix BFS just as a
learning experience ;-) ADFS looks tolerably easy to fix. AFFS... directories
will be pure hell - blocks jump from directory to directory at zero notice.
NTFS and HPFS will win from switch (esp. NTFS). FAT is not a problem, if we
are willing to break CVF and let author fix it. Reiserfs... Dunno. They've
got a private (slightly mutated) copy of ~60% of fs/buffer.c. UDF should be
OK. ISOFS... ask Peter. JFFS - dunno.

So probably we'll have to keep the buffer cache (AFFS looks like a real
killer), but we will be able to do pagecache-only versions of a_ops methods.
If fs has no metadata in buffer cache we can drop unmap_underlying_metadata()
for it.

