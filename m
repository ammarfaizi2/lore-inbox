Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262016AbTFBHw6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 03:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262023AbTFBHw6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 03:52:58 -0400
Received: from mx1.elte.hu ([157.181.1.137]:56298 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262016AbTFBHwz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 03:52:55 -0400
Date: Mon, 2 Jun 2003 10:05:49 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Mike Galbraith <efault@gmx.de>
Cc: Bill Davidsen <davidsen@tmr.com>, Olivier Galibert <galibert@pobox.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-ia64] Re: web page on O(1) scheduler
In-Reply-To: <5.2.0.9.2.20030529062657.01fcaa50@pop.gmx.net>
Message-ID: <Pine.LNX.4.44.0306020949520.3375-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 29 May 2003, Mike Galbraith wrote:

> [...] What makes more sense to me than the current implementation is to
> rotate the entire peer queue when a thread expires... ie pull in the
> head of the expired queue into the tail of the active queue at the same
> time so you always have a player if one exists.  (you'd have to select
> queues based on used cpu time to make that work right though)

we have tried all sorts of more complex yield() schemes before - they
sucked for one or another workload. So in 2.5 i took the following path:  
make yield() _simple_ and effective, ie. expire the yielding task (push it
down the runqueue roughly halfway, statistically) and dont try to be too
smart doing it. All the real yield() users (mostly in the kernel) want it
to be an efficient way to avoid livelocks. The old 2.4 yield
implementation had the problem of enabling a ping-pong between two
higher-prio yielding processes, until they use up their full timeslice.

(we could do one more thing that still keeps the thing simple: we could
re-set the yielding task's timeslice instead of the current 'keep the
previous timeslice' logic.)

OpenOffice used to use yield() as a legacy of 'green thread'
implementation - where userspace threads needed to do periodic yield()s to
get any sort of multitasking behavior.

	Ingo

