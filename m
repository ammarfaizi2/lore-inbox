Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1425431AbWLHLy2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425431AbWLHLy2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 06:54:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425437AbWLHLy1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 06:54:27 -0500
Received: from smtp.osdl.org ([65.172.181.25]:52476 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1425431AbWLHLyZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 06:54:25 -0500
Message-Id: <200612081152.kB8BqTf4019768@shell0.pdx.osdl.net>
Subject: [patch 07/13] io-accounting-read-accounting cifs fix
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, balbir@in.ibm.com, csturtiv@sgi.com, daw@sgi.com,
       guillaume.thouvenin@bull.net, jlan@sgi.com, nagar@watson.ibm.com,
       sfrench@us.ibm.com, tee@sgi.com
From: akpm@osdl.org
Date: Fri, 08 Dec 2006 03:52:29 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>

CIFS implements ->readpages and doesn't use read_cache_pages().  So wire the
read IO accounting up within CIFS.

Cc: Jay Lan <jlan@sgi.com>
Cc: Shailabh Nagar <nagar@watson.ibm.com>
Cc: Balbir Singh <balbir@in.ibm.com>
Cc: Chris Sturtivant <csturtiv@sgi.com>
Cc: Tony Ernst <tee@sgi.com>
Cc: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
Cc: Steven French <sfrench@us.ibm.com>
Cc: David Wright <daw@sgi.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 fs/cifs/file.c |    2 ++
 1 file changed, 2 insertions(+)

diff -puN fs/cifs/file.c~io-accounting-read-accounting-cifs-fix fs/cifs/file.c
--- a/fs/cifs/file.c~io-accounting-read-accounting-cifs-fix
+++ a/fs/cifs/file.c
@@ -29,6 +29,7 @@
 #include <linux/pagevec.h>
 #include <linux/smp_lock.h>
 #include <linux/writeback.h>
+#include <linux/task_io_accounting_ops.h>
 #include <linux/delay.h>
 #include <asm/div64.h>
 #include "cifsfs.h"
@@ -1813,6 +1814,7 @@ static int cifs_readpages(struct file *f
 			cFYI(1, ("Read error in readpages: %d", rc));
 			break;
 		} else if (bytes_read > 0) {
+			task_io_account_read(bytes_read);
 			pSMBr = (struct smb_com_read_rsp *)smb_read_data;
 			cifs_copy_cache_pages(mapping, page_list, bytes_read,
 				smb_read_data + 4 /* RFC1001 hdr */ +
_
