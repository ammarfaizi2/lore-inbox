Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262243AbVCPAla@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262243AbVCPAla (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 19:41:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262265AbVCPAl3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 19:41:29 -0500
Received: from anchor-post-31.mail.demon.net ([194.217.242.89]:13073 "EHLO
	anchor-post-31.mail.demon.net") by vger.kernel.org with ESMTP
	id S262243AbVCPAlT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 19:41:19 -0500
Message-ID: <42376ED3.4090502@lougher.demon.co.uk>
Date: Tue, 15 Mar 2005 23:25:07 +0000
From: Phillip Lougher <phillip@lougher.demon.co.uk>
User-Agent: Mozilla Thunderbird 0.8 (X11/20041012)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matt Mackall <mpm@selenic.com>
CC: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2/2] SquashFS
References: <4235BC29.2060009@lougher.demon.co.uk> <20050315031251.GI3163@waste.org>
In-Reply-To: <20050315031251.GI3163@waste.org>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall wrote:
> On Mon, Mar 14, 2005 at 04:30:33PM +0000, Phillip Lougher wrote:
> 
> 
>>+config SQUASHFS_1_0_COMPATIBILITY
>>+	bool "Include support for mounting SquashFS 1.x filesystems"
> 
> 
> How common are these? It would be nice not to bring in legacy code.
> 

Squashfs 1.x filesystems were the previous file format.  Embedded 
systems tend to be conservative, and so there are quite a few systems 
out there using 1.x filesystems.  I've also heard of quite a few cases 
where Squashfs is used as an archival filesystem, and so there's 
probably quite a few 1.x fileystems around for this reason.

One issue which I'm aware of here is deciding what getting squashfs 
support into the kernel is meant to answer.  I'm asking for it to be put 
into the kernel because developers out there are asking me to put it in 
the kernel - because they don't want to continually (re)patch their kernels.

If I drop too much support from the kernel patch, then the kernel 
squashfs support will not be adequate, and the developers will still 
have to patch their kernels with my third-party patches.

Before I submitted this patch I factored out the Squashfs 1.x code into 
a separate file only built if this option is selected.  Obviously this 
reduces the built kernel size (by 6K - 8K depending on architecture), 
but doesn't address the issue of "legacy" code in the kernel.

If people don't want support for 1.x filesystems in the patch, then I 
will drop it...  Opinions?

>>+#define SERROR(s, args...)	do { \
>>+				if (!silent) \
>>+				printk(KERN_ERR "SQUASHFS error: "s, ## args);\
>>+				} while(0)
> 
> 
> Why would we ever want to be silent about something of KERN_ERR
> severity? Isn't that a better job for klogd?
> 

Silent is a parameter passed into the superblock read routine at mount 
time.  It appears to be intended to ensure the filesystem is silent 
about failed mounts, which is what I use it for.

The macros is only used by the superbock read routine and so I'll 
replace it with direct printks.

> 
>>+#define SQUASHFS_MAGIC			0x73717368
>>+#define SQUASHFS_MAGIC_SWAP		0x68737173
> 
> 
> Again, what's the story here? Is this purely endian conversion or do
> filesystems of both endian persuasions exist? If the latter, let's not
> keep that legacy. Pick an order, and use endian conversion functions
> unconditionally everywhere.

This is _certainly_ not legacy code.  Squashfs deliberately supports 
filesystems of both endian persuasions for efficiency in embedded 
systems.  Swapping data structures is an unnecessary overhead which can 
be avoided if the filesystem is in the native byte order - embedded 
systems often need all the performance optimisations possible, 
especially in the filesystem to reduce initial 'turn-on' start up delay.

Picking an order will impose unnecessary overhead on the losing 
architecture.  When Linux was almost exclusively running on little 
endian machines, having little endian only filesystems probably didn't 
matter (but still not nice in my view), however, Linux now runs on lots 
of different architectures.  In the embedded market the PowerPC (big 
endian) makes up a large percentage of the machines running Linux.

In short SquashFS will always be a dual endian filesystem.

Incidently cramfs is also a dual endian filesystem (not by design, but 
by virtue of the fact it writes filesystems in the host byte order). 
No-one seems to be complaining there.

> 
> 
>>+#define SQUASHFS_COMPRESSED_SIZE_BLOCK(B)	(((B) & \
>>+	~SQUASHFS_COMPRESSED_BIT_BLOCK) ? (B) & \
>>+	~SQUASHFS_COMPRESSED_BIT_BLOCK : SQUASHFS_COMPRESSED_BIT_BLOCK)
> 
> 
> Shortening all these macro names would be nice..
> 
> 
>>+typedef unsigned int		squashfs_block;
>>+typedef long long		squashfs_inode;
> 
> 
> Eh? Seems we can have many more inodes than blocks? What sorts of
> volume limits do we have here?

For efficiency Squashfs encodes the location of inode data on disk 
within the inode number, this means the inode can be directly read 
without an intermediate inode to disk block lookup.  Because SquashFS 
compresses metadata the inode data location consists of a tuple: the 
location of the compressed block the inode is within, and the offset 
within the uncompressed block of the inode data itself.

The filesystem can be 4GB in size which requires 32 bits for the block 
location.  An uncompressed metadata block is 8KB, which requires 13 bits 
for the block offset.  A Squashfs inode is consequently 45 bits in size.
> 
> 
>>+	unsigned int		s_major:16;
>>+	unsigned int		s_minor:16;
> 
> 
> What's going on here? s_minor's not big enough for modern minor
> numbers.
> 

What is the modern size then?

> 
>>+typedef struct {
>>+	unsigned int		index:27;
>>+	unsigned int		start_block:29;
>>+	unsigned char		size;
> 
> 
> Eep. Not sure how bit-fields handle crossing word boundaries, would be
> surprised if this were very portable.

It is.  Please see earlier reply on the same subject to Andrew Morton.

> 
> 
>>+ * macros to convert each packed bitfield structure from little endian to big
>>+ * endian and vice versa.  These are needed when creating or using a filesystem
>>+ * on a machine with different byte ordering to the target architecture.
>>+ *
>>+ */
>>+
>>+#define SQUASHFS_SWAP_SUPER_BLOCK(s, d) {\
>>+	SQUASHFS_MEMSET(s, d, sizeof(squashfs_super_block));\
>>+	SQUASHFS_SWAP((s)->s_magic, d, 0, 32);\
>>+	SQUASHFS_SWAP((s)->inodes, d, 32, 32);\
>>+	SQUASHFS_SWAP((s)->bytes_used, d, 64, 32);\
>>+	SQUASHFS_SWAP((s)->uid_start, d, 96, 32);\
>>+	SQUASHFS_SWAP((s)->guid_start, d, 128, 32);\
>>+	SQUASHFS_SWAP((s)->inode_table_start, d, 160, 32);\
>>+	SQUASHFS_SWAP((s)->directory_table_start, d, 192, 32);\
>>+	SQUASHFS_SWAP((s)->s_major, d, 224, 16);\
>>+	SQUASHFS_SWAP((s)->s_minor, d, 240, 16);\
>>+	SQUASHFS_SWAP((s)->block_size_1, d, 256, 16);\
>>+	SQUASHFS_SWAP((s)->block_log, d, 272, 16);\
>>+	SQUASHFS_SWAP((s)->flags, d, 288, 8);\
>>+	SQUASHFS_SWAP((s)->no_uids, d, 296, 8);\
>>+	SQUASHFS_SWAP((s)->no_guids, d, 304, 8);\
>>+	SQUASHFS_SWAP((s)->mkfs_time, d, 312, 32);\
>>+	SQUASHFS_SWAP((s)->root_inode, d, 344, 64);\
>>+	SQUASHFS_SWAP((s)->block_size, d, 408, 32);\
>>+	SQUASHFS_SWAP((s)->fragments, d, 440, 32);\
>>+	SQUASHFS_SWAP((s)->fragment_table_start, d, 472, 32);\
>>+}
> 
> 
> Are those positions in bits? If you're going to go to the trouble of
> swapping the whole thing, I think it'd be easier to just unpack the
> and endian-convert the thing so that we didn't have the overhead of
> bitfields and unpacking except at read/write time. Something like:
> 
> void pack(void *src, void *dest, pack_table_t *e);
> void unpack(void *src, void *dest, pack_table_t *e);
> size_t pack_size(pack_table_t);
> 
> where e is an array containing basically the info you have in the
> above macros for each element: offset into unpacked structure,
> starting bit in packed structure, and packed bits.
> 

As mentioned in the previous reply to Andrew Morton, the macros _are_ 
simply endian converting and unpacking the data at disk read-off time, 
once this is performed there is no further bit field overhead.
