Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932677AbVHSQnc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932677AbVHSQnc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 12:43:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932665AbVHSQnc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 12:43:32 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2975 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932660AbVHSQna (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 12:43:30 -0400
Date: Fri, 19 Aug 2005 09:43:17 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Anton Altaparmakov <aia21@cam.ac.uk>
cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, vandrove@vc.cvut.cz,
       Andrew Morton <akpm@osdl.org>, linware@sh.cvut.cz,
       fsdevel <linux-fsdevel@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Kernel bug: Bad page state: related to generic symlink code and
 mmap
In-Reply-To: <Pine.LNX.4.58.0508190913570.3412@g5.osdl.org>
Message-ID: <Pine.LNX.4.58.0508190934470.3412@g5.osdl.org>
References: <1124450088.2294.31.camel@imp.csi.cam.ac.uk> 
 <20050819142025.GA29811@parcelfarce.linux.theplanet.co.uk>
 <1124466246.2294.65.camel@imp.csi.cam.ac.uk> <Pine.LNX.4.58.0508190855350.3412@g5.osdl.org>
 <Pine.LNX.4.58.0508190913570.3412@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 19 Aug 2005, Linus Torvalds wrote:
> 
>  - document this as a fundamental fact, and apply the ncpfs patch. Local 
>    filesystems can still continue to use the generic helper functions 
>    (all other users _are_ local filesystems).

Actually, looking at the ncpfs patch, I'd rather not apply that patch 
as-is. It looks like it will totally disable symlink caching, which would 
be kind of sad. Somebody willing to do the same thing NFS does?

NFS hides away the "struct page *" pointer at the end of the page data, so
that when we pass the pointer to the virtual address around, we can 
trivially look up the "struct page".

An alternative is to make the symlink address-space use a gfp_mask of 
GFP_KERNEL (no highmem), at which point ncpfs_put_link() just becomes 
something like

	void ncpfs_put_link(struct dentry *dentry, struct nameidata *nd)
	{
		char *addr = nd_get_link(nd);

		if (!IS_ERR(addr))
			page_cache_release(virt_to_page(addr));
	}

which is pretty ugly, but even simpler than the NFS trick.

Anybody?

			Linus
