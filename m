Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262562AbUBYJjW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 04:39:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262579AbUBYJjW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 04:39:22 -0500
Received: from fw.osdl.org ([65.172.181.6]:48021 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262562AbUBYJjU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 04:39:20 -0500
Date: Wed, 25 Feb 2004 01:39:38 -0800
From: Andrew Morton <akpm@osdl.org>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.3-mm3 sometimes freeze on "sync"
Message-Id: <20040225013938.53179d6c.akpm@osdl.org>
In-Reply-To: <403C7D4D.1040104@aitel.hist.no>
References: <20040222172200.1d6bdfae.akpm@osdl.org>
	<403C7D4D.1040104@aitel.hist.no>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting <helgehaf@aitel.hist.no> wrote:
>
> 2.6.3-mm3 (and 2.6.3-mm1) occationally freeze on "sync".

yup. bug.  This should fix.



 mm/page-writeback.c |   28 ++++++++++++----------------
 1 files changed, 12 insertions(+), 16 deletions(-)

diff -puN mm/page-writeback.c~O_DIRECT-vs-buffered-fix-pdflush-hang-fix mm/page-writeback.c
--- 25/mm/page-writeback.c~O_DIRECT-vs-buffered-fix-pdflush-hang-fix	2004-02-24 12:19:55.000000000 -0800
+++ 25-akpm/mm/page-writeback.c	2004-02-24 12:19:55.000000000 -0800
@@ -483,30 +483,26 @@ void __init page_writeback_init(void)
 int do_writepages(struct address_space *mapping, struct writeback_control *wbc)
 {
 	int ret;
-	if (wbc->sync_mode == WB_SYNC_NONE) {
-		if (!down_read_trylock(&mapping->wb_rwsema))
-			/*
-			 * SYNC writeback in progress
-			 */
-			return 0;
-	} else {
-		/*
-		 * Only allow 1 SYNC writeback at a time, to be able
-		 * to wait for all i/o without worrying about racing
-		 * WB_SYNC_NONE writers.
-		 */
+
+	/*
+	 * Only allow 1 SYNC writeback at a time, to be able to wait for all
+	 * I/O without worrying about racing WB_SYNC_NONE writers.
+	 */
+	if (wbc->sync_mode == WB_SYNC_NONE)
+		down_read(&mapping->wb_rwsema);
+	else
 		down_write(&mapping->wb_rwsema);
-	}
 
 	if (mapping->a_ops->writepages)
 		ret = mapping->a_ops->writepages(mapping, wbc);
 	else
 		ret = generic_writepages(mapping, wbc);
-	if (wbc->sync_mode == WB_SYNC_NONE) {
+
+	if (wbc->sync_mode == WB_SYNC_NONE)
 		up_read(&mapping->wb_rwsema);
-	} else {
+	else
 		up_write(&mapping->wb_rwsema);
-	}
+
 	return ret;
 }
 

_

