Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751220AbVHSQIB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220AbVHSQIB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 12:08:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751215AbVHSQIB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 12:08:01 -0400
Received: from smtp.osdl.org ([65.172.181.4]:46740 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751209AbVHSQIA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 12:08:00 -0400
Date: Fri, 19 Aug 2005 09:07:35 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Anton Altaparmakov <aia21@cam.ac.uk>
cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, vandrove@vc.cvut.cz,
       Andrew Morton <akpm@osdl.org>, linware@sh.cvut.cz,
       fsdevel <linux-fsdevel@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Kernel bug: Bad page state: related to generic symlink code and
 mmap
In-Reply-To: <1124466246.2294.65.camel@imp.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.58.0508190855350.3412@g5.osdl.org>
References: <1124450088.2294.31.camel@imp.csi.cam.ac.uk> 
 <20050819142025.GA29811@parcelfarce.linux.theplanet.co.uk>
 <1124466246.2294.65.camel@imp.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 19 Aug 2005, Anton Altaparmakov wrote:
>
> 		struct page *page;
> 		page = find_get_page(dentry->d_inode->i_mapping, 0);
> 		if (!page)
> ---->			BUG();

Something has truncated the mapping. 

My guess is that you had a cache invalidate event that removed the page
from the mapping while it was being used. That might also explain why this
only happens for ncpfs. I bet that in the other cases, the mapping was 
also invalidated, but re-filled immediately, and your strace slowed the 
other process down enough that it didn't get to re-fill the cache it 
invalidated or something like that.

The fact that it happens only for cross-volume things might also be 
explained that way - is there something ncpfs does when switching volumes 
that might trigger a cache invalidate for another volume (either on the 
client side or the server side - maybe the server tends to try to break 
the connection for the old volume when you start traversing a new one?)

The generic "page cache for symlinks" code does _not_ support invalidating 
the cache while it's being used. A local filesystem will obviously never 
invalidate the cache at all. 

Hmm.. NFS _does_ use the page cache for symlinks, but uses it slightly 
differently: instead of relying on the page cache entry being the same 
when freeing the page, it just caches the page it looked up in the page 
cache (ie "nfs_follow_link()" does look up the page cache, but then hides 
the page pointer inside the page data itself (uglee), and thus does not 
depend on the mapping staying the same (nfs_put_link() just takes the page 
from the symlink data).

		Linus
