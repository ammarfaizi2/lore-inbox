Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265871AbTFSRzd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 13:55:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265874AbTFSRzc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 13:55:32 -0400
Received: from rj.sgi.com ([192.82.208.96]:6850 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S265871AbTFSRzW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 13:55:22 -0400
Message-ID: <3EF1FC53.2C9C5249@sgi.com>
Date: Thu, 19 Jun 2003 13:09:23 -0500
From: Ray Bryant <raybry@sgi.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Manfred Spraul <manfred@colorfullife.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Bug in __pollwait() can cause select() and poll() tohang in
References: <3EF1E136.40305@colorfullife.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul wrote:
> 
> Hi Ray,
> 
> your bug description seems to be correct, but the fix is wrong:
> If the allocation is for the 2nd page of wait queue heads, then
> "current->state = TASK_INTERRUPTIBLE" can lead to lost wakeups, if an fd
> that is stored in the first page gets ready during the allocation.

Hi Manfred,

Grumble.  :-) Yes, I believe you are correct.

> Setting the state to interruptible is only permitted if a full scan of
> all file descriptors happens before calling schedule(). This is
> expensive and should be avoided.
> 
> The correct fix is current->state = TASK_RUNNING just before calling
> yield() in the rebalance code.

But doesn't this have the same kind of problem?  e. g., just before
calling yield() in the rebalance code we save current->state, set it to
TASK_RUNNING, then restore current->state on return from yield().  If a
fd becomes ready after the call to yield(), and we entered
__alloc_pages() with state TASK_INTERRUPTIBLE, aren't we in exactly the
same situation as described above?

Let me think about this some more.

Thanks,
-- 
Best Regards,
Ray
-----------------------------------------------
                  Ray Bryant
512-453-9679 (work)         512-507-7807 (cell)
raybry@sgi.com             raybry@austin.rr.com
The box said: "Requires Windows 98 or better",
           so I installed Linux.
-----------------------------------------------
