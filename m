Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264802AbUDWNCx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264802AbUDWNCx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 09:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264803AbUDWNCx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 09:02:53 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:48586 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S264802AbUDWNCt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 09:02:49 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16521.5104.489490.617269@laputa.namesys.com>
Date: Fri, 23 Apr 2004 17:02:40 +0400
To: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       alexander viro <viro@parcelfarce.linux.theplanet.co.uk>,
       trond myklebust <trondmy@trondhjem.org>,
       neil brown <neilb@cse.unsw.edu.au>
Subject: d_splice_alias() problem.
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

for some time I am observing that during stress tests over NFS

   shrink_slab->...->prune_dcache()->prune_one_dentry()->...->iput()

is called on inode with ->i_nlink == 0 which results in truncate and
file deletion. This is wrong in general (file system is re-entered), and
deadlock prone on some file systems.

After some debugging, I tracked problem down the to d_splice_alias()
failing to identify dentries when necessary.

Suppose we have an inode with ->i_nlink == 1. It's accessed over NFS and
DCACHE_DISCONNECTED dentry D1 is created for it. Then, unlink request
comes for this file. nfsd looks name up in the parent directory
(nfsd_unlink()->lookup_one_len()). File system back-end uses
d_splice_alias(), but it only works for directories and we end up with
second (this time connected) dentry D2.

D2 is successfully unlinked, file has ->i_nlink == 0, and ->i_count == 1
from D1, and when prune_dcache() hits D1 bad things happen.

It's hard to imagine how new name can be identified with one among
multiple anonymous dentries, which is necessary for
NFSEXP_NOSUBTREECHECK export to work reliably.

One possible work-around is to forcibly destroy all remaining
DCACHE_DISCONNECTED dentries when ->i_nlink drops to zero, but I am not
sure that this is possible and solves all problems of having more
dentries than there are nlinks.

Nikita.
