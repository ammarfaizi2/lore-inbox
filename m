Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263129AbUDZMpL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263129AbUDZMpL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 08:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263789AbUDZMpL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 08:45:11 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:59860 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S263129AbUDZMpF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 08:45:05 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16525.1100.432660.844335@laputa.namesys.com>
Date: Mon, 26 Apr 2004 16:45:00 +0400
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk,
       trondmy@trondhjem.org, neilb@cse.unsw.edu.au
Subject: Re: d_splice_alias() problem.
In-Reply-To: <20040423164936.390462fb.akpm@osdl.org>
References: <16521.5104.489490.617269@laputa.namesys.com>
	<20040423164936.390462fb.akpm@osdl.org>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:
 > Nikita Danilov <Nikita@Namesys.COM> wrote:
 > >
 > > for some time I am observing that during stress tests over NFS
 > > 
 > >     shrink_slab->...->prune_dcache()->prune_one_dentry()->...->iput()
 > > 
 > >  is called on inode with ->i_nlink == 0 which results in truncate and
 > >  file deletion. This is wrong in general (file system is re-entered), and
 > >  deadlock prone on some file systems.
 > 
 > The filesystem is only reentered if the caller of __alloc_pages() passed in
 > __GFP_FS, in which case the bug is in the caller, not in shrink_slab().

Well, I always thought that the only file system IO that GFP_FS is
expected to do is one issued by ->writepage. Doing truncate from within
VM scanner looks... wrong. But that's not the point, actually. Current
d_splice_alias leads to the following problems with NFS (and may be
other remote file systems also):

 * there are more dentries than nlinks for a given file, as a result

 * file (not opened by user) is not truncated when its last name is
   removed. inode is pinned in the memory indefinitely by remaining
   disconnected dentries.

 * sequence "touch x; rm x" always creates _two_ dentries for "x": one
   disconnected (by ->decode_fh) and one connected (by lookup_one_len
   from nfs unlink request).

I think that d_splice_alias() should be changed to scan inode->i_dentry
list and d_move() any disconnected dentry found into new one.

 > 

Nikita.
