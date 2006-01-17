Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932411AbWAQTl7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932411AbWAQTl7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 14:41:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbWAQTl7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 14:41:59 -0500
Received: from fmr21.intel.com ([143.183.121.13]:36756 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S932411AbWAQTl6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 14:41:58 -0500
Message-Id: <200601171941.k0HJfwg14084@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: <linux-kernel@vger.kernel.org>
Subject: [patch] bug fix in dio handling write error
Date: Tue, 17 Jan 2006 11:41:58 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcYbnhP84hS2P8VRSFGw/m5+LpvQsQ==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is a bug in direct-io on propagating write error up to the
higher I/O layer.  When performing an async ODIRECT write to a
block device, if a device error occurred (like media error or disk
is pulled), the error code is only propagated from device driver
to the DIO layer.  The error code stops at finished_one_bio(). The
aysnc write, however, is supposedly have a corresponding AIO event
with appropriate return code (in this case -EIO).  Application
which waits on the async write event, will hang forever since such
AIO event is lost forever (if such app did not use the timeout
option in io_getevents call. Regardless, an AIO event is lost).

The problem is that calls to aio_complete() is conditioned upon
READ, but it should've handle WRITE error as well.


Signed-off-by: Ken Chen <kenneth.w.chen@intel.com>


--- linux-2.6.15/fs/direct-io.c.orig	2006-01-17 11:54:17.010422462 -0800
+++ linux-2.6.15/fs/direct-io.c	2006-01-17 12:08:00.444982688 -0800
@@ -253,8 +253,7 @@ static void finished_one_bio(struct dio 
 			dio_complete(dio, offset, transferred);
 
 			/* Complete AIO later if falling back to buffered i/o */
-			if (dio->result == dio->size ||
-				((dio->rw == READ) && dio->result)) {
+			if (dio->result == dio->size || dio->result) {
 				aio_complete(dio->iocb, transferred, 0);
 				kfree(dio);
 				return;



