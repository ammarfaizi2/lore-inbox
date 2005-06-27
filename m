Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261941AbVF0WIk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261941AbVF0WIk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 18:08:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261946AbVF0WIk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 18:08:40 -0400
Received: from rgminet04.oracle.com ([148.87.122.33]:50374 "EHLO
	rgminet04.oracle.com") by vger.kernel.org with ESMTP
	id S261944AbVF0WII (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 18:08:08 -0400
Date: Mon, 27 Jun 2005 15:06:12 -0700
From: Mark Fasheh <mark.fasheh@oracle.com>
To: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, joel.becker@oracle.com
Subject: generic_drop_inode
Message-ID: <20050627220612.GH8215@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
References: <20050620235458.5b437274.akpm@osdl.org> <20050627090640.GA5410@infradead.org> <1119882343.4256.358.camel@tribesman.namesys.com> <20050627192651.GB21932@infradead.org> <20050627194402.GK31165@ca-server1.us.oracle.com> <20050627202648.GA24745@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050627202648.GA24745@infradead.org>
Organization: Oracle Corporation
User-Agent: Mutt/1.5.9i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2005 at 09:26:48PM +0100, Christoph Hellwig wrote:
> I think this still qualifies as calling generic_delete_inode because it's
> a trivial wrapper.  Manipulating i_nlink seems rather odd to me, I'd
> say you should rather call into generic_delete_inode directly if
> OCFS2_INODE_MAYBE_ORPHANED is set (that's what generic_drop_inode will
> do for i_nlink == 0 anyway).
Allowing the file system to make the full decision and call the proper
function would be fine, but then we'd need generic_forget_inode exported
too :)

> In fact given every cluster and possibly many network filesystems will
> need this it might make sense to take the OCFS2_INODE_MAYBE_ORPHANED into
> the VFS, i.e. make it an i_state flag (after fixing can_unuse to not do
> something totally stupid with i_state)
Yes, the problem certainly isn't necessarily specific to OCFS2 so I'd be
more than happy to see that as a generic VFS feature. As is, the export and
callback get us past quite a few problems with tracking orphaned inodes in
the cluster.

This however, brings me to a related issue for which I'd appreciate some
advice.

If a node crashes or otherwise fails to complete the unlink(2) then the
inode in qusetion will *not* have actually been orphaned. Of course, the
local node doesn't know this and eventually gets to ocfs2_delete_inode() (via
the MAYBE_ORPHANED flag) which will do the work of determining whether the
inode is actually orphaned. The problem is that by the time we've gotten
there, generic_delete_inode() has done a truncate_inode_pages() which might
throw out data for a file which otherwise wants it on disk.

In fact, because OCFS2 supports POSIX style unlink-while-open across the
entire cluster, we might get to ocfs2_delete_inode() and during the voting
process, discover that the file is still open on another node in which case
we don't want to wipe it but would have lost file data due to the
truncate_inode_pages() anyway.

Essentially, we get to ocfs2_delete_inode() before we have a chance to
take the cluster lock and determine the true state of the inode.  By
then it is too late.  We really need to be able to make the
determination before calling generic_drop_inode(), but drop_inode() is
under the inode lock, and we can't call out to the cluster.  The
question becomes where and how to do this work?
	--Mark

--
Mark Fasheh
Senior Software Developer, Oracle
mark.fasheh@oracle.com

