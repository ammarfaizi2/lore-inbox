Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263059AbTHWRAI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 13:00:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263386AbTHWQ5s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 12:57:48 -0400
Received: from ns.aratech.co.kr ([61.34.11.200]:10416 "EHLO ns.aratech.co.kr")
	by vger.kernel.org with ESMTP id S262998AbTHWPLY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 11:11:24 -0400
Date: Sun, 24 Aug 2003 00:13:15 +0900
From: TeJun Huh <tejun@aratech.co.kr>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Race condition in 2.4 tasklet handling (cli() broken?)
Message-ID: <20030823151315.GA6781@atj.dyndns.org>
Mail-Followup-To: Stephan von Krawczynski <skraw@ithnet.com>,
	linux-kernel@vger.kernel.org
References: <20030823025448.GA32547@atj.dyndns.org> <20030823040931.GA3872@atj.dyndns.org> <20030823052633.GA4307@atj.dyndns.org> <20030823122813.0c90e241.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030823122813.0c90e241.skraw@ithnet.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 23, 2003 at 12:28:13PM +0200, Stephan von Krawczynski wrote:
> 
> If we follow your analysis and say it is broken, do you have a suggestion/patch
> how to fix both? I am willing to try your proposals, as it seems I am one of
> very few who really experience stability issues on SMP with the current
> implementation.
> 

 Hello, Stephan.

 The race conditions I'm mentioning in this thread are not likely to
cause real troubles.  The first one does not make any difference on
x86, and AFAIK bh isn't used extensively anymore so the second one
isn't very relevant either.  Only the race condition mentioned in the
other thread is of relvance if there is any :-(.

 We've been also suffering from random lockups (2.4.21 with various
patches including in-kernel irqbalancing) which show symptoms somewhat
different from usual kernel deadlock or panics.  We've seen lock ups
on several different machines.  All the machines were SMP and quite
busy with high volume network traffic and a lot of disk I/Os.  A
lockup takes from a week to a month(!) to take place.  Even though
they take very long, they occur sort of reliably.

 I had a chance to examine a locked up machine (Dual 3g xeon w/HT).  I
could turn on and off keyboard LEDs (so, keyboard irq is working) but
console didn't come back from blanked state.  The kernel was compiled
with sysrq and I've tried many sysrqs but teh console remained blank.
After a while, I pressed sysrq reboot key and it rebooted.
Fortunately, kernel log file did contain all outputs from sysrqs and I
could do a little bit of post-mortem analysis.

 The first weird thing was the timestamps.  Time seemed to be stopped
for a few hours between the lock up and the first sysrq request.
Then, time start to go again after the first sysrq request.  (NMI
watchdog was on)

 Process list showed that a server process is stuck inside kernel, but
the stuck position was very weird.  It was freeing a socket after
receving FIN.  The eip was stuck at the same place over several
sysrqs, and the instruction at the eip was plain ADD right after a
CALL instruction to kfree.  I think there is one more frame above
what's shown but I don't know how sysrq prints stack trace for other
cpus so I'm not sure.

 To gather more information, we hooked up a machine with kdb and are
waiting for the lockup to occur again.  My personal feeling is that
the race conditions I've mentioned are not the causes of the lockups
we're suffering from.

 It would be helpful if you can tell us more about your lockups.  Have
you tried sysrq, NMI watchdog, kdb or kgdb?

-- 
tejun
