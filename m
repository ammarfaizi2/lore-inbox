Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261696AbTJMLzN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 07:55:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261699AbTJMLzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 07:55:13 -0400
Received: from pentafluge.infradead.org ([213.86.99.235]:6038 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261696AbTJMLzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 07:55:07 -0400
Subject: Re: [RFC][PATCH] Kernel thread signal handling.
From: David Woodhouse <dwmw2@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20031013044042.23ab7f69.akpm@osdl.org>
References: <1066041096.24015.431.camel@hades.cambridge.redhat.com>
	 <20031013040219.6ad71a57.akpm@osdl.org>
	 <1066044079.24015.442.camel@hades.cambridge.redhat.com>
	 <20031013044042.23ab7f69.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1066046102.14783.11.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-2.dwmw2.3) 
Date: Mon, 13 Oct 2003 12:55:03 +0100
Content-Transfer-Encoding: 7bit
X-SA-Exim-Mail-From: dwmw2@infradead.org
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
X-Pentafluge-Mail-From: <dwmw2@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-10-13 at 04:40 -0700, Andrew Morton wrote:
> People think "I need to send a message to a kernel thread" and then,
> immediately, "ah-hah!  I'll use a signal!"

I've seen relatively little of this. Most of the problems I've been
aware of have been kernel threads _not_ handling signals (or handling
only SIGKILL) and going into endless loops of bouncing straight back out
of schedule().

That problem is almost unrelated -- it happens because driver writes
want to sleep in TASK_INTERRUPTIBLE state rather than
TASK_UNINTERRUPTIBLE. The fix for that is to have a per-task 
'uninterruptible_count' along much the same lines as preempt_count,
where each function which is unable to handle an -EINTR return
increments the count before calling down to another function which may
have done that. But that's a 2.7 thing and mostly not related to this
particular bug.

> Sounds like the GC should have been performed by a userspace process in the
> first place?

Well, it would have to actually be done in kernel space but I suppose
there could be an ioctl or syscall or something which causes a call to
jffs2_garbage_collect_pass() to happen in the context of the caller, and
the variables which are used to decide when to wake up could be exposed
to userspace via sysfs, and the userspace daemon itself could register
with the JFFS2 code so that it gets woken when those variables change...
or maybe I could poll() on the sysfs file which contains them I
suppose... 

Er, no :)

> How does userspace identify the JFFS2 process to which to send the
> signal?

	daemonize("jffs2_gcd_mtd%d", c->mtd->index);

> > I don't any the benefit in changing this practice.
> 
> Well I know I'm going to lose this one, but at least I get to bitch about
> stuff.

Fair enough :)

Bitching accomplished; now can we fix the bug?

-- 
dwmw2

