Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263794AbTA0Whj>; Mon, 27 Jan 2003 17:37:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264617AbTA0Whj>; Mon, 27 Jan 2003 17:37:39 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:36753 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S263794AbTA0Whi>; Mon, 27 Jan 2003 17:37:38 -0500
X-AuthUser: davidel@xmailserver.org
Date: Mon, 27 Jan 2003 14:52:36 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
cc: Jamie Lokier <jamie@shareable.org>, Mark Mielke <mark@mark.mielke.cc>,
       Lennert Buytenhek <buytenh@math.leidenuniv.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bug in select() (was Re: {sys_,/dev/}epoll waiting timeout)
In-Reply-To: <20030127162717.A1283@ti19>
Message-ID: <Pine.LNX.4.50.0301271427320.1930-100000@blue1.dev.mcafeelabs.com>
References: <20030122065502.GA23790@math.leidenuniv.nl> <20030122080322.GB3466@bjl1.asuk.net>
 <Pine.LNX.4.50.0301230544320.820-100000@blue1.dev.mcafeelabs.com>
 <20030123154304.GA7665@bjl1.asuk.net> <20030123172734.GA2490@mark.mielke.cc>
 <20030123182831.GA8184@bjl1.asuk.net> <20030123204056.GC2490@mark.mielke.cc>
 <20030123221858.GA8581@bjl1.asuk.net> <20030127162717.A1283@ti19>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Jan 2003, Bill Rugolsky Jr. wrote:

> Quite independent of this discussion, my boss came across this today
> while looking at some strace output:
>
>    gettimeofday({1043689947, 402580}, NULL) = 0
>    select(4, [0], [], [], {1, 999658})     = 0 (Timeout)
>    gettimeofday({1043689949, 401857}, NULL) = 0
>    gettimeofday({1043689949, 401939}, NULL) = 0
>    select(4, [0], [], [], {0, 299})        = 0 (Timeout)
>    gettimeofday({1043689949, 403577}, NULL) = 0
>
> Note that 1043689949.401857 - 1043689947.402580 = 1.999277.
>
> The Single Unix Specification (v2 and v3), says of select():
>
>    Implementations may also place limitations on the granularity of
>    timeout intervals. If the requested timeout interval requires a finer
>    granularity than the implementation supports, the actual timeout
>    interval shall be rounded up to the next supported value.
>
> That seems to indicate that a fix is required.

The problem is that the schedule_timeout() is not precise. So if you pass
N to such function, your sleep interval can be ]N-1, N+1[
This w/out considering other latencies but looking only at how timers are
updated ( you can call schedule_timeout() immediately before a timer tick
or immediately after ). So if we want to be sure to sleep at least the
rounded up number of jiffies, we might end up sleeping one/two jiffies
more ( and this w/out accounting other latencies ). And this will lead to
the formula ( used by poll() ) :

Tj = (Tms * HZ + 999) / 1000 + 1

( if Tms > 0 )



- Davide

