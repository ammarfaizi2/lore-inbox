Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161683AbWKHTBY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161683AbWKHTBY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 14:01:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161688AbWKHTBY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 14:01:24 -0500
Received: from mail.zeugmasystems.com ([192.139.122.66]:16597 "EHLO
	zeugmasystems.com") by vger.kernel.org with ESMTP id S1161683AbWKHTBX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 14:01:23 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Re: Jiffies wraparound is not treated in the schedstats
Date: Wed, 8 Nov 2006 11:01:21 -0800
Message-ID: <66910A579C9312469A7DF9ADB54A8B7D44DBFB@exchange.ZeugmaSystems.local>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Re: Jiffies wraparound is not treated in the schedstats
Thread-Index: AccDaEekBsZu9d71T6m75dG1dttOxA==
From: "Kaz Kylheku" <kaz@zeugmasystems.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mauricio Lin wrote:
> For instance the delta_jiffies variable is simply calculated as:
> 
> delta_jiffies = now - t->sched_info.last_queued;
>
> Do not you think the more logical way should be

No. Learn about the modulo arithmetic properties of the unsigned types.
 
> if (time_after(now, t->sched_info.last_queued))

Have you looked at time_after? It just performs a subtraction, after
casting both operands to long. It does not care which one is bigger than
the other. Basically, it performs the same calculation as the
delta_jiffies above, and then checks the sign bit.

>    delta_jiffies = now - t->sched_info.last_queued;
> else
>    delta_jiffies = (MAX_JIFFIES - t->sched_info.last_queued) + now

I'm looking at a 2.6.17 kernel, and I can't find MAX_JIFFIES, or
JIFFIES_MAX. There is a MAX_JIFFY_OFFSET, which is something else. It's
the biggest delta that you can add to a value X so that time_after(X, X
+ delta) is still true. If you try to schedule something beyond now +
MAX_JIFFY_OFFSET, it will be put back in time.

Also, your calculation is buggy. MAX_JIFFIES would correspond to
ULONG_MAX. What you want is:

  (ULONG_MAX + 1 - last_queued + now)

This expression is now mathematically congruent to 

  -last_queued + now (mod ULONG_MAX + 1)

or

   now - last_queued (mod ULONG_MAX + 1).

The arithmetic of the unsigned long type is /already/ carried out modulo
ULONG_MAX + 1, so the ULONG_MAX + 1 term can be dropped from your
expression, leaving it as

  now - last_queued

> I have included more variables to measure some issues of schedule in
> the kernel (following schedstat idea) and I noticed that jiffies
> wraparound has led to wrong values, since the user space tool when
> collecting the values is producing negative values.

What user space tool?

> Any comments?

The user space tool is perhaps buggy, or you are misinterpreting its
output.
 
> Can I provide a patch for that?

Some day, when you learn how to program.
