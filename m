Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262175AbVCOBHg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262175AbVCOBHg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 20:07:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262152AbVCOBHg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 20:07:36 -0500
Received: from fire.osdl.org ([65.172.181.4]:23939 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262191AbVCOBGy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 20:06:54 -0500
Date: Mon, 14 Mar 2005 17:06:53 -0800
From: Andrew Morton <akpm@osdl.org>
To: Phillip Lougher <phillip@lougher.demon.co.uk>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2/2] SquashFS
Message-Id: <20050314170653.1ed105eb.akpm@osdl.org>
In-Reply-To: <4235BC29.2060009@lougher.demon.co.uk>
References: <4235BC29.2060009@lougher.demon.co.uk>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phillip Lougher <phillip@lougher.demon.co.uk> wrote:
>
> 

Please don't send multiple patches with the same Subject:.  Choose nice,
meaningful Subject:s for each patch.  And include the relevant changelog
details within the email for each patch rather than in patch 1/N.  See
http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt and
http://linux.yyz.us/patch-format.html.


> @@ -0,0 +1,439 @@

[lots of comments from patch 1/2 are applicable here]

> +#define SQUASHFS_MAX_FILE_SIZE		((long long) 1 << \
> +					(SQUASHFS_MAX_FILE_SIZE_LOG - 1))

1LL would suit here.  Of a cast to loff_t.

> +typedef unsigned int		squashfs_block;
> +typedef long long		squashfs_inode;

squashfs_block_t and squashfs_inode_t, please.  If one must use typedefs...

> +typedef struct squashfs_super_block {
> +	unsigned int		s_magic;
> +	unsigned int		inodes;
> +	unsigned int		bytes_used;
> +	unsigned int		uid_start;
> +	unsigned int		guid_start;
> +	unsigned int		inode_table_start;
> +	unsigned int		directory_table_start;
> +	unsigned int		s_major:16;
> +	unsigned int		s_minor:16;
> +	unsigned int		block_size_1:16;
> +	unsigned int		block_log:16;
> +	unsigned int		flags:8;
> +	unsigned int		no_uids:8;
> +	unsigned int		no_guids:8;
> +	unsigned int		mkfs_time /* time of filesystem creation */;
> +	squashfs_inode		root_inode;
> +	unsigned int		block_size;
> +	unsigned int		fragments;
> +	unsigned int		fragment_table_start;
> +} __attribute__ ((packed)) squashfs_super_block;

Whoa.  Tons of bitfields in this file.  Are these on-disk data structures? 
If so, that's a problem for portability between architectures and possibly
compiler versions.  It also introduces locking complexity.

if they're in-core data structures then the bitfields are probably slower than using `int', as well.

> +typedef struct {
> +	unsigned int		inode_type:4;
> +	unsigned int		mode:12; /* protection */
> +	unsigned int		uid:8; /* index into uid table */
> +	unsigned int		guid:8; /* index into guid table */
> +} __attribute__ ((packed)) squashfs_base_inode_header;

See, if one CUP is modifying `inode_type' while another CPU is modifying
`mode', this struct can get trashed.

> +/*
> + * macros to convert each packed bitfield structure from little endian to big
> + * endian and vice versa.  These are needed when creating or using a filesystem
> + * on a machine with different byte ordering to the target architecture.
> + *
> + */

hmm, OK..  Tell us more?

> + * bitfields and different bitfield placing conventions on differing
> + * architectures
> + */
> +
> +#include <asm/byteorder.h>
> +
> +#ifdef __BIG_ENDIAN
> +	/* convert from little endian to big endian */
> +#define SQUASHFS_SWAP(value, p, pos, tbits) _SQUASHFS_SWAP(value, p, pos, \
> +		tbits, b_pos)
> +#else
> +	/* convert from big endian to little endian */ 
> +#define SQUASHFS_SWAP(value, p, pos, tbits) _SQUASHFS_SWAP(value, p, pos, \
> +		tbits, 64 - tbits - b_pos)
> +#endif
> +
> +#define _SQUASHFS_SWAP(value, p, pos, tbits, SHIFT) {\
> +	int bits;\
> +	int b_pos = pos % 8;\
> +	unsigned long long val = 0;\
> +	unsigned char *s = (unsigned char *)p + (pos / 8);\
> +	unsigned char *d = ((unsigned char *) &val) + 7;\
> +	for(bits = 0; bits < (tbits + b_pos); bits += 8) \
> +		*d-- = *s++;\
> +	value = (val >> (SHIFT))/* & ((1 << tbits) - 1)*/;\
> +}

Can the standard leXX_to_cpu() helpers not be used here?

> +#include <linux/squashfs_fs.h>
> +
> +typedef struct {
> +	unsigned int	block;
> +	int		length;
> +	unsigned int	next_index;
> +	char		*data;
> +	} squashfs_cache;

Whitespace inconsistency (column 1 for the closing brace is standard)

--- linux-2.6.11.3/init/do_mounts_rd.c	2005-03-13 06:44:30.000000000 +0000
+++ linux-2.6.11.3-squashfs/init/do_mounts_rd.c	2005-03-14 00:53:28.092559728 +0000

Your changelog didn't mention that squashfs interacts with the boot
process.  That's the sort of thing which is nice to tell people about.

> +SQUASHFS FILESYSTEM
> +P: Phillip Lougher
> +M: phillip@lougher.demon.co.uk
> +W: http://squashfs.sourceforge.net
> +L: squashfs-devel@lists.sourceforge.net
> +S: Maintained
> +

Lots of little comments, but I have no fundamental problems with the
patches as long as the bitfield issue is shown to be a non-issue.

Please respin the patches and unless someone else sees a showstopper I'll
merge them into -mm for further testing and review, thanks.

