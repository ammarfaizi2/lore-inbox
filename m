Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265096AbUEUXCm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265096AbUEUXCm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 19:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265722AbUEUWmP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 18:42:15 -0400
Received: from zero.aec.at ([193.170.194.10]:5 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S266003AbUEUWdE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 18:33:04 -0400
To: "Theodore Ts'o" <tytso@mit.edu>
cc: tim.bird@am.sony.com, linux-kernel@vger.kernel.org
Subject: CONFIG_SLOW_TIMESTAMPS was Re: ANNOUNCE: CE Linux Forum -
 Specification V1.0 draft
References: <1WVF1-Nn-25@gated-at.bofh.it> <1WVYp-11I-5@gated-at.bofh.it>
	<1WXdS-279-41@gated-at.bofh.it> <1XiBG-2sN-37@gated-at.bofh.it>
	<1XF55-3Ij-7@gated-at.bofh.it> <1XHzV-5OV-9@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Thu, 20 May 2004 11:56:24 +0200
In-Reply-To: <1XHzV-5OV-9@gated-at.bofh.it> (Theodore Ts'o's message of
 "Thu, 20 May 2004 00:20:07 +0200")
Message-ID: <m3zn83o20n.fsf_-_@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Ts'o <tytso@mit.edu> writes:
>
> B) When CONFIG_FAST_TIMESTAMPS is enabled, the kernel SHALL provide
> the following 2 routines:
>
>       2.1 void store_timestamp(timestamp_t *t)

sched_clock() already exists and does that, although it is a bit confusingly
named. 

Or just use do_gettimeofday() which should be fast - it is used
in networking after all.

>       2.2 void timestamp_to_timeval(timestamp_t *t, struct timeval *tv) 

I don't think this API is a good idea. 

The obvious way to implement timestamp_t is just store the CPU integrated
time stamp counter into it (TSC in x86 terminology). But there are CPUs
where the TSC frequency changes when the CPU changes its core frequency
for power saving purposes.

(newer designs generally avoid this problem, but older designs often have 
it). Now to convert the TSC value you need the xtime and the TSC value
when the xtime matching the TSC value and you need to know about
all frequency changes that happened inbetween, so that you can 
compute the TSC offset. 

do_gettimeofday can handle this in a atomic matter, the CPU frequency
changes just has to resync xtime (I am not sure it does this currently,
but the API allows it at least) 

But splitting it into two functions like in your spec makes this
impossible, because you would need to keep track about all the
possible frequency changes in the timestamp_t between the store and
the timestamp_to_timeval to compute the TSC offset, which is obviously
not practical.

Anyways, the only way to avoid this problem would be to not use the
CPU TSC, but some external timer that is independent of the CPU
frequency (this is sometimes already done to work around other
problems). The problem is just that such external timers in the
southbridge are usually factor 100 and more slower than an TSC access
that can stay inside the CPU, because an access first has to cross the
slow CPU front side bus.

This would turn your fast time stamp into an extremly slow time stamp.

You would be probably better of by just using do_gettimeofday(), which
actually has a chance to use the TSC sanely and is not really that
slow usually.

BTW there are other problems on multiprocessor systems with this that
I don't want to go into.

-Andi

