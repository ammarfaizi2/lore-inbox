Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266175AbUIEDs5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266175AbUIEDs5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 23:48:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266181AbUIEDs5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 23:48:57 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:16807 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S266175AbUIEDsx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 23:48:53 -0400
Date: Sat, 4 Sep 2004 20:48:50 -0700
From: Paul Jackson <pj@sgi.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: ak@muc.de, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix argument checking in sched_setaffinity
Message-Id: <20040904204850.48b7cfbd.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.58.0409041827280.2331@ppc970.osdl.org>
References: <m3zn4bidlx.fsf@averell.firstfloor.org>
	<20040831183655.58d784a3.pj@sgi.com>
	<20040904133701.GE33964@muc.de>
	<20040904171417.67649169.pj@sgi.com>
	<Pine.LNX.4.58.0409041717230.4735@ppc970.osdl.org>
	<20040904180548.2dcdd488.pj@sgi.com>
	<Pine.LNX.4.58.0409041827280.2331@ppc970.osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus wrote:
>	/* We just assume that 8k CPU's aren't going to happen */

SGI doesn't so assume ;).


> but it's just a lot easier to do the "getaffinity" thing - if it fails,
> you can double the size of your buffer and try again. O(log(n)) rather
> than O(n) ;)

I agree.  That's what my cpumask sizing loop does.

Well ... did.

Now it reads /sys/devices/system/node/node0/cpumap and computes the
size of the cpumask as an arithmetic function of the number of bytes
read (the ascii format uses 9 chars for each 32 bits of mask).

Either way works ...

My nodemask sizing code loops on get_mempolicy() calls of increasing
size, until they stop failing -EINVAL.


> Well, historically we _have_ required sizes to match.

I'm not sure what history you're looking at here, Linus.

Last weeks sys_sched_setaffinity didn't seem to require matching size,
only that user size is >= kernel size.  The kernel ignored the extra
user bits.

For nodemask_t, well let me just say the mbind/mempolicy calls are different.

If we want to go in the direction of requiring sizes to match in the
'set' calls, then instead of this weeks changes to sys_sched_setaffinity
allowing user size < kernel size, shouldn't we be going the other way,
and tightening the check in kernel/sched.c:sys_sched_setaffinity(), from
what it was a week ago:

        if (len < sizeof(new_mask))
                return -EINVAL;

to:

        if (len != sizeof(new_mask))
                return -EINVAL;

Or at least reverting this last weeks changes back to the '<' check?


> I don't know how to sanely expose the damn things

How about:

	$ cd /proc/sys/kernel
	$ head sizeof*
	==> sizeof_cpumask <==
	64

	==> sizeof_nodemask <==
	32

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
