Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750720AbWHTK3U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720AbWHTK3U (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 06:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750725AbWHTK3U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 06:29:20 -0400
Received: from filfla-vlan276.msk.corbina.net ([213.234.233.49]:21727 "EHLO
	screens.ru") by vger.kernel.org with ESMTP id S1750720AbWHTK3T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 06:29:19 -0400
Date: Sun, 20 Aug 2006 18:53:21 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Jens Axboe <axboe@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] copy_process: cosmetic ->ioprio tweak
Message-ID: <20060820145321.GA775@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

copy_process:
// holds tasklist_lock + ->siglock
       /*
        * inherit ioprio
        */
       p->ioprio = current->ioprio;

Why? ->ioprio was already copied in dup_task_struct(). I guess this is needed
to ensure that the child can't escape sys_ioprio_set(IOPRIO_WHO_{PGRP,USER}),
yes?

In that case we don't need ->siglock held, and the comment should be updated.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.18-rc4/kernel/fork.c~1_fork	2006-08-19 17:50:56.000000000 +0400
+++ 2.6.18-rc4/kernel/fork.c	2006-08-20 18:18:47.000000000 +0400
@@ -1138,7 +1138,6 @@ static struct task_struct *copy_process(
 
 	/* Our parent execution domain becomes current domain
 	   These must match for thread signalling to apply */
-	   
 	p->parent_exec_id = p->self_exec_id;
 
 	/* ok, now we should be set up.. */
@@ -1161,6 +1160,9 @@ static struct task_struct *copy_process(
 	/* Need tasklist lock for parent etc handling! */
 	write_lock_irq(&tasklist_lock);
 
+	/* for sys_ioprio_set(IOPRIO_WHO_PGRP) */
+	p->ioprio = current->ioprio;
+
 	/*
 	 * The task hasn't been attached yet, so its cpus_allowed mask will
 	 * not be changed, nor will its assigned CPU.
@@ -1220,11 +1222,6 @@ static struct task_struct *copy_process(
 		}
 	}
 
-	/*
-	 * inherit ioprio
-	 */
-	p->ioprio = current->ioprio;
-
 	if (likely(p->pid)) {
 		add_parent(p);
 		if (unlikely(p->ptrace & PT_PTRACED))

