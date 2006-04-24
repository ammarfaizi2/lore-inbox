Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750817AbWDXNnk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817AbWDXNnk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 09:43:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750809AbWDXNnk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 09:43:40 -0400
Received: from mx1.redhat.com ([66.187.233.31]:55182 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750749AbWDXNnj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 09:43:39 -0400
Subject: Re: [PATCH 05/16] GFS2: File and inode operations
From: Steven Whitehouse <swhiteho@redhat.com>
To: Andreas Dilger <adilger@clusterfs.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060423075525.GP6075@schatzie.adilger.int>
References: <1145636030.3856.102.camel@quoit.chygwyn.com>
	 <20060423075525.GP6075@schatzie.adilger.int>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Mon, 24 Apr 2006 14:53:16 +0100
Message-Id: <1145886796.3856.161.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 2006-04-23 at 01:55 -0600, Andreas Dilger wrote:
> On Apr 21, 2006  17:13 +0100, Steven Whitehouse wrote:
> > This also includes a new header file, iflags.h which is designed to
> > abstract the (originally ext2 only, but now used by many different fs)
> > get/set flags ioctl by having one central place in which to register
> > filesystem flags. Given favourable reviews, I'll submit some patches to
> > update the other fileststems to define their flags in terms of those
> > in iflags.h. Note that this doesn't change the interface of the other
> > filesystems since the values of the flags are identical to those
> > previously defined.
> > 
> > To the best of my knowledge, GFS2 is the only filesystem which requires
> > the addition of flags above and beyond those defined by ext2/3 so if
> > there are others and we've clashed with them, please let me know.
> 
> > --- /dev/null
> > +++ b/include/linux/iflags.h
> > @@ -0,0 +1,104 @@
[some constants snipped for brevity]
> > +
> > +#define __IFL(x) (1<<(iflag_##x))
> > +#define IFLAG_SECRM		__IFL(SecureRm)		/* 0x00000001 */
> > +#define IFLAG_UNRM		__IFL(Unrm)		/* 0x00000002 */
> > +#define IFLAG_COMPR		__IFL(Compr)		/* 0x00000004 */
> > +#define IFLAG_SYNC		__IFL(Sync)		/* 0x00000008 */
> > +#define IFLAG_IMMUTABLE		__IFL(Immutable)	/* 0x00000010 */
> > +#define IFLAG_APPEND		__IFL(Append)		/* 0x00000020 */
> > +#define IFLAG_NODUMP		__IFL(NoDump)		/* 0x00000040 */
> > +#define IFLAG_NOATIME		__IFL(NoAtime)		/* 0x00000080 */
> > +#define IFLAG_DIRTY		__IFL(Dirty)		/* 0x00000100 */
> > +#define IFLAG_COMPRBLK		__IFL(ComprBlk)		/* 0x00000200 */
> > +#define IFLAG_NOCOMP		__IFL(NoComp)		/* 0x00000400 */
> > +#define IFLAG_ECOMPR		__IFL(Ecompr)		/* 0x00000800 */
> > +#define IFLAG_BTREE		__IFL(Btree)		/* 0x00001000 */
> > +#define IFLAG_INDEX		__IFL(Index)		/* 0x00001000 */
> > +#define IFLAG_IMAGIC		__IFL(Imagic)		/* 0x00002000 */
> > +#define IFLAG_JOURNAL_DATA	__IFL(JournalData)	/* 0x00004000 */
> > +#define IFLAG_NOTAIL		__IFL(NoTail)		/* 0x00008000 */
> > +#define IFLAG_DIRSYNC		__IFL(DirSync)		/* 0x00010000 */
> > +#define IFLAG_TOPDIR		__IFL(TopDir)		/* 0x00020000 */
> > +#define IFLAG_DIRECTIO		__IFL(DirectIO)		/* 0x00040000 */
> > +#define IFLAG_INHERITDIRECTIO	__IFL(InheritDirectIO)	/* 0x00080000 */
> > +#define IFLAG_INHERITJDATA	__IFL(InheritJdata)	/* 0x00100000 */
> > +#define IFLAG_RESERVED		__IFL(Reserved)		/* 0x80000000 */
> 
> Actually, the 0x0080000 flag has been reserved by e2fsprogs for ext3
> extents for a while already.  AFAICS, there are no other flags in the
> current e2fsprogs that aren't listed above.
> 
So if I call that one IFLAG_EXTENT, then I presume that will be ok?
What about the 0x00040000 flag? That would seem to be a gap in the
sequence (ignoring GFS flags for now), so should I leave that reserved
for use by ext2/3 as well?

> The other tidbit is that new ext2/ext3 files generally inherit the flags
> from their parent directory, so it isn't clear if there is really a need
> for a distinction between DIRECTIO and INHERIT_DIRECTIO, and similarly
> JDATA and INHERIT_JDATA?  Generally, I'd think that JDATA isn't meaningful
> on directories (since they are metadata and journaled anyways), nor is
> DIRECTIO so their only meaning on a directory is "INHERIT for new files".
> 
> Cheers, Andreas

Yes, that sounds like a good plan. The only downside (purely from a GFS2
point of view, it won't affect anybody else) means that its no longer a
1:1 relationship between flags, so in order to do the conversion, I'd
have to use something a little more elaborate than the inline function I
added to the iflags.h header file,

Steve.



