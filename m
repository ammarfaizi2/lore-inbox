Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265053AbUGZItx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265053AbUGZItx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 04:49:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265082AbUGZItx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 04:49:53 -0400
Received: from mx2.elte.hu ([157.181.151.9]:51156 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S265053AbUGZItv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 04:49:51 -0400
Date: Mon, 26 Jul 2004 10:50:02 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: preempt timing violations
Message-ID: <20040726085002.GA25519@elte.hu>
References: <1090813907.6936.56.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1090813907.6936.56.camel@mindpipe>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Lee Revell <rlrevell@joe-job.com> wrote:

> Latency with 2.6.8-rc2 + voluntary-preempt-I4 is the best so far. 
> After extended testing there only seem to be a few hot spots.  In
> several minutes I saw an 11ms violation, a 14ms violation, and several
> 2ms violations.
> 
> get_user_pages() is much better in 2.6.8-rc1-mm1 than 2.6.8-rc2.  Is
> there any chance of getting the fix into mainline?

in -J3 i've added a cond_resched to the latency-generating point of
get_user_pages(). (The biggest latencies happen via
make_pages_present(), which gets triggered by mlockall()/MAP_LOCKED.)

> 2ms non-preemptible critical section violated 1 ms preempt threshold
> starting at unmap_vmas+0x1ff/0x210 and ending at
> unmap_vmas+0x1f5/0x210

this is the normal sys_exit()->exit_mmap()->unmap_vmas() path. It's
weird that it generated a 2ms latency. What are the values of
voluntary_preemption and kernel_preemption on your current kernel? With
a 2:0 setting we ought to have a reschedule point every 32 pages.  Do
you know which application triggers this latency and is it easy to
reproduce?

> 14ms non-preemptible critical section violated 1 ms preempt threshold 
> starting at tty_write+0x1b6/0x290 and ending at schedule+0x2fd/0x5b0

does this one trigger when you are using the VGA console? (or fbcon)?

it's not immediately obvious to me precisely where this latency comes
from, it would be nice to know how to reproduce it.

	Ingo
