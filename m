Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262470AbTFKO5F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 10:57:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262473AbTFKO5F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 10:57:05 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:11527 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S262470AbTFKO4z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 10:56:55 -0400
Date: Wed, 11 Jun 2003 08:08:56 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: viro@parcelfarce.linux.theplanet.co.uk, Frank Cusack <fcusack@fcusack.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nfs_unlink() race (was: nfs_refresh_inode: inode number
 mismatch)
In-Reply-To: <1055334814.2084.12.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0306110804360.4413-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 11 Jun 2003, Alan Cox wrote:
> 
> For vfat at least its all broken. 

Looks like a different issue, not dentry aliasing per se.

> cd foo
> mv ../file .
> more file
> 
> ESTALE.

Yes, VFAT ends up encoding the parent directory in the FH, so renaming 
will invalidate the old file handle, and if you cache inodes (and thus 
filehandles) over a directory move, badness happens.

Arguably it's a NFS client problem - the path revalidate at open time 
should have caught the ESTALE and forced a new inode lookup. But I think 
you can also argue that VFAT over NFS is just non-unixy enough that it 
just isn't really "supported".

I think it's more of a "you can NFS-export strange filesystems for some
limited file sharing, but if things break, you get to keep both pieces".

		Linus

