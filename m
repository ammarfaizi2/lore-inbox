Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261416AbUDHCON (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 22:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261422AbUDHCON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 22:14:13 -0400
Received: from zcamail05.zca.compaq.com ([161.114.32.105]:2833 "EHLO
	zcamail05.zca.compaq.com") by vger.kernel.org with ESMTP
	id S261416AbUDHCOL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 22:14:11 -0400
To: linux-kernel@vger.kernel.org
From: john.l.byrne@hp.com
Cc: marcelo.tosatti@cyclades.com, akpm@osdl.org
Subject: [PATCH]: 2.4/2.6 do_fork() error path memory leak
Message-Id: <E1BBP3Q-0007o9-00@kahuna.lax.cpqcorp.net>
Date: Wed, 07 Apr 2004 19:14:08 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In do_fork(), if an error occurs after the mm_struct for the child has
been allocated, it is never freed. The exit_mm() meant to free it
increments the mm_count and this count is never decremented. (For a
running process that is exitting, schedule() takes care this; however,
the child process being cleaned up is not running.) In the CLONE_VM
case, the parent's mm_struct will get an extra mm_count and so it will
never be freed.

This patch against 2.4.25 should fix both the CLONE_VM and the not
CLONE_VM case; the test of p->active_mm prevents a panic in the case
that a kernel-thread is being cloned.

It looks from the code that the problem exists in 2.6 as well; I can
send a separate patch for that, if necessary.

John Byrne

diff -Nar -U 4 linux-2.4.25/kernel/fork.c linux-2.4.25-new/kernel/fork.c
--- linux-2.4.25/kernel/fork.c	2004-02-18 05:36:32.000000000 -0800
+++ linux-2.4.25-new/kernel/fork.c	2004-04-07 17:43:29.000000000 -0700
@@ -825,8 +825,10 @@
 bad_fork_cleanup_namespace:
 	exit_namespace(p);
 bad_fork_cleanup_mm:
 	exit_mm(p);
+	if (p->active_mm)
+		mmdrop(p->active_mm);
 bad_fork_cleanup_sighand:
 	exit_sighand(p);
 bad_fork_cleanup_fs:
 	exit_fs(p); /* blocking */



