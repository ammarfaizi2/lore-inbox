Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318650AbSIKKYt>; Wed, 11 Sep 2002 06:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318652AbSIKKYt>; Wed, 11 Sep 2002 06:24:49 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:63893 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S318650AbSIKKYs>;
	Wed, 11 Sep 2002 06:24:48 -0400
Date: Wed, 11 Sep 2002 12:29:26 +0200
From: Jens Axboe <axboe@suse.de>
To: Oleg Drokin <green@namesys.com>
Cc: Ingo Molnar <mingo@elte.hu>, Robert Love <rml@tech9.net>,
       Thomas Molina <tmolina@cox.net>, linux-kernel@vger.kernel.org,
       andre@linux-ide.org
Subject: Re: 2.5 Problem Status Report
Message-ID: <20020911102926.GB1364@suse.de>
References: <20020911112808.A6341@namesys.com> <Pine.LNX.4.44.0209110937190.5764-100000@localhost.localdomain> <20020911120551.A937@namesys.com> <20020911102507.GA1364@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020911102507.GA1364@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11 2002, Jens Axboe wrote:
> On Wed, Sep 11 2002, Oleg Drokin wrote:
> > Hello!
> > 
> > On Wed, Sep 11, 2002 at 09:38:25AM +0200, Ingo Molnar wrote:
> > 
> > > > I have preemption disabled.
> > > nevertheless please print out preempt_count() in sched.c - since the big
> > > IRQ cleanups we use the preemption count even if preemption is disabled.
> > > this way we'll know what kind of problem happened - a stuck softirq count, 
> > > a stuck hardirq count or an underflow?
> > 
> > You was exactly right.  preemption count is -1.  I inserted chack in
> > dec_preempt_count() and here is updated correct stacktrace.  Seems
> > like ide_unmap_buffer is called with some bogus data or something like
> > that. Also I guess the bug is only visible with debug highmem = ON and
> > highmem enabled.
> 
> ok I see the bug. it's due to the imbalanced nature of ide_map_buffer()
> vs ide_unmap_buffer(). i'll cook up a fix right away.

Oleg,

Does this make it work?

--- drivers/ide/ide-disk.c~	2002-09-11 12:27:47.000000000 +0200
+++ drivers/ide/ide-disk.c	2002-09-11 12:28:17.000000000 +0200
@@ -175,7 +175,7 @@
 		drive->name, rq->sector, rq->sector+nsect-1,
 		(unsigned long) rq->buffer+(nsect<<9), rq->nr_sectors-nsect);
 #endif
-	ide_unmap_buffer(to, &flags);
+	ide_unmap_buffer(rq, to, &flags);
 	rq->sector += nsect;
 	rq->errors = 0;
 	i = (rq->nr_sectors -= nsect);
@@ -226,7 +226,7 @@
 				unsigned long flags;
 				char *to = ide_map_buffer(rq, &flags);
 				taskfile_output_data(drive, to, SECTOR_WORDS);
-				ide_unmap_buffer(to, &flags);
+				ide_unmap_buffer(rq, to, &flags);
 				if (HWGROUP(drive)->handler != NULL)
 					BUG();
 				ide_set_handler(drive, &write_intr, WAIT_CMD, NULL);
@@ -302,7 +302,7 @@
 		 * re-entering us on the last transfer.
 		 */
 		taskfile_output_data(drive, buffer, nsect<<7);
-		ide_unmap_buffer(buffer, &flags);
+		ide_unmap_buffer(rq, buffer, &flags);
 	} while (mcount);
 
         return 0;
@@ -688,7 +688,7 @@
 				BUG();
 			ide_set_handler(drive, &write_intr, WAIT_CMD, NULL);
 			taskfile_output_data(drive, buffer, SECTOR_WORDS);
-			ide_unmap_buffer(buffer, &flags);
+			ide_unmap_buffer(rq, buffer, &flags);
 		}
 		return ide_started;
 	}
--- drivers/ide/ide-taskfile.c~	2002-09-11 12:27:51.000000000 +0200
+++ drivers/ide/ide-taskfile.c	2002-09-11 12:28:25.000000000 +0200
@@ -60,7 +60,7 @@
 #endif
 
 #define task_map_rq(rq, flags)		ide_map_buffer((rq), (flags))
-#define task_unmap_rq(rq, buf, flags)	ide_unmap_buffer((buf), (flags))
+#define task_unmap_rq(rq, buf, flags)	ide_unmap_buffer((rq), (buf), (flags))
 
 inline u32 task_read_24 (ide_drive_t *drive)
 {
--- include/linux/ide.h~	2002-09-11 12:27:14.000000000 +0200
+++ include/linux/ide.h	2002-09-11 12:27:29.000000000 +0200
@@ -597,9 +597,10 @@
 	return rq->buffer + task_rq_offset(rq);
 }
 
-extern inline void ide_unmap_buffer(char *buffer, unsigned long *flags)
+extern inline void ide_unmap_buffer(struct request *rq, char *buffer, unsigned long *flags)
 {
-	bio_kunmap_irq(buffer, flags);
+	if (rq->bio)
+		bio_kunmap_irq(buffer, flags);
 }
 
 /*

-- 
Jens Axboe

