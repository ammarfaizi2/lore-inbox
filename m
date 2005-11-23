Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750780AbVKWNKF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbVKWNKF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 08:10:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750787AbVKWNJq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 08:09:46 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:36319 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1750780AbVKWNJo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 08:09:44 -0500
Message-ID: <43847B88.483BD743@tv-sign.ru>
Date: Wed, 23 Nov 2005 17:24:08 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Roland McGrath <roland@redhat.com>, Michael Kerrisk <mtk-lkml@gmx.net>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH] do_coredump() should reset group_stop_count earlier
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

__group_complete_signal() sets ->group_stop_count in sig_kernel_coredump()
path and marks the target thread as ->group_exit_task. So any thread except
group_exit_task will go to handle_group_stop()->finish_stop().

However, when group_exit_task actually starts do_coredump(), it sets SIGNAL_GROUP_EXIT,
but does not reset ->group_stop_count while killing other threads. If we have
not yet stopped threads in the same thread group, they all will spin in kernel
mode until group_exit_task sends them SIGKILL, because ->group_stop_count > 0
means:

	recalc_sigpending_tsk() never clears TIF_SIGPENDING

	get_signal_to_deliver() goes to handle_group_stop()

	handle_group_stop() returns when SIGNAL_GROUP_EXIT set

	syscall_exit/resume_userspace notice TIF_SIGPENDING,
	call get_signal_to_deliver() again.

So we are wasting cpu cycles, and if one of these threads is rt_task() this
may be a serious problem.

NOTE: do_coredump() holds ->mmap_sem, so not stopped threads can't escape
coredumping after clearing ->group_stop_count.

See also this thread: http://marc.theaimsgroup.com/?t=112739139900002

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.15-rc2/fs/exec.c~	2005-11-23 19:23:15.000000000 +0300
+++ 2.6.15-rc2/fs/exec.c	2005-11-23 19:56:07.000000000 +0300
@@ -1472,6 +1472,7 @@ int do_coredump(long signr, int exit_cod
 	if (!(current->signal->flags & SIGNAL_GROUP_EXIT)) {
 		current->signal->flags = SIGNAL_GROUP_EXIT;
 		current->signal->group_exit_code = exit_code;
+		current->signal->group_stop_count = 0;
 		retval = 0;
 	}
 	spin_unlock_irq(&current->sighand->siglock);
@@ -1487,7 +1488,6 @@ int do_coredump(long signr, int exit_cod
 	 * Clear any false indication of pending signals that might
 	 * be seen by the filesystem code called to write the core file.
 	 */
-	current->signal->group_stop_count = 0;
 	clear_thread_flag(TIF_SIGPENDING);
 
 	if (current->signal->rlim[RLIMIT_CORE].rlim_cur < binfmt->min_coredump)
