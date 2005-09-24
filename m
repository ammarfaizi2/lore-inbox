Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751454AbVIXHdJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751454AbVIXHdJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Sep 2005 03:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751456AbVIXHdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Sep 2005 03:33:09 -0400
Received: from mail21.sea5.speakeasy.net ([69.17.117.23]:21681 "EHLO
	mail21.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1751454AbVIXHdI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Sep 2005 03:33:08 -0400
Date: Sat, 24 Sep 2005 00:33:05 -0700 (PDT)
From: Vadim Lobanov <vlobanov@speakeasy.net>
To: Willy Tarreau <willy@w.ods.org>
cc: Nish Aravamudan <nish.aravamudan@gmail.com>,
       Davide Libenzi <davidel@xmailserver.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] sys_epoll_wait() timeout saga ...
In-Reply-To: <20050924061500.GA24628@alpha.home.local>
Message-ID: <Pine.LNX.4.58.0509240030370.24744@shell2.speakeasy.net>
References: <Pine.LNX.4.63.0509231108140.10222@localhost.localdomain>
 <20050924040534.GB18716@alpha.home.local> <29495f1d05092321447417503@mail.gmail.com>
 <20050924061500.GA24628@alpha.home.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Sep 2005, Willy Tarreau wrote:

> On Fri, Sep 23, 2005 at 09:44:10PM -0700, Nish Aravamudan wrote:
> > > >        * that why (t * HZ) / 1000.
> > > >        */
> > > > -     jtimeout = timeout == -1 || timeout > (MAX_SCHEDULE_TIMEOUT - 1000) / HZ ?
> > > > +     jtimeout = timeout < 0 || (timeout / 1000) >= (MAX_SCHEDULE_TIMEOUT / HZ) ?
> > > >               MAX_SCHEDULE_TIMEOUT: (timeout * HZ + 999) / 1000;
> > >
> > > Here, I'm not certain that gcc will optimize the divide. It would be better
> > > anyway to write this which is equivalent, and a pure integer comparison :
> > >
> > > +       jtimeout = timeout < 0 || timeout >= 1000 * MAX_SCHEDULE_TIMEOUT / HZ ?
> > > >               MAX_SCHEDULE_TIMEOUT: (timeout * HZ + 999) / 1000;
> >
> > Just a question here, maybe it's dumb.
>
> Your question is not dumb, this code is not trivial at all !
>
> > * and / have the same priority in the order of operations, yes? If so,
> > won't the the 1000 * MAX_SCHEDULE_TIMEOUT overflow
> > (MAX_SCHEDULE_TIMEOUT is LONG_MAX)?
>
> Yes it can, and that's why I said that gcc should send a warning when
> comparing an int with something too large for an int. But I should have
> forced the constant to be evaluated as long long. At the moment, the
> constant cannot overflow, but it can reach a value so high that
> timeout/1000 will never reach it. Example :
>   MAX_SCHEDULE_TIMEOUT=LONG_MAX
>   HZ=250
>   timeout=LONG_MAX-1
>   => timeout/1000 < MAX_SCHEDULE_TIMEOUT/HZ
>   but (timeout * HZ + 999) / 1000 will still overflow !
>
> So I finally think that the safest test would be to avoid the timeout
> range which can overflow in the computation, using something like this
> (but which will limit the timeout to 49 days on HZ=1000 machines) :
>
> +       jtimeout = timeout < 0 || \
> +                    timeout >= (1000ULL * MAX_SCHEDULE_TIMEOUT / HZ) || \
> +                    timeout >= (LONG_MAX / HZ - 1000) ?
>                    MAX_SCHEDULE_TIMEOUT: (timeout * HZ + 999) / 1000;

It seems that we can make the second overflow test be less strict by
doing the following instead:
    timeout >= (LONG_MAX - 1000) / HZ
Unless I'm confused. :-)

> as both are constants, they can be optimized. Otherwise, we can resort to
> using a MAX() macro to reduce this to only one test which will catch all
> corner cases.
>
> > I really think this code just move
> > to the same thing that sys_poll() does to avoid overlflow (I fixed the
> > bug Alexey was experiencing, so I think the changes are safe now).
>
> I'm not totally certain that all overflows are avoided, see above. If
> you play with timeout values close to LONG_MAX / HZ, you're still not
> caught by the test and can overflow in the multiply.
>
> > In any case, this code is approaching unreadable with lots of jiffies
> > <--> human-time units manipulations done in non-standard ways, which
> > the updated sys_poll() also tries to avoid.
>
> I've not checked sys_poll(), but I agree with you that it's rather
> difficult to imagine all corner cases this way.
>
> Regards,
> Willy
>

-Vadim Lobanov
