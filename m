Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261730AbVCGKBK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261730AbVCGKBK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 05:01:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261731AbVCGKBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 05:01:10 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:22490 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S261730AbVCGKA4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 05:00:56 -0500
Subject: [PATCH] 2.6.10 -  direct-io async short read bug
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: "linux-aio kvack.org" <linux-aio@kvack.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Mon, 07 Mar 2005 11:00:07 +0100
Message-Id: <1110189607.11938.14.camel@frecb000686>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 07/03/2005 11:09:59,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 07/03/2005 11:10:02,
	Serialize complete at 07/03/2005 11:10:02
Content-Type: multipart/mixed; boundary="=-N+OjdcmHST/FDLTYjq75"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-N+OjdcmHST/FDLTYjq75
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=ISO-8859-15

 Hi,

 When reading a file in async mode (using kernel AIO), and the file
size is lower than the requested size (short read),  the direct IO
layer reports an incorrect number of bytes read (transferred).

 That case is handled for the sync path in 'direct_io_worker'=20
(fs/direct-io.c) where a check is made against the file size.

 This patch does the same thing for the async path. It applies to
a vanilla 2.6.10 kernel.

 Please CC: me any comments and/or suggestions.

 S=E9bastien.

------------------------------------------------------

  S=E9bastien Dugu=E9                BULL/FREC:B1-247
  phone: (+33) 476 29 77 70      Bullcom: 229-7770

  mailto:sebastien.dugue@bull.net

  Linux POSIX AIO: http://www.bullopensource.org/posix
 =20
------------------------------------------------------

--=-N+OjdcmHST/FDLTYjq75
Content-Transfer-Encoding: 7bit
Content-Description: 
Content-Disposition: attachment; filename=directio_async_bug.patch
Content-Type: text/x-patch; charset=ISO-8859-15

--- linux-2.6.10/fs/direct-io.c.orig	2005-03-03 12:41:05.541074051 +0100
+++ linux-2.6.10/fs/direct-io.c	2005-03-03 12:01:46.206210808 +0100
@@ -230,17 +230,30 @@ static void finished_one_bio(struct dio 
 	spin_lock_irqsave(&dio->bio_lock, flags);
 	if (dio->bio_count == 1) {
 		if (dio->is_async) {
+			ssize_t transferred;
+			ssize_t i_size;
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
+			i_size = i_size_read (dio->inode);
+			offset = dio->iocb->ki_pos;
+
+			if ((dio->rw == READ) && ((offset + transferred) > i_size))
+				transferred = i_size - offset;
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

--=-N+OjdcmHST/FDLTYjq75--

