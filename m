Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964827AbWIDLwV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964827AbWIDLwV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 07:52:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964826AbWIDLwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 07:52:20 -0400
Received: from mx1.redhat.com ([66.187.233.31]:10168 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964805AbWIDLwT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 07:52:19 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060901195009.187af603.akpm@osdl.org> 
References: <20060901195009.187af603.akpm@osdl.org>  <20060831102127.8fb9a24b.akpm@osdl.org> <20060830135503.98f57ff3.akpm@osdl.org> <20060830125239.6504d71a.akpm@osdl.org> <20060830193153.12446.24095.stgit@warthog.cambridge.redhat.com> <27414.1156970238@warthog.cambridge.redhat.com> <9849.1157018310@warthog.cambridge.redhat.com> <9534.1157116114@warthog.cambridge.redhat.com> <20060901093451.87aa486d.akpm@osdl.org> <1157130044.5632.87.camel@localhost> 
To: Andrew Morton <akpm@osdl.org>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       David Howells <dhowells@redhat.com>, torvalds@osdl.org,
       steved@redhat.com, linux-fsdevel@vger.kernel.org,
       linux-cachefs@redhat.com, nfsv4@linux-nfs.org,
       linux-kernel@vger.kernel.org, Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 0/7] Permit filesystem local caching and NFS superblock sharing [try #13] 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Mon, 04 Sep 2006 12:52:01 +0100
Message-ID: <28936.1157370721@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:

> The automounter will mount bix:/ on /net/bix.  But I am unable to get it to
> mount bix's /usr/src on /net/bix/usr/src.

>From what I can tell, the problem is that the automounter causes a dentry to
be created on the xdev transition point, but the dentry is not set up right to
do in-NFS automounting on the follow_link() op.

By "xdev transition point" I mean a directory exported from the server that
has a different FSID to its parent.  The NFS client detects that and provides
automounting facilities in the following manner:

 (1) A directory dentry is set up in the superblock of the parent FSID to
     represent the transition point.  This dentry has a follow_link() op set.

 (2) When someone tries to traverse the transition point, the follow_link() op
     is invoked.  This causes a new superblock to be created to represent the
     new FSID, and a root directory entry is allocated there.  This new root
     is then mounted over the dentry set up in (1).

 (3) The follow_link() op of the transit dentry returns the mountpoint dentry
     as if a symlink had been transited.  Further transits just see the
     mountpoint and ignore the transit dentry at the bottom of the pile.

Note that an lstat() of the transit dentry does not cause automounting to take
place because lstat() does not follow terminal symlinks, and thus does not
invoke the follow_link() op.


However, when the automounter preemptively creates a dentry there with mkdir,
it can install a directory dentry *without* the appropriate follow_link() op.

David

-- 
VGER BF report: H 0.00103342
