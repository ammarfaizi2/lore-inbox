Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262809AbVDBBMK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262809AbVDBBMK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 20:12:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262947AbVDBBMK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 20:12:10 -0500
Received: from fire.osdl.org ([65.172.181.4]:5310 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262809AbVDBBLk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 20:11:40 -0500
Subject: [PATCH] Direct IO async short read bug followup
From: Daniel McNeil <daniel@osdl.org>
To: Badari Pulavarty <pbadari@us.ibm.com>, Andrew Morton <akpm@osdl.org>
Cc: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>,
       jean-pierre.dion@bull.net, gh@us.ibm.com, janetmor@us.ibm.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "linux-aio@kvack.org" <linux-aio@kvack.org>
In-Reply-To: <42442743.40600@us.ibm.com>
References: <1111743607.1299.85.camel@frecb000686>
	 <20050325014307.4395012e.akpm@osdl.org>
	 <1111745400.1299.89.camel@frecb000686>
	 <20050325022416.01c2535b.akpm@osdl.org>  <42442743.40600@us.ibm.com>
Content-Type: text/plain
Message-Id: <1112404259.29841.19.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 01 Apr 2005 17:11:00 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-03-25 at 06:59, Badari Pulavarty wrote:

> Andrew,
> 
> When I debugged the problem, the issue seems to be only for the last 
> block of the file. Filesize is not multiple of 4K blocks. (say 17K).
> So, on the disk we have a 4K block for the last block. The test is
> trying to read 20K.  Since we have a block on the disk, get_block()
> won't complain and we do the IO. Once the IO is done, we can truncate
> the result to match the filesize.
> 
> I tried fixing the problem by limiting the IO submits to the size of
> the file - which became really ugly (since I have to adjust the
> iovec[]).
> 
> Daniel McNeil wanted to take a stab at it. Dan what happend to the fix ?
> 
> Thanks,
> Badari

I updated the patch to add an i_size element to the dio structure and
sample i_size during i/o submission.  When i/o completes the result can
be truncated to match the file size without using i_size_read(), thus
the aio result now matches the number of bytes read to the end of file.

Here's the patch.  It applies to 2.6.11 and the latest bk.

Daniel

--- linux-2.6.11.orig/fs/direct-io.c	2005-04-01 15:33:11.000000000 -0800
+++ linux-2.6.11/fs/direct-io.c	2005-03-31 16:59:15.000000000 -0800
@@ -66,6 +66,7 @@ struct dio {
 	struct bio *bio;		/* bio under assembly */
 	struct inode *inode;
 	int rw;
+	ssize_t i_size;			/* i_size when submitted */
 	int lock_type;			/* doesn't change */
 	unsigned blkbits;		/* doesn't change */
 	unsigned blkfactor;		/* When we're using an alignment which
@@ -230,17 +231,29 @@ static void finished_one_bio(struct dio 
 	spin_lock_irqsave(&dio->bio_lock, flags);
 	if (dio->bio_count == 1) {
 		if (dio->is_async) {
+			ssize_t transferred;
+			loff_t offset;
+
 			/*
 			 * Last reference to the dio is going away.
 			 * Drop spinlock and complete the DIO.
 			 */
 			spin_unlock_irqrestore(&dio->bio_lock, flags);
-			dio_complete(dio, dio->block_in_file << dio->blkbits,
-					dio->result);
+
+			/* Check for short read case */
+			transferred = dio->result;
+			offset = dio->iocb->ki_pos;
+
+			if ((dio->rw == READ) &&
+			    ((offset + transferred) > dio->i_size))
+				transferred = dio->i_size - offset;
+
+			dio_complete(dio, offset, transferred);
+
 			/* Complete AIO later if falling back to buffered i/o */
 			if (dio->result == dio->size ||
 				((dio->rw == READ) && dio->result)) {
-				aio_complete(dio->iocb, dio->result, 0);
+				aio_complete(dio->iocb, transferred, 0);
 				kfree(dio);
 				return;
 			} else {
@@ -951,6 +964,7 @@ direct_io_worker(int rw, struct kiocb *i
 	dio->page_errors = 0;
 	dio->result = 0;
 	dio->iocb = iocb;
+	dio->i_size = i_size_read(inode);
 
 	/*
 	 * BIO completion state.


