Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932771AbVINVZq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932771AbVINVZq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 17:25:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932772AbVINVZp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 17:25:45 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:642 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932771AbVINVZp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 17:25:45 -0400
Message-ID: <43289554.7010606@sgi.com>
Date: Wed, 14 Sep 2005 16:25:40 -0500
From: Eric Sandeen <sandeen@sgi.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.13] clear_buffer_uptodate() in discard_buffer()
Content-Type: multipart/mixed;
 boundary="------------050003070507010708040401"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050003070507010708040401
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I was tracking down a problem in XFS, with this testcase:

(where blocksize = 1/4 page size)

seek out 4 blocks
write 2 blocks (EOF now at 6 blocks)
truncate back to 4 blocks + a few bytes
truncate out to 6 blocks

This should wind up with:

4 blocks of hole | 1 block of data | 1 block of hole

but instead gave:

4 blocks of hole | 2 blocks of data

The last extending truncate, which should lead to a hole of 1 filesystem block 
at the end of the file, wound up getting allocated as an extent.  I tracked 
this down to the first truncate back, where we called discard_buffer() on the 
buffer head covering the last block in the file.  discard_buffer() clears 
several bh state flags, and nulls b_bdev, but it does NOT clear the uptodate flag.

XFS later comes along and allocates blocks for the file (due to a periodic 
sync, in the simplest case), and finds that the buffer_head over the last block 
before EOF is Uptodate, and allocates a block where there should be a hole.

I submit this patch with some hesitation, because a few years ago, akpm 
committed this changeset:

http://linux.bkbits.net:8080/linux-2.6/cset@1.373.70.7?nav=index.html|src/|src/fs|related/fs/buffer.c

which specifically -removed- the clearing of BH_Uptodate in discard_buffer().

Andrew had some concerns about clearing the bh uptodate flag without possibly 
changing the page state, but didn't otherwise remember the details. :)

However, when we truncate down & call discard_buffer, this buffer head is now 
out past EOF, and any other buffers also past EOF on this page have no state at 
all; they also are in their initialized state from alloc_page_buffers with 0 
b_state, and NULL b_bdev, etc.  So by clearing Uptodate on this truncated 
buffer, it simply joins it's friends at the end of the page.

Thanks,

-Eric

--------------050003070507010708040401
Content-Type: text/x-patch;
 name="bh_uptodate.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bh_uptodate.patch"

Signed-off-by: Eric Sandeen <sandeen.sgi.com>

--- a/fs/buffer.c	2005-09-14 15:54:19.000000000 -0500
+++ b/fs/buffer.c	2005-09-14 15:53:52.000000000 -0500
@@ -1549,6 +1549,7 @@
 	lock_buffer(bh);
 	clear_buffer_dirty(bh);
 	bh->b_bdev = NULL;
+	clear_buffer_uptodate(bh);
 	clear_buffer_mapped(bh);
 	clear_buffer_req(bh);
 	clear_buffer_new(bh);

--------------050003070507010708040401--
