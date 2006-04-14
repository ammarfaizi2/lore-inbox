Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751306AbWDNRUh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306AbWDNRUh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 13:20:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbWDNRUh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 13:20:37 -0400
Received: from colo.khms.westfalen.de ([213.239.196.208]:2280 "EHLO
	colo.khms.westfalen.de") by vger.kernel.org with ESMTP
	id S1751306AbWDNRUg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 13:20:36 -0400
Date: 14 Apr 2006 11:14:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <9rqIJOPHw-B@khms.westfalen.de>
In-Reply-To: <616k2-6Xz-27@gated-at.bofh.it>
Subject: Re: PROBLEM: pthread-safety bug in write(2) on Linux 2.6.x
X-Mailer: CrossPoint v3.12d.kh15 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
References: <60Z8f-4QA-25@gated-at.bofh.it> <611Wl-u5-1@gated-at.bofh.it> <616k2-6Xz-27@gated-at.bofh.it>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bonachead@comcast.net (Dan Bonachea)  wrote on 13.04.06 in <616k2-6Xz-27@gated-at.bofh.it>:

> At 09:46 PM 4/12/2006, Andrew Morton wrote:
> >Locking for file.f_pos is generally file->f_dentry->d_inode->i_mutex.  We
> >could use that if we were to restructure the code a lot.  Or we could add a
> >new lock to `struct file'.
> >
> >Or we could do nothing, because a) the application is going to produce
> >inderterminate output anyway and b) because it only affects silly testcases
> >and not real-world apps.
> >
> >OK, there _might_ be a real-world case: threads appending logging
> >information to a flat file.  Trivially workable-around with a userspace
> >lock, or by switching to stdio (same thing).
> >
> >Yes, really we should fix it.  But it's not worth adding more overhead to
> >do so.  So the fix would involve widespread (but simple) change, to draw
> >that f_pos update inside i_mutex.
>
> Hi Andrew - thanks for the detailed response.
>
> I don't know enough about the kernel implementation to comment on your
> proposed fixes.
>
> However, I should clarify that this problem definitely affects more than
> just "silly testcases", and the fact that a program generates
> non-deterministically ordered output does not necessarily make it erroneous,
> invalid or unuseful.
>
> This problem arose in the parallel runtime system for a scientific language
> compiler (nearly a million lines of code total - definitely a "real-world"
> program) - the example code is merely a pared-down demonstration of the
> problem. In parallel scientific computing, it's very common for many threads
> to be writing to stdout (usually for monitoring purposes) and it's expected
> and normal for output from separate threads to be arbitrarily interleaved,
> but it's *not* ok for output to be lost entirely. This is essentially
> equivalent to the real-world example you gave of many threads logging to a
> file.
>
> We've worked around the problem in Linux 2.6 by adding locking at user-level
> around our writes, as you suggest, although this of course penalizes our
> performance on kernels that already correctly implement the thread-safety
> required by the POSIX spec. In any case it seemed like a problem that we
> should report, to be good open-source citizens - especially given that it
> appears to be a regression with respect to the Linux 2.4 kernel. How you
> choose to handle the report is of course your decision.

So, considering the rest of the thread, shouldn't it be enough to simply  
use O_APPEND for that use case - and, for that matter, isn't using  
O_APPEND actually completely natural there, and isn't that (modulo the  
process-thread difference) exactly what O_APPEND was invented for?

MfG Kai
