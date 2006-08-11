Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750966AbWHKBxT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750966AbWHKBxT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 21:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932423AbWHKBxS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 21:53:18 -0400
Received: from mx1.redhat.com ([66.187.233.31]:35206 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750964AbWHKBxS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 21:53:18 -0400
Date: Thu, 10 Aug 2006 21:52:59 -0400
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, arjan@infradead.org
Subject: fix up lockdep trace in fs/exec.c
Message-ID: <20060811015259.GD16454@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, arjan@infradead.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

=============================================
[ INFO: possible recursive locking detected ]
---------------------------------------------
init/1 is trying to acquire lock:
 (&sighand->siglock){....}, at: [<c047a78a>] flush_old_exec+0x3ae/0x859

but task is already holding lock:
 (&sighand->siglock){....}, at: [<c047a77a>] flush_old_exec+0x39e/0x859

other info that might help us debug this:
2 locks held by init/1:
 #0:  (tasklist_lock){..--}, at: [<c047a76a>] flush_old_exec+0x38e/0x859
 #1:  (&sighand->siglock){....}, at: [<c047a77a>] flush_old_exec+0x39e/0x859

stack backtrace:
 [<c04051e1>] show_trace_log_lvl+0x54/0xfd
 [<c040579d>] show_trace+0xd/0x10
 [<c04058b6>] dump_stack+0x19/0x1b
 [<c043b33a>] __lock_acquire+0x773/0x997
 [<c043bacf>] lock_acquire+0x4b/0x6c
 [<c060630b>] _spin_lock+0x19/0x28
 [<c047a78a>] flush_old_exec+0x3ae/0x859
 [<c0498053>] load_elf_binary+0x4aa/0x1628
 [<c0479cab>] search_binary_handler+0xa7/0x24e
 [<c047b577>] do_execve+0x15b/0x1f9
 [<c04022b4>] sys_execve+0x29/0x4d
 [<c0403faf>] syscall_call+0x7/0xb

Signed-off-by: Arjan van de Ven <arjan@infradead.org>
Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.17.noarch/fs/exec.c~	2006-08-10 21:49:38.000000000 -0400
+++ linux-2.6.17.noarch/fs/exec.c	2006-08-10 21:50:36.000000000 -0400
@@ -753,7 +753,7 @@ no_thread_group:
 
 		write_lock_irq(&tasklist_lock);
 		spin_lock(&oldsighand->siglock);
-		spin_lock(&newsighand->siglock);
+		spin_lock_nested(&newsighand->siglock, SINGLE_DEPTH_NESTING);
 
 		rcu_assign_pointer(current->sighand, newsighand);
 		recalc_sigpending();

-- 
http://www.codemonkey.org.uk
