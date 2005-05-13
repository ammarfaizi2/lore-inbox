Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261811AbVEMCVr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261811AbVEMCVr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 22:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261978AbVEMCVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 22:21:47 -0400
Received: from mail.ccur.com ([208.248.32.212]:54669 "EHLO flmx.iccur.com")
	by vger.kernel.org with ESMTP id S261811AbVEMCVn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 22:21:43 -0400
Subject: Re: NFS: msync required for data writes to server?
From: Linda Dunaphant <linda.dunaphant@ccur.com>
Reply-To: linda.dunaphant@ccur.com
To: Andrew Morton <akpm@osdl.org>
Cc: trond.myklebust@fys.uio.no, linux-kernel@vger.kernel.org
In-Reply-To: <20050512175720.74ea6a3e.akpm@osdl.org>
References: <1115925686.6319.3.camel@lindad>
	 <20050512175720.74ea6a3e.akpm@osdl.org>
Content-Type: text/plain
Organization: CCUR
Message-Id: <1115950903.6319.25.camel@lindad>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-1) 
Date: Thu, 12 May 2005 22:21:43 -0400
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 May 2005 02:21:43.0450 (UTC) FILETIME=[811CFFA0:01C55762]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-05-12 at 20:57, Andrew Morton wrote:
> Linda Dunaphant <linda.dunaphant@ccur.com> wrote:
> >
> > Hi Trond,
> > 
> > On our 2.6.9 based systems, data written using mmap(MAP_SHARED) on a NFS
> > client is *never* being pushed out to the server if an explicit msync call
> > is not issued before the munmap.
> > 
> > On 11/12/04, there was a message thread concerning NFS corruption when
> > using mmap/munmap:
> > 
> > http://marc.theaimsgroup.com/?l=linux-nfs&m=110028817508318&w=2
> > 
> > In this thread you stated:
> > 
> >      mmap() offers absolutely NO guarantees that the file will be synced to
> >      disk on close. Use msync(MS_SYNC) if you want such a guarantee.
> > 
> > Are you saying that the data will *never* be written to the server?  Could
> > you please clarify your position on this further? 
> 
> The dirty pages will float about in memory until something causes them to
> be written back.  That "something" could be
> msync/fsync/sync/pdflush/journal commit or, eventually, the VM system
> deciding that it wants to reuse that physical page for something else.
> 
> So yes, the page will eventually be written to the server, but not for
> quite some time.
> 
> In the case where the page was dirtied by mmap and was then unmapped (via
> munmap or via program exit), the page will be marked dirty in pagecache
> when its pagetable entry is unmapped.  That makes the page's dirtiness
> visible to the VFS and the page will be written out approximately 30
> seconds later by pdflush.

Thank you for responding Andrew!

The behavior that you describe is what I expected to see. However, with
my test program that mmap's the NFS file on the client, writes the data,
and then munmap's the file, this wasn't the case with the 2.6.9 based
kernel I was using. The file data was NEVER being written to the server.

This afternoon I downloaded and built several later kernels. I found
that with 2.6.11, the problem still occurred. With 2.6.12-rc1, the
problem did not occur. I could see the proper data on the server. 

Looking at the differences in fs/nfs between these trees I found a
change to nfs_file_release() in fs/nfs/file.c. When I applied this
change to my 2.6.9 tree, the data was written out to the server.

@@ -105,6 +108,9 @@
 static int
 nfs_file_release(struct inode *inode, struct file *filp)
 {
+       /* Ensure that dirty pages are flushed out with the right creds
*/
+       if (filp->f_mode & FMODE_WRITE)
+               filemap_fdatawrite(filp->f_mapping);
        return NFS_PROTO(inode)->file_release(inode, filp);
 }

Thanks for your help!
Linda

