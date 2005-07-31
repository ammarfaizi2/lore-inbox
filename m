Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263212AbVGaLRB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263212AbVGaLRB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 07:17:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263211AbVGaLM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 07:12:27 -0400
Received: from coderock.org ([193.77.147.115]:39876 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261671AbVGaLKp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 07:10:45 -0400
Message-Id: <20050731111047.915285000@homer>
Date: Sun, 31 Jul 2005 13:10:48 +0200
From: domen@coderock.org
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org,
       Marcelo Feitoza Parisi <marcelo@feitoza.com.br>, domen@coderock.org
Subject: [patch 1/1] drivers/block/floppy.c : Use of the time_after() and time_before() macros
Content-Disposition: inline; filename=time_after-drivers_block_floppy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcelo Feitoza Parisi <marcelo@feitoza.com.br>



Use of the time_after() and time_before()  macros, defined at linux/jiffies.h,
which deal with wrapping correctly and are nicer to read.

Signed-off-by: Marcelo Feitoza Parisi <marcelo@feitoza.com.br>
Signed-off-by: Domen Puncer <domen@coderock.org>

---
 floppy.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

Index: quilt/drivers/block/floppy.c
===================================================================
--- quilt.orig/drivers/block/floppy.c
+++ quilt/drivers/block/floppy.c
@@ -179,6 +179,7 @@ static int print_unex = 1;
 #include <linux/devfs_fs_kernel.h>
 #include <linux/device.h>
 #include <linux/buffer_head.h>	/* for invalidate_buffers() */
+#include <linux/jiffies.h>	/* for time_before() */
 
 /*
  * PS/2 floppies have much slower step rates than regular floppies.
@@ -733,7 +734,7 @@ static int disk_change(int drive)
 {
 	int fdc = FDC(drive);
 #ifdef FLOPPY_SANITY_CHECK
-	if (jiffies - UDRS->select_date < UDP->select_delay)
+	if (time_before(jiffies, UDRS->select_date + UDP->select_delay))
 		DPRINT("WARNING disk change called early\n");
 	if (!(FDCS->dor & (0x10 << UNIT(drive))) ||
 	    (FDCS->dor & 3) != UNIT(drive) || fdc != FDC(drive)) {
@@ -1061,7 +1062,7 @@ static int fd_wait_for_completion(unsign
 		return 1;
 	}
 
-	if ((signed)(jiffies - delay) < 0) {
+	if (time_before(jiffies, delay)) {
 		del_timer(&fd_timer);
 		fd_timer.function = function;
 		fd_timer.expires = delay;
@@ -1521,7 +1522,7 @@ static void setup_rw_floppy(void)
 		 * again just before spinup completion. Beware that
 		 * after scandrives, we must again wait for selection.
 		 */
-		if ((signed)(ready_date - jiffies) > DP->select_delay) {
+		if (time_after(ready_date, jiffies + DP->select_delay)) {
 			ready_date -= DP->select_delay;
 			function = (timeout_fn) floppy_start;
 		} else

--
