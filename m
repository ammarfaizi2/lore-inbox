Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265251AbTGABGM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 21:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265757AbTGABGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 21:06:12 -0400
Received: from air-2.osdl.org ([65.172.181.6]:29128 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265251AbTGABGJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 21:06:09 -0400
Subject: [PATCH 2.5.73-mm2] aio O_DIRECT no readahead
From: Daniel McNeil <daniel@osdl.org>
To: Andrew Morton <akpm@digeo.com>, Suparna Bhattacharya <suparna@in.ibm.com>,
       Benjamin LaHaise <bcrl@kvack.org>,
       "linux-aio@kvack.org" <linux-aio@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-IPr35xIgC/e818QE/2M/"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 30 Jun 2003 18:19:51 -0700
Message-Id: <1057022391.22702.18.camel@dell_ss5.pdx.osdl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-IPr35xIgC/e818QE/2M/
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

More testing on AIO with O_DIRECT and /dev/raw/.  Doing AIO reads was
using a lot more cpu time than using dd on the raw partition even with
the io_queue_wait patch.  Found out that aio is doing readahead even
for O_DIRECT.  Here's a patch that fixes it.  Here are some output
from time on reading a 90mb partition on a raw device with 32k i/o:

CMD             Kernel                  I/O     real    user    sys
RUN             version                 size
===             ======                  ===     ====    ====    ===
dd              2.5.73-mm2:             32k     2.514s  0.000s  0.200s
aio (1 iocb)    2.5.73-mm2:             32k     3.408s  1.120s  2.250s
aio (32 iocb)   2.5.73-mm2:             32k     2.994s  0.830s  2.160s
aio (1 iocb)    2.5.73-mm2+patch.aiodio 32k     2.509s  0.850s  1.660s
aio (1 iocb)    2.5.73-mm2+patch.aiodio
                   +patch.io_queue_wait 32k     2.566s  0.010s  0.240s
aio (32 iocb)   2.5.73-mm2+patch.aiodio
                   +patch.io_queue_wait 32k     2.465s  0.010s  0.080s

With this patch and my previous io_queue_wait patch the cpu time
drops down to very little when doing AIO with O_DIRECT.

Daniel McNeil <daniel@osdl.org>

--=-IPr35xIgC/e818QE/2M/
Content-Disposition: attachment; filename=patch-2.5.73-mm2.aiodio
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=patch-2.5.73-mm2.aiodio; charset=ISO-8859-1

--- linux-2.5.73-mm2/fs/aio.c	2003-06-30 16:39:15.874216228 -0700
+++ linux-2.5.73-mm2.aiodio/fs/aio.c	2003-06-30 15:38:46.000000000 -0700
@@ -1380,15 +1380,20 @@ ssize_t aio_setup_iocb(struct kiocb *kio
 			break;
 		ret =3D -EINVAL;
 		if (file->f_op->aio_read) {
-			struct address_space *mapping =3D
-				file->f_dentry->d_inode->i_mapping;
-			unsigned long index =3D kiocb->ki_pos >> PAGE_CACHE_SHIFT;
-			unsigned long end =3D (kiocb->ki_pos + kiocb->ki_left)
-				>> PAGE_CACHE_SHIFT;
-
-			for (; index < end; index++) {
-				page_cache_readahead(mapping, &file->f_ra,
-							file, index);
+			/*
+			 * Do not do readahead for DIRECT i/o
+			 */
+			if (!(file->f_flags & O_DIRECT)) {
+				struct address_space *mapping =3D
+					file->f_dentry->d_inode->i_mapping;
+				unsigned long index =3D kiocb->ki_pos >> PAGE_CACHE_SHIFT;
+				unsigned long end =3D (kiocb->ki_pos + kiocb->ki_left)
+					>> PAGE_CACHE_SHIFT;
+
+				for (; index < end; index++) {
+					page_cache_readahead(mapping, &file->f_ra,
+								file, index);
+				}
 			}
 			kiocb->ki_retry =3D aio_pread;
 		}

--=-IPr35xIgC/e818QE/2M/--

