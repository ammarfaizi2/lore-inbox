Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318298AbSHEFbb>; Mon, 5 Aug 2002 01:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318299AbSHEFbb>; Mon, 5 Aug 2002 01:31:31 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:34057 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318298AbSHEFba>; Mon, 5 Aug 2002 01:31:30 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: context switch vs. signal delivery [was: Re: Accelerating user mode linux]
Date: Mon, 5 Aug 2002 05:35:13 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <ail2qh$bf0$1@penguin.transmeta.com>
References: <1028294887.18635.71.camel@irongate.swansea.linux.org.uk> <Pine.LNX.4.44.0208031332120.7531-100000@localhost.localdomain> <m3u1mb5df3.fsf@averell.firstfloor.org>
X-Trace: palladium.transmeta.com 1028525679 22281 127.0.0.1 (5 Aug 2002 05:34:39 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 5 Aug 2002 05:34:39 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <m3u1mb5df3.fsf@averell.firstfloor.org>,
Andi Kleen  <ak@muc.de> wrote:
>Ingo Molnar <mingo@elte.hu> writes:
>
>
>> actually the opposite is true, on a 2.2 GHz P4:
>> 
>>   $ ./lat_sig catch
>>   Signal handler overhead: 3.091 microseconds
>> 
>>   $ ./lat_ctx -s 0 2
>>   2 0.90
>> 
>> ie. *process to process* context switches are 3.4 times faster than signal
>> delivery. Ie. we can switch to a helper thread and back, and still be
>> faster than a *single* signal.
>
>This is because the signal save/restore does a lot of unnecessary stuff.
>One optimization I implemented at one time was adding a SA_NOFP signal
>bit that told the kernel that the signal handler did not intend 
>to modify floating point state (few signal handlers need FP) It would 
>not save the FPU state then and reached quite some speedup in signal
>latency. 
>
>Linux got a lot slower in signal delivery when the SSE2 support was
>added. That got this speed back.

This will break _horribly_ when (if) glibc starts using SSE2 for things
like memcpy() etc.

I agree that it is really sad that we have to save/restore FP on
signals, but I think it's unavoidable. Your hack may work for you, but
it just gets really dangerous in general. having signals randomly
subtly corrupt some SSE2 state just because the signal handler uses
something like memcpy (without even realizing that that could lead to
trouble) is bad, bad, bad.

In other words, "not intending to" does not imply "will not".  It's just
potentially too easy to change SSE2 state by mistake. 

And yes, this signal handler thing is clearly visible on benchmarks. 
MUCH too clearly visible.  I just didn't see any safe alternatives
(and I still don't ;( )

		Linus
