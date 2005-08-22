Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750747AbVHVTpl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbVHVTpl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 15:45:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbVHVTpl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 15:45:41 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:21755 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750747AbVHVTpk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 15:45:40 -0400
Subject: [RFC] RT-patch update to remove the global pi_lock
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Karsten Wiese <annabellesgarden@yahoo.de>, dwalker@mvista.com,
       george anzinger <george@mvista.com>, Adrian Bunk <bunk@stusta.de>,
       Sven-Thorsten Dietrich <sven@mvista.com>,
       LKML <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <1124739657.5809.6.camel@localhost.localdomain>
References: <1124295214.5764.163.camel@localhost.localdomain>
	 <20050817162324.GA24495@elte.hu>
	 <1124323379.5186.18.camel@localhost.localdomain>
	 <1124333050.5186.24.camel@localhost.localdomain>
	 <20050822075012.GB19386@elte.hu>
	 <1124704837.5208.22.camel@localhost.localdomain>
	 <20050822101632.GA28803@elte.hu>
	 <1124710309.5208.30.camel@localhost.localdomain>
	 <20050822113858.GA1160@elte.hu>
	 <1124715755.5647.4.camel@localhost.localdomain>
	 <20050822183355.GB13888@elte.hu>
	 <1124739657.5809.6.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Mon, 22 Aug 2005 15:44:55 -0400
Message-Id: <1124739895.5809.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-08-22 at 20:33 +0200, Ingo Molnar wrote:

> any ideas how to get rid of pi_lock altogether?

I've toyed with the idea of adding another raw_spin_lock to the mutex. A
lock specific pi_lock.   Instead of grabbing a global pi_lock, grab the
pi_lock of a lock.  To modify any lock w.r.t PI, you must first grab all
the lock's pi_locks being referenced.

The idea stems from the fact that the kernel must order its taking of
locks to prevent deadlocks.  This way the order of locks that are taken
are also always in order. 

So if you have the following case:

P1 blocked_on L1 owned_by P2 blocked_on L2 owned_by P3 ...

The L1, L2, L3 ... must always be in the same order, otherwise the
kernel itself can have a deadlock.

OK, let me prove this (for myself as well ;-)

Lets go by contradiction.

If we assume that the locks _can_ be in different orders and that no
deadlock would result.

So we could have:

P1 blocked_on L1 owned_by P2 ... blocked on Ln owned_by Pn+1

According to our assumtion, there can exist another list here where

Lx owned_by Px+1 ... blocked_on Ly owned by Py+1 

where y < x <= n  and 1 <= y < x

This means that there exists a process that owns Lx and is blocked on a
lock Ly, and also this means that there's some process that owns Ly is
blocked on Lx. This is a deadlock!

So knowing that this list of locks will always be in the same order,
than there must be someway to capitalize on that and take just the locks
of the locks used instead of a global one.

I haven't fully looked into this idea, but there might be something to
it.  I'm sure it will be complex, and perhaps slow things down on a 2x
system. But it should be scalable, since you are only taking locks that
are being used, and not a global one.

What do you guys think? 

-- Steve

