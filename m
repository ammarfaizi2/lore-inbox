Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261636AbUJYACs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261636AbUJYACs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 20:02:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261630AbUJYACs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 20:02:48 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:38360 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261629AbUJYACo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 20:02:44 -0400
Subject: Re: [PATCH] SCSI: Replace semaphores with wait_even
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: tglx@linutronix.de, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <20041024230601.GA14956@elte.hu>
References: <1098300579.20821.65.camel@thomas>
	<1098647869.10824.247.camel@mulgrave> <1098648414.22387.46.camel@thomas>
	<1098658889.10906.361.camel@mulgrave>  <20041024230601.GA14956@elte.hu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 24 Oct 2004 20:02:24 -0400
Message-Id: <1098662552.10824.369.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-10-24 at 19:06, Ingo Molnar wrote:
> i think i fixed this in my PREEMPT_REALTIME tree (having seen spinning
> eh_threads) - maybe Thomas forgot to merge those fixes back?
> 
> (in a PREEMPT_REALTIME kernel a spinning thread is just a thread eating
> up CPU power, it doesnt cause a hang.)

I've really got to say, I don't like what you're doing.  This program
seems to replace

if (condition)
	up(sem);
[...]
down(sem);


with

if (condition)
	up(event_queue);
[...]
wait_event(event_queue, condition);

That can be wrong on three counts:

1) The condition is a local one that will fluctuate between the wake_up
and the actual thread being scheduled to run
2) The actual condition you need to check for might not be the same as
the one that triggered the wake_up.  This is what the SCSI problem was.
3) There might genuinely be n triggers of the event.  With a semaphore,
if we get three up()'s before the waiting thread is schedules, it will
process three times.  With wait_event, the other two will be lost.

Thus, to effect this replacement, you need a thorough audit of what is
usually pretty non-trivial code.

What's the overriding reason for doing this?  the pain doesn't look to
be worth the gain (since I don't see any gain).

James


