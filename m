Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267678AbRGZME1>; Thu, 26 Jul 2001 08:04:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267739AbRGZMER>; Thu, 26 Jul 2001 08:04:17 -0400
Received: from chiara.elte.hu ([157.181.150.200]:51461 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S267678AbRGZMEI>;
	Thu, 26 Jul 2001 08:04:08 -0400
Date: Thu, 26 Jul 2001 14:01:31 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: <tpepper@vato.org>
Cc: <corbet-lk@lwn.net>, <linux-kernel@vger.kernel.org>
Subject: Re: TASK_EXCLUSIVE?
In-Reply-To: <20010725192533.A17850@cb.vato.org>
Message-ID: <Pine.LNX.4.33.0107261341010.3796-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


On Wed, 25 Jul 2001 tpepper@vato.org wrote:

> I was reading through the new edition of Linux Device Drivers and
> decided to try the TASK_EXCLUSIVE flag to get a single member of a
> wait queue to wake.  I get a compile error though that it is
> undeclared.  Grepping the kernel source came up with nothing.

the 2.4 waitqueue interface has changed as part of the wake-some semantics
introduced for the block-IO-scheduler changes. Wake-some is more generic
than wake-one. The new way to add a wake-some task to a waitqueue is to
use the add_wait_queue_exclusive() function. To add a 'wake-all' task you
should use the well-known add_wait_queue() function.

TASK_EXCLUSIVE was an interim implementation that supported wake-one only.
The new implementation enables a task to be on multiple waitqueues with
different wake-up semantics, because there is now a per-waitqueue-entry
attribute, not a per-task (and thus global) attribute for wake-some
semantics.

When a wake_up_nr(N) wakeup event comes, all wake-all tasks will be woken
up, and 'N' wake-some tasks. The 'old' wake_up() function is
wake_up_nr(1). Wake-one is a special case of wake-some, where N = 1. There
is also a new wake_up_all() function that wakes up all tasks disregarding
their wake-up attribute, including all wake-some tasks.

current usage of these interfaces: most places in the kernel use wake_up()
and use wake-all tasks - like they did for years. 'Old' code that does not
need to optimize waitqueue behavior behaves in the expected way.
Networking, the semaphore code, the pagecache locking code and some other
places uses wake-one waitqueues. Certain parts of networking use a mixed
waitqueue with wake-some and wake-all tasks. The block IO scheduler uses
wake-some to signal the completion of multiple IO slots. wake_up_all() is
used in a couple of places as well, like TUX [ :-) ], to eg. deregister
all wake-one worker threads with a single call.

	Ingo

