Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264309AbTLETPA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 14:15:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264320AbTLETPA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 14:15:00 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:50621 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264309AbTLETOs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 14:14:48 -0500
Date: Fri, 5 Dec 2003 19:14:47 +0000
From: Matthew Wilcox <willy@debian.org>
To: Erez Zadok <ezk@cs.sunysb.edu>
Cc: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Phillip Lougher <phillip@lougher.demon.co.uk>,
       Kallol Biswas <kbiswas@neoscale.com>, linux-kernel@vger.kernel.org,
       "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: partially encrypted filesystem
Message-ID: <20031205191447.GC29469@parcelfarce.linux.theplanet.co.uk>
References: <20031205112050.GA29975@wohnheim.fh-wedel.de> <200312051616.hB5GGpef027492@agora.fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200312051616.hB5GGpef027492@agora.fsl.cs.sunysb.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 05, 2003 at 11:16:51AM -0500, Erez Zadok wrote:
> We compress each chunk separately; currently chunk==PAGE_CACHE_SIZE.  For
> each file foo we keep an index file foo.idx that records the offsets in the
> main file of where you might find the decompressed data for page N.  Then we
> hook it up into the page read/write ops of the VFS.  It works great for the
> most common file access patterns: small files, sequential/random reads, and
> sequential writes.  But, it works poorly for random writes into large files,
> b/c we have to decompress and re-compress the data past the point of
> writing.  Our paper provides a lot of benchmarks results showing performance
> and resulting space consumption under various scenarios.
> 
> We've got some ideas on how to improve performance for writes-in-the-middle,
> but they may hurt performance for common cases.  Essentially we have to go
> for some sort of O(log n)-like data structure, which'd make random writes
> much better.  But since it may hurt performance for other access patterns,
> we've been thinking about some way to support both modes and be able to
> switch b/t the two modes on the fly (or at least let users "mark" a file as
> one for which you'd expect a lot of random writes to happen).
> 
> If anyone has some comments or suggestions, we'd love to hear them.

Sure.  I've described it before on this list, but here goes:

What Acorn did for their RISCiX product (4.3BSD based, ran on an ARM box
in late 80s/early 90s) was compress each 32k page individually and write
it to a 1k block size filesystem (discs were around 50MB at the time,
1k was the right size).  This left the file full of holes, and wasted
on average around 512/32k = 1/64 of the compression that could have been
attained, but it was very quick to seek to the right place.

Now 4k block size filesystems are the rule, and page size is also
4k so you'd need to be much more clever to achieve the same effect.
Compressing 256k chunks at a time would give you the same wastage, but
I don't think Linux has very good support for filesystems that want to
drop 64 pages into the page cache when the VM/VFS only asked for one.

If it did, that would allow ext2/3 to grow block sizes beyond the current
4k limit on i386, which would be a good thing to do.  Or perhaps we just
need to bite the bullet and increase PAGE_CACHE_SIZE to something bigger,
like 64k.  People are going to want that on 32-bit systems soon anyway.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
