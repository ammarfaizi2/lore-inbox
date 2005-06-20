Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261406AbVFUGXi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261406AbVFUGXi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 02:23:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261733AbVFUGW1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 02:22:27 -0400
Received: from coderock.org ([193.77.147.115]:12441 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261734AbVFTVzF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 17:55:05 -0400
Message-Id: <20050620215137.011629000@nd47.coderock.org>
Date: Mon, 20 Jun 2005 23:51:38 +0200
From: domen@coderock.org
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org, Nishanth Aravamudan <nacc@us.ibm.com>,
       domen@coderock.org
Subject: [patch 08/12] block/acsi_slm: replace interruptible_sleep_on() with wait_event_interruptible()
Content-Disposition: inline; filename=wait_event_int-drivers_block_acsi_slm.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nishanth Aravamudan <nacc@us.ibm.com>



Use wait_event_interruptible() instead of the deprecated
interruptible_sleep_on(). The sleep_on() call later in the same function is
replaced with inline wait-queue code which achieves the same. This required
adding a local wait-queue, though.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
---
 acsi_slm.c |   16 +++++++++-------
 1 files changed, 9 insertions(+), 7 deletions(-)

Index: quilt/drivers/block/acsi_slm.c
===================================================================
--- quilt.orig/drivers/block/acsi_slm.c
+++ quilt/drivers/block/acsi_slm.c
@@ -67,6 +67,7 @@ not be guaranteed. There are several way
 #include <linux/slab.h>
 #include <linux/devfs_fs_kernel.h>
 #include <linux/smp_lock.h>
+#include <linux/wait.h>
 
 #include <asm/pgtable.h>
 #include <asm/system.h>
@@ -625,12 +626,10 @@ static ssize_t slm_write( struct file *f
 	int		device = iminor(node);
 	int		n, filled, w, h;
 
-	while( SLMState == PRINTING ||
-		   (SLMState == FILLING && SLMBufOwner != device) ) {
-		interruptible_sleep_on( &slm_wait );
-		if (signal_pending(current))
-			return( -ERESTARTSYS );
-	}
+	wait_event_interruptible(slm_wait, (SLMState != PRINTING &&
+				(SLMState != FILLING || SLMBufOwner == device)));
+	if (signal_pending(current))
+		return -ERESTARTSYS;
 	if (SLMState == IDLE) {
 		/* first data of page: get current page size  */
 		if (slm_get_pagesize( device, &w, &h ))
@@ -654,6 +653,7 @@ static ssize_t slm_write( struct file *f
 	filled += n;
 
 	if (filled == BufferSize) {
+		DEFINE_WAIT(wait);
 		/* Check the paper size again! The user may have switched it in the
 		 * time between starting the data and finishing them. Would end up in
 		 * a trashy page... */
@@ -672,7 +672,9 @@ static ssize_t slm_write( struct file *f
 #endif
 		
 		start_print( device );
-		sleep_on( &print_wait );
+		prepare_to_wait(&print_wait, &wait, TASK_UNINTERRUPTIBLE);
+		schedule();
+		finish_wait(&print_wait, &wait);
 		if (SLMError && IS_REAL_ERROR(SLMError)) {
 			printk( KERN_ERR "slm%d: %s\n", device, slm_errstr(SLMError) );
 			n = -EIO;

--
