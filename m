Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261503AbVBACZo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261503AbVBACZo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 21:25:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261507AbVBACZo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 21:25:44 -0500
Received: from mail.joq.us ([67.65.12.105]:18155 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S261503AbVBACZf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 21:25:35 -0500
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, Alexander Nyberg <alexn@dsv.su.se>,
       Zwane Mwaikambo <zwane@linuxpower.ca>
Subject: Re: [PATCH] sched - Implement priority and fifo support for
 SCHED_ISO
References: <41F76746.5050801@kolivas.org> <87acqpjuoy.fsf@sulphur.joq.us>
	<41FE9582.7090003@kolivas.org> <87651di55a.fsf@sulphur.joq.us>
	<41FEB8BA.7000106@kolivas.org>
From: "Jack O'Quin" <joq@io.com>
Date: Mon, 31 Jan 2005 20:27:08 -0600
In-Reply-To: <41FEB8BA.7000106@kolivas.org> (Con Kolivas's message of "Tue,
 01 Feb 2005 10:01:14 +1100")
Message-ID: <87fz0hf20z.fsf@sulphur.joq.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Jack O'Quin wrote:
>> The corrected version works noticeably better, but still nowhere near
>> as well as SCHED_FIFO.  The first run had a cluster of really bad
>> xruns.  The second and third were much better, but still with numerous
>> small xruns.
>>
>>   http://www.joq.us/jack/benchmarks/sched-iso-fix/
>>
>> With a compile running in the background it was a complete failure.
>> Some kind of big xrun storm triggered a collapse on every attempt.
>>
>>   http://www.joq.us/jack/benchmarks/sched-iso-fix+compile/
>>
>> The summary statistics are mixed.  The delay_max is noticeably better
>> than before, but still much worse than SCHED_FIFO.  But, the xruns are
>> really bad news...

Con Kolivas <kernel@kolivas.org> writes:
> Believe it or not these look like good results to me. Your XRUNS are
> happening when the DSP load is >70% which is the iso_cpu % cutoff. Try
> setting the iso_cpu to 90%
>
> echo 90 > /proc/sys/kernel/iso_cpu

I ran them again with that setting.  But, don't forget the large
number of xruns before, even running without the compiles in the
background.  There are still way too many of those, although the third
run was clean.  If you can get them all to work like that, we'll
really have something.

  http://www.joq.us/jack/benchmarks/sched-iso-fix.90

With a compile running in the background, the entire run did not fail
completely as it had at 70%.  But there are still way too many xruns.

  http://www.joq.us/jack/benchmarks/sched-iso-fix.90+compile

I moved a bunch of directories testing older prototypes to a .old
subdirectory, they no longer clutter up the summary statistics.

  http://www.joq.us/jack/benchmarks/.SUMMARY

The fact that the results did improve with the 90% setting suggests
that there may be a bug in your throttling or time accounting.  The
DSP load for this test should hover around 50% when things are working
properly.  It should never hit a 70% limit, not even momentarily.  The
background compile should not affect that, either.

Something seems to be causing scheduling delays when the sound card
interrupt causes jackd to become runnable.  Ingo's nice(-20) patches
seem to have the same problem, but his RLIMIT_RT_CPU version does not.

This is still not working well enough for JACK users.  Long and
variable trigger latencies after hardware interrupts are deadly to any
serious realtime application.
-- 
  joq
