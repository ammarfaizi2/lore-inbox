Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261871AbVANDRU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261871AbVANDRU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 22:17:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261889AbVANDQG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 22:16:06 -0500
Received: from mx1.redhat.com ([66.187.233.31]:62621 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261877AbVANDGM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 22:06:12 -0500
Date: Thu, 13 Jan 2005 19:05:59 -0800
Message-Id: <200501140305.j0E35xqW007488@magilla.sf.frob.com>
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
X-Fcc: ~/Mail/linus
Cc: Steve Dickson <SteveD@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] clear false pending signal indication in core dump
X-Windows: a mistake carried out to perfection.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When kill is used to force a core dump, __group_complete_signal uses the
group_stop_count machinery to stop other threads from doing anything more
before the signal-taking thread starts the coredump synchronization.  This
intentionally results in group_stop_count always still being > 0 when the
signal-taking thread gets into do_coredump.  However, that has the
unintended effect that signal_pending can return true when called from the
filesystem code while writing the core dump file.  For NFS mounts using the
"intr" option, this results in NFS operations bailing out before they even
try, so core files never get successfully dumped on such a filesystem when
the crash was induced by an asynchronous process-wide signal.

This patch fixes the problem by clearing group_stop_count after the
coredump synchronization is complete.

The locking I threw in is not directly related, but always should have been
there and may avoid some potential races with kill.


Thanks,
Roland


Signed-off-by: Roland McGrath <roland@redhat.com>

--- linux-2.6/fs/exec.c
+++ linux-2.6/fs/exec.c
@@ -1397,10 +1434,19 @@ int do_coredump(long signr, int exit_cod
 	}
 	mm->dumpable = 0;
 	init_completion(&mm->core_done);
+	spin_lock_irq(&current->sighand->siglock);
 	current->signal->flags = SIGNAL_GROUP_EXIT;
 	current->signal->group_exit_code = exit_code;
+	spin_unlock_irq(&current->sighand->siglock);
 	coredump_wait(mm);
 
+	/*
+	 * Clear any false indication of pending signals that might
+	 * be seen by the filesystem code called to write the core file.
+	 */
+	current->signal->group_stop_count = 0;
+	clear_thread_flag(TIF_SIGPENDING);
+
 	if (current->signal->rlim[RLIMIT_CORE].rlim_cur < binfmt->min_coredump)
 		goto fail_unlock;
 
