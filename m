Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136505AbREASzf>; Tue, 1 May 2001 14:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136516AbREASz0>; Tue, 1 May 2001 14:55:26 -0400
Received: from jalon.able.es ([212.97.163.2]:55531 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S136505AbREASzS>;
	Tue, 1 May 2001 14:55:18 -0400
Date: Tue, 1 May 2001 20:55:10 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: boris <boris@macbeth.rhoen.de>, Hugh Dickins <hugh@veritas.com>
Subject: [PATCH] Re: Linux 2.4.4-ac2
Message-ID: <20010501205510.A1059@werewolf.able.es>
In-Reply-To: <20010501192726.A1246@werewolf.able.es> <Pine.LNX.4.21.0105011835240.1576-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.21.0105011835240.1576-100000@localhost.localdomain>; from hugh@veritas.com on Tue, May 01, 2001 at 19:41:43 +0200
X-Mailer: Balsa 1.1.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 05.01 Hugh Dickins wrote:
> On Tue, 1 May 2001, J . A . Magallon wrote:
> > > 
> > > OK works here ...
> > 
> > Me too.
> > 
> > Perhaps this reschedules ok in UP but kinda fails in SMP...
> 
> Great.  And see Andrea's SCHED_YIELD explanation in the "sluggish"
> mail thread.  Well, I didn't try to understand it in full, and I
> think he was expecting another thread to hang, rather than the main
> startup itself; but no doubt deeper thought would make sense of it all.
> 

I saw it. Minimal change to make 2.4.4-ac2 work:
========== patch-fork-yield
--- linux/kernel/fork.c.orig	Tue May  1 20:03:12 2001
+++ linux/kernel/fork.c	Tue May  1 20:52:18 2001
@@ -677,8 +677,11 @@
 	 * few simple things and then exec(). This is only important in the
 	 * first timeslice. In the long run, the scheduling behavior is
 	 * unchanged.
+	 * Make sure the child gets the SCHED_YIELD flag cleared, even if
+	 * it inherited it, to avoid deadlocks.
 	 */
 	p->counter = (current->counter + 1) >> 1;
+	p->policy &= ~SCHED_YIELD;
 	current->counter >>= 1;
 	current->policy |= SCHED_YIELD;
 	current->need_resched = 1;

Is this enough (Andrea?) or just "works for me" ?.

-- 
J.A. Magallon                                          #  Let the source
mailto:jamagallon@able.es                              #  be with you, Luke... 

Linux werewolf 2.4.4-ac1 #1 SMP Tue May 1 11:35:17 CEST 2001 i686

