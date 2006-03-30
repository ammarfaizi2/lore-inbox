Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750965AbWC3VSN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750965AbWC3VSN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 16:18:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750964AbWC3VSM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 16:18:12 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:27833 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750965AbWC3VSL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 16:18:11 -0500
Date: Fri, 31 Mar 2006 07:17:36 +1000
From: Nathan Scott <nathans@sgi.com>
To: Neil Brown <neilb@suse.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, drepper@redhat.com,
       mtk-manpages@gmx.net, nickpiggin@yahoo.com.au
Subject: Re: [patch 1/1] sys_sync_file_range()
Message-ID: <20060331071736.K921158@wobbly.melbourne.sgi.com>
References: <200603300741.k2U7fQLe002202@shell0.pdx.osdl.net> <17451.36790.450410.79788@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <17451.36790.450410.79788@cse.unsw.edu.au>; from neilb@suse.de on Thu, Mar 30, 2006 at 06:58:46PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2006 at 06:58:46PM +1100, Neil Brown wrote:
> On Wednesday March 29, akpm@osdl.org wrote:
> > Remove the recently-added LINUX_FADV_ASYNC_WRITE and LINUX_FADV_WRITE_WAIT
> > fadvise() additions, do it in a new sys_sync_file_range() syscall
> > instead. 
> 
> Hmmm... any chance this could be split into a sys_sync_file_range and
> a vfs_sync_file_range which takes a 'struct file*' and does less (or
> no) sanity checking, so I can call it from nfsd?
> 
> Currently I implement COMMIT (which has a range) with a by messing
> around with filemap_fdatawrite and filemap_fdatawait (ignoring the
> range) and I'd rather than a vfs helper.

I'm not 100% sure, but it looks like the PF_SYNCWRITE process flag
should be set on the nfsd's while they're doing that, which doesn't
seem to be happening atm.  Looks like a couple of the IO schedulers
will make use of that knowledge now.  All the more reason for a VFS
helper here I guess. ;)

cheers.

-- 
Nathan


Index: 2.6.x-xfs/fs/nfsd/vfs.c
===================================================================
--- 2.6.x-xfs.orig/fs/nfsd/vfs.c
+++ 2.6.x-xfs/fs/nfsd/vfs.c
@@ -712,11 +712,13 @@ static inline int nfsd_dosync(struct fil
 	int (*fsync) (struct file *, struct dentry *, int);
 	int err;
 
+	current->flags |= PF_SYNCWRITE;
 	err = filemap_fdatawrite(inode->i_mapping);
 	if (err == 0 && fop && (fsync = fop->fsync))
 		err = fsync(filp, dp, 0);
 	if (err == 0)
 		err = filemap_fdatawait(inode->i_mapping);
+	current->flags &= ~PF_SYNCWRITE;
 
 	return err;
 }
