Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267299AbTA0VSP>; Mon, 27 Jan 2003 16:18:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267301AbTA0VSP>; Mon, 27 Jan 2003 16:18:15 -0500
Received: from 209-166-240-202.cust.walrus.com.240.166.209.in-addr.arpa ([209.166.240.202]:19351
	"EHLO ti3.telemetry-investments.com") by vger.kernel.org with ESMTP
	id <S267299AbTA0VSN>; Mon, 27 Jan 2003 16:18:13 -0500
Date: Mon, 27 Jan 2003 16:27:17 -0500
From: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: Mark Mielke <mark@mark.mielke.cc>,
       Davide Libenzi <davidel@xmailserver.org>,
       Lennert Buytenhek <buytenh@math.leidenuniv.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: bug in select() (was Re: {sys_,/dev/}epoll waiting timeout)
Message-ID: <20030127162717.A1283@ti19>
References: <20030122065502.GA23790@math.leidenuniv.nl> <20030122080322.GB3466@bjl1.asuk.net> <Pine.LNX.4.50.0301230544320.820-100000@blue1.dev.mcafeelabs.com> <20030123154304.GA7665@bjl1.asuk.net> <20030123172734.GA2490@mark.mielke.cc> <20030123182831.GA8184@bjl1.asuk.net> <20030123204056.GC2490@mark.mielke.cc> <20030123221858.GA8581@bjl1.asuk.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20030123221858.GA8581@bjl1.asuk.net>; from jamie@shareable.org on Thu, Jan 23, 2003 at 10:18:58PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 23, 2003 at 10:18:58PM +0000, Jamie Lokier wrote:
> If, as someone said, the appropriate unix specification says that
> "wait for 10ms" means to wait for _at minimum_ 10ms, then you do need
> the +1.
> 
> (Davide), IMHO epoll should decide whether it means "at minimum" (in
> which case the +1 is a requirement), or it means "at maximum" (in
> which case rounding up is wrong).
> 
> The current method of rounding up and then effectively down means that
> you get an unpredictable mixture of both.

Quite independent of this discussion, my boss came across this today
while looking at some strace output:

   gettimeofday({1043689947, 402580}, NULL) = 0
   select(4, [0], [], [], {1, 999658})     = 0 (Timeout)
   gettimeofday({1043689949, 401857}, NULL) = 0
   gettimeofday({1043689949, 401939}, NULL) = 0
   select(4, [0], [], [], {0, 299})        = 0 (Timeout)
   gettimeofday({1043689949, 403577}, NULL) = 0

Note that 1043689949.401857 - 1043689947.402580 = 1.999277.

The Single Unix Specification (v2 and v3), says of select():

   Implementations may also place limitations on the granularity of
   timeout intervals. If the requested timeout interval requires a finer
   granularity than the implementation supports, the actual timeout
   interval shall be rounded up to the next supported value.

That seems to indicate that a fix is required.

Regards,

   Bill Rugolsky
