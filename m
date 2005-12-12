Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932078AbVLLV4l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078AbVLLV4l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 16:56:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932086AbVLLV4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 16:56:41 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:48055 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932078AbVLLV4l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 16:56:41 -0500
Date: Tue, 13 Dec 2005 08:56:32 +1100
From: Nathan Scott <nathans@sgi.com>
To: David Howells <dhowells@redhat.com>
Cc: hch@infradead.org, linux-xfs@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: XFS accessing arch-specific structures
Message-ID: <20051213085632.B7465575@wobbly.melbourne.sgi.com>
References: <25190.1134398352@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <25190.1134398352@warthog.cambridge.redhat.com>; from dhowells@redhat.com on Mon, Dec 12, 2005 at 02:39:12PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there David,

On Mon, Dec 12, 2005 at 02:39:12PM +0000, David Howells wrote:
> I've got a problem in which XFS is accessing arch-specific structures, and
> thus requiring those structures to conform to its ideals. Specifically, it's
> trying to read the counter using atomic_read(), whether or not this is
> possible:
> 
>     fs/xfs/linux-2.6/sema.h:
>     #define valusema(sp)			(atomic_read(&(sp)->count))
> 
>     compile log:
> 
>       CC      fs/xfs/xfs_inode.o
>       CC      fs/xfs/xfs_inode_item.o
>     fs/xfs/xfs_inode_item.c: In function `xfs_inode_item_pushbuf':
>     fs/xfs/xfs_inode_item.c:803: error: structure has no member named `count'
>     fs/xfs/xfs_inode_item.c:825: error: structure has no member named `count'
> 
> Can you fix this please? This will not compile with all archs.
> 
> I'm told that Christoph Hellwig may have an idea or a patch that might provide
> a fix. If it's necessary to get the count on the semaphore (which it might
> be), then you should add a function to each asm/semaphore.h to retrieve it and
> use that.

I just chatted with Christoph about this.  For some reason we thought
all instances of direct count use were in debug code (or were put into
debug-only code), but we missed the one in xfs_inode_item_pushbuf.  It
only needs to know if count > 0, so we could implement that using the
down_trylock primitive, but it'd be pretty ugly.

It looks like a couple of the arch's have now got a sem_getcount, and
Christoph is planning on reviving an earlier patch to provide that API
across all architectures, and then we can change XFS to use that.

cheers.

-- 
Nathan
