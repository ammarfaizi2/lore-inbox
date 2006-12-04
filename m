Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937099AbWLDQfK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937099AbWLDQfK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 11:35:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937107AbWLDQfK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 11:35:10 -0500
Received: from mga02.intel.com ([134.134.136.20]:6641 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937099AbWLDQfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 11:35:08 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,494,1157353200"; 
   d="scan'208"; a="169962201:sNHT93237754183"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "Andrew Morton" <akpm@osdl.org>, "'Zach Brown'" <zach.brown@oracle.com>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: [patch] kill pointless ki_nbytes assignment in aio_setup_single_vector
Date: Mon, 4 Dec 2006 08:34:25 -0800
Message-ID: <000101c717c2$0fe26ce0$2589030a@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AccXwg9dufCrETuuSnyDr9e0TIxV4w==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

io_submit_one assigns ki_left = ki_nbytes = iocb->aio_nbytes, then
calls down to aio_setup_iocb, then to aio_setup_single_vector. In there,
ki_nbytes is reassigned to the same value it got two call stack above it.
There is no need to do so.

Signed-off-by: Ken Chen <kenneth.w.chen@intel.com>


diff -Nurp linux-2.6.19/fs/aio.c linux-2.6.19.ken/fs/aio.c
--- linux-2.6.19/fs/aio.c	2006-12-03 17:16:52.000000000 -0800
+++ linux-2.6.19.ken/fs/aio.c	2006-12-03 17:19:06.000000000 -0800
@@ -1415,7 +1415,6 @@ static ssize_t aio_setup_single_vector(s
 	kiocb->ki_iovec->iov_len = kiocb->ki_left;
 	kiocb->ki_nr_segs = 1;
 	kiocb->ki_cur_seg = 0;
-	kiocb->ki_nbytes = kiocb->ki_left;
 	if (unlikely((ssize_t) kiocb->ki_nbytes < 0))
 		return -EINVAL;
 	return 0;

