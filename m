Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266543AbUJFAeG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266543AbUJFAeG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 20:34:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266538AbUJFAeF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 20:34:05 -0400
Received: from mx1.redhat.com ([66.187.233.31]:21464 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266519AbUJFAdv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 20:33:51 -0400
Date: Tue, 5 Oct 2004 17:33:35 -0700
Message-Id: <200410060033.i960XZ0S007852@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
X-Fcc: ~/Mail/linus
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ulrich Drepper <drepper@redhat.com>,
       Christoph Lameter <clameter@sgi.com>
Subject: Re: [PATCH] CPU time clock support in clock_* syscalls
In-Reply-To: Nick Piggin's message of  Wednesday, 6 October 2004 09:18:10 +1000 <41632BB2.6000202@yahoo.com.au>
X-Windows: a moment of convenience, a lifetime of regret.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It seemed like a syscall could read the values from a task currently
> running on another CPU. If not, great.

Indeed it can.  And yes, there is no locking against updates for this.  For
sched_time on 32-bit platforms, there is the possibility it could be read
during an update and give a bogus value if the high half is updated before
the low half.  Since there are no guarantees about accuracy, period, I
decided not to worry about such an anomaly.  Perhaps it would be better to
do something about this, but AFAIK nothing perfect can be done without
adding more words to task_struct (e.g. seqcount).  I don't know if the
nature of SMP cache behavior makes something like:

	do {
		sample = p->sched_time;
	} while (p->sched_time != sample);

sufficient.  That would certainly be easy to do.


Thanks,
Roland
