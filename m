Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265144AbTLCUSD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 15:18:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265158AbTLCUSD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 15:18:03 -0500
Received: from mx1.elte.hu ([157.181.1.137]:9700 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S265144AbTLCUR7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 15:17:59 -0500
Date: Wed, 3 Dec 2003 21:18:00 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Srivatsa Vaddagiri <vatsa@in.ibm.com>, Raj <raju@mailandnews.com>,
       linux-kernel@vger.kernel.org, lhcs-devel@lists.sourceforge.net,
       Manfred Spraul <manfred@colorfullife.com>
Subject: Re: kernel BUG at kernel/exit.c:792!
In-Reply-To: <Pine.LNX.4.58.0312031203430.7406@home.osdl.org>
Message-ID: <Pine.LNX.4.58.0312032110140.5864@earth>
References: <20031203153858.C14999@in.ibm.com> <3FCDCEA3.1020209@mailandnews.com>
 <20031203182319.D14999@in.ibm.com> <Pine.LNX.4.58.0312032059040.4438@earth>
 <Pine.LNX.4.58.0312031203430.7406@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 3 Dec 2003, Linus Torvalds wrote:

> > only the starting point should be checked. If the starting point is wrong
> > then we have no access to the 'thread list' anymore. If the starting point
> > is alive then all the thread-list walking within the tasklist_lock is
> > safe.
> 
> I'm not sure that's true. The starting point is not necessarily the
> thread group leader, and then following the chain can see a zombie
> thread group leader in the _middle_ without a sighandler pointer - at
> which point we BUG() out again.

hm, get_tid_list() is used in proc_task_readdir(), which is
/proc/<TGID>/task/ directory - so proc_task(dir) is a thread group leader
by definition, right?

also, a zombie thread group leader does not mean it's removed from the
thread list - we keep it around hashed just to enable the 'process' to
live along and only release it once the last thread has gone too (by
delaying parent notification up to the last thread has exited).

But this should be irrelevant in this case, i think the crash here is
stale access to the thread leader via /proc/<TGID>, and trying to follow
that non-existent thread list pointer.

	Ingo
