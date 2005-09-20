Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964911AbVITIdb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964911AbVITIdb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 04:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964928AbVITIdb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 04:33:31 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:14562 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964911AbVITId3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 04:33:29 -0400
Date: Tue, 20 Sep 2005 09:33:27 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: John McCutchan <ttb@tentacle.dhs.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Robert Love <rml@novell.com>, Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [patch] stop inotify from sending random DELETE_SELF event under load
Message-ID: <20050920083327.GA31209@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Linus Torvalds <torvalds@osdl.org>,
	John McCutchan <ttb@tentacle.dhs.org>,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Robert Love <rml@novell.com>, Al Viro <viro@ZenIV.linux.org.uk>
References: <1127177337.15262.6.camel@vertex> <Pine.LNX.4.58.0509191821220.2553@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0509191821220.2553@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2005 at 06:37:43PM -0700, Linus Torvalds wrote:
> 
> 
> On Mon, 19 Sep 2005, John McCutchan wrote:
> > 
> > Below is a patch that fixes the random DELETE_SELF events when the
> > system is under load. The problem is that the DELETE_SELF event is sent
> > from dentry_iput, which is called in two code paths,
> > 
> > 1) When a dentry is being deleted
> > 2) When the dcache is being pruned.
> 
> No no.
> 
> The problem is that you put the "fsnotify_inoderemove(inode);" in the 
> wrong place, and I and Al never noticed.
> 
> iput() doesn't have anything to do with delete at all, and adding a flag 
> to it would be wrong. The inode may stay around _after_ the unlink() for 
> as long as it has users (or much longer, if you have hardlinks ;). 
> 
> You should probably move the "fsnotify_inoderemove(inode);" call into
> generic_delete_inode() instead, just after "security_inode_delete()".  No
> new flags, just a new place.
> 
> (Oh, I think you need to add it to "hugetlbfs_delete_inode()" too).

I have a patch pending to kill hugetlbfs_delete_inode().

