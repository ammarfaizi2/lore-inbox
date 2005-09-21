Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751345AbVIUSKF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345AbVIUSKF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 14:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbVIUSKF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 14:10:05 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:35442 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1751345AbVIUSKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 14:10:02 -0400
Date: Wed, 21 Sep 2005 11:08:45 -0700
From: Mark Fasheh <mark.fasheh@oracle.com>
To: Christoph Hellwig <hch@infradead.org>, Al Viro <viro@ftp.linux.org.uk>,
       John McCutchan <ttb@tentacle.dhs.org>,
       Linus Torvalds <torvalds@osdl.org>, Ray Lee <ray@madrabbit.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Robert Love <rml@novell.com>, ocfs2-devel@oss.oracle.com
Subject: Re: [patch] stop inotify from sending random DELETE_SELF event under load
Message-ID: <20050921180845.GG18764@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
References: <20050920182249.GP7992@ftp.linux.org.uk> <Pine.LNX.4.58.0509201234560.2553@g5.osdl.org> <1127256814.749.5.camel@vertex> <20050921010154.GR7992@ftp.linux.org.uk> <1127266907.3950.5.camel@vertex> <20050921023601.GT7992@ftp.linux.org.uk> <20050921083525.GB27254@infradead.org> <20050921091524.GG26425@ca-server1.us.oracle.com> <20050921091738.GA28289@infradead.org> <20050921144538.GI26425@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050921144538.GI26425@ca-server1.us.oracle.com>
Organization: Oracle Corporation
User-Agent: Mutt/1.5.10i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2005 at 07:45:38AM -0700, Joel Becker wrote:
> On Wed, Sep 21, 2005 at 10:17:38AM +0100, Christoph Hellwig wrote:
> > The real fix would be to put an equivalent of OCFS2_INODE_MAYBE_ORPHANED
> > into struct inode.  That way it could be shared by other clustered
> > filesystems aswell, and OCFS2 had no need to implement ->drop_inode.
> 	Or change the VFS patterns to allow lookup and validation of the
> inode before choosing the generic_drop/generic_delete path.
Right. *Only* setting something akin to OCFS2_INODE_MAYBE_ORPHANED on struct
inode would give us essentially what we have today assuming that
generic_drop_inode() punted to delete_inode() in that case (as well as nlink
== 0). Which is fine as long as we're ok with inodes who might *not*
actually orphaned going through delete_inode().

A more involved solution might be to give OCFS2 the chance to do it's
cluster querying at or around drop_inode() time on those which have been
marked as potentially orphaned.

This would give us the benefit of allowing those inodes which wound up not
being orphaned (due to remote node error or death) to go through
generic_forget_inode(), which if my reading is correct would at least allow
it to live longer in the system. I'm not so sure how important this is
however, considering the number of inodes which wind up not having been
orphaned is typically very small and the only downside for those few as far
as i can tell is a small loss of performance.

Btw, the other reason a local node might not completely wipe an inode in
OCFS2 land is if another node is still using it (if it has open file
descriptors), in which case what we do today is sync the inode, truncate
it's pages and then exit ocfs2_delete_inode(), thus allowing our local VFS
to destroy it secure in the knowledge that the actual wiping of the inode
will happen elsewhere in the cluster.
	--Mark

--
Mark Fasheh
Senior Software Developer, Oracle
mark.fasheh@oracle.com
