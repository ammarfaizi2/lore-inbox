Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932345AbVJKXu0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932345AbVJKXu0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 19:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932364AbVJKXu0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 19:50:26 -0400
Received: from science.horizon.com ([192.35.100.1]:24114 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S932345AbVJKXuZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 19:50:25 -0400
Date: 11 Oct 2005 19:50:17 -0400
Message-ID: <20051011235017.21719.qmail@science.horizon.com>
From: linux@horizon.com
To: dev@sw.ru
Subject: Re: SMP syncronization on AMD processors (broken?)
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The whole story started when we wrote the following code:
> 
> void XXX(void)
> {
> 	/* ints disabled */
> restart:
> 	spin_lock(&lock);
> 	do_something();
> 	if (!flag)
> 		need_restart = 1;
> 	spin_unlock(&lock);
> 	if (need_restart)
> 		goto restart;	<<<< LOOPS 4EVER ON AMD!!!
> }
> 
> void YYY(void)
> {
> 	spin_lock(&lock);	<<<< SPINS 4EVER ON AMD!!!
> 	flag = 1;
> 	spin_unlock(&lock);
> }
> 
> function XXX() starts on CPU0 and begins to loop since flag is not set, 
> then CPU1 calls function YYY() and it turns out that it can't take the 
> lock any arbitrary time.

The right thing to do here is to wait for the flag to be set *outside*
the lock, and then re-validate inside the lock:

void XXX(void)
{
	/* ints disabled */
restart:
	spin_lock(&lock);
	do_something();
	if (!flag)
		need_restart = 1;
	spin_unlock(&lock);
	if (need_restart) {
		while (!flag)
			cpu_relax();
		goto restart;
	}
}

This way, XXX() keeps the lock dropped for as long as it takes for
YYY() to notice and grab it.


However, I realize that this is of course a simplified case of some real
code, where even *finding* the flag requires the spin lock.

The generic solution is to have a global "progress" counter, which
records "I made progress toward setting flag", that XXX() can
busy-loop on:

int progress;

void XXX(void)
{
	int old_progress;
	/* ints disabled */
restart:
	spin_lock(&lock);
	do_something();
	if (!flag) {
		old_progress = progress;
		need_restart = 1;
	}
	spin_unlock(&lock);
	if (need_restart) {
		while (progress == old_progress)
			cpu_relax();
		goto restart;
	}
}

void YYY(void)
{
	spin_lock(&lock);
	flag = 1;
	progress++;
	spin_unlock(&lock);
}

It may be that in your data structure, there is one or a series of
fields that already exist that you can use for the purpose.  The goal
is to merely detect *change*, so you can reacquire the lock and test
definitively.  It's okay to read freed memory while doing this, as long as
you can be sure that:
- The memory read won't oops the kernel, and
- You don't end up depending on the value of the freed memory to
  get you out of the stall.
