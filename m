Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261178AbTEHFk2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 01:40:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261181AbTEHFk2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 01:40:28 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:24139 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S261178AbTEHFk1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 01:40:27 -0400
Date: Wed, 7 May 2003 22:53:10 -0700
From: Andrew Morton <akpm@digeo.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: ak@muc.de, linux-kernel@vger.kernel.org, rddunlap@osdl.org
Subject: Re: garbled oopsen
Message-Id: <20030507225310.609ae215.akpm@digeo.com>
In-Reply-To: <23400000.1052364724@[10.10.2.4]>
References: <20030508011013$3d80@gated-at.bofh.it>
	<20030508015008$481c@gated-at.bofh.it>
	<m34r46dufb.fsf@averell.firstfloor.org>
	<23400000.1052364724@[10.10.2.4]>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 May 2003 05:52:57.0821 (UTC) FILETIME=[139888D0:01C31526]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> wrote:
>
> >>> Can these be cleaned up in any reasonable way?
> >> 
> >> It needs some additional spinlock in there.  People have moaned for over a
> >> year, patches have been floating about but nobody has taken the time to
> >> finish one off and submit it.
> > 
> > I considered it for x86-64 and even implemented it, but never submitted
> > in fear of deadlocks e.g. when an oops recurses. For this a 
> > spinlock_timeout() would be useful. Print anyways when you cannot get the
> > lock in a second or two.
> 
> The trouble is that the subsystems you want may be broken (eg timers).
> IMHO it's better to just spew whatever you can (the current crap) ... 
> wait a couple of seconds, then have another go at doing it properly.

A recursive oops is easy enough to detect anyway.

	preempt_disable();
	if (oops_cpu == -1 || oops_cpu != smp_processor_id()) {
		_raw_spin_lock(&oops_lock);
		oops_cpu = smp_processor_id();
	}
	<current stuff>
	oops_cpu = -1;
	spin_lock_init(&oops_lock);
	preempt_enable();

or something like that.

> That way people can't complain it's worse than it is now in any way ;-)

Too many complaints, too few unified diffs on this one.

