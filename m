Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267339AbTALJhQ>; Sun, 12 Jan 2003 04:37:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267346AbTALJhQ>; Sun, 12 Jan 2003 04:37:16 -0500
Received: from mailout05.sul.t-online.com ([194.25.134.82]:21405 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S267339AbTALJhQ>; Sun, 12 Jan 2003 04:37:16 -0500
Date: Sun, 12 Jan 2003 10:45:45 +0100
From: Juergen Quade <quade@hsnr.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] small bugfix to tasklet_kill
Message-ID: <20030112094545.GA1420@hsnr.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Find a mini-patch below, which is a bugfix to the tasklet_kill()
code. It removes the last line of the function, which clears the
TASKLET_STATE_SCHED bit.

Some more explanation:

That a tasklet has been scheduled for processing is marked by
the TASKLET_STATE_SCHED bit. If this bit is set, a call to
tasklet_schedule() does nothing. If it is cleared, the tasklet
is put on the processing queue (call to __tasklet_schedule()).
After processing the tasklet the TASKLET_STATE_SCHED bit is
cleared (so by calling tasklet_schedule() it will be put on the
processing queue).

The trick to kill a tasklet (function tasklet_kill() ) is:
    - set the TASKLET_SCHEDULE_BIT, but at the same time
    - take care that the tasklet is _not_ on the processing queue.
This is done by waiting for the execution of the tasklet (if it
is scheduled) and then _setting_ the bit.


==================================================================
diff -urN linux-2.5.56/kernel/softirq.c linux/kernel/softirq.c
--- linux-2.5.56/kernel/softirq.c       2003-01-02 04:21:21.000000000
+0100
+++ linux/kernel/softirq.c      2003-01-12 10:13:06.000000000 +0100
@@ -258,7 +258,6 @@
                while (test_bit(TASKLET_STATE_SCHED, &t->state));
        }
        tasklet_unlock_wait(t);
-       clear_bit(TASKLET_STATE_SCHED, &t->state);
 }


