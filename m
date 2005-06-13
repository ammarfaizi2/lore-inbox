Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261689AbVFMQTV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261689AbVFMQTV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 12:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261732AbVFMQTV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 12:19:21 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:18645 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261689AbVFMQTF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 12:19:05 -0400
Date: Mon, 13 Jun 2005 18:19:03 +0200
From: Jan Kara <jack@suse.cz>
To: Alexander Scheibner <alexander.scheibner@newthinking.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bug at fs/jbd/checkpoint.c:613
Message-ID: <20050613161903.GA19442@atrey.karlin.mff.cuni.cz>
References: <42A99B03.7070908@newthinking.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="uAKRQypu60I7Lcqm"
Content-Disposition: inline
In-Reply-To: <42A99B03.7070908@newthinking.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

  Hello,

> [1.] One line summary of the problem:
> System got completely frozen
> 
> [2.] Full description of the problem/report:
> - System got completely frozen, exept for the mouse pointer
> - Switching to another screen via STR+ALT+Fx not working
> - no service (ssh, samba, mail, ftp) was available any more
> - syslog reportet Kernel bug (localhost kernel: kernel BUG at 
> fs/jbd/checkpoint.c:613!)
  There were several bugs fixed in recent kernels in the JBD code. Can
you please try running the latest kernel - 2.6.12-rc6 - plus the
attached patch?

							Thanks
								Honza

--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="reschedfix-2.6.12-rc5.diff"

We must return 1 whenever we drop the lock.

Signed-off-by: Jan Kara <jack@suse.cz>

diff -rupX /home/jack/.kerndiffexclude linux-2.6.12-rc5/kernel/sched.c linux-2.6.12-rc5-1-condresched/kernel/sched.c
--- linux-2.6.12-rc5/kernel/sched.c	2005-05-27 10:48:52.000000000 +0200
+++ linux-2.6.12-rc5-1-condresched/kernel/sched.c	2005-06-11 13:48:29.000000000 +0200
@@ -3755,19 +3755,22 @@ EXPORT_SYMBOL(cond_resched);
  */
 int cond_resched_lock(spinlock_t * lock)
 {
+	int ret = 0;
+
 	if (need_lockbreak(lock)) {
 		spin_unlock(lock);
 		cpu_relax();
+		ret = 1;
 		spin_lock(lock);
 	}
 	if (need_resched()) {
 		_raw_spin_unlock(lock);
 		preempt_enable_no_resched();
 		__cond_resched();
+		ret = 1;
 		spin_lock(lock);
-		return 1;
 	}
-	return 0;
+	return ret;
 }
 
 EXPORT_SYMBOL(cond_resched_lock);

--uAKRQypu60I7Lcqm--
