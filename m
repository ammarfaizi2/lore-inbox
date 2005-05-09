Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263028AbVEIC4L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263028AbVEIC4L (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 22:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263029AbVEIC4K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 22:56:10 -0400
Received: from mx1.liv.ac.uk ([138.253.100.179]:456 "EHLO mx1.liv.ac.uk")
	by vger.kernel.org with ESMTP id S263028AbVEICzo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 22:55:44 -0400
From: "A.M. Fradley" <u2amf@csc.liv.ac.uk>
Message-ID: <1115607333.427ed12531f96@cgi.server.csc.liv.ac.uk>
Date: Mon,  9 May 2005 03:55:33 +0100
To: kernelnewbies@nl.linux.org, linux-kernel@vger.kernel.org
Subject: An attempt to improve the swap tokening:
References: <1113667425.426137617423a@cgi.server.csc.liv.ac.uk>  <1113732924.17394.27.camel@laptopd505.fenrus.org>  <1113743431.426260479a513@cgi.server.csc.liv.ac.uk>  <1113744260.17394.44.camel@laptopd505.fenrus.org>  <1113750155.42627a8bd5fda@cgi.server.csc.liv.ac.uk> <1113751757.17394.57.camel@laptopd505.fenrus.org> <1113952994.426592e247157@cgi.server.csc.liv.ac.uk> <Pine.LNX.4.61L.0504202325570.7722@imladris.surriel.com> <Pine.LNX.4.61L.0504212238330.13021@imladris.surriel.com> <1114612337.426fa2712d414@cgi.server.csc.liv.ac.uk> <Pine.LNX.4.61L.0504271322280.13884@imladris.surriel.com> <1114676760.42709e18b0227@cgi.server.csc.liv.ac.uk> <Pine.LNX.4.61L.0504281549130.26165@imladris.surriel.com> <1115052944.42765b90ba515@cgi.server.csc.liv.ac.uk> <Pine.LNX.4.61L.0505021638110.31547@imladris.surriel.com> <1115101782.42771a56e4b81@cgi.server.csc.liv.ac.uk> <Pine.LNX.4.61L.0505031136470.2760@imladris.surriel.com> <1115216727.4278db57baad5@cgi.server.csc.liv.ac.uk>
In-Reply-To: <1115216727.4278db57baad5@cgi.server.csc.liv.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.2
X-Originating-IP: 138.253.163.94
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'd been trying to reduce the amount of page swapping in order to improve the
kernels behaviour during thrashing as a project for my course.  I made this
after Arjan van de Ven and Rik van Riel suggested I looked into the swap
tokening mechanism as part of my research.  I came up with a function to
measure the swap rate and then to activate/deactivate the token mechanism
depending on how much swapping was being done overall.  I think the statistics
I added to the thrash.c file could help it decide how to behave but I'm unsure
how best to use them to do that.

I've tried testing it a few different ways
but none of them seem to make any difference.  I think this is because of my
tests though.  I made one program that allocates a linked list, until it is
128MB long, then once it's done that, it should swap in the oldest page in
order to free the memory and then swap the newest one back in to edit the
pointer to the next node then continue for 2 mins.  Then to test how much
progress is made
during the thrashing, I've been running a simple counter program that stops
after minute and I've been comparing the max number reached for the different
attempts I've been making with the kernel.  The program for causing thrashing
at least makes it swap pages because I can watch the memory and swap fill up in
system monitor.  Running the program to cause thrashing seems to work because
the kernel begins reporting high swap rates when the list reaches the target
length.

Does anyone know any programs that are designed to test this type of
thing or any comments on the code that I wrote?  I'm still new at this, so I've
probably misunderstood/left out some things.  The updateSwapRate() fuction is
called at the end of scheduler_tick().  That could probably go somewhere
better.  Also, I wasn't sure if changing the value of
swap_token_default_timeout was all I needed to do to reactivate the tokening as
it was disabled in 2.6.11 that I'm working with.

[code]
/*
 * mm/thrash.c
 *
 * Copyright (C) 2004, Red Hat, Inc.
 * Copyright (C) 2004, Rik van Riel <riel@redhat.com>
 * Released under the GPL, see the file COPYING for details.
 *
 * Simple token based thrashing protection, using the algorithm
 * described in:  http://www.cs.wm.edu/~sjiang/token.pdf
 */
#include <linux/jiffies.h>
#include <linux/mm.h>
#include <linux/sched.h>
#include <linux/swap.h>

static DEFINE_SPINLOCK(swap_token_lock);
static unsigned long swap_token_timeout;
/* Added swap_rate_check ~AMF*/
unsigned long swap_token_check, swap_rate_check=0;  
struct mm_struct * swap_token_mm = &init_mm;

/* SWAP_RATE_CHECK_INTERVAL is how often to call updateSwapRate() ~AMF*/
#define SWAP_RATE_CHECK_INTERVAL (HZ * 1)
#define SWAP_TOKEN_CHECK_INTERVAL (HZ * 2)
#define SWAP_TOKEN_TIMEOUT	0
/*
 * Currently disabled; Needs further code to work at HZ * 300:
 * #define SWAP_TOKEN_TIMEOUT (HZ * 300)
 */
unsigned long swap_token_default_timeout = SWAP_TOKEN_TIMEOUT;

/*
 * Time of last swap/majflt,
 * Time since last swap/majflt,
 * Number of swaps since last swapRate() call,
 * Average number of swaps per swapRate() call,
 * Flag for activating/decactivating tokening
 * ~AMF
 */
unsigned long tLastSwp = 0;
unsigned long tSncLastSwp = 0;
unsigned long swapCount = 0;
unsigned long swapRate = 0;
int switchedOn = 0;

/*
 * Measure how much swapping is being done.  Then set the token timeout.  ~AMF
 */
void updateSwapRate(void) {

	if (time_after(jiffies, swap_rate_check)) {

		//printk(KERN_CRIT "It should be working... Jffs = %lu, S_R_C = %lu\r\n",
jiffies, 			//	swap_rate_check);

		// Calculate the new swapRate
		swapRate = (swapRate + swapCount) >> 1;	

		if (swapRate>=100) {
			printk(KERN_CRIT "Swap rate is %lu\r\n", swapRate);
			if (!switchedOn) {
				printk(KERN_CRIT "Activating tokening mechanism\r\n");
				// Activate the tokening mechanism
				swap_token_default_timeout = HZ * 300;
				switchedOn=1;
			}
		}
		else {
			if (switchedOn) {
				printk(KERN_CRIT "Dectivating tokening mechanism\r\n");
				// Deactivate the swap mechanism
				swap_token_default_timeout = SWAP_TOKEN_TIMEOUT;
				switchedOn=0;
			}
		}
		// Reset the counter
		swapCount = 0;
		swap_rate_check = jiffies+SWAP_RATE_CHECK_INTERVAL;
	/* Without this, s_w_c stays at zero and swap rate isn't measured properly.
	 * Probably just a stupid newbie error I made.
	 */
	} else if (time_before(jiffies+SWAP_RATE_CHECK_INTERVAL, swap_rate_check)) {
		swap_rate_check = jiffies;
		printk(KERN_CRIT "Should be very rare!\r\n");
	}
	return;
}

/*
 * Take the token away if the process had no page faults
 * in the last interval, or if it has held the token for
 * too long.
 */
#define SWAP_TOKEN_ENOUGH_RSS 1
#define SWAP_TOKEN_TIMED_OUT 2
static int should_release_swap_token(struct mm_struct *mm)
{
	int ret = 0;
	if (!mm->recent_pagein)
		ret = SWAP_TOKEN_ENOUGH_RSS;
	else if (time_after(jiffies, swap_token_timeout))
		ret = SWAP_TOKEN_TIMED_OUT;
	mm->recent_pagein = 0;
	return ret;
}

/*
 * Try to grab the swapout protection token.  We only try to
 * grab it once every TOKEN_CHECK_INTERVAL, both to prevent
 * SMP lock contention and to check that the process that held
 * the token before is no longer thrashing.
 */
void grab_swap_token(void)
{
	struct mm_struct *mm;
	int reason;

	/* Get basic swap stats. ~AMF */
	tSncLastSwp = jiffies - tLastSwp;
	tLastSwp = jiffies;
	swapCount++;

	/* We have the token. Let others know we still need it. */
	if (has_swap_token(current->mm)) {
		current->mm->recent_pagein = 1;
		return;
	}

	if (time_after(jiffies, swap_token_check)) {

		/* Can't get swapout protection if we exceed our RSS limit. */
		// if (current->mm->rss > current->mm->rlimit_rss)
		//	return;

		/* ... or if we recently held the token. */
		if (time_before(jiffies, current->mm->swap_token_time))
			return;

		if (!spin_trylock(&swap_token_lock))
			return;

		swap_token_check = jiffies + SWAP_TOKEN_CHECK_INTERVAL;

		mm = swap_token_mm;
		if ((reason = should_release_swap_token(mm))) {
			unsigned long eligible = jiffies;
			if (reason == SWAP_TOKEN_TIMED_OUT) {
				eligible += swap_token_default_timeout;
			}
			mm->swap_token_time = eligible;
			swap_token_timeout = jiffies + swap_token_default_timeout;
			swap_token_mm = current->mm;
		}
		spin_unlock(&swap_token_lock);
	}
	return;
}

/* Called on process exit. */
void __put_swap_token(struct mm_struct *mm)
{
	spin_lock(&swap_token_lock);
	if (likely(mm == swap_token_mm)) {
		swap_token_mm = &init_mm;
		swap_token_check = jiffies;
	}
	spin_unlock(&swap_token_lock);
}
[/code]

----------------------------------------------------------------
This message was sent using IMP, the Internet Messaging Program.
