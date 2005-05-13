Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262225AbVEMDly@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262225AbVEMDly (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 23:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262226AbVEMDly
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 23:41:54 -0400
Received: from mail.ccur.com ([208.248.32.212]:40853 "EHLO flmx.iccur.com")
	by vger.kernel.org with ESMTP id S262225AbVEMDlu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 23:41:50 -0400
Subject: Re: NFS: msync required for data writes to server?
From: Linda Dunaphant <linda.dunaphant@ccur.com>
Reply-To: linda.dunaphant@ccur.com
To: Andrew Morton <akpm@osdl.org>
Cc: trond.myklebust@fys.uio.no, linux-kernel@vger.kernel.org
In-Reply-To: <20050512194210.10a9dc93.akpm@osdl.org>
References: <1115925686.6319.3.camel@lindad>
	 <20050512175720.74ea6a3e.akpm@osdl.org> <1115950903.6319.25.camel@lindad>
	 <20050512194210.10a9dc93.akpm@osdl.org>
Content-Type: text/plain
Organization: CCUR
Message-Id: <1115955709.6319.66.camel@lindad>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-1) 
Date: Thu, 12 May 2005 23:41:49 -0400
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 May 2005 03:41:50.0169 (UTC) FILETIME=[B2241C90:01C5576D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-05-12 at 22:42, Andrew Morton wrote:
> Linda Dunaphant <linda.dunaphant@ccur.com> wrote:
> >
> > The behavior that you describe is what I expected to see. However, with
> >  my test program that mmap's the NFS file on the client, writes the data,
> >  and then munmap's the file, this wasn't the case with the 2.6.9 based
> >  kernel I was using. The file data was NEVER being written to the server.
> 
> There's something very wrong with that.
> 
> >  This afternoon I downloaded and built several later kernels. I found
> >  that with 2.6.11, the problem still occurred. With 2.6.12-rc1, the
> >  problem did not occur. I could see the proper data on the server. 
> > 
> >  Looking at the differences in fs/nfs between these trees I found a
> >  change to nfs_file_release() in fs/nfs/file.c. When I applied this
> >  change to my 2.6.9 tree, the data was written out to the server.
> > 
> >  @@ -105,6 +108,9 @@
> >   static int
> >   nfs_file_release(struct inode *inode, struct file *filp)
> >   {
> >  +       /* Ensure that dirty pages are flushed out with the right creds
> >  */
> >  +       if (filp->f_mode & FMODE_WRITE)
> >  +               filemap_fdatawrite(filp->f_mapping);
> >          return NFS_PROTO(inode)->file_release(inode, filp);
> >   }
> 
> Well yes, that'll sync the file on close, but it doesn't explain the
> original problem.
> 

The original problem that I was trying to track down occurred with an
Ada test suite. During the initialization phase it creates several data
files with mmap(MAP_SHARED) that contain information that is used by
later phases of the test. We were getting test failures on random tests
because the testsuite running on the client was occasionally reading
nulls from these files. Using ethereal to trace several testruns (~2.5
hrs for a complete run), I never saw any writes for these files being
issued to the server. My original theory was that as long as the pages
associated with the file were still in memory, the data was correct for
applications running on the client - but if a page is being dropped
without being written to the server, and someone references that offset
later, the data would be reread from the server and nulls would be
returned.  

After I found Trond's statement that msync was required to flush the
data to the server, I created a small test program that creates a file,
ftruncates it to 16384 bytes, mmaps it, closes it, writes the data, then
munmaps it. With the 2.6.9 based kernel, I never saw the correct data on
the server, even if I waited over an hour. If I looked at the file from
the client, I would see the correct data. I also tried unmounting the
filesystem to see if the data flush would occur, but it never did. We
also tried adding msync calls to the testsuite and the original problem
we had went away. This was the reason I posted my original question
whether an msync is required if the file is NFS. 

Tomorrow we will try running the testsuite with the above change in
place to see if it helps the original problem. I suspect the potential
still exists for a page to be dropped before the file release that could
still cause incorrect data to be read back from the server.

Linda

