Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267774AbUH3MGd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267774AbUH3MGd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 08:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267815AbUH3MGd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 08:06:33 -0400
Received: from mailsc1.simcon-mt.com ([195.27.129.236]:32290 "EHLO
	mailsc1.simcon-mt.com") by vger.kernel.org with ESMTP
	id S267774AbUH3MGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 08:06:21 -0400
Date: Mon, 30 Aug 2004 14:10:12 +0200
From: Andrei Voropaev <avorop@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: Re: with 2.6.7 setitimer called in sequence returns strange values on i686
Message-ID: <20040830121012.GA1938@avorop.local>
References: <20040824144241.GE1527@avorop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040824144241.GE1527@avorop.local>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2004 at 04:42:41PM +0200, Andrei Voropaev wrote:
[...]
> 
> I'm using setitimer(ITIMER_REAL...) to measure time intervals.
> Everything was working fine untill I've installed 2.6.7 kernel. 
[...]
> 
> Previous value of 10 timer is 10.479
> 
> Note the last line. I've reset timer to 10 seconds and setitimer tells
> me that there are 10.479 seconds left.

I'm not sure if it is of particular importance. After checking the
sources it appears that the problem lies with mathematic. New math makes
sure than during conversion of timeval to jiffies bigger number of
jiffies is allocated to force the requirement that timer expires not
earlier than requested. But during conversion from jiffies back to
timeval no reverse adjustment is done, so resulting timeval can be
more than original. From my standpoint this violates the requirement
that the timer is only decremented (thus reduces its value) and not 
incremented.

That is why I believe that the following patch would be correct.

--- ../time.h   2004-08-30 13:59:14.000000000 +0200
+++ include/linux/time.h        2004-08-30 14:00:10.000000000 +0200
@@ -239,7 +239,7 @@
         * Convert jiffies to nanoseconds and separate with
         * one divide.
         */
-       u64 nsec = (u64)jiffies * TICK_NSEC; 
+       u64 nsec = (u64)jiffies * TICK_NSEC - (TICK_NSEC / 2); 
        value->tv_sec = div_long_long_rem(nsec, NSEC_PER_SEC, &value->tv_nsec);
 }

Well, this might be minor issue since normally nobody should call getitimer immidiately after setitimer, but still...

> I have one more machine with 2.6.7 kernel. But that machine is Athlon64
> and runs 64-bit kernel. There the program also runs correctly.

The above is not true. The problem appears on 64-bit kernel as well.
Just for different numbers :)

Andrei
