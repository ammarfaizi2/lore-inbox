Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317424AbSHCDWv>; Fri, 2 Aug 2002 23:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317431AbSHCDWv>; Fri, 2 Aug 2002 23:22:51 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:24848 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S317424AbSHCDWu>;
	Fri, 2 Aug 2002 23:22:50 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200208030326.g733Q7O474061@saturn.cs.uml.edu>
Subject: Re: BIG files & file systems
To: rddunlap@osdl.org (Randy.Dunlap)
Date: Fri, 2 Aug 2002 23:26:07 -0400 (EDT)
Cc: acahalan@cs.uml.edu (Albert D. Cahalan),
       matti.aarnio@zmailer.org (Matti Aarnio),
       hch@infradead.org (Christoph Hellwig),
       braam@clusterfs.com (Peter J. Braam), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33L2.0208021507420.14068-100000@dragon.pdx.osdl.net> from "Randy.Dunlap" at Aug 02, 2002 03:14:21 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap writes:
> On Fri, 2 Aug 2002, Albert D. Cahalan wrote:
>> Matti Aarnio writes:

>>>    - Filesystem format dependent limits
>>>       - EXT2/EXT3: u32_t FILESYSTEM block index, presuming the EXT2/EXT3
>>>                    is supported only up to 4 kB block sizes, that gives
>>>                    you a very hard limit.. of 16 terabytes (16 * "10^12")
>>
>> You first hit the triple-indirection limit at 4 TB.
>> http://www.cs.uml.edu/~acahalan/linux/ext2.gif
>>
>>>       - ReiserFS:  u32_t block indexes presently, u64_t in future;
>>>                    block size ranges ?   Max size is limited by the
>>>                    maximum supported file size, likely 2^63, which is
>>>                    roughly  8 * "10^18", or circa 500 000 times larger
>>>                    than EXT2/EXT3 format maximum.
>>
>> The top 4 st_size bits get stolen, so it's 60-bit sizes.
>> You also get the 32-bit block limit at 16 TB.
>
> For a LinuxWorld presentation in August, I have asked each of the
> 4 journaling filesystems (ext3, reiserfs, JFS, and XFS) what their
> filesystem/filesize limits are.  Here's what they have told me.
>
>                       ext3fs     reiserfs     JFS     XFS
> max filesize:         16 TB#      1 EB       4 PB$   8 TB%
> max filesystem size:   2 TB      17.6 TB*    4 PB$   2 TB!
>
> Notes:
> #: think sparse files
> *: 4 KB blocks
> $: 16 TB on 32-bit architectures
> %: 4 KB pages
> !: block device limit

Please fix that before you give your presentation.
Sparse files won't save you from the triple-indirection limit.
This has me suspicious of the other numbers as well.

Ext2 gives you 0xc blocks addressed right off the inode.
Then with one 4 kB block of block pointers, you can get
to another 0x400 (1024) blocks. With a block of pointers to
blocks of pointers, you may address another 0x100000 blocks.
Finally, triple indirection gives you a block of pointers
to blocks of pointers to blocks of pointers, for another
0x40000000 data blocks. That's a total of:

0x4010040c blocks
0x4010040c000 bytes
4.4e12 bytes and change
4402 GB (decimal gigabytes)
4.4 TB (decimal terabytes)

Of course you can't really use 4.4 TB on 32-bit Linux,
so there is a sort of dishonesty in making this claim.
I can get to 2.2 TB, which disturbingly would wrap any
code using signed 32-bit math on units of 512 bytes.
The exact limits are:

0x000001ffffffefff max offset
0x000001fffffff000 max size
