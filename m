Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280620AbRKFWNs>; Tue, 6 Nov 2001 17:13:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280624AbRKFWNk>; Tue, 6 Nov 2001 17:13:40 -0500
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:46096 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S280620AbRKFWNb>; Tue, 6 Nov 2001 17:13:31 -0500
Date: Tue, 6 Nov 2001 23:12:55 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: <andre@linux-ide.org>
cc: <linux-kernel@vger.kernel.org>
Subject: drivers/ide/*.c jiffies cleanup
Message-ID: <Pine.LNX.4.30.0111062121580.23828-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andre,

while most of the ide code seems to be carefully designed to handle
jiffies wrap correctly, for ease of audit as well as future
maintainability I have changed all comparisons to use the
time_{before,after} macros. Also, a few places actually seem to get
the wrap wrong.

I did not yet CC Linus and Alan on this patch as I did on the others,
since it is a little bit larger, and some of the jiffies uses are
a bit tricky.

Btw.: I cannot figure out what read_timer in ide.c is supposed to do,
but it's use of jiffies is probably broken if it is intended to be
anything else than a random number generator.

Tim


--- /usr/src/linux-2.4.14-pre6/drivers/ide/ide-cd.c	Wed Oct 31 23:06:19 2001
+++ drivers/ide/ide-cd.c	Tue Nov  6 21:10:57 2001
@@ -1147,7 +1147,7 @@
 		return startstop;
 	CDROM_CONFIG_FLAGS(drive)->seeking = 1;

-	if (retry && jiffies - info->start_seek > IDECD_SEEK_TIMER) {
+	if (retry && time_after(jiffies, info->start_seek + IDECD_SEEK_TIMER)) {
 		if (--retry == 0) {
 			/*
 			 * this condition is far too common, to bother
@@ -1700,11 +1700,10 @@
 		case WRITE:
 		case READ: {
 			if (CDROM_CONFIG_FLAGS(drive)->seeking) {
-				unsigned long elpased = jiffies - info->start_seek;
 				int stat = GET_STAT();

 				if ((stat & SEEK_STAT) != SEEK_STAT) {
-					if (elpased < IDECD_SEEK_TIMEOUT) {
+					if (time_before(jiffies, info->start_seek + IDECD_SEEK_TIMEOUT) {
 						ide_stall_queue(drive, IDECD_SEEK_TIMER);
 						return ide_stopped;
 					}
--- /usr/src/linux-2.4.14-pre6/drivers/ide/ide-features.c	Fri Feb  9 20:40:02 2001
+++ drivers/ide/ide-features.c	Tue Nov  6 21:13:29 2001
@@ -173,7 +173,7 @@
 	OUT_BYTE(WIN_IDENTIFY, IDE_COMMAND_REG);
 	timeout = jiffies + WAIT_WORSTCASE;
 	do {
-		if (0 < (signed long)(jiffies - timeout)) {
+		if (time_after(jiffies, timeout)) {
 			SELECT_MASK(HWIF(drive), drive, 0);
 			return 0;	/* drive timed-out */
 		}
@@ -321,7 +321,7 @@
 		ide__sti();		/* local CPU only -- for jiffies */
 		timeout = jiffies + WAIT_CMD;
 		while ((stat = GET_STAT()) & BUSY_STAT) {
-			if (0 < (signed long)(jiffies - timeout))
+			if (time_after(jiffies, timeout))
 				break;
 		}
 		__restore_flags(flags); /* local CPU only */
--- /usr/src/linux-2.4.14-pre6/drivers/ide/ide-probe.c	Thu Oct 11 18:14:32 2001
+++ drivers/ide/ide-probe.c	Tue Nov  6 21:15:57 2001
@@ -226,7 +226,7 @@
 	timeout = ((cmd == WIN_IDENTIFY) ? WAIT_WORSTCASE : WAIT_PIDENTIFY) / 2;
 	timeout += jiffies;
 	do {
-		if (0 < (signed long)(jiffies - timeout)) {
+		if (time_after(jiffies, timeout)) {
 			return 1;	/* drive timed-out */
 		}
 		ide_delay_50ms();		/* give drive a breather */
@@ -370,7 +370,7 @@
 	OUT_BYTE(EXABYTE_ENABLE_NEST, IDE_COMMAND_REG);
 	timeout = jiffies + WAIT_WORSTCASE;
 	do {
-		if (jiffies > timeout) {
+		if (time_after(jiffies, timeout)) {
 			printk("failed (timeout)\n");
 			return;
 		}
@@ -548,7 +548,7 @@
 		do {
 			ide_delay_50ms();
 			stat = IN_BYTE(hwif->io_ports[IDE_STATUS_OFFSET]);
-		} while ((stat & BUSY_STAT) && 0 < (signed long)(timeout - jiffies));
+		} while ((stat & BUSY_STAT) && time_after(timeout, jiffies));

 	}
 	__restore_flags(flags);	/* local CPU only */
--- /usr/src/linux-2.4.14-pre6/drivers/ide/ide-proc.c	Fri Sep  7 18:28:38 2001
+++ drivers/ide/ide-proc.c	Tue Nov  6 21:17:07 2001
@@ -192,7 +192,7 @@
 			cli();	/* all CPUs; ensure all writes are done together */
 			while (mygroup->busy || (mategroup && mategroup->busy)) {
 				sti();	/* all CPUs */
-				if (0 < (signed long)(jiffies - timeout)) {
+				if (time_after(jiffies, timeout)) {
 					printk("/proc/ide/%s/config: channel(s) busy, cannot write\n", hwif->name);
 					restore_flags(flags);	/* all CPUs */
 					return -EBUSY;
--- /usr/src/linux-2.4.14-pre6/drivers/ide/ide-tape.c	Mon Aug 13 23:56:19 2001
+++ drivers/ide/ide-tape.c	Tue Nov  6 21:38:02 2001
@@ -2418,26 +2418,26 @@
 	idetape_tape_t *tape = drive->driver_data;
 	int full = 125, empty = 75;

-	if (jiffies > tape->controlled_pipeline_head_time + 120 * HZ) {
+	if (time_after(jiffies, tape->controlled_pipeline_head_time + 120 * HZ)) {
 		tape->controlled_previous_pipeline_head = tape->controlled_last_pipeline_head;
 		tape->controlled_previous_head_time = tape->controlled_pipeline_head_time;
 		tape->controlled_last_pipeline_head = tape->pipeline_head;
 		tape->controlled_pipeline_head_time = jiffies;
 	}
-	if (jiffies > tape->controlled_pipeline_head_time + 60 * HZ)
+	if (time_after(jiffies, tape->controlled_pipeline_head_time + 60 * HZ))
 		tape->controlled_pipeline_head_speed = (tape->pipeline_head - tape->controlled_last_pipeline_head) * 32 * HZ / (jiffies - tape->controlled_pipeline_head_time);
-	else if (jiffies > tape->controlled_previous_head_time)
+	else if (time_after(jiffies, tape->controlled_previous_head_time))
 		tape->controlled_pipeline_head_speed = (tape->pipeline_head - tape->controlled_previous_pipeline_head) * 32 * HZ / (jiffies - tape->controlled_previous_head_time);

 	if (tape->nr_pending_stages < tape->max_stages /*- 1 */) { /* -1 for read mode error recovery */
-		if (jiffies > tape->uncontrolled_previous_head_time + 10 * HZ) {
+		if (time_after(jiffies, tape->uncontrolled_previous_head_time + 10 * HZ)) {
 			tape->uncontrolled_pipeline_head_time = jiffies;
 			tape->uncontrolled_pipeline_head_speed = (tape->pipeline_head - tape->uncontrolled_previous_pipeline_head) * 32 * HZ / (jiffies - tape->uncontrolled_previous_head_time);
 		}
 	} else {
 		tape->uncontrolled_previous_head_time = jiffies;
 		tape->uncontrolled_previous_pipeline_head = tape->pipeline_head;
-		if (jiffies > tape->uncontrolled_pipeline_head_time + 30 * HZ) {
+		if (time_after(jiffies, tape->uncontrolled_pipeline_head_time + 30 * HZ)) {
 			tape->uncontrolled_pipeline_head_time = jiffies;
 		}
 	}
@@ -2500,9 +2500,9 @@
 		tape->insert_time = jiffies;
 		tape->insert_size = 0;
 	}
-	if (jiffies > tape->insert_time)
+	if (time_after(jiffies, tape->insert_time))
 		tape->insert_speed = tape->insert_size / 1024 * HZ / (jiffies - tape->insert_time);
-	if (jiffies - tape->avg_time >= HZ) {
+	if (time_after_eq(jiffies, tape->avg_time + HZ)) {
 		tape->avg_speed = tape->avg_size * HZ / (jiffies - tape->avg_time) / 1024;
 		tape->avg_size = 0;
 		tape->avg_time = jiffies;
@@ -2680,11 +2680,11 @@
 		tape->reads_since_buffer_fill = 0;
 		tape->last_buffer_fill = jiffies;
 		idetape_queue_onstream_buffer_fill(drive);
-		if (jiffies > tape->insert_time)
+		if (time_after(jiffies, tape->insert_time))
 			tape->insert_speed = tape->insert_size / 1024 * HZ / (jiffies - tape->insert_time);
 		return ide_stopped;
 	}
-	if (jiffies > tape->insert_time)
+	if (time_after(jiffies, tape->insert_time))
 		tape->insert_speed = tape->insert_size / 1024 * HZ / (jiffies - tape->insert_time);
 	calculate_speeds(drive);
 	if (tape->onstream && tape->max_frames &&
@@ -2716,7 +2716,7 @@
 			tape->dsc_polling_start = jiffies;
 			tape->dsc_polling_frequency = tape->best_dsc_rw_frequency;
 			tape->dsc_timeout = jiffies + IDETAPE_DSC_RW_TIMEOUT;
-		} else if ((signed long) (jiffies - tape->dsc_timeout) > 0) {
+		} else if (time_after(jiffies, tape->dsc_timeout)) {
 			printk (KERN_ERR "ide-tape: %s: DSC timeout\n", tape->name);
 			if (rq->cmd == IDETAPE_PC_RQ2) {
 				idetape_media_access_finished (drive);
@@ -2724,7 +2724,7 @@
 			} else {
 				return ide_do_reset (drive);
 			}
-		} else if (jiffies - tape->dsc_polling_start > IDETAPE_DSC_MA_THRESHOLD)
+		} else if (time_after(jiffies, tape->dsc_polling_start + IDETAPE_DSC_MA_THRESHOLD))
 			tape->dsc_polling_frequency = IDETAPE_DSC_MA_SLOW;
 		idetape_postpone_request (drive);
 		return ide_stopped;
@@ -2740,7 +2740,7 @@
 			if (tape->onstream) {
 				if (tape->cur_frames - tape->reads_since_buffer_fill <= 0)
 					tape->req_buffer_fill = 1;
-				if (jiffies > tape->last_buffer_fill + 5 * HZ / 100)
+				if (time_after(jiffies, tape->last_buffer_fill + 5 * HZ / 100))
 					tape->req_buffer_fill = 1;
 			}
 			pc = idetape_next_pc_storage (drive);
@@ -2756,7 +2756,7 @@
 			if (tape->onstream) {
 				if (tape->cur_frames + tape->writes_since_buffer_fill >= tape->max_frames)
 					tape->req_buffer_fill = 1;
-				if (jiffies > tape->last_buffer_fill + 5 * HZ / 100)
+				if (time_after(jiffies, tape->last_buffer_fill + 5 * HZ / 100))
 					tape->req_buffer_fill = 1;
 				calculate_speeds(drive);
 			}
@@ -3214,7 +3214,7 @@
 	 * Wait for the tape to become ready
 	 */
 	timeout += jiffies;
-	while (jiffies < timeout) {
+	while (time_before(jiffies, timeout)) {
 		idetape_create_test_unit_ready_cmd(&pc);
 		if (!__idetape_queue_pc_tail(drive, &pc))
 			return 0;
--- /usr/src/linux-2.4.14-pre6/drivers/ide/ide.c	Wed Oct 31 23:06:19 2001
+++ drivers/ide/ide.c	Tue Nov  6 22:36:20 2001
@@ -654,7 +654,7 @@
 	if (OK_STAT(stat=GET_STAT(), 0, BUSY_STAT)) {
 		printk("%s: ATAPI reset complete\n", drive->name);
 	} else {
-		if (0 < (signed long)(hwgroup->poll_timeout - jiffies)) {
+		if (time_before(jiffies, hwgroup->poll_timeout)) {
 			ide_set_handler (drive, &atapi_reset_pollfunc, HZ/20, NULL);
 			return ide_started;	/* continue polling */
 		}
@@ -679,7 +679,7 @@
 	byte tmp;

 	if (!OK_STAT(tmp=GET_STAT(), 0, BUSY_STAT)) {
-		if (0 < (signed long)(hwgroup->poll_timeout - jiffies)) {
+		if (time_before(jiffies, hwgroup->poll_timeout)) {
 			ide_set_handler (drive, &reset_pollfunc, HZ/20, NULL);
 			return ide_started;	/* continue polling */
 		}
@@ -1111,7 +1111,7 @@
 		ide__sti();		/* local CPU only */
 		timeout += jiffies;
 		while ((stat = GET_STAT()) & BUSY_STAT) {
-			if (0 < (signed long)(jiffies - timeout)) {
+			if (time_after(jiffies, timeout)) {
 				__restore_flags(flags);	/* local CPU only */
 				*startstop = ide_error(drive, "status timeout", stat);
 				return 1;
@@ -1300,7 +1300,7 @@
 	best = NULL;
 	drive = hwgroup->drive;
 	do {
-		if (!list_empty(&drive->queue.queue_head) && (!drive->sleep || 0 <= (signed long)(jiffies - drive->sleep))) {
+		if (!list_empty(&drive->queue.queue_head) && (!drive->sleep || time_after_eq(jiffies, drive->sleep))) {
 			if (!best
 			 || (drive->sleep && (!best->sleep || 0 < (signed long)(best->sleep - drive->sleep)))
 			 || (!best->sleep && 0 < (signed long)(WAKEUP(best) - WAKEUP(drive))))
@@ -1395,7 +1395,7 @@
 				 * play fairly with us, just in case there are big differences
 				 * in relative throughputs.. don't want to hog the cpu too much.
 				 */
-				if (0 < (signed long)(jiffies + WAIT_MIN_SLEEP - sleep))
+				if (time_before(sleep, jiffies + WAIT_MIN_SLEEP))
 					sleep = jiffies + WAIT_MIN_SLEEP;
 #if 1
 				if (timer_pending(&hwgroup->timer))
@@ -1634,7 +1634,7 @@
 				/* Try to not flood the console with msgs */
 				static unsigned long last_msgtime, count;
 				++count;
-				if (0 < (signed long)(jiffies - (last_msgtime + HZ))) {
+				if (time_after(jiffies, last_msgtime + HZ)) {
 					last_msgtime = jiffies;
 					printk("%s%s: unexpected interrupt, status=0x%02x, count=%ld\n",
 					 hwif->name, (hwif->next == hwgroup->hwif) ? "" : "(?)", stat, count);
@@ -2433,7 +2433,7 @@
 		spin_unlock_irq(&io_request_lock);
 		__save_flags(lflags);	/* local CPU only */
 		__sti();		/* local CPU only; needed for jiffies */
-		if (0 < (signed long)(jiffies - timeout)) {
+		if (time_after(jiffies, timeout)) {
 			__restore_flags(lflags);	/* local CPU only */
 			printk("%s: channel busy\n", drive->name);
 			return -EBUSY;

