Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271928AbRIIJIw>; Sun, 9 Sep 2001 05:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271930AbRIIJIn>; Sun, 9 Sep 2001 05:08:43 -0400
Received: from ns.caldera.de ([212.34.180.1]:7902 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S271928AbRIIJId>;
	Sun, 9 Sep 2001 05:08:33 -0400
Date: Sun, 9 Sep 2001 11:05:39 +0200
Message-Id: <200109090905.f8995dM27818@ns.caldera.de>
From: Christoph Hellwig <hch@ns.caldera.de>
To: adilger@turbolabs.com (Andreas Dilger)
Cc: torvalds@transmeta.com, andrea@suse.de, linux-kernel@vger.kernel.org
Subject: Re: linux-2.4.10-pre5
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <20010908222923.H32553@turbolinux.com>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.2 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010908222923.H32553@turbolinux.com> you wrote:
> On Sep 08, 2001  20:58 -0700, Linus Torvalds wrote:
>> On Sun, 9 Sep 2001, Andrea Arcangeli wrote:
>> > I wish the cache coherency logic would be simpler but just doing
>> > something unconditionally it's going to break things in one way or
>> > another as far I can tell.
>> 
>> I'd rather fix that, then.
>> 
>> Otherwise we'll just end up carrying broken baggage around forever. Which
>> is not the way to do things.
>> 
>> Anyway, at this point this definitely sounds like a 2.5.x patch. Which I
>> always pretty much assumed it would be anyway.

> So basically - when we move block devices to the page cache, get rid of
> buffer cache usage in the filesystems as well?  Ext2 is nearly there at
> least.

IBM's Linux port of JFS2 does already not use the buffercache at all.
It has an special struct address_space (and inode due to the braindamaged
assumption that ->host must be an inode, introduced in 2.4.0-test) that
covers the whole filesystems.


> One alternative is as Daniel Phillips did in the indexed-ext2-
> directory patch, where he kept the "bread" interface, but backed it
> with the page cache, so it required relatively little change to the
> filesystem.

I'd rather prefer to use a different structure for this kind of accesses,
so that we can get rid of struct buffer_head altogether (especially
with Jens' bio rewrite that nukes it out of the lowlevel drivers.)

An example for such an interface is the fbuf use for directorioes in
SVR4/SVR5.  Header file that should explain it attached.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.


/*
 * Copyright (c) 2001 Caldera International, Inc.. All Rights Reserved.  
 *                                                                       
 *        THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF                 
 *                  CALDERA INTERNATIONAL, INC.                          
 *                                                                       
 *   The copyright notice above does not evidence any actual or intended 
 *   publication of such source code.                                    
 */

#ifndef _FS_FBUF_H	/* wrapper symbol for kernel use */
#define _FS_FBUF_H	/* subject to change without notice */

#ident	"@(#)unixsrc:usr/src/common/uts/fs/fbuf.h /main/uw7_nj/1"
#ident	"$Header: $"

#if defined(__cplusplus)
extern "C" {
#endif

#ifdef _KERNEL_HEADERS

#include <mem/seg.h> /* REQUIRED */
#include <util/types.h>	/* REQUIRED */

#elif defined(_KERNEL) || defined(_KMEMUSER)

#include <vm/seg.h> /* REQUIRED */
#include <sys/types.h>	/* REQUIRED */

#endif /* _KERNEL_HEADERS */

#if defined(_KERNEL) || defined(_KMEMUSER)

/*
 * A struct fbuf is used to get a mapping to part of a file using the
 * segkmap facilities.  After you get a mapping, you can fbrelse() it
 * (giving a seg code to pass back to segmap_release), you can fbwrite()
 * it (causes a synchronous write back using the file mapping information),
 * or you can fbiwrite it (causing indirect synchronous write back to
 * the block number given without using the file mapping information).
 */

typedef struct fbuf {
	char	*fb_addr;
	size_t	 fb_count;
} fbuf_t;

#endif /* _KERNEL || _KMEMUSER */

#ifdef _KERNEL

struct vnode;

#ifdef _FSKI
extern int fbread(struct vnode *vp, off_t off, size_t len, enum seg_rw rw,
		  fbuf_t **fbpp);
#else
extern int fbread(struct vnode *vp, off64_t off, size_t len, enum seg_rw rw,
		  fbuf_t **fbpp);
#endif

extern int fbrelse(fbuf_t *fbp, uint_t sm_flags);

#endif /* _KERNEL */

#if defined(__cplusplus)
	}
#endif

#endif /* _FS_FBUF_H */
