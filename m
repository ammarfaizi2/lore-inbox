Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262204AbVCOC35@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262204AbVCOC35 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 21:29:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262209AbVCOC35
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 21:29:57 -0500
Received: from anchor-post-31.mail.demon.net ([194.217.242.89]:22547 "EHLO
	anchor-post-31.mail.demon.net") by vger.kernel.org with ESMTP
	id S262204AbVCOC3k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 21:29:40 -0500
Date: Tue, 15 Mar 2005 01:14:57 +0000
Subject: Re: [PATCH][2/2] SquashFS
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v553)
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
From: Phillip Lougher <phillip@lougher.demon.co.uk>
In-Reply-To: <20050314170653.1ed105eb.akpm@osdl.org>
Message-Id: <A572579D-94EF-11D9-8833-000A956F5A02@lougher.demon.co.uk>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.553)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tuesday, March 15, 2005, at 01:06  am, Andrew Morton wrote:

> Phillip Lougher <phillip@lougher.demon.co.uk> wrote:
>
>> @@ -0,0 +1,439 @@
>
> [lots of comments from patch 1/2 are applicable here]
>

OK.  Noted :-)

>> +#define SQUASHFS_MAX_FILE_SIZE		((long long) 1 << \
>> +					(SQUASHFS_MAX_FILE_SIZE_LOG - 1))
>
> 1LL would suit here.  Of a cast to loff_t.
>
OK

>> +typedef unsigned int		squashfs_block;
>> +typedef long long		squashfs_inode;
>
> squashfs_block_t and squashfs_inode_t, please.  If one must use 
> typedefs...
>
OK

>> +typedef struct squashfs_super_block {
>> +	unsigned int		s_magic;
>> +	unsigned int		inodes;
>> +	unsigned int		bytes_used;
>> +	unsigned int		uid_start;
>> +	unsigned int		guid_start;
>> +	unsigned int		inode_table_start;
>> +	unsigned int		directory_table_start;
>> +	unsigned int		s_major:16;
>> +	unsigned int		s_minor:16;
>> +	unsigned int		block_size_1:16;
>> +	unsigned int		block_log:16;
>> +	unsigned int		flags:8;
>> +	unsigned int		no_uids:8;
>> +	unsigned int		no_guids:8;
>> +	unsigned int		mkfs_time /* time of filesystem creation */;
>> +	squashfs_inode		root_inode;
>> +	unsigned int		block_size;
>> +	unsigned int		fragments;
>> +	unsigned int		fragment_table_start;
>> +} __attribute__ ((packed)) squashfs_super_block;
>
> Whoa.  Tons of bitfields in this file.  Are these on-disk data 
> structures?
> If so, that's a problem for portability between architectures and 
> possibly
> compiler versions.  It also introduces locking complexity.
>
> if they're in-core data structures then the bitfields are probably 
> slower than using `int', as well.
>

They look pretty nasty, but are quite harmless really...

The structures represent on-disk structures.  Squashfs tries to cram as 
much information into
  as small an area as possible on disk, which is why they're using 
bitfields.

The structures are read into memory from disk into the bit field 
structure, and the information
is immediately transferred to more sane 'int' structures inside the 
inode or into private
Squashfs data, and all reads/writes take place from there.  No writes 
are made into the
bit fields, they're only used to temporarily 'parse' the packed data on 
disk.

I've done a lot of checking to ensure portability across architectures 
and against different
compiler versions.  Gcc uniformly uses two representations for 'packed 
structures', one for
little endian architectures and one for big endian architectures.  
Little endian bitfield
structures are packed low-byte high byte order, allocating bitfields 
from low bit to high bit in ints.
Big endian structures are packed high-byte low-byte order, allocating 
bitfields from
high bit to low bit in ints (this incidently generates structures in 
the bit/byte order
specified in the C source).  The filling is done this way on different 
endian architectures
as it allows the most efficient bit-field access code to be generated 
for each endian
architecture.

I've checked compatibilty against Intel 32 and 64 bit architectures, 
PPC 32/64 bit, ARM, MIPS
and SPARC.  I've used compilers from 2.91.x upto 3.4...

>> +typedef struct {
>> +	unsigned int		inode_type:4;
>> +	unsigned int		mode:12; /* protection */
>> +	unsigned int		uid:8; /* index into uid table */
>> +	unsigned int		guid:8; /* index into guid table */
>> +} __attribute__ ((packed)) squashfs_base_inode_header;
>
> See, if one CUP is modifying `inode_type' while another CPU is 
> modifying
> `mode', this struct can get trashed.

I agree.  This is why the structures are never written to.  Bit fields 
are slow, I move
the data out as soon as possible.

>
>> +/*
>> + * macros to convert each packed bitfield structure from little 
>> endian to big
>> + * endian and vice versa.  These are needed when creating or using a 
>> filesystem
>> + * on a machine with different byte ordering to the target 
>> architecture.
>> + *
>> + */
>
> hmm, OK..  Tell us more?
>

As mentioned previously, there are two packed bit-field 
representations, one
for big endian machines, and one for little endian machines.  Squashfs 
for
efficiency in embedded systems writes little endian filesystems (with 
little
endian bit field structures) for little endian targets, and big endian 
filesystems
for big endian targets.  However, to allow non-native endian filesystems
(i.e. where the host is little endian but the target is big endian), to 
be mounted,
Squashfs will swap the filesystem on a different endian machine.

Squashfs at filesystem mount time determines if the filesystem is 
swapped with
respect to the host architecture.  If it is then the packed bit-field 
structures
read off disk are in the wrong endianness.  Immediately after reading 
off disk,
the structures are converted to the correct endianness for the 
architecture, and
are then processed as normal.

Due to the different bit-field filling rules between big endian and 
little
endian machines, bit fields are in different places within the structure
for each architecture, this means when coverting the endianness of
a structure the structure has to be converted as a whole.  For each
bit field the macros are given the 'logical' position of the bit field 
and
use that to find the bit-field in the non-native structure using the non
native structure filling rules.


>> + * bitfields and different bitfield placing conventions on differing
>> + * architectures
>> + */
>> +
>> +#include <asm/byteorder.h>
>> +
>> +#ifdef __BIG_ENDIAN
>> +	/* convert from little endian to big endian */
>> +#define SQUASHFS_SWAP(value, p, pos, tbits) _SQUASHFS_SWAP(value, p, 
>> pos, \
>> +		tbits, b_pos)
>> +#else
>> +	/* convert from big endian to little endian */
>> +#define SQUASHFS_SWAP(value, p, pos, tbits) _SQUASHFS_SWAP(value, p, 
>> pos, \
>> +		tbits, 64 - tbits - b_pos)
>> +#endif
>> +
>> +#define _SQUASHFS_SWAP(value, p, pos, tbits, SHIFT) {\
>> +	int bits;\
>> +	int b_pos = pos % 8;\
>> +	unsigned long long val = 0;\
>> +	unsigned char *s = (unsigned char *)p + (pos / 8);\
>> +	unsigned char *d = ((unsigned char *) &val) + 7;\
>> +	for(bits = 0; bits < (tbits + b_pos); bits += 8) \
>> +		*d-- = *s++;\
>> +	value = (val >> (SHIFT))/* & ((1 << tbits) - 1)*/;\
>> +}
>
> Can the standard leXX_to_cpu() helpers not be used here?
>

No unfortunately not.  The above hopefully describes why.

The swap macro is IMHO quite concise and efficient, the same macro
is used to swap from little-endian to big endian, and from big-endian to
little endian.  The only difference is the _SQUASHFS_SWAP value which
either counts down from 64 bits to 0 (for high-bit low-bit filling 
order on
big endian machines), or counts up from 0 to 64 (for low-bit high-bit 
filling
order on little endian machines).   For efficiency this value is 
determined
at compile time.

I believe doing the work another way would make the code more difficult 
to
understand and less efficient?


>> +#include <linux/squashfs_fs.h>
>> +
>> +typedef struct {
>> +	unsigned int	block;
>> +	int		length;
>> +	unsigned int	next_index;
>> +	char		*data;
>> +	} squashfs_cache;
>
> Whitespace inconsistency (column 1 for the closing brace is standard)
>
> --- linux-2.6.11.3/init/do_mounts_rd.c	2005-03-13 06:44:30.000000000 
> +0000
> +++ linux-2.6.11.3-squashfs/init/do_mounts_rd.c	2005-03-14 
> 00:53:28.092559728 +0000
>
> Your changelog didn't mention that squashfs interacts with the boot
> process.  That's the sort of thing which is nice to tell people about.
>

Ok.

>> +SQUASHFS FILESYSTEM
>> +P: Phillip Lougher
>> +M: phillip@lougher.demon.co.uk
>> +W: http://squashfs.sourceforge.net
>> +L: squashfs-devel@lists.sourceforge.net
>> +S: Maintained
>> +
>
> Lots of little comments, but I have no fundamental problems with the
> patches as long as the bitfield issue is shown to be a non-issue.
>
> Please respin the patches and unless someone else sees a showstopper 
> I'll
> merge them into -mm for further testing and review, thanks.
>
>
Thanks

Phillip

