Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270205AbRHWTlh>; Thu, 23 Aug 2001 15:41:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270203AbRHWTl2>; Thu, 23 Aug 2001 15:41:28 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:5896 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S270205AbRHWTlJ>; Thu, 23 Aug 2001 15:41:09 -0400
Message-ID: <3B855C62.85BC16E7@zip.com.au>
Date: Thu, 23 Aug 2001 12:41:22 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.8-ac9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Adrian Cox <adrian@humboldt.co.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: Filling holes in ext2
In-Reply-To: <3B83E9FD.6020801@humboldt.co.uk> <3B83FB3F.A0BDC056@zip.com.au> <3B853BE6.3010703@humboldt.co.uk> <3B854186.F0C00E3C@zip.com.au> <3B8556B6.7040700@humboldt.co.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Cox wrote:
> 
> Andrew Morton wrote:
> 
> > generic_file_write() will mark the page not up-to-date in this case.
> > I wonder what's actually going on?  Perhaps the fact that we've
> > instantiated a block in ext2 outside i_size?
> 
> The problem is that the on-disk metadata now says that that disk block
> is part of the file. So as the page is not up-to-date, the next read
> operation will go to the disk and fetch that block of garbage into the
> page cache.
> 

Ah.  Now I'm with you.  Yes, we need a better cleanup facility
to handle this.

We can sort-of fudge it with commit_write():

--- linux-2.4.8-ac9/mm/filemap.c	Wed Aug 22 10:57:47 2001
+++ ac/mm/filemap.c	Thu Aug 23 12:33:50 2001
@@ -2674,8 +2674,9 @@ generic_file_write(struct file *file,con
 		status = __copy_from_user(kaddr+offset, buf, bytes);
 		flush_dcache_page(page);
 		if (status) {
-			if (mapping->a_ops->abort_write)
-				mapping->a_ops->abort_write(file, page);
+			/* Zero the disk blocks so we don't expose stale data mid-file */
+			memset(kaddr + offset, 0, bytes);
+			mapping->a_ops->commit_write(file, page, offset, offset+bytes);
 			goto fail_write;
 		}
 		status = mapping->a_ops->commit_write(file, page, offset, offset+bytes);
@@ -2720,7 +2721,6 @@ out:
 fail_write:
 	status = -EFAULT;
 	ClearPageUptodate(page);
-	kunmap(page);
 	goto unlock;
 sync_failure:
 	UnlockPage(page);

Which is OK for mid-file blocks, but will cause i_size to be extended
at eof, which probably isn't too bad.  Needs more thought.

-
