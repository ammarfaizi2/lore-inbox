Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266626AbSKLOj1>; Tue, 12 Nov 2002 09:39:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266702AbSKLOj1>; Tue, 12 Nov 2002 09:39:27 -0500
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:40626 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S266626AbSKLOjY>; Tue, 12 Nov 2002 09:39:24 -0500
Date: Tue, 12 Nov 2002 15:46:09 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Linus Torvalds <torvalds@transmeta.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] use 64 bit jiffies 1/4
In-Reply-To: <aqn25i$gm7$1@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0211121528060.3864-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Nov 2002, Linus Torvalds wrote:

> I disagree with the implementation of this (and yes, I would also prefer
> for it to be called "jiffies64_to_clock_t()"):

I'm fine with the name "jiffies_64_to_clock_t()".
I'd like "jiffies64_to_clock_t()" (without the first underscore)
even more, but this is inconsistent with jiffies_64. (And I don't know if
we want to rename the latter now)

> This is wrong. You should really start off by fixing the 32-bit case,
> since even that needs fixing anyway (some interfaces really _are_
> 32-bit, and cannot be expanded). 
> 
> It also only works for cases where HZ is a direct multiple of USER_HZ,
> and yes, my original code has the same problem, but that's not a good
> excuse to make it worse.  I think it should be fairly straightforward to
> get this right, and have a simple

OK, changed my patch to

+#if (HZ % USER_HZ)==0
 # define jiffies_to_clock_t(x) ((x) / (HZ / USER_HZ))
+#else
+# define jiffies_to_clock_t(x) ((clock_t) jiffies_64_to_clock_t((u64) x))
+#endif
+
+static inline u64 jiffies_64_to_clock_t(u64 x)
+{
+#if (HZ % USER_HZ)==0
+       do_div(x, HZ / USER_HZ);
+#else
+       /*
+        * There are better ways that don't overflow early,
+        * but even this doesn't overflow in hundreds of years
+        * in 64 bits, so..
+        */
+       x *= USER_HZ;
+       do_div(x, HZ);
+#endif
+       return x;                                                       
+}

I'll send the full new set of patches off-list. They can also be retrieved 
from
  http://www.physik3.uni-rostock.de/tim/kernel/2.5/jiffies64-32a.patch.gz
    (1/4: infrastructure)
  http://www.physik3.uni-rostock.de/tim/kernel/2.5/jiffies64-32b.patch.gz
    (2/4: fix uptime wrap)
  http://www.physik3.uni-rostock.de/tim/kernel/2.5/jiffies64-32c.patch.gz
    (3/4: 64 bit process start time)
  http://www.physik3.uni-rostock.de/tim/kernel/2.5/jiffies64-32d.patch.gz
    (4/4: use unsigned long for cpu statistics)

> (And yes, the above does not return a clock_t, it returns a 64-bit
> thing, but people who need to can truncate it to clock_t and live with
> the old 497-day overflow of USER_HZ in 32 bits for broken interfaces
> like "clock()".  This way the caller can use the same function for both
> the "true 64-bit result" and the truncated case). 

Hey, this is just why I renamed it from "jiffies_64_to_clock_t()" to 
"jiffies_64_to_user_HZ()" before sending it off :-) 

> And then we should just remove the "jiffies_to_clock_t()" thing, I
> suspect.  The 49-day overflow is just too soon for comfort, you're
> definitely right about that. 

OK, will prepare patch for that later.

Tim

