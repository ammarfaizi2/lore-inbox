Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751366AbWDWHz3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751366AbWDWHz3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 03:55:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbWDWHz2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 03:55:28 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:15515 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S1751359AbWDWHz1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 03:55:27 -0400
Date: Sun, 23 Apr 2006 01:55:25 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Steven Whitehouse <swhiteho@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/16] GFS2: File and inode operations
Message-ID: <20060423075525.GP6075@schatzie.adilger.int>
Mail-Followup-To: Steven Whitehouse <swhiteho@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <1145636030.3856.102.camel@quoit.chygwyn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1145636030.3856.102.camel@quoit.chygwyn.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 21, 2006  17:13 +0100, Steven Whitehouse wrote:
> This also includes a new header file, iflags.h which is designed to
> abstract the (originally ext2 only, but now used by many different fs)
> get/set flags ioctl by having one central place in which to register
> filesystem flags. Given favourable reviews, I'll submit some patches to
> update the other fileststems to define their flags in terms of those
> in iflags.h. Note that this doesn't change the interface of the other
> filesystems since the values of the flags are identical to those
> previously defined.
> 
> To the best of my knowledge, GFS2 is the only filesystem which requires
> the addition of flags above and beyond those defined by ext2/3 so if
> there are others and we've clashed with them, please let me know.

> --- /dev/null
> +++ b/include/linux/iflags.h
> @@ -0,0 +1,104 @@
> +enum {
> +	iflag_SecureRm		= 0,	/* Secure deletion */
> +	iflag_Unrm		= 1,	/* Undelete */
> +	iflag_Compress		= 2,	/* Compress file */
> +	iflag_Sync		= 3,	/* Synchronous updates */
> +	iflag_Immutable	= 4,	/* Immutable */
> +	iflag_Append		= 5,	/* Append */
> +	iflag_NoDump		= 6,	/* Don't dump file */
> +	iflag_NoAtime		= 7,	/* No atime updates */
> +	/* Reserved for compression usage */
> +	iflag_Dirty		= 8,
> +	iflag_ComprBlk		= 9,	/* One or more compressed clusters */
> +	iflag_NoComp		= 10,	/* Don't compress */
> +	iflag_Ecompr		= 11,	/* Compression error */
> +	/* End of compression flags */
> +	iflag_Btree		= 12,	/* btree format dir */
> +	iflag_Index		= 12,	/* hash-indexed directory */
> +	iflag_Imagic		= 13,	/* AFS directory */
> +	iflag_JournalData	= 14,	/* file data should be journaled */
> +	iflag_NoTail		= 15,	/* file tail should not be merged */
> +	iflag_DirSync		= 16,	/* dirsync behaviour */
> +	iflag_TopDir		= 17,	/* Top of directory hierarchies */
> +	iflag_DirectIO		= 18,	/* Always use direct I/O on this file */
> +	iflag_InheritDirectIO	= 19,	/* Set DirectIO on new files in dir */
> +	iflag_InheritJdata	= 20,	/* Set JournalData on create in dir */
> +	iflag_Reserved		= 31	/* reserved for ext2/3 lib */
> +};
> +
> +#define __IFL(x) (1<<(iflag_##x))
> +#define IFLAG_SECRM		__IFL(SecureRm)		/* 0x00000001 */
> +#define IFLAG_UNRM		__IFL(Unrm)		/* 0x00000002 */
> +#define IFLAG_COMPR		__IFL(Compr)		/* 0x00000004 */
> +#define IFLAG_SYNC		__IFL(Sync)		/* 0x00000008 */
> +#define IFLAG_IMMUTABLE		__IFL(Immutable)	/* 0x00000010 */
> +#define IFLAG_APPEND		__IFL(Append)		/* 0x00000020 */
> +#define IFLAG_NODUMP		__IFL(NoDump)		/* 0x00000040 */
> +#define IFLAG_NOATIME		__IFL(NoAtime)		/* 0x00000080 */
> +#define IFLAG_DIRTY		__IFL(Dirty)		/* 0x00000100 */
> +#define IFLAG_COMPRBLK		__IFL(ComprBlk)		/* 0x00000200 */
> +#define IFLAG_NOCOMP		__IFL(NoComp)		/* 0x00000400 */
> +#define IFLAG_ECOMPR		__IFL(Ecompr)		/* 0x00000800 */
> +#define IFLAG_BTREE		__IFL(Btree)		/* 0x00001000 */
> +#define IFLAG_INDEX		__IFL(Index)		/* 0x00001000 */
> +#define IFLAG_IMAGIC		__IFL(Imagic)		/* 0x00002000 */
> +#define IFLAG_JOURNAL_DATA	__IFL(JournalData)	/* 0x00004000 */
> +#define IFLAG_NOTAIL		__IFL(NoTail)		/* 0x00008000 */
> +#define IFLAG_DIRSYNC		__IFL(DirSync)		/* 0x00010000 */
> +#define IFLAG_TOPDIR		__IFL(TopDir)		/* 0x00020000 */
> +#define IFLAG_DIRECTIO		__IFL(DirectIO)		/* 0x00040000 */
> +#define IFLAG_INHERITDIRECTIO	__IFL(InheritDirectIO)	/* 0x00080000 */
> +#define IFLAG_INHERITJDATA	__IFL(InheritJdata)	/* 0x00100000 */
> +#define IFLAG_RESERVED		__IFL(Reserved)		/* 0x80000000 */

Actually, the 0x0080000 flag has been reserved by e2fsprogs for ext3
extents for a while already.  AFAICS, there are no other flags in the
current e2fsprogs that aren't listed above.

The other tidbit is that new ext2/ext3 files generally inherit the flags
from their parent directory, so it isn't clear if there is really a need
for a distinction between DIRECTIO and INHERIT_DIRECTIO, and similarly
JDATA and INHERIT_JDATA?  Generally, I'd think that JDATA isn't meaningful
on directories (since they are metadata and journaled anyways), nor is
DIRECTIO so their only meaning on a directory is "INHERIT for new files".

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

