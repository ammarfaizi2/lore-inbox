Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbQLFXJY>; Wed, 6 Dec 2000 18:09:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129431AbQLFXJO>; Wed, 6 Dec 2000 18:09:14 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:37506 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129267AbQLFXJA>;
	Wed, 6 Dec 2000 18:09:00 -0500
Date: Wed, 6 Dec 2000 17:38:31 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Tigran Aivazian <tigran@veritas.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch-2.4.0-test12-pre6] truncate(2) permissions
In-Reply-To: <Pine.LNX.4.10.10012061145010.1917-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0012061728530.17341-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 6 Dec 2000, Linus Torvalds wrote:

> 
> 
> On Wed, 6 Dec 2000, Tigran Aivazian wrote:
> > 
> > This patch combines your previous patch with 2 changes I have just
> > suggested. Both changes are obvious (and correct).
> 
> Why remove the EROFS test?

Tigran has a point - permission() does

        if ((mask & S_IWOTH) && IS_RDONLY(inode) &&
                 (S_ISREG(mode) || S_ISDIR(mode) || S_ISLNK(mode)))
                return -EROFS; /* Nobody gets write access to a read-only fs */

so do_sys_truncate() has no chance in hell to trigger its own check for
IS_RDONLY() - we have

        if (!S_ISREG(inode->i_mode))
                goto dput_and_out;

        error = permission(inode,MAY_WRITE);
        if (error)
                goto dput_and_out;

        error = -EROFS;
        if (IS_RDONLY(inode))
                goto dput_and_out;

there, so if it's not a regular file we die before the call of permission(),
if it is and fs is readonly - we get -EROFS from permission() and die
there. In either case we don't get to the IS_RDONLY() check...

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
