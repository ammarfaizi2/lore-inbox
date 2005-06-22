Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261195AbVFVMts@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261195AbVFVMts (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 08:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261203AbVFVMtr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 08:49:47 -0400
Received: from tama5.ecl.ntt.co.jp ([129.60.39.102]:13247 "EHLO
	tama5.ecl.ntt.co.jp") by vger.kernel.org with ESMTP id S261171AbVFVMtm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 08:49:42 -0400
Message-Id: <6.0.0.20.2.20050622211238.03e6ba30@mailsv2.y.ecl.ntt.co.jp>
X-Mailer: QUALCOMM Windows Eudora Version 6J-Jr3
Date: Wed, 22 Jun 2005 21:49:29 +0900
To: akpm@osdl.org, sct@redhat.com, adilger@clusterfs.com
From: Hifumi Hisashi <hifumi.hisashi@lab.ntt.co.jp>
Subject: [PATCH] Fix the error handling in direct I/O 
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello.

	I fixed a bug on error handling in the direct I/O function.
Currenlty, if a file is opened with the O_DIRECT|O_SYNC flag,
  write() syscall cannot receive the EIO error just after
I/O error(SCSI cable is disconnected etc.) occur.

	Return values of other points that call generic_osync_inode()
are treated appropriately.

	With the following patch, this problem was fixed.
	Please apply this patch.

	Thanks,


Signed-off-by: Hisashi Hifumi  <hifumi.hisashi@lab.ntt.co.jp>

diff -Nru linux-2.6.12/mm/filemap.c linux-2.6.12_fix/mm/filemap.c
--- linux-2.6.12/mm/filemap.c	2005-06-22 17:21:21.000000000 +0900
+++ linux-2.6.12_fix/mm/filemap.c	2005-06-22 20:26:34.000000000 +0900
@@ -1927,8 +1927,12 @@
  	 * i_sem is held, which protects generic_osync_inode() from
  	 * livelocking.
  	 */
-	if (written >= 0 && file->f_flags & O_SYNC)
-		generic_osync_inode(inode, mapping, OSYNC_METADATA);
+	if (written >= 0 && ((file->f_flags & O_SYNC) || IS_SYNC(inode))) {
+		int err;
+		err = generic_osync_inode(inode, mapping, OSYNC_METADATA);
+		if (err < 0)
+			written = err;
+	}
  	if (written == count && !is_sync_kiocb(iocb))
  		written = -EIOCBQUEUED;
  	return written; 

