Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261577AbRE0TWR>; Sun, 27 May 2001 15:22:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261615AbRE0TV6>; Sun, 27 May 2001 15:21:58 -0400
Received: from chiara.elte.hu ([157.181.150.200]:48392 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S261577AbRE0TVu>;
	Sun, 27 May 2001 15:21:50 -0400
Date: Sun, 27 May 2001 21:19:41 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: "David S. Miller" <davem@redhat.com>
Cc: <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Subject: Re: [patch] softirq-2.4.5-B0
In-Reply-To: <15121.21054.657593.830199@pizda.ninka.net>
Message-ID: <Pine.LNX.4.33.0105272114350.5852-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 27 May 2001, David S. Miller wrote:

> Hooray, some sanity in this thread finally :-)

[ finally i had some sleep after a really long debugging session :-| ]

>  > the attached softirq-2.4.5-B0 patch fixes this problem by calling
>  > do_softirq()  from local_bh_enable() [if the bh count is 0, to avoid
>  > recursion].
>
> Yikes!  I do not like this fix.

i think we have no choice, unfortunately.

and i think function calls are not that scary anymore, especially not with
regparms and similar compiler optimizations. The function is simple, the
function just goes in and returns in 90% of the cases, which should be
handled nicely by most BTBs.

we have other fundamental primitives that are a function call too, eg.
dget(), and they are used just as frequently. In 2.4 we were moving
inlined code into functions in a number of cases, and it appeared to work
out well in most cases.

> I'd rather local_bh_enable() not become a more heavy primitive.
>
> I know, in one respect it makes sense because it parallels how
> hardware interrupts work, but not this thing is a function call
> instead of a counter bump :-(

i believe the important thing is that the function has no serialization or
other 'heavy' stuff. BHs had the misdesign of not being restarted after
being re-enabled, and it caused performance problems - we should not
repeat history.

	Ingo

