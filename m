Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262242AbVC2L4y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262242AbVC2L4y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 06:56:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262245AbVC2L4F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 06:56:05 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:37015 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262242AbVC2Lxg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 06:53:36 -0500
Subject: Re: [RFC] logdev debugging memory device for tough to debug areas
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20050329090707.GD7074@elte.hu>
References: <1109032784.32648.24.camel@localhost.localdomain>
	 <20050329090707.GD7074@elte.hu>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Tue, 29 Mar 2005 06:53:30 -0500
Message-Id: <1112097210.3691.51.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-29 at 11:07 +0200, Ingo Molnar wrote:
> * Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > I've created a tracing tool several years ago for my master's thesis 
> > against the 2.2 kernel and onto the 2.4 kernel. I'm currently using 
> > this in the 2.6 kernel to debug some customizations against Ingo's RT 
> > kernel.
> 
> neat. It seems there's some overlap with relayfs, which is in -mm 
> currently:
> 
>  http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc1/2.6.12-rc1-mm3/broken-out/relayfs.patch
> 

Thanks Ingo, I didn't know about this. I'll look into it further when I
have more time, and maybe my tools already implement things that need to
be done in here, and I can port them (if they're interested).  I first
wrote this back in 1998 or 1999 and have added on since then. So it is
pretty mature. Unfortunately I still had to clean it up for the post. It
was only for my personal use till someone mentioned to me that I should
share it.

Also, I'm almost done adding the pending owner work against .41-11. I
see you now have 41-13, and if you already implemented it, let me know.
I've been fighting your deadlock detection to make sure it works with
the changes. Then finally I found a race condition that I'm solving.

To have a task take back the ownership, I had the stealer call
task_blocks_on_lock on the task that it stole it from. To get this to
work, when a task is given the pending ownership, it doesn't NULL the
blocked_on at that point (although the waiter->task is set to NULL). But
this gives the race condition in pi_setprio where it checks for
p->blocked_on still exists. Reason is that I don't want the waking up of
a process to call any more locks. To solve this, I had to (and this is
what I don't like right now) add another flag for the process called
PF_BLOCKED. So that this can tell the pi_setprio when to stop. This flag
is set in task_blocks_on_lock and cleared in pick_new_owner where the
setting of blocked_on to NULL use to be.

Unless you already implemented this, I'll have a patch for you to look
at later today, and you can then (if you want) critique it :-)

-- Steve


