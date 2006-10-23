Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964983AbWJWSLU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964983AbWJWSLU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 14:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964986AbWJWSLU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 14:11:20 -0400
Received: from mtagate5.de.ibm.com ([195.212.29.154]:7586 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP id S964983AbWJWSLT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 14:11:19 -0400
Message-ID: <453D05C3.7040104@de.ibm.com>
Date: Mon, 23 Oct 2006 20:11:15 +0200
From: Martin Peschke <mp3@de.ibm.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: Jens Axboe <jens.axboe@oracle.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [Patch 0/5] I/O statistics through request queues
References: <1161435423.3054.111.camel@dyn-9-152-230-71.boeblingen.de.ibm.com> <20061023113728.GM8251@kernel.dk>
In-Reply-To: <20061023113728.GM8251@kernel.dk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Sat, Oct 21 2006, Martin Peschke wrote:
>> This patch set makes the block layer maintain statistics for request
>> queues. Resulting data closely resembles the actual I/O traffic to a
>> device, as the block layer takes hints from block device drivers when a
>> request is being issued as well as when it is about to complete.
>>
>> It is crucial (for us) to be able to look at such kernel level data in
>> case of customer situations. It allows us to determine what kind of
>> requests might be involved in performance situations. This information
>> helps to understand whether one faces a device issue or a Linux issue.
>> Not being able to tap into performance data is regarded as a big minus
>> by some enterprise customers, who are reluctant to use Linux SCSI
>> support or Linux.
>>
>> Statistics data includes:
>> - request sizes (read + write),
>> - residual bytes of partially completed requests (read + write),
>> - request latencies (read + write),
>> - request retries (read + write),
>> - request concurrency,
> 
> Question - what part of this does blktrace currently not do?

The Dispatch / Complete events of blktrace aren't as accurate as
the additional "markers" introduced by my patch. A request might have
been dispatched (to the block device driver) from the block layer's
point of view, although this request still lingers in the low level
device driver.

For example, the s390 DASD driver accepts a small batch of requests
from the block layer and translates them into DASD requests. Such DASD
requests stay in an internal queue until an interrupt triggers the DASD
driver to issue the next ready-made DASD request without further delay.
Saving on latency.

For SCSI, the accuracy of the Dispatch / Complete events of blktrace
is not such an issue, since SCSI doesn't queue stuff on its own, but
reverts to queues implemented in SCSI devices. Anyway, command pre-
and postprocessing in the SCSI stack adds to the latency that can be
observed through the Dispatch / Complete events of blktrace.

Of course, the addition of two events to blktrace could fix that.

And it would be some effort to teach the blktrace tools family to
calculate the set of statistics I have proposed. But that's not a
reason to do things in the kernel...

 > In case it's missing something, why not add it there instead of
 > putting new trace code in?

The question is:
Is blktrace a performance tool? Or a development tool, or what?

Our tests indicate that the blktrace approach is fine for performance
analysis as long as the system to be analysed isn't too busy.
But once the system faces a consirable amount of non-sequential I/O
workload, the plenty of blktrace-generated data starts to get painful.

The majority of the scenarios that are likely to become subject of a
performance analysis due to some customer complaint fit into the
category of workloads that will be affected by the activation of
blktrace.

If the system runs I/O-bound, how to write out traces without
stealing bandwith and causing side effects?
And if CPU utilisation is high, how to make sure that blktrace
tools get the required share without seriously impacting
applications which are responsible for the workload to be analysed?
How much memory is reqired for per-cpu and per-device relay buffers
and for the processing done by blktrace tools at run time?

What if other subsystems get rigged with relay-based traces,
following the blktrace example? I think that's okay - much better
than cluttering the printk buffer with data that doesn't necessarily
require user attention. I am advocating the renovation of
arch/s390/kernel/debug.c - a tracing facility widely used throughout
the s390 code - so that it is switched over to blktrace-like techniques,
(and ideally shares code and is slimmed down).

With blktrace-like (utt-based?) tracing facilities the data
stream will swell. But if those were required to get an overview
about the performance of subsystems or drivers...

In my opinion, neither trace events relayed to user space nor
performance counters maintained in the kernel are the sole answer
to all information needs. The trick is to deliberate about 'when to
use which approach what for'. Performance counters should give
directions for further investigation. Traces are fine for debugging
a specific subsystem.

