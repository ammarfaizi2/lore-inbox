Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314838AbSENAao>; Mon, 13 May 2002 20:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314841AbSENAam>; Mon, 13 May 2002 20:30:42 -0400
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:54766 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S314838AbSENAaj>; Mon, 13 May 2002 20:30:39 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15584.23204.925373.44968@wombat.chubb.wattle.id.au>
Date: Tue, 14 May 2002 10:30:28 +1000
To: Christoph Hellwig <hch@infradead.org>
Cc: Peter Chubb <peter@chubb.wattle.id.au>, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com, axboe@suse.de, akpm@zip.com.au,
        martin@dalecki.de, neilb@cse.unsw.edu.au
Subject: Re: [PATCH] remove 2TB block device limit
In-Reply-To: <20020513131339.A4610@infradead.org>
X-Mailer: VM 7.03 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Christoph" == Christoph Hellwig <hch@infradead.org> writes:

Christoph> On Mon, May 13, 2002 at 08:28:30PM +1000, Peter Chubb
Christoph> wrote:
>> There's now a patch available against 2.5.15, and the BK repository
>> has been updated to v2.5.15 as well:
>> 
>> http://www.gelato.unsw.edu.au/patches/2.5.15-largefile-patch
>> bk://gelato.unsw.edu.au:2023/

Christoph> This looks really good, I'd like to see something like that
Christoph> merged soon!  Some comments:

Christoph>  - please move the sector_t typedef from <linux/types.h> to
Christoph> <asm/types.h>, so 64 bit arches don't have to have the
Christoph> CONFIG_ option at all, some 32bit plattforms that are
Christoph> unlikely to ever support large disks (m68k comes to mind)
Christoph> can make it 32bit unconditionally and some like i386 can
Christoph> use a config option.  - sector_div should move to a common
Christoph> header (blkdev.h?)

That's not a bad idea, I'll do it.

Christoph> And something related to general sector_t usage:

Christoph>  - what about sector_t vs daddr_t?  Linux still has
Christoph> daddr_t, but it is still always 32bit, I think a big
Christoph> s/sector_t/daddr_t/ would fit the traditional unix way of
Christoph> doing disk addressing

Yes I considered that, but daddr_t is exported to userland by the tape
ioctls, and is defined to be 32-bit, so it'd require out-of-kernel changes.

Besides, Jens had introduced sector_t for the purpose of counting
blocks and sectors, so I thought I may as well use it.  One could
argue that it's misnamed (personally, I liked Ben's `blkoff_t' for
offset in blocks), but it's been thare for four months or so, and was
already being used in likely places throughout the block layer.  I
just extended its use to all the places I thought were necessary
(there may be some paths that I've missed; but I hope not).

Christoph>  - why is the get_block block argument
Christoph> a sector_t?  It presents a logical filesystem block which
Christoph> usually is larger than the sector, not to mention that for
Christoph> the usual blocksize == PAGE_SIZE case a ulong is enough as
Christoph> that is the same size the pagecache limit triggers.

For filesystems that *can* handle logical filesystem blocks beyond the
2^32 limit (i.e., that use >32bit offsets in their on-disc format),
the get_block() argument has to be > 32bits long.  At  the moment
that's only JFS and XFS, but reiserfs version 4 looks as if it might
go that way.  We'll need this especially when the pagecache limit is
gone.

Besides, blocksize is not usually pagesize.  ext[23] uses 1k or 4k
blocks depending on the size and expected use of the filesystem; alpha
pagesize is usually 8k, for example.  The arm uses 4k, 16k or 32k
pagesizes depending on the model.

So on 32-bit systems, ulong is not enough.  (in fact if you look at
jfs, the first thing jfs_get_block does is convert the block number
arg to a 64-bit number).

Peter C
