Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262323AbTKIKQQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 05:16:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262324AbTKIKQQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 05:16:16 -0500
Received: from fw.osdl.org ([65.172.181.6]:39060 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262323AbTKIKQO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 05:16:14 -0500
Date: Sun, 9 Nov 2003 02:19:43 -0800
From: Andrew Morton <akpm@osdl.org>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: prepare_wait / finish_wait question
Message-Id: <20031109021943.470fc601.akpm@osdl.org>
In-Reply-To: <3FAE0223.7070402@colorfullife.com>
References: <3FAE0223.7070402@colorfullife.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul <manfred@colorfullife.com> wrote:
>
> Hi Ingo,
> 
> sysv semaphores show the same problem you've fixed for wait queue with 
> finish_wait:

Was me, actually.

> one thread wakes up a blocked thread and must hold a spinlock for the 
> wakeup. The blocked thread immediately tries to acquire that spinlock, 
> because it must figure out what happened. Result: noticable cache line 
> trashing on an 4xXeon with postgres.
> autoremove_wake_function first calls wake_up, then list_del_init. Did 
> you test that the woken up thread is not too fast and acquires the 
> spinlock before list_del_init had a chance to reset the list?

No, I didn't instrument it.  But profiling showed that it was working as
desired.  The workload was tons of disk I/O, showing significant CPU time
in the page lock/unlock functions.

It would be neater to remove the task from the list _before_ waking it up. 
The current code in there is careful to only remove the task if the wakeup
attempt was successful, but I have a feeling that this is unnecessary - the
waiting task will do the right thing.  One would need to think about that a
bit more.

> I wrote a patch for sysv sem and on a 4x Pentium 3, 99.9% of the calls 
> hit the fast path, but I'm a bit afraid that monitor/mwait could be so 
> fast that the fast path is not chosen.

Is it not the case that ia32's reschedule IPI is async?  If the
architecture's reschedule uses a synchronous IPI then it could indeed be
the case that the woken CPU gets there first.

> I'm thinking about a two-stage algorithm - what's your opinion?

Instrumentation on other architectures would be interesting.
