Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267005AbRGMK6K>; Fri, 13 Jul 2001 06:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267009AbRGMK6B>; Fri, 13 Jul 2001 06:58:01 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:50560 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S267005AbRGMK5t>;
	Fri, 13 Jul 2001 06:57:49 -0400
Date: Fri, 13 Jul 2001 06:57:51 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andrew Morton <andrewm@uow.edu.au>
cc: malfet@gw.mipt.sw.ru, linux-kernel@vger.kernel.org
Subject: Re: Question about ext2
In-Reply-To: <3B4EB493.DC805F45@uow.edu.au>
Message-ID: <Pine.GSO.4.21.0107130623510.17323-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 13 Jul 2001, Andrew Morton wrote:

> I recently spent an hour decrypting this function.  Here is
> a commented version which may prove helpful. It is from a
> non-mainline branch of ext3, but it's much the same.

<raised brows> OK, here's an algorithm used in rename() - hopefully it
answers "dunno why" part.

	find directory entry of source or fail (-ENOENT)

	if moving directory
		find directory entry of ".." in object we move or fail (-EIO)

	if there is a victim
		if moving directory and victim is not empty - fail (-ENOTEMPTY)

		find directory entry of victim or fail (-ENOENT)

		grab a reference to old_inode and redirect that entry to it
		if victim is a directory
			drop reference to victim twice
		else
			drop reference to victim once
	else
		if moving directory
			check that we can grab an extra reference to new parent
			or fail with -EMLINK
		grab a reference to old inode
		create a link to old_inode (with new name)
		if link creation failed
			drop a reference we've just got and fail
		if it was a directory
			grab a reference to new parent

	/*
		Now we had created a new link to object we are moving
		and link to victim (if any) is destroyed.
	 */

	delete old link and drop the reference held by it.

	if moving directory
		redirect ".." to new parent and drop reference to old parent

Notice that we always grab a reference before creating a link and drop it
only after the link removal. All checks are done before any directory
modifications start - that way we can bail out if they fail.

The only really obscure part is dropping an extra reference if victim is
a directory - then we know that we are cannibalizing the last external
link to it and the only link that remains is victim's ".". We don't want
it to prevent victim's removal, so we drive i_nlink of victim to zero.

