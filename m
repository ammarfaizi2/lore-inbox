Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315388AbSHFGtl>; Tue, 6 Aug 2002 02:49:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315437AbSHFGtl>; Tue, 6 Aug 2002 02:49:41 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:37870 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S315388AbSHFGti>; Tue, 6 Aug 2002 02:49:38 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Mon, 5 Aug 2002 23:19:50 -0600
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>,
       Matti Aarnio <matti.aarnio@zmailer.org>,
       Christoph Hellwig <hch@infradead.org>,
       "Peter J. Braam" <braam@CLUSTERFS.COM>, linux-kernel@vger.kernel.org
Subject: Re: BIG files & file systems
Message-ID: <20020806051950.GD22933@clusterfs.com>
Mail-Followup-To: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
	"Randy.Dunlap" <rddunlap@osdl.org>,
	Matti Aarnio <matti.aarnio@zmailer.org>,
	Christoph Hellwig <hch@infradead.org>,
	"Peter J. Braam" <braam@clusterfs.com>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.33L2.0208021507420.14068-100000@dragon.pdx.osdl.net> <200208030326.g733Q7O474061@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200208030326.g733Q7O474061@saturn.cs.uml.edu>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 02, 2002  23:26 -0400, Albert D. Cahalan wrote:
> Randy.Dunlap writes:
> > On Fri, 2 Aug 2002, Albert D. Cahalan wrote:
> >> Matti Aarnio writes:
> 
> >>>    - Filesystem format dependent limits
> >>>       - EXT2/EXT3: u32_t FILESYSTEM block index, presuming the EXT2/EXT3
> >>>                    is supported only up to 4 kB block sizes, that gives
> >>>                    you a very hard limit.. of 16 terabytes (16 * "10^12")
> >>
> >> You first hit the triple-indirection limit at 4 TB.
> >> http://www.cs.uml.edu/~acahalan/linux/ext2.gif
> >>
> >>>       - ReiserFS:  u32_t block indexes presently, u64_t in future;
> >>>                    block size ranges ?   Max size is limited by the
> >>>                    maximum supported file size, likely 2^63, which is
> >>>                    roughly  8 * "10^18", or circa 500 000 times larger
> >>>                    than EXT2/EXT3 format maximum.
> >>
> >> The top 4 st_size bits get stolen, so it's 60-bit sizes.
> >> You also get the 32-bit block limit at 16 TB.
> >
> > For a LinuxWorld presentation in August, I have asked each of the
> > 4 journaling filesystems (ext3, reiserfs, JFS, and XFS) what their
> > filesystem/filesize limits are.  Here's what they have told me.
> >
> >                       ext3fs     reiserfs     JFS     XFS
> > max filesize:         16 TB#      1 EB       4 PB$   8 TB%
> > max filesystem size:   2 TB      17.6 TB*    4 PB$   2 TB!

I think you need a "!" behind the 2TB limit for ext3 max filesystem
size.  The actual filesystem limit for 4kB block size is 16TB*
(2^32 blocks).  More on this below.

> > Notes:
> > #: think sparse files
> > *: 4 KB blocks
> > $: 16 TB on 32-bit architectures
> > %: 4 KB pages
> > !: block device limit
> 
> Please fix that before you give your presentation.
> Sparse files won't save you from the triple-indirection limit.
> This has me suspicious of the other numbers as well.
> 
> Ext2 gives you 0xc blocks addressed right off the inode.
> Then with one 4 kB block of block pointers, you can get
> to another 0x400 (1024) blocks. With a block of pointers to
> blocks of pointers, you may address another 0x100000 blocks.
> Finally, triple indirection gives you a block of pointers
> to blocks of pointers to blocks of pointers, for another
> 0x40000000 data blocks. That's a total of:
> 
> 0x4010040c blocks
> 0x4010040c000 bytes
> 4.4e12 bytes and change
> 4402 GB (decimal gigabytes)
> 4.4 TB (decimal terabytes)
> 
> Of course you can't really use 4.4 TB on 32-bit Linux,
> so there is a sort of dishonesty in making this claim.
> I can get to 2.2 TB, which disturbingly would wrap any
> code using signed 32-bit math on units of 512 bytes.
> The exact limits are:
> 
> 0x000001ffffffefff max offset
> 0x000001fffffff000 max size

I would also have to add another footnote to this, if people start
talking about limits on 64-bit and >4kB page size systems.  ext2/3 can
support multiple block sizes (limited by the hardware page size), and
actually supporting larger block sizes has only been restricted for
cross-platform compatibility reasons.

Now that larger page sizes are becoming more common, the support for up
to 16kB block sizes has already been added into e2fsprogs, and will only
need a 1-line change in the kernel to be supported.  The choice of 16kB
pages as the limit is somewhat arbitrary also, and could be increased
again in the future, as needed.

Having 16kB block size would allow a maximum of 64TB for a single
filesystem.  The per-file limit would be over 256TB.

In reality, we will probably implement extent-based allocation for
ext3 when we start getting into filesystems that large, which has been
discussed among the ext2/ext3 developers already.  We could also go to
a clustered filesystem like Lustre, which can span a large number of
separate filesystems (and hosts).

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

