Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbTJJLm5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 07:42:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbTJJLm5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 07:42:57 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:40618 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261151AbTJJLmx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 07:42:53 -0400
Date: Fri, 10 Oct 2003 17:18:21 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Daniel McNeil <daniel@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "linux-aio@kvack.org" <linux-aio@kvack.org>
Subject: Re: 2.6.0-test6-mm4 - oops in __aio_run_iocbs()
Message-ID: <20031010114821.GA4357@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20031005013326.3c103538.akpm@osdl.org> <1065655095.1842.34.camel@ibm-c.pdx.osdl.net> <20031009111624.GA11549@in.ibm.com> <1065721121.1821.16.camel@ibm-c.pdx.osdl.net> <20031010083401.GA3983@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031010083401.GA3983@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 10, 2003 at 02:04:01PM +0530, Suparna Bhattacharya wrote:
> On Thu, Oct 09, 2003 at 10:38:41AM -0700, Daniel McNeil wrote:
> > On Thu, 2003-10-09 at 04:16, Suparna Bhattacharya wrote:
> > > On Wed, Oct 08, 2003 at 04:18:15PM -0700, Daniel McNeil wrote:
> > > > I'm been testing AIO on test6-mm4 using a ext3 file system and
> > > > copying a 88MB file to an already existing preallocated file of 88MB.
> > > > I been using my aiocp program to copy the file using i/o sizes of
> > > > 1k to 512k and outstanding aio requests of between 1 and 64 using
> > > > O_DIRECT, O_SYNC and O_DIRECT & O_SYNC.  Everything works as long
> > > > as the file is pre-allocated.  When copying the file to a new file
> > > > (O_CREAT|O_DIRECT), I get the following oops:
> > > 
> > > What are the i/o sizes and block sizes for which you get the oops ?
> > > Is this only for large i/o sizes ?
> > 
> > 
> > I've done more testing and it is a little confusing.
> > I originally got the oops running a shell script which copied 4
> > 88MB files one at a time to a sub-directory:
> > 
> > for i in fff ff1 ff2 ff3
> > do
> >         aiocp -b 128k -n 8 -f CREAT -f DIRECT $i junkdir/$i
> > done
> > sync
> > 
> > This script would always cause the oops and the machine would lock up.
> > 
> > I ran aiocp manually using different block sizes (4k-128k) to copy
> > 1 file to a subdirectory.  I removed the file in the subdirectory
> > afterward.  These tests completed without any problems or oopses.
> > 
> > > __aio_run_iocbs should have been called only for buffered i/o, 
> > > so this sounds like an O_DIRECT fallback to buffered i/o.
> > > Possibly after already submitting some blocks direct to BIO,
> > > the i/o completion path for which ends up calling aio_complete
> > > releasing the iocb. That could explain the use-after-free situation
> > > you see.
> > 
> > mm4 has my extra iocb ref count for retries patch.  So the iocb should
> > not be being freed by aio_complete.  The stack trace looks like the
> > fault is on the ctx or ctx->runlist.
> 
> The race I was suspecting is a different one - a case where the dio code
> calls aio_complete before a fallback to buffered i/o, and the latter
> queues up a retry. By the time the retry gets to run the reference to
> the iocb would have gone. (your extra iocb ref count patch wouldn't
> be able to guard against this - the correct solution would be to
> avoid doing aio_complete if we run into -ENOTBLK i.e. when we intend 
> to fallback to buffered i/o).
> 

Could you try applying the following hack and see if it makes a 
difference ?

I was able to recreate an oops running aiocp with the same arguments
that you mentioned on 2.6.0-test6-mm4; and that didn't seem to
occur when I applied this patch.

Note: This is not a complete fix though and probably room for doing this 
in a cleaner way. If what I suspect is going on, we'll need more work to get 
there - like thinking through the case where a request spans an allocated
region followed by a hole.

Regards
Suparna
-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Labs, India

----------------------------------------------

AIO-DIO fix: Don't call aio_complete if we are falling back to buffered i/o

diff -urp puremm/fs/direct-io.c linux-2.6.0-test6-mm4/fs/direct-io.c
--- puremm/fs/direct-io.c	2003-10-10 14:26:53.000000000 +0530
+++ linux-2.6.0-test6-mm4/fs/direct-io.c	2003-10-10 14:26:26.000000000 +0530
@@ -208,7 +208,7 @@ static struct page *dio_get_page(struct 
  */
 static void dio_complete(struct dio *dio, loff_t offset, ssize_t bytes)
 {
-	if (dio->end_io)
+	if (dio->end_io && dio->result != -ENOTBLK)
 		dio->end_io(dio->inode, offset, bytes, dio->map_bh.b_private);
 	if (dio->needs_locking)
 		up_read(&dio->inode->i_alloc_sem);
@@ -224,7 +224,8 @@ static void finished_one_bio(struct dio 
 		if (dio->is_async) {
 			dio_complete(dio, dio->block_in_file << dio->blkbits,
 					dio->result);
-			aio_complete(dio->iocb, dio->result, 0);
+			if (dio->result != -ENOTBLK)
+				aio_complete(dio->iocb, dio->result, 0);
 			kfree(dio);
 		}
 	}
@@ -978,6 +979,8 @@ direct_io_worker(int rw, struct kiocb *i
 	 * OK, all BIOs are submitted, so we can decrement bio_count to truly
 	 * reflect the number of to-be-processed BIOs.
 	 */
+	if (ret == -ENOTBLK)
+		dio->result = ret;
 	if (dio->is_async) {
 		if (ret == 0)
 			ret = dio->result;	/* Bytes written */
