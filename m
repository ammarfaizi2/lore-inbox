Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262215AbVCODOA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262215AbVCODOA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 22:14:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262213AbVCODN7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 22:13:59 -0500
Received: from waste.org ([216.27.176.166]:59532 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262215AbVCODM7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 22:12:59 -0500
Date: Mon, 14 Mar 2005 19:12:51 -0800
From: Matt Mackall <mpm@selenic.com>
To: Phillip Lougher <phillip@lougher.demon.co.uk>
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2/2] SquashFS
Message-ID: <20050315031251.GI3163@waste.org>
References: <4235BC29.2060009@lougher.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4235BC29.2060009@lougher.demon.co.uk>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2005 at 04:30:33PM +0000, Phillip Lougher wrote:

> +config SQUASHFS_1_0_COMPATIBILITY
> +	bool "Include support for mounting SquashFS 1.x filesystems"

How common are these? It would be nice not to bring in legacy code.

> +#define SERROR(s, args...)	do { \
> +				if (!silent) \
> +				printk(KERN_ERR "SQUASHFS error: "s, ## args);\
> +				} while(0)

Why would we ever want to be silent about something of KERN_ERR
severity? Isn't that a better job for klogd?

> +#define SQUASHFS_MAGIC			0x73717368
> +#define SQUASHFS_MAGIC_SWAP		0x68737173

Again, what's the story here? Is this purely endian conversion or do
filesystems of both endian persuasions exist? If the latter, let's not
keep that legacy. Pick an order, and use endian conversion functions
unconditionally everywhere.

> +#define SQUASHFS_COMPRESSED_SIZE_BLOCK(B)	(((B) & \
> +	~SQUASHFS_COMPRESSED_BIT_BLOCK) ? (B) & \
> +	~SQUASHFS_COMPRESSED_BIT_BLOCK : SQUASHFS_COMPRESSED_BIT_BLOCK)

Shortening all these macro names would be nice..

> +typedef unsigned int		squashfs_block;
> +typedef long long		squashfs_inode;

Eh? Seems we can have many more inodes than blocks? What sorts of
volume limits do we have here?

> +	unsigned int		s_major:16;
> +	unsigned int		s_minor:16;

What's going on here? s_minor's not big enough for modern minor
numbers.

> +typedef struct {
> +	unsigned int		index:27;
> +	unsigned int		start_block:29;
> +	unsigned char		size;

Eep. Not sure how bit-fields handle crossing word boundaries, would be
surprised if this were very portable.

> + * macros to convert each packed bitfield structure from little endian to big
> + * endian and vice versa.  These are needed when creating or using a filesystem
> + * on a machine with different byte ordering to the target architecture.
> + *
> + */
> +
> +#define SQUASHFS_SWAP_SUPER_BLOCK(s, d) {\
> +	SQUASHFS_MEMSET(s, d, sizeof(squashfs_super_block));\
> +	SQUASHFS_SWAP((s)->s_magic, d, 0, 32);\
> +	SQUASHFS_SWAP((s)->inodes, d, 32, 32);\
> +	SQUASHFS_SWAP((s)->bytes_used, d, 64, 32);\
> +	SQUASHFS_SWAP((s)->uid_start, d, 96, 32);\
> +	SQUASHFS_SWAP((s)->guid_start, d, 128, 32);\
> +	SQUASHFS_SWAP((s)->inode_table_start, d, 160, 32);\
> +	SQUASHFS_SWAP((s)->directory_table_start, d, 192, 32);\
> +	SQUASHFS_SWAP((s)->s_major, d, 224, 16);\
> +	SQUASHFS_SWAP((s)->s_minor, d, 240, 16);\
> +	SQUASHFS_SWAP((s)->block_size_1, d, 256, 16);\
> +	SQUASHFS_SWAP((s)->block_log, d, 272, 16);\
> +	SQUASHFS_SWAP((s)->flags, d, 288, 8);\
> +	SQUASHFS_SWAP((s)->no_uids, d, 296, 8);\
> +	SQUASHFS_SWAP((s)->no_guids, d, 304, 8);\
> +	SQUASHFS_SWAP((s)->mkfs_time, d, 312, 32);\
> +	SQUASHFS_SWAP((s)->root_inode, d, 344, 64);\
> +	SQUASHFS_SWAP((s)->block_size, d, 408, 32);\
> +	SQUASHFS_SWAP((s)->fragments, d, 440, 32);\
> +	SQUASHFS_SWAP((s)->fragment_table_start, d, 472, 32);\
> +}

Are those positions in bits? If you're going to go to the trouble of
swapping the whole thing, I think it'd be easier to just unpack the
and endian-convert the thing so that we didn't have the overhead of
bitfields and unpacking except at read/write time. Something like:

void pack(void *src, void *dest, pack_table_t *e);
void unpack(void *src, void *dest, pack_table_t *e);
size_t pack_size(pack_table_t);

where e is an array containing basically the info you have in the
above macros for each element: offset into unpacked structure,
starting bit in packed structure, and packed bits.

-- 
Mathematics is the supreme nostalgia of our time.
