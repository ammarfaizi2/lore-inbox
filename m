Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263925AbSIQIzD>; Tue, 17 Sep 2002 04:55:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263926AbSIQIzD>; Tue, 17 Sep 2002 04:55:03 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:56074
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S263925AbSIQIzC>; Tue, 17 Sep 2002 04:55:02 -0400
Subject: Re: [PATCH] BUG(): sched.c: Line 944
From: Robert Love <rml@tech9.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1032250378.969.112.camel@phantasy>
References: <Pine.LNX.4.44.0209162250170.3443-100000@home.transmeta.com> 
	<1032250378.969.112.camel@phantasy>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 17 Sep 2002 04:59:51 -0400
Message-Id: <1032253191.4592.15.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-09-17 at 04:12, Robert Love wrote:

> I implemented exactly what you detailed, with one change: we need to
> check kernel_locked() before setting lock_depth because it is valid to
> exit() while holding the BKL.  Aside from kernel code that does it
> intentionally, crashed code (e.g. modules) would have the same problem.

fsck, this is non-ending... obviously, this is insufficient:
preempt_count will equal two if the BKL was previously held and
in_atomic() will trip.

This should work:

	if (likely(!kernel_locked())
		tsk->lock_depth = -2;
	else {
		/* compensate for BKL; we still cannot preempt */
		preempt_enable_no_resched();
	}

look sane?

Now, remind me why this is all worth it...

	Robert Love

