Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269805AbRHDFtF>; Sat, 4 Aug 2001 01:49:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269807AbRHDFs4>; Sat, 4 Aug 2001 01:48:56 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:4796 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S269805AbRHDFsr>;
	Sat, 4 Aug 2001 01:48:47 -0400
Date: Sat, 4 Aug 2001 01:48:56 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
cc: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4.8-pre3 fsync entire path (+reiserfs fsync semantic
 change patch)
In-Reply-To: <20010804055307.H16516@emma1.emma.line.org>
Message-ID: <Pine.GSO.4.21.0108040140390.5264-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 4 Aug 2001, Matthias Andree wrote:

> On Fri, 03 Aug 2001, Alexander Viro wrote:
> 
> > It has nothing to bindings/mount/etc. fsync /a/b/c. While c is written
> > out, mv a/b/c /a/d/c. While d is written out, mv a/d/c a/b/c && mv a/d e/d
> > Through all these renames /a remained the grandparent of c. You won't sync it -
> > you sync c, then d, then e, then root.
> 
> Which looks like the right thing, what used to be a/b/c is now e/d/c --
> and you synced c, d, and e.

Like hell it is.

/        /a        /a/b        /a/b/c        /a/d        /e
                               ^^^^^^
/        /a        /a/b        /a/d/c        /a/d        /e
                               ^^^^^^
/        /a        /a/b        /a/b/c        /a/d        /e
                                             ^^^^
/        /a        /a/b        /a/b/c        /e/d        /e
                                             ^^^^
/        /a        /a/b        /a/b/c        /e/d        /e
                                                         ^^
/        /a        /a/b        /a/b/c        /e/d        /e
^

Result of these renames is the same as mv /a/d /e/d. See above for names
and currently synced inode during that sequence...

