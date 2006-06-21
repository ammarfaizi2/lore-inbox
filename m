Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932124AbWFUN1B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124AbWFUN1B (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 09:27:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932127AbWFUN1A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 09:27:00 -0400
Received: from mx1.redhat.com ([66.187.233.31]:46524 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932124AbWFUN07 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 09:26:59 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 0/2] VFS: Enable future NFS superblock sharing [try #2]
Date: Wed, 21 Jun 2006 14:26:48 +0100
To: torvalds@osdl.org, akpm@osdl.org
Cc: dhowells@redhat.com, viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, nfsv4@linux-nfs.org
Message-Id: <20060621132648.22882.57254.stgit@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


These two patches are a precursor to the NFS superblock sharing patches.  The
NFS superblock sharing patches group NFS files together into superblocks by
{server, protocol, FSID}.

Ideally we'd represent each FSID tree retrieved from the server as a single
tree in the client, rooted at the root of the FSID tree.  However, things are
much more messy than that for two reasons:

 (1) We may jump directly into the middle of a tree (consider mountd), and we
     may not be able to access the common root of a tree on the server.

     This means we may know about several subtrees of a particular filesystem
     on the server, but not be able to get the bits connecting them.  Consider
     /home: the automounter might mount various users' home directories, but it
     may not actually be able to mount the directory in which they live.

 (2) We can't simply assume that the hidden common bit of the paths forms a
     real tree.  Symbolic links on the server may distort our perception of
     reality, and if the common part suddenly becomes visible, we may find that
     the dentry tree we've constructed is out of shape.

So what we want to do with NFS is have the ability to have separate trees
within one superblock, and to splice the root of one as a branch on another
when we find a connection.

The getsb patch permits the get_sb() op to return an arbitrary root for a
superblock, allowing multiple trees to be set up within the superblock, or
permitting a subtree to be returned (similar to mount --bind).

The statfs patch permits the statfs() op to find out which bit of the tree is
being probed.  In the NFS case, this is because the actual root dentry is a
dummy that is never actually used (since we aren't necessarily sure of what the
root actually is).  For FUSE this might be because different dentries map to
different data sources.

[try #2] is updated to 2.6.17-git2.

David
