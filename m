Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131489AbRCXMOW>; Sat, 24 Mar 2001 07:14:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131526AbRCXMOL>; Sat, 24 Mar 2001 07:14:11 -0500
Received: from [195.67.32.61] ([195.67.32.61]:3856 "EHLO actionbase.se")
	by vger.kernel.org with ESMTP id <S131489AbRCXMOC>;
	Sat, 24 Mar 2001 07:14:02 -0500
Message-ID: <3ABC8F97.88806231@marasystems.com>
Date: Sat, 24 Mar 2001 13:14:15 +0100
From: Henrik Nordstrom <hno@marasystems.com>
Organization: MARA Systems
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.3-pre3-hno i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Henrik Nordstrom <hno@actionbase.se>
CC: linux-kernel@vger.kernel.org
Subject: sigtimedwait timeout
In-Reply-To: <39CB844E.5ECBEA20@actionbase.se>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Noticed that my sigtimedwait timeout patch got into the kernel, so polled signal I/O should now
work much better.

The question on why the timeout is calculated with an +1 for non-zero timeouts is still open.
AFAICT is is not needed as timespec_to_jiffies() does a correct rounding. The effect now is

 timeout    sleeping
 0          0
 1ns        2 jiffies
 1 jiffies  2 jiffies
 2 jiffies  3 jiffies
 3 jiffies  4 jiffies
 ...

If the "+1" is taken out then the timeout scale becomes the expected one, starting at 1 jiffie, not
2.


--
Henirk Nordstrom


Henrik Nordstrom wrote 22 September 2000:

> As I mentioned earlier sigtimedwait with a zero timeout (0,0) should not
> block, but it currently does for 10msec (one jiffie). This is a
> performance problem for applications using polled signal queues. SUSV2
> says specifically for this case "returns immediately with an error".
>
> Attached is a new version of my patch. The previous version messed up
> the signal mask if the signal queue was empty and a zero timeout was
> selected.
>
> It is still waiting one more jiffie than what is indicated by the
> timeout value if other than zero, caused by the following code fragment:
>
>                         timeout = (timespec_to_jiffies(&ts)
>                                    + (ts.tv_sec || ts.tv_nsec));
>
> Does anyone have any clue on why this +1 is there? I think this should
> also go away to only read
>
>                         timeout = timespec_to_jiffies(&ts);
>
> --
> Henrik Nordstrom

[patch deleted]


