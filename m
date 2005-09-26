Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932391AbVIZFxH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932391AbVIZFxH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 01:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932392AbVIZFxH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 01:53:07 -0400
Received: from cnxtsmtp8.conexant.com ([216.89.70.36]:14604 "EHLO
	mime-nj.bbnet.ad") by vger.kernel.org with ESMTP id S932391AbVIZFxG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 01:53:06 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: schedule_work returns FAILURE (0)
Date: Mon, 26 Sep 2005 11:23:56 +0530
Message-ID: <4D6E93075B31154298572E6B73CA849D02339336@noida-mail.bbnet.ad>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: schedule_work returns FAILURE (0)
Thread-Index: AcXCXMQAebWC3rj7QWi8tvJbk0b0RgAAVlPg
From: "Ravi Dubey" <ravi.dubey@conexant.com>
To: "Andrew Morton" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 26 Sep 2005 05:54:02.0676 (UTC) 
    FILETIME=[B2769F40:01C5C25E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Thanks for your response.

In 2.4 series there were three different kind of task queues: Timer,
Scheduler and Immediate. It is said that "work queue" is basically the
old Scheduler type. Is there any way I can make it work the "Immediate"
way.

I have gone through many of the LINUX sample 2.6 drivers, but all these
have just replaced tqueue by work_queue and mark_bh(IMMEDIATE_BH) by
schedule_work, but they are not using their own queues. Is it because my
driver has a very heavy / time intensive bottom half function?

Ravi

-----Original Message-----




********************** Legal Disclaimer ****************************
"This email may contain confidential and privileged material for the sole use of the intended recipient.  Any unauthorized review, use or distribution by others is strictly prohibited.  If you have received the message in error, please advise the sender by reply email and delete the message. Thank you."
**********************************************************************

From: Andrew Morton [mailto:akpm@osdl.org] 
Sent: Monday, September 26, 2005 11:08 AM
To: Ravi Dubey
Cc: linux-kernel@vger.kernel.org
Subject: Re: schedule_work returns FAILURE (0)

"Ravi Dubey" <ravi.dubey@conexant.com> wrote:
>
> Hi,
> 
> I have ported my USB driver on from Linux Kernel 2.4.20-8 to
2.6.11.12.
> As a part of this porting process, I have replaced the bottom halves
> with work_queues. Now, I am facing problems in the driver execution.
> :-(.
> 
> The schedule_work() function which schedules the work is returning
> FAILURE (0) many times (at least 1 out of 4 times it is called).
> 
> My queries:
> 
> 1. When a work is queued using schedule_work (), does the function
(that
> is to be called as bottom half) run at process context OR Interrupt
> context

Process context.

> - The reason why I am getting confused is that in this called
> function, if I print the return value of in_interrupt (), I get 0
(which
> means that is running at process context),

Yup.

> However, if I print the value
> of in_interrupt after I have acquired a spin lock in this function, I
> get the value 256 (which means I am running in interrupt context) ?

Not really.  Bits 8-19 of preempt_count() count the IRQ depth and bits
0..7
count the inc_preempt_count() depth.  If CONFIG_PREEMPT is enabled,
spin_lock() does inc_preempt_count().  See the definitions of
hardirq_count(), softirq_count() and irq_count().

> 2. Why is the schedule_work () function failing.

umm, look at the implementation of schedule_work()?

	if (!test_and_set_bit(0, &work->pending)) {

it's already pending (the scheduled work has not run yet).  You need to
design you schedule_work() caller to queue things up and you need to
design
your schedule_work() handler to consume all the thus-far-queued work
items.

Just ignore the return value of schedule_work().
