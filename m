Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267435AbSLSAzH>; Wed, 18 Dec 2002 19:55:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267436AbSLSAzH>; Wed, 18 Dec 2002 19:55:07 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:59909
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S267435AbSLSAzG>; Wed, 18 Dec 2002 19:55:06 -0500
Subject: RE: [PATCH 2.5.52] Use __set_current_state() instead of current->
	state = (take 1)
From: Robert Love <rml@tech9.net>
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
Cc: torvalds@transmeta.org, linux-kernel@vger.kernel.org
In-Reply-To: <A46BBDB345A7D5118EC90002A5072C7806CACA2A@orsmsx116.jf.intel.com>
References: <A46BBDB345A7D5118EC90002A5072C7806CACA2A@orsmsx116.jf.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1040259792.6857.93.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 18 Dec 2002 20:03:13 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-12-18 at 19:46, Perez-Gonzalez, Inaky wrote:

> > Some of these should probably be set_current_state().  I 
> > realize the current code is equivalent to __set_current_state()
> > but it might as well be done right.
> 
> Agreed; however, I also don't want to introduce unnecessary
> bloat, so I need to understand first what cases need it - it
> is kind of hard for me. Care to let me know some gotchas?

set_current_state() includes a write barrier to ensure the setting of
the state is flushed before any further instructions.  This is to
provide a memory barrier for weak-ordering processors that can and will
rearrange the writes.

Not all processors like those made by your employer are strongly-ordered
:)

Anyhow, the problem is when the setting of the state is set to
TASK_INTERRUPTIBLE or TASK_UNINTERRUPTIBLE.  In those cases, it may be
possible for the state to actually be flushed to memory AFTER the wake
up event has occurred.

So you have code like this:

	__set_current_state(TASK_INTERRUPTIBLE);
	add_waitqueue(...);

but the processor ends up storing the current->state write after the
task is added to the waitqueue.  In between those events, the wake up
event occurs and the task is woken up.  Then the write to current->state
is flushed.  So you end up with:

	add_waitqueue(...);
	interrupt or whatever occurs and wakes up the wait queue
	task is now woken up and running
	current->state = TASK_INTERRUPTIBLE /* BOOM! */

the task is marked sleeping now, but its wait event has already occurred
-- its in for a long sleep...

So to ensure the write is flushed then and there, and that the processor
(or compile, but we do not really worry about it because the call to
add_waitqueue will act as a compiler barrier, for example) does not move
the write to after the potential wake up, we use the write barrier.

In short, set_current_state() uses a memory barrier to ensure the state
setting occurs before any potential wake up activity, eliminating a
potential race and process deadlock.

It sounds complicated but its pretty simple... my explanation was
probably way too long - better than any I have seen here before on why
we have these things, at least.  Hope it helps.

If in doubt, just make all of them set_current_state().  That is the
standard API, and its at least safe.

	Robert Love

