Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751019AbWIYPjd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019AbWIYPjd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 11:39:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751027AbWIYPjd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 11:39:33 -0400
Received: from wr-out-0506.google.com ([64.233.184.236]:58310 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751018AbWIYPjc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 11:39:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WKLNCqP4bt4d5Zah0YOrkM2xe95yHrIx3qp9AH47512JGch2ZD8ZofWMYv5yX5gm3574XKM2klVQ1vT++CSBozJu7iradgHeOUJVLXEOh/neBarM5J6V0IaiifUmGlwg3acaIo1HhbFbqzDs//KUA8c1Qht5BqhAATaz0g6eXAw=
Message-ID: <6d6a94c50609250839y7365e20ale6910e36b0ec9976@mail.gmail.com>
Date: Mon, 25 Sep 2006 23:39:31 +0800
From: Aubrey <aubreylee@gmail.com>
To: "Arnd Bergmann" <arnd@arndb.de>
Subject: Re: [PATCH 1/4] Blackfin: arch patch for 2.6.18
Cc: "Luke Yang" <luke.adi@gmail.com>, linux-kernel@vger.kernel.org,
       "Andrew Morton" <akpm@osdl.org>
In-Reply-To: <200609251126.17494.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <489ecd0c0609202032l1c5540f7t980244e30d134ca0@mail.gmail.com>
	 <200609250854.04470.arnd@arndb.de>
	 <6d6a94c50609250049l75b2f070q81583b90d8fcfaec@mail.gmail.com>
	 <200609251126.17494.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/25/06, Arnd Bergmann <arnd@arndb.de> wrote:
> It's the same problem as why sleep_on() is wrong and wait_event() is
> right, you can find lots of documentation about that.
>
> Think about a process calling nanosleep() to wait for a timeout.
> It eventually ends up going to sleep and the kernel schedules
> the idle task.
>
> The idle task checks need_resched(), which returns false, so it
> will call the idle instruction. Before it gets there, the timer
> tick happens, which calls the timer softirq. That softirq notices
> that the user process should continue running and calls wake_up(),
> which makes the condition for need_resched() true.
>
> Since we're handling that softirq that interrupted the idle task,
> that task continues what it was last doing and calls the idle instruction.
> This is the point where it goes wrong, because your user task should
> run, but the CPU is sleeping until the next interrupt happens.
>
> Note that you should in the future disable timer ticks during the
> idle function (CONFIG_NO_IDLE_HZ or similar) to save more power, but
> in that case the CPU may be in idle indefinitely after missing the
> one interrupt that should have woken it up.
>

I digged into the code and got something different.
Between need_resched() and IDLE instruction, a timer interrupt occurs.
Yes, softirq may not schedule out to run the user task, but the
interrupt handler will.
You can find in our patch, I believe the same behavior is on the ARM/M68K.

1) Timer interrupt will call do_irq(), then return_from_int().

2) return_from_int() will check if there is interrupt pending or
signal pending, if so, it will call schedule_and_signal_from_int().

3) schedule_and_signal_from_int() will jump to resume_userspace()

4) resume_userspace() will call _schedule to run the user task.

So, here is no interrupt latency. The user task will run even between
need_resched() and IDLE instruction.

-Aubrey
