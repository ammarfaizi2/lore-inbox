Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261706AbTDEQfx (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 11:35:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262534AbTDEQfx (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 11:35:53 -0500
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:41845 "EHLO
	dickson.boston.redhat.com") by vger.kernel.org with ESMTP
	id S261706AbTDEQfw (for <rfc822;linux-kernel@vger.kernel.org>); Sat, 5 Apr 2003 11:35:52 -0500
Date: Sat, 5 Apr 2003 11:47:41 -0500
From: Steve Dickson <SteveD@RedHat.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: nfs@lists.sourceforge.net, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [NFS] [PATCH] mmap corruption
Message-ID: <20030405164741.GA6450@RedHat.com>
Reply-To: SteveD@RedHat.com
References: <3E8DDB13.9020009@RedHat.com> <shsistt7wip.fsf@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <shsistt7wip.fsf@charged.uio.no>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Trond,

On Sat, Apr 05, 2003 at 12:01:02AM +0200, Trond Myklebust wrote:
> >>>>> " " == Steve Dickson <SteveD@redhat.com> writes:
> 
> That simply doesn't ring true. The nfs_wb_all() immediately after the
> call to filemap_fdatasync() should ensure that *all* scheduled writes
> will flushed out.
> 
Here is my evidence your honor... :-)

1)  Through my debugging I was able to show when (and only when)
the following if statement is true, there would be corruption:

nfs_notify_change(struct dentry *dentry, struct iattr *attr)
{
	/*
	 * beginning code skipped
	 */

	filemap_fdatasync(inode->i_mapping);
	error = nfs_wb_all(inode);
	filemap_fdatawait(inode->i_mapping);
	if (error)
		goto out;

	/*
	 * Every time either npages or ncommit had a value and the file size is
	 * immediately changed (with in a microsecond or two) by another 
	 * truncation, followed by a mmap read, the file would be corrupted.
	 */
	if (NFS_I(inode)->npages || NFS_I(inode)->ncommit || NFS_I(inode)->ndirty) {
		printk("nfs_notify_change: fid %Ld npages %d ncommit %d ndirty %d\n",
		NFS_FILEID(inode), NFS_I(inode)->npages, 
		NFS_I(inode)->ncommit, NFS_I(inode)->ndirty);
	}
}

I was also able to log the fact that the page was being written out (and committed)
by kupdated was after second truncation finished. At first, I was thinking 
there was a problem with the nfs_fattr_obsolete() code (and still might be) 
since this late write/commit is *truly* obsolete. But I just could not figure 
out how to detect this event so I went with avoidance approach. Now, if the 
server supplied the client with valid pre and post attrs, I believe this condition 
could be detected. But I didn't have a server that did that so I could 
not test out my theroy...

2) Without this patch my script that startups 300 process fails within
minutes. With this patch the script runs to completion constistanly...

I rest my case... and the verdict is?

SteveD.
