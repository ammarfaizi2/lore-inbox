Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261351AbVAWUr1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261351AbVAWUr1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 15:47:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261352AbVAWUr1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 15:47:27 -0500
Received: from mail.joq.us ([67.65.12.105]:56192 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S261351AbVAWUrS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 15:47:18 -0500
To: Ingo Molnar <mingo@elte.hu>, Con Kolivas <kernel@kolivas.org>
Cc: Paul Davis <paul@linuxaudiosystems.com>,
       linux <linux-kernel@vger.kernel.org>, rlrevell@joe-job.com,
       CK Kernel <ck@vds.kolivas.org>, utz <utz@s2y4n2c.de>,
       Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [PATCH]sched: Isochronous class v2 for unprivileged soft rt
 scheduling
References: <200501201542.j0KFgOwo019109@localhost.localdomain>
	<87y8eo9hed.fsf@sulphur.joq.us> <20050120172506.GA20295@elte.hu>
	<87wtu6fho8.fsf@sulphur.joq.us> <20050122165458.GA14426@elte.hu>
From: "Jack O'Quin" <joq@io.com>
Date: Sun, 23 Jan 2005 14:48:45 -0600
In-Reply-To: <20050122165458.GA14426@elte.hu> (Ingo Molnar's message of
 "Sat, 22 Jan 2005 17:54:58 +0100")
Message-ID: <87pszvlvma.fsf@sulphur.joq.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> writes:

> thanks for the testing. The important result is that nice--20
> performance is roughly the same as SCHED_ISO. This somewhat
> reduces the urgency of the introduction of SCHED_ISO.

Doing more runs and a more thorough analysis has driven me to a
different conclusion.  The important result is that *neither* nice-20
*nor* SCHED_ISO work properly in their current forms.

For further comparison, I booted an old 2.4.19 kernel with Andrew
Morton's low-latency patches and ran the same test SCHED_FIFO, with
and without background compiles.  The results were roughly the same as
SCHED_FIFO on 2.6.11-rc1...

  http://www.joq.us/jack/benchmarks/2.4ll-fifo
  http://www.joq.us/jack/benchmarks/2.4ll-fifo+compile

In addition, I extracted some across the board information by grepping
for key results.  Looking at these numbers in aggregate paints a
pretty convincing picture that neither of the new scheduler prototypes
are performing adequately compared to SCHED_FIFO on either 2.4ll or
2.6.

  http://www.joq.us/jack/benchmarks/cycle_max.log
  http://www.joq.us/jack/benchmarks/delay_max.log
  http://www.joq.us/jack/benchmarks/xrun_count.log

Looking at delay_max broken down by directory is particularly
striking.  Below, I grouped the values by scheduling class to show the
striking differences.  These kinds of worst-case numbers are what
realtime applications designers are generally most interested in...

============= SCHED_FIFO ==============
...benchmarks/2.4ll-fifo...
Delay Maximum . . . . . . . . :   823   usecs
Delay Maximum . . . . . . . . :   303   usecs
...benchmarks/2.4ll-fifo+compile...
Delay Maximum . . . . . . . . :   926   usecs
Delay Maximum . . . . . . . . :   663   usecs
...benchmarks/sched-fifo...
Delay Maximum . . . . . . . . :   347   usecs
Delay Maximum . . . . . . . . :   277   usecs
Delay Maximum . . . . . . . . :   246   usecs
...benchmarks/sched-fifo+compile...
Delay Maximum . . . . . . . . :   285   usecs
Delay Maximum . . . . . . . . :   269   usecs
Delay Maximum . . . . . . . . :   277   usecs
Delay Maximum . . . . . . . . :   569   usecs
Delay Maximum . . . . . . . . :   461   usecs

============= nice(-20) ==============
...benchmarks/nice-20...
Delay Maximum . . . . . . . . : 13818   usecs
Delay Maximum . . . . . . . . : 155637   usecs
Delay Maximum . . . . . . . . :   487   usecs
Delay Maximum . . . . . . . . : 160328   usecs
Delay Maximum . . . . . . . . : 495328   usecs
...benchmarks/nice-20+compile...
Delay Maximum . . . . . . . . : 183083   usecs
Delay Maximum . . . . . . . . :  5976   usecs
Delay Maximum . . . . . . . . : 18155   usecs
Delay Maximum . . . . . . . . :   557   usecs

============= SCHED_ISO ==============
...benchmarks/sched-iso...
Delay Maximum . . . . . . . . : 21410   usecs
Delay Maximum . . . . . . . . : 36830   usecs
Delay Maximum . . . . . . . . :  4062   usecs
...benchmarks/sched-iso+compile...
Delay Maximum . . . . . . . . : 98909   usecs
Delay Maximum . . . . . . . . : 39414   usecs
Delay Maximum . . . . . . . . : 40294   usecs
Delay Maximum . . . . . . . . : 217192   usecs
Delay Maximum . . . . . . . . : 156989   usecs

Looked at this way, there really is no question.  The new scheduler
prototypes are falling short significantly.  Could this be due to
their lack of priority distinctions between realtime threads?  Maybe.
I can't say for sure.  I'll be interested to see what happens when Con
is ready for me to try his new priority-based SCHED_ISO prototype.

On a different note, the fact that 2.6 is finally performing as well
as 2.4+lowlat on this test represents significant progress.  In fact,
it performed slightly better (I don't know whether that improvement is
statistically significant).

Congratulations to all who had a hand in making this happen!
-- 
  joq
