Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750767AbWIYJ00@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbWIYJ00 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 05:26:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750787AbWIYJ00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 05:26:26 -0400
Received: from [212.227.126.177] ([212.227.126.177]:62186 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1750767AbWIYJ0Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 05:26:25 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Aubrey <aubreylee@gmail.com>
Subject: Re: [PATCH 1/4] Blackfin: arch patch for 2.6.18
Date: Mon, 25 Sep 2006 11:26:17 +0200
User-Agent: KMail/1.9.4
Cc: "Luke Yang" <luke.adi@gmail.com>, linux-kernel@vger.kernel.org,
       "Andrew Morton" <akpm@osdl.org>
References: <489ecd0c0609202032l1c5540f7t980244e30d134ca0@mail.gmail.com> <200609250854.04470.arnd@arndb.de> <6d6a94c50609250049l75b2f070q81583b90d8fcfaec@mail.gmail.com>
In-Reply-To: <6d6a94c50609250049l75b2f070q81583b90d8fcfaec@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609251126.17494.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 25 September 2006 09:49, Aubrey wrote:
> Oh, sorry for my unclear description, any of the peripherals can be configured
> to wake up the core from its idled state to process the interrupt on
> Blackfin. I should say __if no other interrupts__ here is the timer
> interrupt waking up the processor every one jiffy.

And that works if interrupts are disabled as it should?

> I don't understand if interrupt occurs between need_resched() and the
> idle instruction, what will become the racy object? Can you comment it
> detailed? thanks.

It's the same problem as why sleep_on() is wrong and wait_event() is
right, you can find lots of documentation about that.

Think about a process calling nanosleep() to wait for a timeout.
It eventually ends up going to sleep and the kernel schedules
the idle task.

The idle task checks need_resched(), which returns false, so it
will call the idle instruction. Before it gets there, the timer
tick happens, which calls the timer softirq. That softirq notices
that the user process should continue running and calls wake_up(),
which makes the condition for need_resched() true.

Since we're handling that softirq that interrupted the idle task,
that task continues what it was last doing and calls the idle instruction.
This is the point where it goes wrong, because your user task should
run, but the CPU is sleeping until the next interrupt happens.

Note that you should in the future disable timer ticks during the
idle function (CONFIG_NO_IDLE_HZ or similar) to save more power, but
in that case the CPU may be in idle indefinitely after missing the
one interrupt that should have woken it up.

	Arnd <><
