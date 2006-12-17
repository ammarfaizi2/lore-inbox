Return-Path: <linux-kernel-owner+w=401wt.eu-S1752519AbWLQMVT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752519AbWLQMVT (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 07:21:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752493AbWLQMVT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 07:21:19 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:56184 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752520AbWLQMVS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 07:21:18 -0500
Date: Sun, 17 Dec 2006 13:21:05 +0100
From: Pavel Machek <pavel@ucw.cz>
To: rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>, Dirk@Opfer-Online.de,
       arminlitzel@web.de, pavel.urban@ct.cz, metan@seznam.cz,
       patches@arm.linux.org.uk
Subject: [patch] fix collie compilation
Message-ID: <20061217122105.GB28628@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks to Al Viro, here's fix to 2.6.20-rc1-git, so that collie
compiles, again. It was broken by INIT_WORK changes.

Signed-off-by: Pavel Machek <pavel@suse.cz>

PATCH FOLLOWS
KernelVersion: 2.6.20-rc1-git

diff --git a/drivers/video/sa1100fb.c b/drivers/video/sa1100fb.c
index cd10b18..5d2a4a4 100644
--- a/drivers/video/sa1100fb.c
+++ b/drivers/video/sa1100fb.c
@@ -1200,9 +1200,9 @@ static void set_ctrlr_state(struct sa110
  * Our LCD controller task (which is called when we blank or unblank)
  * via keventd.
  */
-static void sa1100fb_task(void *dummy)
+static void sa1100fb_task(struct work_struct *w)
 {
-	struct sa1100fb_info *fbi = dummy;
+	struct sa1100fb_info *fbi = container_of(w, struct sa1100fb_info, task);
 	u_int state = xchg(&fbi->task_state, -1);
 
 	set_ctrlr_state(fbi, state);
@@ -1444,7 +1444,7 @@ static struct sa1100fb_info * __init sa1
 					  fbi->max_bpp / 8;
 
 	init_waitqueue_head(&fbi->ctrlr_wait);
-	INIT_WORK(&fbi->task, sa1100fb_task, fbi);
+	INIT_WORK(&fbi->task, sa1100fb_task);
 	init_MUTEX(&fbi->ctrlr_sem);
 
 	return fbi;

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
