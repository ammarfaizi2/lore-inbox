Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261320AbVCEW7O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261320AbVCEW7O (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 17:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261325AbVCEWzY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 17:55:24 -0500
Received: from coderock.org ([193.77.147.115]:58277 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261319AbVCEWng (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 17:43:36 -0500
Subject: [patch 10/15] 4/34: block/acsi_slm: replace interruptible_sleep_on() with wait_event_interruptible()
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, nacc@us.ibm.com
From: domen@coderock.org
Date: Sat, 05 Mar 2005 23:43:13 +0100
Message-Id: <20050305224313.BF17F1F205@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Use wait_event_interruptible() instead of the deprecated
interruptible_sleep_on(). The sleep_on() call later in the same function is
replaced with inline wait-queue code which achieves the same. This required
adding a local wait-queue, though.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/drivers/block/acsi_slm.c |   16 +++++++++-------
 1 files changed, 9 insertions(+), 7 deletions(-)

diff -puN drivers/block/acsi_slm.c~wait_event_int-drivers_block_acsi_slm drivers/block/acsi_slm.c
--- kj/drivers/block/acsi_slm.c~wait_event_int-drivers_block_acsi_slm	2005-03-05 16:11:54.000000000 +0100
+++ kj-domen/drivers/block/acsi_slm.c	2005-03-05 16:11:54.000000000 +0100
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
_
