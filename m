Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132468AbRCZQ1y>; Mon, 26 Mar 2001 11:27:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132464AbRCZQ1o>; Mon, 26 Mar 2001 11:27:44 -0500
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:9477 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S132461AbRCZQ1Z>; Mon, 26 Mar 2001 11:27:25 -0500
Date: Mon, 26 Mar 2001 11:26:35 -0500
From: Chris Mason <mason@suse.com>
To: Jean Charles Delepine <delepine@u-picardie.fr>,
        linux-kernel@vger.kernel.org, alan@redhat.com, viro@math.psu.edu
cc: linux-scsi@vger.kernel.org
Subject: Re: BUG in reiserfs with 2.4.2-ac20 + linux-aic7xxx Rev 6.1.7
Message-ID: <42730000.985623995@tiny>
In-Reply-To: <m2n1a826ri.fsf@eloi.machoro.ka>
X-Mailer: Mulberry/2.0.6b4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> 
> Mar 25 06:56:50 gip2 kernel: journal_begin called without kernel lock held
> Mar 25 06:56:50 gip2 kernel: kernel BUG at journal.c:423!
> 
Ok, this BUG is there to catch people trying to use the reiserfs journal
without the BKL held.  Older ac series kernel had a bug where vmtruncate
would trigger this when called from generic_file_write (which your stack
trace shows you hit).

But, ac20 should have the fix.  Looks like only the expanding truncate case
ended up under the BKL in vmtruncate.  This untested diff is stolen from the
expanding truncate fix in ac25:

--- linux/mm/memory.c.1	Mon Mar 26 11:05:25 2001
+++ linux/mm/memory.c	Mon Mar 26 11:06:31 2001
@@ -969,7 +969,12 @@
 	spin_unlock(&mapping->i_shared_lock);
 	truncate_inode_pages(mapping, offset);
 	if (inode->i_op && inode->i_op->truncate)
+	{
+		/* This doesnt scale but it is meant to be a 2.4 invariant */
+		lock_kernel();
 		inode->i_op->truncate(inode);
+		unlock_kernel();
+	}
 	return 0;
 
 do_expand:

-chris

