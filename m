Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263564AbTIBGnR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 02:43:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263569AbTIBGnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 02:43:17 -0400
Received: from mx2.elte.hu ([157.181.151.9]:18862 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S263564AbTIBGnO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 02:43:14 -0400
Date: Tue, 2 Sep 2003 08:33:50 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Tejun Huh <tejun@aratech.co.kr>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@digeo.com>
Subject: Re: [PATCH] Race condition in del_timer_sync (2.5)
In-Reply-To: <20030902025927.GA12121@atj.dyndns.org>
Message-ID: <Pine.LNX.4.56.0309020820330.3654@localhost.localdomain>
References: <20030902025927.GA12121@atj.dyndns.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 2 Sep 2003, Tejun Huh wrote:

>  This patch fixes a race between del_timer_sync and recursive timers.
> Current implementation allows the value of timer->base that is used for
> timer_pending test to be fetched before finishing running_timer test, so
> it's possible for a recursive time to be pending after del_timer_sync.  
> Adding smp_rmb before timer_pending removes the race.

good catch. Have you ever trigger this bug, or did you find it via code
review?

just to explore the scope of this problem a bit more: at first glance all
other timer_pending() uses seem to be safe. del_timer_sync()'s
timer_pending() use is special, because it's next to the ->running_timer
check without any barriers inbetween - so we could indeed in theory end up
with having the two reads reordered and a freshly added timer (on another
CPU) not being recognized properly. Also, this is the only timer API call
that guarantees the complete stopping of a timer.

	Ingo
