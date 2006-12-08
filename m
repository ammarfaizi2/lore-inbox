Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1425440AbWLHL7H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425440AbWLHL7H (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 06:59:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425434AbWLHL7H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 06:59:07 -0500
Received: from smtp.osdl.org ([65.172.181.25]:52785 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1425440AbWLHL7D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 06:59:03 -0500
Message-Id: <200612081152.kB8BqRcH019762@shell0.pdx.osdl.net>
Subject: [patch 05/13] io-accounting: read accounting
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, balbir@in.ibm.com, csturtiv@sgi.com, daw@sgi.com,
       guillaume.thouvenin@bull.net, jlan@sgi.com, nagar@watson.ibm.com,
       tee@sgi.com
From: akpm@osdl.org
Date: Fri, 08 Dec 2006 03:52:27 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>

Wire up read accounting for block devices, within submit_bio().

Cc: Jay Lan <jlan@sgi.com>
Cc: Shailabh Nagar <nagar@watson.ibm.com>
Cc: Balbir Singh <balbir@in.ibm.com>
Cc: Chris Sturtivant <csturtiv@sgi.com>
Cc: Tony Ernst <tee@sgi.com>
Cc: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
Cc: David Wright <daw@sgi.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 block/ll_rw_blk.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff -puN block/ll_rw_blk.c~io-accounting-read-accounting-2 block/ll_rw_blk.c
--- a/block/ll_rw_blk.c~io-accounting-read-accounting-2
+++ a/block/ll_rw_blk.c
@@ -25,6 +25,7 @@
 #include <linux/slab.h>
 #include <linux/swap.h>
 #include <linux/writeback.h>
+#include <linux/task_io_accounting_ops.h>
 #include <linux/interrupt.h>
 #include <linux/cpu.h>
 #include <linux/blktrace_api.h>
@@ -3235,10 +3236,12 @@ void submit_bio(int rw, struct bio *bio)
 	BIO_BUG_ON(!bio->bi_size);
 	BIO_BUG_ON(!bio->bi_io_vec);
 	bio->bi_rw |= rw;
-	if (rw & WRITE)
+	if (rw & WRITE) {
 		count_vm_events(PGPGOUT, count);
-	else
+	} else {
+		task_io_account_read(bio->bi_size);
 		count_vm_events(PGPGIN, count);
+	}
 
 	if (unlikely(block_dump)) {
 		char b[BDEVNAME_SIZE];
_
