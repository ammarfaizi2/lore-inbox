Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270035AbRHGCPQ>; Mon, 6 Aug 2001 22:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270038AbRHGCPG>; Mon, 6 Aug 2001 22:15:06 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:31997 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S270035AbRHGCOy>;
	Mon, 6 Aug 2001 22:14:54 -0400
Date: Mon, 6 Aug 2001 22:15:03 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] one of $BIGNUM devfs races
In-Reply-To: <200108070200.f77202G27928@vindaloo.ras.ucalgary.ca>
Message-ID: <Pine.GSO.4.21.0108062203170.16817-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 6 Aug 2001, Richard Gooch wrote:

> Again, historical reasons. When I wrote devfs, the pipe data trampled
> the inode->u.generic_ip pointer. So that's no good. I see that the
> pipe data has been moved away. Good. Hm. But there's still the
> inode->u.socket_i structure. I'd need to check where that gets
> trampled.

It isn't. socket_i is used only in inodes allocated by sock_alloc().
It is not used in the inodes that live on any fs other than sockfs.
For local-domain socket you get _two_ kinds of inodes, both with
S_IFSOCK in ->i_mode: one on the filesystem (acting like an meeting
place) and another - bearing the actual socket and used for all IO.

In other words, the only kind you can get from mknod(2) never uses
->i_socket. It's used only by bind() and connect() - and only as
a place in namespace. The only thing we ever look at is ownership
and permissions - they determine who can bind()/connect() here.

So ->u.generic_ip is safe.

