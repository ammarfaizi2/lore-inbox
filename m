Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266420AbUA3F4z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 00:56:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266547AbUA3Fzh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 00:55:37 -0500
Received: from dp.samba.org ([66.70.73.150]:43655 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S266542AbUA3Fy6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 00:54:58 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Affinity of call_usermode_helper fix
Date: Fri, 30 Jan 2004 15:52:34 +1100
Message-Id: <20040130055513.2B6282C0CA@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vatsa and I noticed this.

call_usermode_helper uses keventd, so the process created inherits its
cpus_allowed mask.  Unset it.

Name: call_usermode_helper Without Being Bound To A Specific CPU
Author: Rusty Russell
Status: Booted on 2.6.2-rc2-bk2

D: call_usermode_helper uses keventd, so the process created inherits
D: its cpus_allowed mask.  Unset it.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .6951-linux-2.6.2-rc2-bk2/kernel/kmod.c .6951-linux-2.6.2-rc2-bk2.updated/kernel/kmod.c
--- .6951-linux-2.6.2-rc2-bk2/kernel/kmod.c	2004-01-10 13:59:39.000000000 +1100
+++ .6951-linux-2.6.2-rc2-bk2.updated/kernel/kmod.c	2004-01-29 16:08:31.000000000 +1100
@@ -168,6 +168,8 @@ static int ____call_usermodehelper(void 
 	recalc_sigpending();
 	spin_unlock_irq(&current->sighand->siglock);
 
+	/* We can run anywhere, unlike our parent keventd(). */
+	set_cpus_allowed(current, CPU_MASK_ALL);
 	retval = -EPERM;
 	if (current->fs->root)
 		retval = execve(sub_info->path, sub_info->argv,sub_info->envp);


--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
