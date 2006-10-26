Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751749AbWJZLIA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751749AbWJZLIA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 07:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751758AbWJZLH7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 07:07:59 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:62666 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751749AbWJZLH7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 07:07:59 -0400
Message-ID: <45409709.3000701@de.ibm.com>
Date: Thu, 26 Oct 2006 13:07:53 +0200
From: Martin Peschke <mp3@de.ibm.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: "Frank Ch. Eigler" <fche@redhat.com>
CC: Phillip Susi <psusi@cfl.rr.com>, Jens Axboe <jens.axboe@oracle.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [Patch 0/5] I/O statistics through request queues
References: <1161435423.3054.111.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>	<20061023113728.GM8251@kernel.dk> <453D05C3.7040104@de.ibm.com>	<20061023200220.GB4281@kernel.dk> <453E38FE.1020306@de.ibm.com>	<20061024162050.GK4281@kernel.dk> <453E79D1.6070703@cfl.rr.com>	<453E9368.9070405@de.ibm.com> <y0mvem8thc3.fsf@ton.toronto.redhat.com>
In-Reply-To: <y0mvem8thc3.fsf@ton.toronto.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank Ch. Eigler wrote:
> Martin Peschke <mp3@de.ibm.com> writes:
> 
>> [...]  The tricky question is: is event processing, that is,
>> statistics data aggregation, better done later (in user space), or
>> immediately (in the kernel). Both approaches exist: blktrace/btt vs.
>> gendisk statistics used by iostat, for example. [...]
> 
> I would put it one step farther: the tricky question is whether it's
> worth separating marking the state change events ("request X
> enqueued") from the action to be taken ("track statistics", "collect
> trace records").
> 
> The reason I brought up the lttng/marker thread here was because that
> suggests a way of addressing several of the problems at the same time.
> This could work thusly: (This will sound familiar to OLS attendees.)
> 
> - The blktrace code would adopt a generic marker mechanism such as
>   that (still) evolving within the lttng/systemtap effort.  These
>   markers would replace calls to inline functions such as
>       blk_add_trace_bio(q,bio,BLK_TA_QUEUE);
>   with something like
>       MARK(blk_bio_queue,q,bio);
> 
> - The blktrace code that formats and manages trace data would become a
>   consumer of the marker API.  It would be hooked up at runtime to
>   these markers.

I suppose the marker approach will be adopted if jumping from a marker
to code hooked up there can be made fast and secure enough for
prominent architectures.

>   When the events fire, the tracing backend receiving
>   the callbacks could do the same thing it does now.  (With the
>   markers dormant, the cost should not be much higher than the current
>   (likely (!q->blk_trace)) conditional.)
> 
> - The mp3 statistics code would be an alternate backend to these same
>   markers.  It could be activated or deactivated on the fly (to let
>   another subsystem use the markers).  The code would maintain statistics
>   in its own memory and could present the data on /proc or whatnot, the
>   same way as today.

Basically, I agree. But, the devel is in the details.

Dynamic instrumentation based on markers allows to grow code,
but it doesn't allow to grow data structure, AFAICS.

Statistics might require temporary results to be stored per
entity.

For example, latencies require two timestamps. The older one needs to
be stored somewhere until the second timestamp can be determined and
a latency is calculated. I would add a field a field to struct request
for this purpose.

The workaround would be to pass any intermediate result in the form
of a trace event up to user space and try to sort it out later -
which takes us back to the blktrace approach.

Martin

