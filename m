Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261316AbVFNUBh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261316AbVFNUBh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 16:01:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261317AbVFNUBh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 16:01:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:57031 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261316AbVFNUBU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 16:01:20 -0400
Date: Tue, 14 Jun 2005 13:00:52 -0700
From: Andrew Morton <akpm@osdl.org>
To: John Baboval <baboval@spineless.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11: kernel BUG at fs/jbd/checkpoint.c:247! - Also on
 2.6.12-rc5
Message-Id: <20050614130052.5e672405.akpm@osdl.org>
In-Reply-To: <42AEE3DA.8060201@spineless.org>
References: <42AEE3DA.8060201@spineless.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Baboval <baboval@spineless.org> wrote:
>
> On Fri, 3 Jun 2005 16:33:56 -0700 Andrew Morton <akpm@osdl.org> wrote:
>  > Please test
>  > 
>  > ftp://ftp.kernel.org/pub/linux/kernel/v2.6/testing/linux-2.6.12-rc5.tar.bz2
>  > plus
>  > ftp://ftp.kernel.org/pub/linux/kernel/v2.6/snapshots/patch-2.6.12-rc5-git8.bz2
> 
> 
>  I've just reproduced this on 2.6.12-rc5.
> 
>  It was hapening every 4 hours or so with 2.6.11.9. 2.6.12-rc5 ran for a week... The system is being used as a fairly high traffic NFS server.

Could you try this, please?


From: Jan Kara <jack@suse.cz>

On one path, cond_resched_lock() fails to return true if it dropped the lock. 
We think this might be causing the crashes in JBD's log_do_checkpoint().

Cc: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 kernel/sched.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff -puN kernel/sched.c~cond_resched-lock-fix kernel/sched.c
--- 25/kernel/sched.c~cond_resched-lock-fix	Mon Jun 13 15:51:22 2005
+++ 25-akpm/kernel/sched.c	Mon Jun 13 15:51:22 2005
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
_

