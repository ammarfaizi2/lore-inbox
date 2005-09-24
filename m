Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750727AbVIXUVx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750727AbVIXUVx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Sep 2005 16:21:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750728AbVIXUVx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Sep 2005 16:21:53 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:27910 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1750727AbVIXUVw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Sep 2005 16:21:52 -0400
Date: Sat, 24 Sep 2005 22:21:31 +0200
From: Willy TARREAU <willy@w.ods.org>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Andrew Morton <akpm@osdl.org>, Nishanth Aravamudan <nacc@us.ibm.com>,
       Nish Aravamudan <nish.aravamudan@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] fixes for overflow in poll(), epoll(), and msec_to_jiffies()
Message-ID: <20050924202131.GA4048@pcw.home.local>
References: <Pine.LNX.4.63.0509231108140.10222@localhost.localdomain> <20050924040534.GB18716@alpha.home.local> <29495f1d05092321447417503@mail.gmail.com> <20050924061500.GA24628@alpha.home.local> <20050924171928.GF3950@us.ibm.com> <Pine.LNX.4.63.0509241120380.31327@localhost.localdomain> <20050924193839.GB26197@alpha.home.local> <Pine.LNX.4.63.0509241301440.31327@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0509241301440.31327@localhost.localdomain>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 24, 2005 at 01:08:22PM -0700, Davide Libenzi wrote:
> On Sat, 24 Sep 2005, Willy Tarreau wrote:
> 
> >Hello,
> >
> >After the discussion around epoll() timeout, I noticed that the functions 
> >used
> >to detect the timeout could themselves overflow for some values of HZ.
> >
> >So I decided to fix them by defining a macro which represents the maximal
> >acceptable argument which is guaranteed not to overflow. As an added bonus,
> >those functions can now be used in poll() and ep_poll() and remove the 
> >divide
> >if HZ == 1000, or replace it with a shift if (1000 % HZ) or (HZ % 1000) is 
> >a
> >power of two.
> 
> Why all that code, when you can have it with:
> 
> #define MAX_LONG_MSTIMEO (long) min(1000ULL * MAX_SCHEDULE_TIMEOUT / HZ, 
> LONG_MAX / HZ - 1000ULL)
> 
> that gcc-O2 collapses into a single constant?

It is because I wanted to ensure that it matched exactly the limits of the
functions that we call. And since msec_to_jiffies() is defined in 3 possible
ways depending on HZ, 1000 % HZ and HZ % 1000, there are 3 different limits.

Then, once the msec_to_jiffies() function is fixed, it's valuable to use it
in ep_poll(), because its worst case does exactly what you already have
(timeout * HZ + 999) / 1000, and other optimal cases can do better (for
HZ=100, 250, 1000, there will be no divide at all).

Don't worry, in my case, gcc also produces a single constant. That's just
that it depends on how it will be used (check include/linux/jiffies.h,
you'll understand what I mean).

Regards,
Willy

