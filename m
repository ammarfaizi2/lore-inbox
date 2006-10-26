Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423578AbWJZPhH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423578AbWJZPhH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 11:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423577AbWJZPhH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 11:37:07 -0400
Received: from mtagate6.de.ibm.com ([195.212.29.155]:12305 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP
	id S1423578AbWJZPhF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 11:37:05 -0400
Message-ID: <4540D61B.5040802@de.ibm.com>
Date: Thu, 26 Oct 2006 17:36:59 +0200
From: Martin Peschke <mp3@de.ibm.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: "Frank Ch. Eigler" <fche@redhat.com>
CC: psusi@cfl.rr.com, Jens Axboe <jens.axboe@oracle.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [Patch 0/5] I/O statistics through request queues
References: <453D05C3.7040104@de.ibm.com> <20061023200220.GB4281@kernel.dk> <453E38FE.1020306@de.ibm.com> <20061024162050.GK4281@kernel.dk> <453E79D1.6070703@cfl.rr.com> <453E9368.9070405@de.ibm.com> <y0mvem8thc3.fsf@ton.toronto.redhat.com> <45409709.3000701@de.ibm.com> <20061026121348.GB4978@redhat.com> <4540BA32.3020708@de.ibm.com> <20061026140218.GC4978@redhat.com>
In-Reply-To: <20061026140218.GC4978@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank Ch. Eigler wrote:
> Hi -
> 
> On Thu, Oct 26, 2006 at 03:37:54PM +0200, Martin Peschke wrote:
>> [...]
>> lookup_table[key] = value	, or
>> lookup_table[key]++
>>
>> How does this scale?
> 
> It depends.  If one is interested in only aggregates as an end result,
> then intermediate totals can be tracked individiaully per-cpu with no
> locking contention, so this scales well.

Sorry for not being clear.
I meant scaling with regard to lots of different keys.
This is what you have described as "By 'rows'", isn't it?

For example, if I wanted to store a timestamp for each request
issued, and there were lots of devices and the I/O was driving
the system crazy - how would affect that lookup time?

I would use, say, the address of struct request as key. I would
store the start time of a request there. Once a requests completes
I would look up the start time and calculate a latency.

I would be done with that lookup table entry then.
But it won't go away, will it? Is this an issue?

>> It must be someting else than an array, because key boundaries
>> aren't known when the lookup table is created, right?
>> And actual keys might be few and far between.
> 
> In systemtap, we use a hash table.
> 
>> What if the heap of intermediate results grows into thousands or
>> more?  [...]
> 
> It depends whether you mean "rows" or "columns".
> 
> By "rows", if you need to track thousands of queues, you will need
> memory to store some data for each of them.  In systemtap's case, the
> maximum number of elements in a hash table is configurable, and is all
> allocated at startup time.  (The default is a couple of thousand.)
> This is of course still larger than enlarging the base structures the
> way your code does.  But it's only larger by a constant amount, and
> makes it unnecessary to patch the code.
> 
> By "columns", if you need to track statistical aggregates of thousands
> of data points for an individual queue, then one can use a handful of
> fixed-size counters, as you already have for histograms.
> 
> 
> Anyway, my point was not that you should use systemtap proper, or that
> you need to use the same techniques for managing data on the side.
> It's that by using instrumentation markers, more things are possible.

Right, I have gone off on a tangent - systemtap, just one out of many
likely exploiters of markers.

Anyway, I think this discussion shows that any dynamically added client
of kernel markers which needs to hold extra data for entities like
requests might be difficult to be implemented efficiently (compared
to static instrumentation), because markers, by nature, only allow
for code additions, but not for additions to existing data structures.

