Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261686AbTJMLVX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 07:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261687AbTJMLVW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 07:21:22 -0400
Received: from pentafluge.infradead.org ([213.86.99.235]:56465 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261686AbTJMLVV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 07:21:21 -0400
Subject: Re: [RFC][PATCH] Kernel thread signal handling.
From: David Woodhouse <dwmw2@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20031013040219.6ad71a57.akpm@osdl.org>
References: <1066041096.24015.431.camel@hades.cambridge.redhat.com>
	 <20031013040219.6ad71a57.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1066044079.24015.442.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-2.dwmw2.3) 
Date: Mon, 13 Oct 2003 12:21:19 +0100
Content-Transfer-Encoding: 7bit
X-SA-Exim-Mail-From: dwmw2@infradead.org
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
X-Pentafluge-Mail-From: <dwmw2@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-10-13 at 04:02 -0700, Andrew Morton wrote:
> Sigh.  Using signals to communicate with kernel threads is evil.  It keeps
> on breaking and each site does it differently and we've had plenty of bugs
> due to this practice.

The point in cleaning up allow_signal() et al. is that it gets simple
and it stops breaking. Not that I recall having signal problems with the
JFFS2 garbage collection thread other than this one, mind you.

> Is there no way in which jffs2 can be weaned off this obnoxious habit?

We have a kernel thread which performs garbage collection on our
log-structured file system, to make space ahead of time for writes to
happen. It's purely an optimisation -- we also perform garbage
collection just-in-time in the context of a process which wants to
actually _write_, if there's no free space but some could be made.

This garbage collection involves reading, writing and erasing the flash.
It takes CPU time and power. Sometimes userspace wants it to stop
happening in the background; sometimes userspace wants it to resume
again.

So userspace sends SIGSTOP, SIGCONT and SIGKILL to the garbage
collection thread and all of them have the expected effect. 

Since we handle these signals anyway, the normal wakeup of the GC thread
when the amount of free space changes is also done by SIGHUP, which
userspace can also send to trigger a single pass.

I don't any the benefit in changing this practice.

-- 
dwmw2

