Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129593AbRAPUSI>; Tue, 16 Jan 2001 15:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131009AbRAPUR6>; Tue, 16 Jan 2001 15:17:58 -0500
Received: from fungus.teststation.com ([212.32.186.211]:4486 "EHLO
	fungus.svenskatest.se") by vger.kernel.org with ESMTP
	id <S129593AbRAPURs>; Tue, 16 Jan 2001 15:17:48 -0500
Date: Tue, 16 Jan 2001 21:17:37 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
cc: <linux-kernel@vger.kernel.org>, <rmager@vgkk.com>
Subject: Re: Oops with 4GB memory setting in 2.4.0 stable
In-Reply-To: <12BC861F21D7@vcnet.vc.cvut.cz>
Message-ID: <Pine.LNX.4.30.0101162000280.13791-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jan 2001, Petr Vandrovec wrote:

> smb_get_dircache looks suspicious to me, as it can try to map unlimited
> number of pages with kmap. And kmaps are not unlimited resource...
> You have 512 kmaps, but one SMBFS cache page can contain about 504
> pages... So two smbfs cached directories can consume all your kmaps,
> dying then in endless loop in mm/highmem.c:map_new_virtual().

The smbfs dircache needs to find/kmap all of its cache pages since the
entries in it are variable length and the way it is called. It would be
nice to change that.

I haven't looked at all your detailed comments yet. They may not matter if
the many kmaps are a problem.


The ncpfs code puts 'struct dentry *' in it's cache pages. Fixed size
entries makes it easy to know which page you need to start reading from,
so only one kmap is needed. That looks simpler so I want to steal it,
except ...

ncpfs ends up calling d_validate to verify that the dentry is sane. But
how can it know that the dentry is the right one? I thought that dentries
could be removed/reused by someone at will (d_count will be 0 because of
the dput in ncp_fill_cache, no?). Why isn't it possible for someone to
write a new dentry where the old one was.

fs/ncpfs/dir.c:ncp_d_validate() calls
  valid = d_validate(dentry, dentry->d_parent, dentry->d_name.hash, len);

all values are taken from the dentry pointer on the cache page (including
len). d_validate verifies that d_hash() points to a list and it searches
the list for dentry. How do you know that it is the same dentry that was
put in the cache and not someone elses dentry?


> But I personally do not use neither smbfs nor PAE, so what I can say...

A whole lot, thanks. Especially for the kmap info.

Now if someone could explain the dentry pointers ... what am I missing?

/Urban

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
