Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262034AbTKGWZK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 17:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262030AbTKGWYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:24:54 -0500
Received: from mx1.elte.hu ([157.181.1.137]:46826 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S264395AbTKGPRi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 10:17:38 -0500
Date: Fri, 7 Nov 2003 16:17:29 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Mark Gross <mgross@linux.co.intel.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] SMP signal latency fix up.
In-Reply-To: <Pine.LNX.4.44.0311070701370.1842-100000@home.osdl.org>
Message-ID: <Pine.LNX.4.56.0311071610320.29925@earth>
References: <Pine.LNX.4.44.0311070701370.1842-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 7 Nov 2003, Linus Torvalds wrote:

> (It _looks_ obvious enough, but can you check that there are no pointers
> that we might be following in the "is it running" checks that could be
> stale because we don't hold the runqueue lock any more).

the 'is it running' check is 'task_curr(p)', which in this circumstance is
equivalent to the following test:

	per_cpu(runqueues, (cpu)).curr == p

where 'cpu' is p->thread_info->cpu. All pointers dereferenced in this test
are stable, because 1) send_signal() is always called within the siglock,
which serializes with task exit 2) p->thread_info->cpu is always valid for
the same reason.

so this seems to be safe to me.

	Ingo
