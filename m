Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273729AbRJIIuh>; Tue, 9 Oct 2001 04:50:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273748AbRJIIu0>; Tue, 9 Oct 2001 04:50:26 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:168 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S273729AbRJIIuQ>;
	Tue, 9 Oct 2001 04:50:16 -0400
Date: Tue, 9 Oct 2001 04:50:35 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
cc: linux-kernel@vger.kernel.org, devfs-announce-list@vindaloo.ras.ucalgary.ca
Subject: Re: [PATCH] devfs v194 available
In-Reply-To: <200110090604.f99644D23291@vindaloo.ras.ucalgary.ca>
Message-ID: <Pine.GSO.4.21.0110090445340.13381-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 9 Oct 2001, Richard Gooch wrote:

>   Hi, all. Version 194 of my devfs patch is now available from:
> http://www.atnf.csiro.au/~rgooch/linux/kernel-patches.html
> The devfs FAQ is also available here.
> 
> Patch directly available from:
> ftp://ftp.??.kernel.org/pub/linux/kernel/people/rgooch/v2.4/devfs-patch-current.gz
> 
> AND:
> ftp://ftp.atnf.csiro.au/pub/people/rgooch/linux/kernel-patches/v2.4/devfs-patch-current.gz
> 
> This is against 2.4.11-pre6. Highlights of this release:
> 
> - Fixed overrun in <devfs_link> by removing function (not needed)

... doesn't fix _under_run in try_modload() (see what happens if namelen is
255 and parent is devfs root)

... doesn't fix the deadlock introduced into -pre6 in place of symlink
races. That

    /*  Need to follow the link: this is a stack chomper  */
    down_read (&symlink_rwsem);
    retval = curr->registered ?
        search_for_entry (parent, curr->u.symlink.linkname,
                          curr->u.symlink.length, FALSE, FALSE, NULL,
                          TRUE) : NULL;
    up_read (&symlink_rwsem);

is a fairly bad idea.  Think what happens if somebody else tries to
acquire symlink_rwsem for write between two calls of down_read() in
that recursion.

