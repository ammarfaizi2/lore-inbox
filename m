Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751265AbVLLQ66@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265AbVLLQ66 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 11:58:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbVLLQ66
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 11:58:58 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:46473 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1751265AbVLLQ66 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 11:58:58 -0500
Message-ID: <439DBDE7.75F0BAAD@tv-sign.ru>
Date: Mon, 12 Dec 2005 21:13:59 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] copy_process: error path cleanup
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch moves 'fork_out:' under 'bad_fork_free:',
and removes now unneeded 'if (retval)' check.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.15-rc5/kernel/fork.c~	2005-12-06 23:33:16.000000000 +0300
+++ 2.6.15-rc5/kernel/fork.c	2005-12-12 22:55:12.000000000 +0300
@@ -1141,11 +1141,7 @@ static task_t *copy_process(unsigned lon
 	write_unlock_irq(&tasklist_lock);
 	proc_fork_connector(p);
 	cpuset_fork(p);
-	retval = 0;
 
-fork_out:
-	if (retval)
-		return ERR_PTR(retval);
 	return p;
 
 bad_fork_cleanup_namespace:
@@ -1184,7 +1180,8 @@ bad_fork_cleanup_count:
 	free_uid(p->user);
 bad_fork_free:
 	free_task(p);
-	goto fork_out;
+fork_out:
+	return ERR_PTR(retval);
 }
 
 struct pt_regs * __devinit __attribute__((weak)) idle_regs(struct pt_regs *regs)
