Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264389AbTK0ABk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 19:01:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264394AbTK0ABk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 19:01:40 -0500
Received: from rth.ninka.net ([216.101.162.244]:30084 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S264389AbTK0ABh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 19:01:37 -0500
Date: Wed, 26 Nov 2003 16:01:29 -0800
From: "David S. Miller" <davem@redhat.com>
To: Ben Greear <greearb@candelatech.com>
Cc: ak@suse.de, linux-kernel@vger.kernel.org
Subject: Fast timestamps
Message-Id: <20031126160129.32855a15.davem@redhat.com>
In-Reply-To: <3FC53A40.8010904@candelatech.com>
References: <BAY1-DAV15JU71pROHD000040e2@hotmail.com.suse.lists.linux.kernel>
	<20031125183035.1c17185a.davem@redhat.com.suse.lists.linux.kernel>
	<p73fzgbzca6.fsf@verdi.suse.de>
	<20031126113040.3b774360.davem@redhat.com>
	<3FC505F4.2010006@google.com>
	<20031126120316.3ee1d251.davem@redhat.com>
	<20031126232909.7e8a028f.ak@suse.de>
	<20031126143620.5229fb1f.davem@redhat.com>
	<20031126235641.36fd71c1.ak@suse.de>
	<20031126151352.160b4734.davem@redhat.com>
	<3FC53A40.8010904@candelatech.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Nov 2003 15:41:52 -0800
Ben Greear <greearb@candelatech.com> wrote:

> I'll try to write up a patch that uses the TSC and lazy conversion
> to timeval as soon as I get the rx-all and rx-fcs code happily
> into the kernel....
> 
> Assuming TSC is very fast and the conversion is accurate enough, I think
> this can give good results....

I'm amazed that you will be able to write a fast_timestamp
implementation without even seeing the API I had specified
to the various arch maintainers :-)

====================

But at the base I say we need three things:

1) Some kind of fast_timestamp_t, the property is that this stores
   enough information at time "T" such that at time "T + something"
   the fast_timestamp_t can be converted what the timeval was back at
   time "T".

   For networking, make skb->stamp into this type.

2) store_fast_timestamp(fast_timestamp_t *)

   For networking, change do_gettimeofday(&skb->stamp) into
   store_fast_timestamp(&skb->stamp)

3) fast_timestamp_to_timeval(arch_timestamp_t *, struct timeval *)

   For networking, change things that read the skb->stamp value
   into calls to fast_timestamp_to_timeval().

It is defined that the timeval given by fast_timestamp_to_timeval()
needs to be the same thing that do_gettimeofday() would have recorded
at the time store_fast_timestamp() was called.

Here is the default generic implementation that would go into
asm-generic/faststamp.h:

1) fast_timestamp_t is struct timeval
2) store_fast_timestamp() is gettimeofday()
3) fast_timestamp_to_timeval() merely copies the fast_timestamp_t
   into the passed in timeval.

And here is how an example implementation could work on sparc64:

1) fast_timestamp_t is a u64

2) store_fast_timestamp() reads the cpu cycle counter

3) fast_timestamp_to_timeval() records the difference between the
   current cpu cycle counter and the one recorded, it takes a sample
   of the current xtime value and adjusts it accordingly to account
   for the cpu cycle counter difference.

This only works because sparc64's cpu cycle counters are synchronized
across all cpus, they increase monotonically, and are guarenteed not
to overflow for at least 10 years.

Alpha, for example, cannot do it this way because it's cpu cycle counter
register overflows too quickly to be useful.

Platforms with inter-cpu TSC synchronization issues will have some
troubles doing the same trick too, because one must handle properly
the case where the fast timestamp is converted to a timeval on a different
cpu on which the fast timestamp was recorded.

Regardless, we could put the infrastructure in there now and arch folks
can work on implementations.  The generic implementation code, which is
what everyone will end up with at first, will cancel out to what we have
currently.

This is a pretty powerful idea that could be applied to other places,
not just the networking.
