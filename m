Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261567AbUKIQLy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261567AbUKIQLy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 11:11:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261568AbUKIQLy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 11:11:54 -0500
Received: from fw.osdl.org ([65.172.181.6]:9671 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261567AbUKIQLt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 11:11:49 -0500
Date: Tue, 9 Nov 2004 08:11:41 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Dinakar Guniguntala <dino@in.ibm.com>
cc: Sripathi Kodi <sripathik@in.ibm.com>, linux-kernel@vger.kernel.org,
       Roland McGrath <roland@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] do_wait fix for 2.6.10-rc1
In-Reply-To: <20041109143118.GA8961@in.ibm.com>
Message-ID: <Pine.LNX.4.58.0411090745250.2301@ppc970.osdl.org>
References: <418B4E86.4010709@in.ibm.com> <Pine.LNX.4.58.0411051101500.30457@ppc970.osdl.org>
 <418F826C.2060500@in.ibm.com> <Pine.LNX.4.58.0411080744320.24286@ppc970.osdl.org>
 <Pine.LNX.4.58.0411080806400.24286@ppc970.osdl.org>
 <Pine.LNX.4.58.0411080820110.24286@ppc970.osdl.org>
 <Pine.LNX.4.58.0411081708000.2301@ppc970.osdl.org> <20041109143118.GA8961@in.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 9 Nov 2004, Dinakar Guniguntala wrote:
> 
> All of your patches address the TASK_STOPPED case, whereas the current
> problem that Sripathi reported does not have a task in the stopped state.

Sorry, I'm a retard.

> Hence the patches Sripathi sent which did fix the problem, but they end up 
> busy looping because of schedule. The only clean solution seems to be to 
> wake up the siblings if there are any in the case we reap a process from 
> wait_task_zombie. What do you think?

Ok, that was my original second suggestion, but the more I think about it, 
the more unnecessarily complicated it sounds.

I think I have a potentially better approach: make the rules for "flag" a 
bit more explicit, and make it have structure. We use "flag" for two 
things: we use it to determine if we should return -ECHILD (no children), 
and for whether we should wait for something that might become available 
later. So just split up "flag" into these two meanings, instead of just 
trying to use a single bit:

 - one bit that says "we found a child that _will_ wake us up when it's 
   ready". In other words, that's a child that is ours, and is not yet a 
   zombie.

 - one bit that says "we found a child that is ours".

Make "eligible_child()" follow these rules, and then instead of just 
setting "flag = 1", we'd set "flag |= ret".

Now, with these rules, we know just what to do: we only do the wait if the 
"we have children that will wake us up" bit is set. But we return ECHILD 
only if flag is totally clear.

Does that sound like it would fix the problem?

		Linus
