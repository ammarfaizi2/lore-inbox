Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129370AbQLHAIl>; Thu, 7 Dec 2000 19:08:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129392AbQLHAIb>; Thu, 7 Dec 2000 19:08:31 -0500
Received: from app79.hitnet.RWTH-Aachen.DE ([137.226.181.79]:55812 "EHLO
	anduin.gondor.com") by vger.kernel.org with ESMTP
	id <S129370AbQLHAIN>; Thu, 7 Dec 2000 19:08:13 -0500
Date: Fri, 8 Dec 2000 00:37:44 +0100
From: Jan Niehusmann <jan@gondor.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: fs corruption with invalidate_buffers()
Message-ID: <20001208003744.A1006@gondor.com>
In-Reply-To: <3A300933.29813DE8@Hell.WH8.TU-Dresden.De> <Pine.GSO.4.21.0012071718330.22281-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0012071718330.22281-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Thu, Dec 07, 2000 at 05:26:46PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2000 at 05:26:46PM -0500, Alexander Viro wrote:
> That invalidate_buffers() should leave the unhashed ones alone. If it can't
> be found via getblk() - just leave it as is.
> 
> IOW, let it skip bh if (bh->b_next == NULL && !destroy_dirty_buffers).
> No warnings needed - it's a normal situation.

Yes, if(bh->b_next == NULL && !destroy_dirty_buffers) seems to work, too.
I wonder why, because, if I analysed the problem correctly, it was caused
by the page mapping. Or is it a general rule that bh->b_next==NULL if
bh->b_page->mapping != NULL, ie. a buffer is never directly hased and belongs
to a mapped page?

Is there a place one can look for documentation about these things?

Another question is what should happen with the mapped pages? Whoever calls
invalidate_buffers(), probably does it because the underlying device disappered
or changed, so the page mappings should be invalidated, too.
OTOH, pages are (normally) mapped through inodes, and if the inode stays valid
after the invalidate_buffers() (ie. if it's called by an lvm resize event),
the page mapping stays valid, too.

Jan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
