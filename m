Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261612AbVADNgV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261612AbVADNgV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 08:36:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261626AbVADNgV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 08:36:21 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:24007 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S261612AbVADNgQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 08:36:16 -0500
Message-ID: <41DAAA93.F96EAED7@tv-sign.ru>
Date: Tue, 04 Jan 2005 17:39:15 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Suparna Bhattacharya <suparna@in.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] fix double sync_page_range() in generic_file_aio_write()
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

generic_file_aio_write():
	generic_file_aio_write_nolock():
		if (SYNC) sync_page_range_nolock();
	if (SYNC) sync_page_range();

I think that generic_file_aio_write() should use
__generic_file_aio_write_nolock() instead.

Oleg.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.10/mm/filemap.c~	2004-11-15 17:12:21.000000000 +0300
+++ 2.6.10/mm/filemap.c	2005-01-04 20:20:42.068803912 +0300
@@ -2149,7 +2149,7 @@ ssize_t generic_file_aio_write(struct ki
 	BUG_ON(iocb->ki_pos != pos);
 
 	down(&inode->i_sem);
-	ret = generic_file_aio_write_nolock(iocb, &local_iov, 1,
+	ret = __generic_file_aio_write_nolock(iocb, &local_iov, 1,
 						&iocb->ki_pos);
 	up(&inode->i_sem);
