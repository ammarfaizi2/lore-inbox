Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263094AbTJKQO0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 12:14:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263108AbTJKQOZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 12:14:25 -0400
Received: from mx1.elte.hu ([157.181.1.137]:27619 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S263094AbTJKQOY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 12:14:24 -0400
Date: Sat, 11 Oct 2003 17:49:07 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch] SMP races in the timer code, timer-fix-2.6.0-test7-A0
In-Reply-To: <3F881B46.6070301@colorfullife.com>
Message-ID: <Pine.LNX.4.56.0310111713440.8641@earth>
References: <3F881B46.6070301@colorfullife.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 11 Oct 2003, Manfred Spraul wrote:

> What about moving the "timer running" information into the timer_list,
> instead of keeping it in the base? For example base=0 means neither
> running nor pending. base=1 means running, but not pending, and pointers
> mean pending on the given base.
> 
> This would allow an atomic test without the brute force locking.

it's not so simple. Firstly, it would burden some of the other timer
codepaths with extra logic. (mod/add/del_timer) Secondly, the use of
timer->base is closely controlled, and it's not that simple to clear the
value of '1' from timer->base after the timer has run. [this could race
with any other CPU.]

it would be much cleaner to add another timer->running field, especially
since this would be the 8th word-sized field in struct timer_list, making
it a nice round structure size.

btw., there's a third type of timer race we have. If a timer function is
delayed by more than 1 timer tick [which could happen under eg. UML], then
it's possible for the timer function to run on another CPU in parallel to
the already executing timer function.

	Ingo
