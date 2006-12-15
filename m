Return-Path: <linux-kernel-owner+w=401wt.eu-S1030410AbWLOX6c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030410AbWLOX6c (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 18:58:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030413AbWLOX6b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 18:58:31 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:43444 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1030410AbWLOX6a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 18:58:30 -0500
Date: Sat, 16 Dec 2006 00:58:18 +0100
From: Pavel Machek <pavel@ucw.cz>
To: rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>, Dirk@Opfer-Online.de,
       arminlitzel@web.de, pavel.urban@ct.cz, metan@seznam.cz
Subject: Nasty warnings on arm (+ one compile problem -- INIT_WORK related)
Message-ID: <20061215235818.GD2853@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I get nasty warning for each file compiled:

  CC      drivers/video/sa1100fb.o
In file included from include/asm/bitops.h:23,
                 from include/linux/bitops.h:9,
                 from include/linux/thread_info.h:20,
                 from include/linux/preempt.h:9,
                 from include/linux/spinlock.h:49,
                 from include/linux/module.h:9,
                 from drivers/video/sa1100fb.c:163:
include/asm/system.h: In function `adjust_cr':
include/asm/system.h:185: warning: implicit declaration of function
`local_irq_save'
include/asm/system.h:192: warning: implicit declaration of function
`local_irq_restore'
include/asm/system.h:179: warning: unused variable `cr'

Plus compile error. It should be some search&replace I should do, but
which one?

drivers/video/sa1100fb.c:1447:49: macro "INIT_WORK" passed 3
arguments, but takes just 2
drivers/video/sa1100fb.c: In function `sa1100fb_init_fbinfo':
drivers/video/sa1100fb.c:1447: error: `INIT_WORK' undeclared (first
use in this function)
drivers/video/sa1100fb.c:1447: error: (Each undeclared identifier is
reported only once
drivers/video/sa1100fb.c:1447: error: for each function it appears
in.)
drivers/video/sa1100fb.c: At top level:
drivers/video/sa1100fb.c:1204: warning: `sa1100fb_task' defined but
not used
make[2]: *** [drivers/video/sa1100fb.o] Error 1
make[1]: *** [drivers/video] Error 2
make: *** [drivers] Error 2

        INIT_WORK(&fbi->task, sa1100fb_task, fbi);

...

/*
 * Our LCD controller task (which is called when we blank or unblank)
 * via keventd.
 */
static void sa1100fb_task(void *dummy)
{
        struct sa1100fb_info *fbi = dummy;
        u_int state = xchg(&fbi->task_state, -1);

        set_ctrlr_state(fbi, state);
}

(Or will I need to play with container_of or something? I guess I did
not pay attetion to workqueue stuff).
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
