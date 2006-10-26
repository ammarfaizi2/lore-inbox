Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161330AbWJZODO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161330AbWJZODO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 10:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161386AbWJZODO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 10:03:14 -0400
Received: from mx1.redhat.com ([66.187.233.31]:18323 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161330AbWJZODO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 10:03:14 -0400
Date: Thu, 26 Oct 2006 10:02:18 -0400
From: "Frank Ch. Eigler" <fche@redhat.com>
To: Martin Peschke <mp3@de.ibm.com>
Cc: psusi@cfl.rr.com, Jens Axboe <jens.axboe@oracle.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [Patch 0/5] I/O statistics through request queues
Message-ID: <20061026140218.GC4978@redhat.com>
References: <453D05C3.7040104@de.ibm.com> <20061023200220.GB4281@kernel.dk> <453E38FE.1020306@de.ibm.com> <20061024162050.GK4281@kernel.dk> <453E79D1.6070703@cfl.rr.com> <453E9368.9070405@de.ibm.com> <y0mvem8thc3.fsf@ton.toronto.redhat.com> <45409709.3000701@de.ibm.com> <20061026121348.GB4978@redhat.com> <4540BA32.3020708@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4540BA32.3020708@de.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi -

On Thu, Oct 26, 2006 at 03:37:54PM +0200, Martin Peschke wrote:
> [...]
> lookup_table[key] = value	, or
> lookup_table[key]++
> 
> How does this scale?

It depends.  If one is interested in only aggregates as an end result,
then intermediate totals can be tracked individiaully per-cpu with no
locking contention, so this scales well.

> It must be someting else than an array, because key boundaries
> aren't known when the lookup table is created, right?
> And actual keys might be few and far between.

In systemtap, we use a hash table.

> What if the heap of intermediate results grows into thousands or
> more?  [...]

It depends whether you mean "rows" or "columns".

By "rows", if you need to track thousands of queues, you will need
memory to store some data for each of them.  In systemtap's case, the
maximum number of elements in a hash table is configurable, and is all
allocated at startup time.  (The default is a couple of thousand.)
This is of course still larger than enlarging the base structures the
way your code does.  But it's only larger by a constant amount, and
makes it unnecessary to patch the code.

By "columns", if you need to track statistical aggregates of thousands
of data points for an individual queue, then one can use a handful of
fixed-size counters, as you already have for histograms.


Anyway, my point was not that you should use systemtap proper, or that
you need to use the same techniques for managing data on the side.
It's that by using instrumentation markers, more things are possible.


- FChE
