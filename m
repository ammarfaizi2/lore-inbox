Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280967AbRKCPa6>; Sat, 3 Nov 2001 10:30:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280968AbRKCPas>; Sat, 3 Nov 2001 10:30:48 -0500
Received: from draco.cus.cam.ac.uk ([131.111.8.18]:9616 "EHLO
	draco.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S280967AbRKCPae>; Sat, 3 Nov 2001 10:30:34 -0500
Subject: [PATCH] 2.4.14-pre7 Missing disk req queue unplugs
To: torvalds@transmeta.com
Date: Sat, 3 Nov 2001 15:30:32 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, will_dyson@pobox.com
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <E1602ki-0001Uw-00@draco.cus.cam.ac.uk>
From: Anton Altaparmakov <aia21@cus.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please apply below patch for your next -pre kernel.

This patch adds two disk request queue unplugs in mm/filemap.c which are
present in -ac kernels but not in -pre kernels.

Without this patch NTFS TNG will hang when it tries to read anything using
the page cache. Same for BeFS as reported by Will Dyson. The hangs would
"unhang" as soon as something else caused disk io to happen (e.g. doing
md5sum on an ext2 partition on a file that hasn't been accessed before
so it isn't in the page cache yet).

With this patch NTFS TNG no longer hangs. I haven't tried BeFS but I am
confident it will be fixed by this patch, too.

Thanks go to Andrew Morton for locating the problem causing the hangs.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

--- linux-2.4.14-pre7-unplug.diff ---

diff -u -urN linux-2.4.14-pre7-vanilla/mm/filemap.c linux-2.4.14-pre7-aia1/mm/filemap.c
--- linux-2.4.14-pre7-vanilla/mm/filemap.c	Sat Nov  3 12:17:55 2001
+++ linux-2.4.14-pre7-aia1/mm/filemap.c	Sat Nov  3 15:18:22 2001
@@ -769,6 +769,7 @@
 		if (!PageLocked(page))
 			break;
 		sync_page(page);
+		run_task_queue(&tq_disk);
 		schedule();
 	} while (PageLocked(page));
 	tsk->state = TASK_RUNNING;
@@ -800,7 +801,9 @@
 		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
 		if (PageLocked(page)) {
 			sync_page(page);
+			run_task_queue(&tq_disk);
 			schedule();
+			continue;
 		}
 		if (!TryLockPage(page))
 			break;

