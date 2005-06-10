Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261298AbVFJNBa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261298AbVFJNBa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 09:01:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261536AbVFJNB3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 09:01:29 -0400
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:18857 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261280AbVFJNBN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 09:01:13 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Subject: Bug in error recovery in fs/buffer.c::__block_prepare_write()
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Andrew Morton <akpm@osdl.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: fsdevel <linux-fsdevel@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Computing Service, University of Cambridge, UK
Date: Fri, 10 Jun 2005 14:01:03 +0100
Message-Id: <1118408464.31710.54.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

fs/buffer.c::__block_prepare_write() has broken error recovery.  It
calls the get_block() callback with "create = 1" and if that succeeds it
immediately clears buffer_new on the just allocated buffer (recognised
by virtue of having buffer_new set).

It then zeroes out the region _outside_ the write, thus if the buffer is
fully being overwritten nothing is zeroed at all in this buffer.

It then repeats this for all buffers in the page.

The bug is that if an error occurs and get_block() returns != 0, we
break from this loop and go into recovery code.  This code has this
comment:

/* Error case: */
/*
 * Zero out any newly allocated blocks to avoid exposing stale
 * data.  If BH_New is set, we know that the block was newly
 * allocated in the above loop.
 */

So the intent is obviously good in that it wants to clear just allocated
and hence not zeroed buffers.  However the code recognises allocated
buffers by checking for buffer_new being set.

Unfortunately __block_prepare_write() as discussed above already cleared
buffer_new on all allocated buffers hence not a single buffer will be
cleared here and old data will be leaked.  Here is the relevant code
from the error recovery path which at present _never_ triggers:

                if (buffer_new(bh)) {
                        void *kaddr;

                        clear_buffer_new(bh);
                        kaddr = kmap_atomic(page, KM_USER0);
                        memset(kaddr+block_start, 0, bh->b_size);
                        kunmap_atomic(kaddr, KM_USER0);
                        set_buffer_uptodate(bh);
                        mark_buffer_dirty(bh);
                }

So how do we fix this?

A) The simplest way I can see to fix this is to make the current
recovery code work by _not_ clearing buffer_new after calling
get_block() in __block_prepare_write().  The patch is simple and is
below.

We should be safe to leave the buffer_new set in the non-error case.  No
code should care other than __block_prepare_write() and this clears
buffer_new before it calls get_block() so that is fine.  I had a quick
look at buffer_new() users and I think it is safe to just leave it
set...  Anyone know otherwise?

B) If we cannot safely allow buffer_new buffers to "leak out" of
__block_prepare_write(), then we simply would need to run a quick loop
over the buffers clearing buffer_new on each of them if it is set just
before returning "success" to the caller of __block_prepare_write().
The patch for this is simple, too (sent in separate email).

Andrew/Linus, I would suggest that you apply at least A and perhaps B if
you deem it necessary or want to be on the safe side.

Having had a look at the code it would seem perfectly safe to leave
buffer_new() set and ignore patch B but I may be wrong which is why I
did both.

Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

ps. I am sending this from evolution so please let me know if it mangles
the whitespace.  (It shouldn't as I told it to use "Preformat" style but
you never know.)

Best regards,

        Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

--- linux-2.6.git/fs/buffer.c.old	2005-06-10 13:33:07.000000000 +0100
+++ linux-2.6.git/fs/buffer.c	2005-06-10 13:34:11.000000000 +0100
@@ -1951,7 +1951,6 @@ static int __block_prepare_write(struct 
 			if (err)
 				break;
 			if (buffer_new(bh)) {
-				clear_buffer_new(bh);
 				unmap_underlying_metadata(bh->b_bdev,
 							bh->b_blocknr);
 				if (PageUptodate(page)) {


