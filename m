Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129319AbRCEOxQ>; Mon, 5 Mar 2001 09:53:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129318AbRCEOxH>; Mon, 5 Mar 2001 09:53:07 -0500
Received: from mail.zmailer.org ([194.252.70.162]:29962 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S129311AbRCEOwt>;
	Mon, 5 Mar 2001 09:52:49 -0500
Date: Mon, 5 Mar 2001 16:52:41 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Christoph Rohland <cr@sap.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4 and 2GB swap partition limit
Message-ID: <20010305165241.D15688@mea-ext.zmailer.org>
In-Reply-To: <CDF99E351003D311A8B0009027457F1403BF9E09@ausxmrr501.us.dell.com> <m3n1b0h9t3.fsf@linux.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3n1b0h9t3.fsf@linux.local>; from cr@sap.com on Mon, Mar 05, 2001 at 09:58:00AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 05, 2001 at 09:58:00AM +0100, Christoph Rohland wrote:
> Hi Matt,
> 
> On Sun, 4 Mar 2001, Matt Domsch wrote:
> > My concern is that if there continues to be a 2GB swap
> > partition/file size limitation, and you can have (as currently
> > #defined) 8 swap partitions, you're limited to 16GB swap, which then
> > follows a max of 8GB RAM.  We'd like to sell servers with 32GB or
> > 64GB RAM to customers who request such for their applications.  Such
> > customers generally have no problem purchasing additional disks to
> > be used for swap, likely on a hardware RAID controller.
> 
> I did think about that too and I also think the 2GB limit is not
> appropriate for the big servers. But I do not beleive that you need so
> much swap on these machines. If you drive a 32 GB machine so heavily
> into swap it is more busy finding the pages to swap than doing
> anything really interesting. (At least that's my experience)

	While 2.4 did grow the maximum filesizes to CACHEPAGESIZE*2G
	bytes by scaling pagecache contained file page offsets with
	the CACHEPAGESIZE -- which may or may not be the same as the
	machine PAGE_SIZE.  It can be larger, though propably not smaller.

	For SWAP uses there is also similar 32 bit quantity (actually
	it is "unsigned long"), however some bits in the the swp_entry_t
	are being used to something usefull in the cache logic besides
	of the offset inside the file.

	Indeed looking at the source,  include/asm-i386/pgtable.h
        defines following:

#define SWP_TYPE(x)             (((x).val >> 1) & 0x3f)
#define SWP_OFFSET(x)           ((x).val >> 8)
#define SWP_ENTRY(type, offset) ((swp_entry_t){ ((type) << 1)|((offset) << 8) })

	The i386 actually support up to 4*16 = 64 swap files (or partitions)
	with this SWP_TYPE() definition, while  include/linux/swap.h does
	define  MAX_SWAPFILES  to be 8 ...  If that were a pointer array
	to kmalloc()ed blocks, the limit could be much higher.  Indeed
	I think this is the only *static* limit anywhere in the current
	swap code.

	Similarly it supports 2^24 PAGES of swap at i386 per file/partition.
	( 16 million pages of 4k each = 64 GB -- should be enough ;) )
	( That would require vmalloc() to allocate 32 MB block, though.
	  That might not be possible at every occasion -> swapon may fail. )

	The more I read the documentation (= source and its comments),
	the more I am inclined to think that the beast *will* work with
	swap-partitions (and files!) larger than 2G.

	Stephen Tweedie did this 'SWAPSPACE2' work for 2.4 series, what
	he might tell ?   Is it really just a matter of fixing the
		mkswap
	utility ?  Was Stephen just conservative saying:
		"Don't go over 2G" (I haven't tested it)


	Reviewing thru the architectural definitions of these SWP_***()
	macroes, the shifts used for SWP_OFFSET seem to vary in between
	7-12 and for Alpha and MIPS64: 40.  Indeed things are not very
	easy to understand with 64 bit architectures.  It looks like
	those architectures use the low 32 bits of  swp_entry_t  for
	something, while most use at most couple of bits.

	Oh, even those 64-bit system seem to give at least 24 bits for
	PAGE_SIZE 'offset'.  The lowest bitcount for 'offset' seems to
	be at s390 which gives "only" 2^20 * 4k pages, or 4 GB per
	swap file/partition. (SWP_OFFSET() shifts with 12, which is
	same as PAGE_SHIFT for the machine.  Why SPARC64 uses PAGE_SHIFT
	in its own unique way, that I don't know.)

	Somehow I suspect that the makers of each architecture port have
	not quite understood what the swp_entry_t bits are used for, and
	have blindly presumed them to be related to PAGE_SIZE ...

> For 2.5 we could perhaps think about a new swapfile layout which
> allows bigger partitions.

	The format seems to be just fine.

> Greetings
> 		Christoph

/Matti Aarnio
