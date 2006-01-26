Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751252AbWAZABf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbWAZABf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 19:01:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751251AbWAZABf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 19:01:35 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:15335 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751250AbWAZABe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 19:01:34 -0500
Date: Thu, 26 Jan 2006 01:02:00 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: rostedt@goodmis.org, linux-kernel@vger.kernel.org, viro@ftp.linux.org.uk
Subject: [patch, lock validator] fix proc_inum_lock related deadlock
Message-ID: <20060126000200.GA12809@elte.hu>
References: <20060125170331.GA29339@elte.hu> <1138209283.6695.55.camel@localhost.localdomain> <20060125180811.GA12762@elte.hu> <20060125102351.28cd52b8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060125102351.28cd52b8.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.2
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.2 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.6 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

there's another VFS lock that just popped up, hopefully the last one.  
Fix below. (All this is still related to proc_subdir_lock, and the 
original BKL bug it fixed.)

	Ingo

-------------

&proc_inum_lock also nests within proc_subdir_lock, and &proc_inum_lock
is used in a softirq-unsafe manner. The lock validator noticed the
following scenario:

  =====================================
  [ BUG: lock inversion bug detected! ]
  -------------------------------------
  ifup-eth/2308 just changed the state of lock {proc_subdir_lock} at:
   [<c0197083>] remove_proc_entry+0x33/0x1f0
  but this lock took lock {proc_inum_lock} in the past, acquired at:
   [<c0196fee>] free_proc_entry+0x2e/0x90
  and interrupts could create an inverse lock dependency between them,
  which could lead to deadlocks!

  other info that might help in debugging this:
  locks held by ifup-eth/2308:
   [<c010432d>] show_trace+0xd/0x10
   [<c0104347>] dump_stack+0x17/0x20
   [<c0137a41>] check_no_lock_2_mask+0x131/0x180
   [<c013852b>] mark_lock+0xfb/0x2a0
   [<c0138b63>] debug_lock_chain+0x493/0xdc0
   [<c01394cd>] debug_lock_chain_spin+0x3d/0x60
   [<c026594d>] _raw_spin_lock+0x2d/0x90
   [<c04d91a2>] _spin_lock_bh+0x12/0x20
   [<c0197083>] remove_proc_entry+0x33/0x1f0
   [<c01429e9>] unregister_handler_proc+0x19/0x20
   [<c01421ab>] free_irq+0x7b/0xe0
   [<c02f25b2>] floppy_release_irq_and_dma+0x1b2/0x210
   [<c02f0aa7>] set_dor+0xc7/0x1b0
   [<c02f3b21>] motor_off_callback+0x21/0x30
   [<c01274d5>] run_timer_softirq+0xf5/0x1f0
   [<c0122e27>] __do_softirq+0x97/0x130
   [<c0105519>] do_softirq+0x69/0x100
   =======================

the fix is to take proc_inum_lock in a softirq-safe manner.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

----

 fs/proc/generic.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

Index: linux/fs/proc/generic.c
===================================================================
--- linux.orig/fs/proc/generic.c
+++ linux/fs/proc/generic.c
@@ -329,9 +329,9 @@ retry:
 	if (idr_pre_get(&proc_inum_idr, GFP_KERNEL) == 0)
 		return 0;
 
-	spin_lock(&proc_inum_lock);
+	spin_lock_bh(&proc_inum_lock);
 	error = idr_get_new(&proc_inum_idr, NULL, &i);
-	spin_unlock(&proc_inum_lock);
+	spin_unlock_bh(&proc_inum_lock);
 	if (error == -EAGAIN)
 		goto retry;
 	else if (error)
@@ -350,9 +350,9 @@ static void release_inode_number(unsigne
 {
 	int id = (inum - PROC_DYNAMIC_FIRST) | ~MAX_ID_MASK;
 
-	spin_lock(&proc_inum_lock);
+	spin_lock_bh(&proc_inum_lock);
 	idr_remove(&proc_inum_idr, id);
-	spin_unlock(&proc_inum_lock);
+	spin_unlock_bh(&proc_inum_lock);
 }
 
 static void *proc_follow_link(struct dentry *dentry, struct nameidata *nd)
