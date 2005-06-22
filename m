Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262893AbVFVHwB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262893AbVFVHwB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 03:52:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262842AbVFVHtY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 03:49:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41146 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262791AbVFVGwV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 02:52:21 -0400
Date: Tue, 21 Jun 2005 23:51:44 -0700
From: Andrew Morton <akpm@osdl.org>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: linux-kernel@vger.kernel.org,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>
Subject: Re: 2.6.12-rc6-mm1 oops on startup.
Message-Id: <20050621235144.15fc55c6.akpm@osdl.org>
In-Reply-To: <42B46C18.2030101@superbug.demon.co.uk>
References: <42B46C18.2030101@superbug.demon.co.uk>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Courtier-Dutton <James@superbug.demon.co.uk> wrote:
>
> I have used the kernel.org normal kernel, and it compiles and boots fine.
>  I then use exactly the same .config file for the 2.6.12-rc6-mm1 and it
>  fails to boot.

It's due to the fork notifier code.  Set CONFIG_FORK_CONNECTOR=n and you
should be OK.

The oops is detected by CONFIG_DEBUG_PAGEALLOC.  It's good that you're
running with CONFIG_DEBUG_PAGEALLOC, but be aware that it uses tons of
memory and will slow down smaller machines quite a lot.


Here:

	if (clone_flags & CLONE_VFORK) {
		wait_for_completion(&vfork);
		if (unlikely (current->ptrace & PT_TRACE_VFORK_DONE))
			ptrace_notify ((PTRACE_EVENT_VFORK_DONE << 8) | SIGTRAP);
	}

	fork_connector(current->tgid, current->pid,
	               p->tgid, p->pid);

Someone does a call_usermodehelper() which uses CLONE_VFORK.  The new
process at `p' exits quickly so when the parent returns from
wait_for_completion() it is left with freed memory at *p.  When the parent
tries to reference p->pid we oops due to the use-after-free bug.

Guillaume, I'll do this for now:

--- 25/kernel/fork.c~connector-add-a-fork-connector-use-after-free-fix	2005-06-21 23:46:35.000000000 -0700
+++ 25-akpm/kernel/fork.c	2005-06-21 23:46:58.000000000 -0700
@@ -1248,14 +1248,15 @@ long do_fork(unsigned long clone_flags,
 			ptrace_notify ((trace << 8) | SIGTRAP);
 		}
 
+		fork_connector(current->tgid, current->pid, p->tgid, p->pid);
+
 		if (clone_flags & CLONE_VFORK) {
+
 			wait_for_completion(&vfork);
 			if (unlikely (current->ptrace & PT_TRACE_VFORK_DONE))
-				ptrace_notify ((PTRACE_EVENT_VFORK_DONE << 8) | SIGTRAP);
+				ptrace_notify((PTRACE_EVENT_VFORK_DONE << 8) |
+						SIGTRAP);
 		}
-
-		fork_connector(current->tgid, current->pid,
-		               p->tgid, p->pid);
 	} else {
 		free_pidmap(pid);
 		pid = PTR_ERR(p);
_


But you need to work out what semantics you want for vfork()?
