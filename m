Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266544AbRGXBNB>; Mon, 23 Jul 2001 21:13:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266567AbRGXBMv>; Mon, 23 Jul 2001 21:12:51 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:13040 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S266544AbRGXBMj>;
	Mon, 23 Jul 2001 21:12:39 -0400
Date: Mon, 23 Jul 2001 21:12:44 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Nathan Laredo <nlaredo@transmeta.com>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: patch for allowing msdos/vfat nfs exports
In-Reply-To: <200107232355.QAA01785@nil.transmeta.com>
Message-ID: <Pine.GSO.4.21.0107232053040.23359-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing



On Mon, 23 Jul 2001, Nathan Laredo wrote:

> +	result = d_alloc_root(inode);
> +	if (result == NULL) {
> +	         iput(inode);
> +	         return ERR_PTR(-ENOMEM);
> +	}
> +	result->d_flags |= DCACHE_NFSD_DISCONNECTED;
> +	return result;

Erm... AFAICS it got a race - think of doing that for directory when
dentry is already gone, but inode still in cache. You will get
nfsd_findparent() called and that will give funny results on FAT.

The worst thing being, it _will_ get a decently-looking inode. Inode that
will point to the same blocks as parent directory, but will be completely
independent (different location).

Notice that we will end up reading directories that might be changing
under us - struct inode is different, so exclusion simply doesn't work.

IOW, we need
	if (S_ISDIR(inode->i_mode))
		return ERR_PTR(-ESTALE);
immediately before the chunk above.

