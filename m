Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264851AbUDWPlm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264851AbUDWPlm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 11:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264846AbUDWPlm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 11:41:42 -0400
Received: from moraine.clusterfs.com ([66.246.132.190]:32732 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S264851AbUDWPkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 11:40:40 -0400
Date: Fri, 23 Apr 2004 09:40:38 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Nikita Danilov <Nikita@Namesys.COM>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       alexander viro <viro@parcelfarce.linux.theplanet.co.uk>,
       trond myklebust <trondmy@trondhjem.org>,
       neil brown <neilb@cse.unsw.edu.au>
Subject: Re: d_splice_alias() problem.
Message-ID: <20040423154038.GM2938@schnapps.adilger.int>
Mail-Followup-To: Nikita Danilov <Nikita@Namesys.COM>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>,
	alexander viro <viro@parcelfarce.linux.theplanet.co.uk>,
	trond myklebust <trondmy@trondhjem.org>,
	neil brown <neilb@cse.unsw.edu.au>
References: <16521.5104.489490.617269@laputa.namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16521.5104.489490.617269@laputa.namesys.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 23, 2004  17:02 +0400, Nikita Danilov wrote:
> Suppose we have an inode with ->i_nlink == 1. It's accessed over NFS and
> DCACHE_DISCONNECTED dentry D1 is created for it. Then, unlink request
> comes for this file. nfsd looks name up in the parent directory
> (nfsd_unlink()->lookup_one_len()). File system back-end uses
> d_splice_alias(), but it only works for directories and we end up with
> second (this time connected) dentry D2.
> 
> It's hard to imagine how new name can be identified with one among
> multiple anonymous dentries, which is necessary for
> NFSEXP_NOSUBTREECHECK export to work reliably.
> 
> One possible work-around is to forcibly destroy all remaining
> DCACHE_DISCONNECTED dentries when ->i_nlink drops to zero, but I am not
> sure that this is possible and solves all problems of having more
> dentries than there are nlinks.

We use a patch for Lustre which solves this problem.  When there is
a lookup-by-inum done on the server there is the possibility to get a
DISCONNECTED dentry as you say.  However, if we ever do another lookup
on this inode we verify that either this is a disconnected dentry and
return the existing dentry, or if it is a connected dentry we essentially
"rename" the disconnected dentry and connect it to the tree and return
that.  There can never be both connected and disconnected dentry aliases
on an inode at one time.

This is handled inside the ext3 lookup code, I'm not sure how easy/hard
it would be to make a generic VFS patch to do the same.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

