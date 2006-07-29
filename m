Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932073AbWG2HxG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932073AbWG2HxG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 03:53:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932580AbWG2HxG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 03:53:06 -0400
Received: from science.horizon.com ([192.35.100.1]:38472 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S932073AbWG2HxE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 03:53:04 -0400
Date: 29 Jul 2006 02:56:12 -0400
Message-ID: <20060729065612.8661.qmail@science.horizon.com>
From: linux@horizon.com
To: linux-kernel@vger.kernel.org, tytso@mit.edu
Subject: Re: A better interface, perhaps: a timed signal flag
Cc: linux@horizon.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If we had such an interface, then the application would look like
> this:
> 
>	volatile int	flag = 0;
>
>	register_timout(&time_val, &flag);
>	while (work to do) {
>		do_a_bit_of_work();
>		if (flag)
>			break;
>	}
>
> Finally, a note about tickless designs.  Very often such applications
> don't need a constantly ticking design.  For example, the X server
> only needs to have the memory location incremented while it is
> processing events; if the laptop is idle, there's no reason to have
> the RTC generating interrupts and incrementing memory locations.
> Similarly, the Metronome garbage collector would only need to poll to
> see if the timeout has expired while the garbage collector is running,
> which is _not_ all of the time.  
> 
> Yes, you could use ioctl's to start and stop the RTC interrupt
> handler, but that's just ugly, and points out that maybe the interface
> should not be one of programming the RTC interrupt frequency directly,
> but rather one of "increment this flag after X units of
> (CPU/wallclock) time, and I don't care how it is implemented at the
> hardware level."

Actually, unless you want the kernel to have to poll the timeout_flag
periodically, it's more like:

	volatile bool	timeout_flag = false, armed_flag = false;

	register_timout(&time_val, &flag);
	while (work to do) {
		if (!armed_flag) {
			rearm_timeout();
			armed_flag = true;
		}
		do_a_bit_of_work();
		if (timeout_flag) {
			armed_flag = false;
			timeout_flag = false;
			break;
		}
	}

Personally, I use setitimer() for this.  You can maintain the flags in
software, and be slightly lazy about disarming it.  If you get a signal
while you shouldn't be armed, *then* disarm the timer in the kernel.
Likewise, when rearming, set the user-disarmed flag and chec if kernel-level
rearming is required.

volatile bool timeout_flag = false, armed_flag = false, sys_armed_flag = false;

void
sigalrm(int sig)
{
	(void)sig;
	if (!armed_flag) {
		static const struct itimerval it_zero = {{0,0},{0,0}};
		if (sys_armed_flag)
			warn_unexpected_sigalrm();
		setitimer(ITIMER_REAL, &it_zero, 0);
		
	} else if (timeout_flag)
		warn_gc_is_slow();
	else
		timeout_flag = true;
}

void
arm_timer()
{
	static const struct itimerval it_interval = { time_val, time_val };

	armed_flag = true;
	if (!sys_armed_flag) {
		setitimer(ITIMER_REAL, &it_interval, 0);
		sys_armed_flag = true;
	}
}

main_loop()
{
	signal(SIGALRM, sigalrm);

	while (work to do) {
		arm_timer();
		do_a_bit_of_work();
		if (timeout_flag) {
			gc();
			armed_flag = false;
			timeout_flag = false;
		}
	}
}

... where only do_a_bit_of_work can prompt the need for more gc() calls.
This really tries to minimize the number of system calls.
