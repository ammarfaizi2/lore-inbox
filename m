Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263820AbTH1Fsr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 01:48:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263734AbTH1FrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 01:47:10 -0400
Received: from fw.osdl.org ([65.172.181.6]:2233 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263796AbTH1Fn3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 01:43:29 -0400
Date: Wed, 27 Aug 2003 22:41:35 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm@osdl.org
Subject: [PATCH] floppy driver cleanup
Message-Id: <20030827224135.75f344dd.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I'm looking into some oopsen that happen in bad_flp_intr() [1]
but noticed that the floppy driver needs some cleaning.

Please apply.

[1]
http://marc.theaimsgroup.com/?l=linux-kernel&m=105837886921297&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=105988913707536&w=2
and my home machine (with some bad media)

--
~Randy


patch_name:	floppy_update.patch
patch_version:	2003-08-27.22:32:00
author:		Randy.Dunlap <rddunlap@osdl.org>
description:	use kernel.h min() and max();
		use C99 initializers;
		clean up some odd function calls [(void *)(void *)];
product:	Linux
product_versions: 260-826
maintainer:	_
diffstat:	=
 drivers/block/floppy.c |  112 ++++++++++++++++++++++---------------------------
 1 files changed, 51 insertions(+), 61 deletions(-)


diff -Naur ./drivers/block/floppy.c~badio ./drivers/block/floppy.c
--- ./drivers/block/floppy.c~badio	2003-08-26 19:34:05.000000000 -0700
+++ ./drivers/block/floppy.c	2003-08-27 22:30:52.000000000 -0700
@@ -695,23 +695,9 @@
 	spin_unlock_irqrestore(&floppy_lock, flags);
 }
 
-static int maximum(int a, int b)
-{
-	if (a > b)
-		return a;
-	else
-		return b;
-}
-#define INFBOUND(a,b) (a)=maximum((a),(b));
+#define INFBOUND(a,b) (a)=max_t(int, a, b)
 
-static int minimum(int a, int b)
-{
-	if (a < b)
-		return a;
-	else
-		return b;
-}
-#define SUPBOUND(a,b) (a)=minimum((a),(b));
+#define SUPBOUND(a,b) (a)=min_t(int, a, b)
 
 
 /*
@@ -1021,7 +1007,7 @@
 
 static DECLARE_WORK(floppy_work, NULL, NULL);
 
-static void schedule_bh( void (*handler)(void*) )
+static void schedule_bh(void (*handler) (void *))
 {
 	PREPARE_WORK(&floppy_work, handler, NULL);
 	schedule_work(&floppy_work);
@@ -1035,7 +1021,7 @@
 
 	spin_lock_irqsave(&floppy_lock, flags);
 	do_floppy = NULL;
-	PREPARE_WORK(&floppy_work, (void*)(void*)empty, NULL);
+	PREPARE_WORK(&floppy_work, (void*)empty, NULL);
 	del_timer(&fd_timer);
 	spin_unlock_irqrestore(&floppy_lock, flags);
 }
@@ -1814,7 +1800,7 @@
 		} while ((ST0 & 0x83) != UNIT(current_drive) && inr == 2 && max_sensei);
 	}
 	if (handler) {
-		schedule_bh( (void *)(void *) handler);
+		schedule_bh((void *) handler);
 	} else
 		FDCS->reset = 1;
 	is_alive("normal interrupt end");
@@ -2058,26 +2044,26 @@
 	wake_up(&command_done);
 }
 
-static struct cont_t wakeup_cont={
-	empty,
-	do_wakeup,
-	empty,
-	(done_f)empty
+static struct cont_t wakeup_cont = {
+	.interrupt = empty,
+	.redo = do_wakeup,
+	.error = empty,
+	.done = (done_f) empty
 };
 
 
-static struct cont_t intr_cont={
-	empty,
-	process_fd_request,
-	empty,
-	(done_f) empty
+static struct cont_t intr_cont = {
+	.interrupt = empty,
+	.redo = process_fd_request,
+	.error = empty,
+	.done = (done_f) empty
 };
 
 static int wait_til_done(void (*handler)(void), int interruptible)
 {
 	int ret;
 
-	schedule_bh((void *)(void *)handler);
+	schedule_bh((void *) handler);
 
 	if (command_status < 2 && NO_SIGNAL) {
 		DECLARE_WAITQUEUE(wait, current);
@@ -2281,11 +2267,12 @@
 #endif
 }
 
-static struct cont_t format_cont={
-	format_interrupt,
-	redo_format,
-	bad_flp_intr,
-	generic_done };
+static struct cont_t format_cont = {
+	.interrupt = format_interrupt,
+	.redo = redo_format,
+	.error = bad_flp_intr,
+	.done = generic_done
+};
 
 static int do_format(int drive, struct format_descr *tmp_format_req)
 {
@@ -2523,12 +2510,12 @@
 	int size, i;
 
 	max_sector = transfer_size(ssize,
-				   minimum(max_sector, max_sector_2),
+				   min(max_sector, max_sector_2),
 				   current_req->nr_sectors);
 
 	if (current_count_sectors <= 0 && CT(COMMAND) == FD_WRITE &&
 	    buffer_max > fsector_t + current_req->nr_sectors)
-		current_count_sectors = minimum(buffer_max - fsector_t,
+		current_count_sectors = min_t(int, buffer_max - fsector_t,
 						current_req->nr_sectors);
 
 	remaining = current_count_sectors << 9;
@@ -2546,7 +2533,7 @@
 	}
 #endif
 
-	buffer_max = maximum(max_sector, buffer_max);
+	buffer_max = max(max_sector, buffer_max);
 
 	dma_buffer = floppy_track_buffer + ((fsector_t - buffer_min) << 9);
 
@@ -2697,7 +2684,7 @@
 	if ((_floppy->rate & FD_2M) && (!TRACK) && (!HEAD)){
 		max_sector = 2 * _floppy->sect / 3;
 		if (fsector_t >= max_sector){
-			current_count_sectors = minimum(_floppy->sect - fsector_t,
+			current_count_sectors = min_t(int, _floppy->sect - fsector_t,
 							current_req->nr_sectors);
 			return 1;
 		}
@@ -2987,7 +2974,7 @@
 
 		if (TESTF(FD_NEED_TWADDLE))
 			twaddle();
-		schedule_bh( (void *)(void *) floppy_start);
+		schedule_bh((void *) floppy_start);
 #ifdef DEBUGT
 		debugt("queue fd request");
 #endif
@@ -2996,16 +2983,17 @@
 #undef REPEAT
 }
 
-static struct cont_t rw_cont={
-	rw_interrupt,
-	redo_fd_request,
-	bad_flp_intr,
-	request_done };
+static struct cont_t rw_cont = {
+	.interrupt = rw_interrupt,
+	.redo = redo_fd_request,
+	.error = bad_flp_intr,
+	.done = request_done
+};
 
 static void process_fd_request(void)
 {
 	cont = &rw_cont;
-	schedule_bh( (void *)(void *) redo_fd_request);
+	schedule_bh((void *) redo_fd_request);
 }
 
 static void do_fd_request(request_queue_t * q)
@@ -3031,11 +3019,12 @@
 	is_alive("do fd request");
 }
 
-static struct cont_t poll_cont={
-	success_and_wakeup,
-	floppy_ready,
-	generic_failure,
-	generic_done };
+static struct cont_t poll_cont = {
+	.interrupt = success_and_wakeup,
+	.redo = floppy_ready,
+	.error = generic_failure,
+	.done = generic_done
+};
 
 static int poll_drive(int interruptible, int flag)
 {
@@ -3066,11 +3055,12 @@
 	printk("weird, reset interrupt called\n");
 }
 
-static struct cont_t reset_cont={
-	reset_intr,
-	success_and_wakeup,
-	generic_failure,
-	generic_done };
+static struct cont_t reset_cont = {
+	.interrupt = reset_intr,
+	. redo = success_and_wakeup,
+	. error = generic_failure,
+	. done = generic_done
+};
 
 static int user_reset_fdc(int drive, int arg, int interruptible)
 {
@@ -3174,11 +3164,11 @@
 }
 
 
-static struct cont_t raw_cmd_cont={
-	success_and_wakeup,
-	floppy_start,
-	generic_failure,
-	raw_cmd_done
+static struct cont_t raw_cmd_cont = {
+	.interrupt = success_and_wakeup,
+	.redo = floppy_start,
+	.error = generic_failure,
+	.done = raw_cmd_done
 };
 
 static inline int raw_cmd_copyout(int cmd, char *param,
