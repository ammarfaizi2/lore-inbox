Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266678AbUGQBzH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266678AbUGQBzH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 21:55:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266680AbUGQBzH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 21:55:07 -0400
Received: from aun.it.uu.se ([130.238.12.36]:24027 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S266678AbUGQBzA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 21:55:00 -0400
Date: Sat, 17 Jul 2004 03:54:53 +0200 (MEST)
Message-Id: <200407170154.i6H1srwB015007@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH][2.6.8-rc1-mm1] perfctr inheritance 0/3: summary
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

This set of patches add "inheritance" support to the per-process
performance counters code in 2.6.8-rc1-mm1, bringing it in sync
with the stand-alone perfctr-2.7.4 package.

Inheritance has the following semantics:
- At fork()/clone(), the child gets the same perfctr control
  settings (but fresh/reset counters) as its parent.
- As an exited child is reaped, if it still uses the exact
  same control as its parent, then its final counts (self plus
  children) are merged into its parent's "children counts" state. 
  This is analogous to how the kernel handles plain time etc.
  If either parent or child has reprogrammed their counters since
  the fork(), then the child's final counts are not merged back.

This feature is one users have asked for repeatedly, and it's
the only embarrasing feature omission in the current code. It's
not perfect, since one cannot distinguish child 1 from child 2
or some grandchild, but it's easy and cheap to implement.

The implementation is as follows:
- The per-process counters object is extended with "children counts".
- To determine if the control in parent and child are related, each
  new control setting gets a new 64-bit id. fork() copies control and
  id to the child. release_task() checks the ids of child and parent
  and only merges the final counts if the ids match.
- The copy_task() callback is renamed to copy_thread(), and also
  takes the "struct pt_regs *regs" as parameter. "regs" is needed to
  check if the thread is created for a user-space fork()/clone(), or
  a kernel-level thread; in the latter case the perfctr state is
  _not_ inherited.
- Adds callback to release_task(), invoked at the point where the
  other child time etc values are propagated to the parent.
- The tsk->thread.perfctr locking rules are strengthened to always
  take task_lock(tsk). Previously it sufficed to disable preemption
  when HT P4s couldn't occur.

The updated perfctr-2.7.4 library and tools package is needed to
actually use the updated kernel code.

Three patches follow:
1/3: updates to the driver
2/3: updates to the kernel callbacks
3/3: updates to the documentation

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>
