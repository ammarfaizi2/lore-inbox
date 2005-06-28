Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262035AbVF1Oyg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262035AbVF1Oyg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 10:54:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262012AbVF1Oyb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 10:54:31 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:441 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262004AbVF1Oy2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 10:54:28 -0400
Date: Tue, 28 Jun 2005 15:54:20 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Mark Fasheh <mark.fasheh@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, joel.becker@oracle.com
Subject: Re: generic_drop_inode
Message-ID: <20050628145420.GA23771@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Mark Fasheh <mark.fasheh@oracle.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, joel.becker@oracle.com
References: <20050620235458.5b437274.akpm@osdl.org> <20050627090640.GA5410@infradead.org> <1119882343.4256.358.camel@tribesman.namesys.com> <20050627192651.GB21932@infradead.org> <20050627194402.GK31165@ca-server1.us.oracle.com> <20050627202648.GA24745@infradead.org> <20050627220612.GH8215@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050627220612.GH8215@ca-server1.us.oracle.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2005 at 03:06:12PM -0700, Mark Fasheh wrote:
> Allowing the file system to make the full decision and call the proper
> function would be fine, but then we'd need generic_forget_inode exported
> too :)

shouldn't be much of a problem if it's actually an _GPL export.

> If a node crashes or otherwise fails to complete the unlink(2) then the
> inode in qusetion will *not* have actually been orphaned. Of course, the
> local node doesn't know this and eventually gets to ocfs2_delete_inode() (via
> the MAYBE_ORPHANED flag) which will do the work of determining whether the
> inode is actually orphaned. The problem is that by the time we've gotten
> there, generic_delete_inode() has done a truncate_inode_pages() which might
> throw out data for a file which otherwise wants it on disk.

As discussed in a different subthread of the 2.6.13 merge plan we'd like to
move towards not having truncate_inode_pages in that place, because reiser4,
hugetlbfs and some other cluster filesystems don't like it either.
But that alone isn't going to help you a lot..

> In fact, because OCFS2 supports POSIX style unlink-while-open across the
> entire cluster, we might get to ocfs2_delete_inode() and during the voting
> process, discover that the file is still open on another node in which case
> we don't want to wipe it but would have lost file data due to the
> truncate_inode_pages() anyway.
> 
> Essentially, we get to ocfs2_delete_inode() before we have a chance to
> take the cluster lock and determine the true state of the inode.  By
> then it is too late.  We really need to be able to make the
> determination before calling generic_drop_inode(), but drop_inode() is
> under the inode lock, and we can't call out to the cluster.  The
> question becomes where and how to do this work?

I don't think that's doable without a major rework of that area of code.
