Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262079AbUDWQUy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262079AbUDWQUy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 12:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264859AbUDWQUy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 12:20:54 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:38099 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S262079AbUDWQUw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 12:20:52 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16521.16994.676933.323590@laputa.namesys.com>
Date: Fri, 23 Apr 2004 20:20:50 +0400
To: Andreas Dilger <adilger@clusterfs.com>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       alexander viro <viro@parcelfarce.linux.theplanet.co.uk>,
       trond myklebust <trondmy@trondhjem.org>,
       neil brown <neilb@cse.unsw.edu.au>
Subject: Re: d_splice_alias() problem.
In-Reply-To: <20040423154038.GM2938@schnapps.adilger.int>
References: <16521.5104.489490.617269@laputa.namesys.com>
	<20040423154038.GM2938@schnapps.adilger.int>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger writes:
 > On Apr 23, 2004  17:02 +0400, Nikita Danilov wrote:
 > > Suppose we have an inode with ->i_nlink == 1. It's accessed over NFS and
 > > DCACHE_DISCONNECTED dentry D1 is created for it. Then, unlink request
 > > comes for this file. nfsd looks name up in the parent directory
 > > (nfsd_unlink()->lookup_one_len()). File system back-end uses
 > > d_splice_alias(), but it only works for directories and we end up with
 > > second (this time connected) dentry D2.
 > > 
 > > It's hard to imagine how new name can be identified with one among
 > > multiple anonymous dentries, which is necessary for
 > > NFSEXP_NOSUBTREECHECK export to work reliably.
 > > 
 > > One possible work-around is to forcibly destroy all remaining
 > > DCACHE_DISCONNECTED dentries when ->i_nlink drops to zero, but I am not
 > > sure that this is possible and solves all problems of having more
 > > dentries than there are nlinks.
 > 
 > We use a patch for Lustre which solves this problem.  When there is
 > a lookup-by-inum done on the server there is the possibility to get a
 > DISCONNECTED dentry as you say.  However, if we ever do another lookup
 > on this inode we verify that either this is a disconnected dentry and
 > return the existing dentry, or if it is a connected dentry we essentially
 > "rename" the disconnected dentry and connect it to the tree and return
 > that.  There can never be both connected and disconnected dentry aliases
 > on an inode at one time.

I am not sure I understand this description correctly, but it looks
pretty much like what d_splice_alias() is supposed to do according to
the comment on top of it.

What I missed is that inode can have no more than one disconnected
dentry even if it has multiple names. Hence when lookup-by-name happens
list we can d_move disconnected dentry in place of the named one. This
is no worse that what is done currently by d_find_alias() that
identifies disconnected dentry with arbitrary connected.

 > 
 > This is handled inside the ext3 lookup code, I'm not sure how easy/hard
 > it would be to make a generic VFS patch to do the same.
 > 
 > Cheers, Andreas

Nikita.
