Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964997AbVHSQWG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964997AbVHSQWG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 12:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964996AbVHSQWF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 12:22:05 -0400
Received: from smtp.osdl.org ([65.172.181.4]:61847 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964978AbVHSQWE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 12:22:04 -0400
Date: Fri, 19 Aug 2005 09:21:38 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Anton Altaparmakov <aia21@cam.ac.uk>
cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, vandrove@vc.cvut.cz,
       Andrew Morton <akpm@osdl.org>, linware@sh.cvut.cz,
       fsdevel <linux-fsdevel@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Kernel bug: Bad page state: related to generic symlink code and
 mmap
In-Reply-To: <Pine.LNX.4.58.0508190855350.3412@g5.osdl.org>
Message-ID: <Pine.LNX.4.58.0508190913570.3412@g5.osdl.org>
References: <1124450088.2294.31.camel@imp.csi.cam.ac.uk> 
 <20050819142025.GA29811@parcelfarce.linux.theplanet.co.uk>
 <1124466246.2294.65.camel@imp.csi.cam.ac.uk> <Pine.LNX.4.58.0508190855350.3412@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 19 Aug 2005, Linus Torvalds wrote:
> 
> The generic "page cache for symlinks" code does _not_ support invalidating 
> the cache while it's being used. A local filesystem will obviously never 
> invalidate the cache at all. 
> 
> Hmm.. NFS _does_ use the page cache for symlinks [..]

Looking more and more at this, I'm convinced this is it.

Basically, page_follow_link_light() and page_put_link() depend on the fact
that the page in the page cache is the same one the whole time:  
page_follow_link_light() will increment the page count of the page it
finds at offset 0, and page_put_link() will decrement it. If the page has 
changed, they increment/decrement different pages.

There's two ways to fix this:

 - document this as a fundamental fact, and apply the ncpfs patch. Local 
   filesystems can still continue to use the generic helper functions 
   (all other users _are_ local filesystems).

 - make "nameidata" contain not just the virtual addresses of the names, 
   but also have a "struct page *pages[MAX_NESTED_LINKS + 1]", and save 
   away the page there. That will fix ncpfs, and we could then make NFS 
   also use the generic routines.

I suspect that #1 is the prudent one. We have a patch already, and we
don't want to grow nameidata. I'll commit a comment at the head of
page_follow_link_light() too.

		Linus
