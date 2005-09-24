Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932200AbVIXRW7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932200AbVIXRW7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Sep 2005 13:22:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932201AbVIXRW7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Sep 2005 13:22:59 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:17158 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S932200AbVIXRW6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Sep 2005 13:22:58 -0400
Date: Sat, 24 Sep 2005 19:20:11 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Willy Tarreau <willy@w.ods.org>,
       Nish Aravamudan <nish.aravamudan@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] sys_epoll_wait() timeout saga ...
Message-ID: <20050924172011.GA25997@alpha.home.local>
References: <Pine.LNX.4.63.0509231108140.10222@localhost.localdomain> <20050924040534.GB18716@alpha.home.local> <29495f1d05092321447417503@mail.gmail.com> <20050924061500.GA24628@alpha.home.local> <Pine.LNX.4.63.0509240800020.31060@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0509240800020.31060@localhost.localdomain>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 24, 2005 at 08:10:32AM -0700, Davide Libenzi wrote:
> >+       jtimeout = timeout < 0 || \
> >+                    timeout >= (1000ULL * MAX_SCHEDULE_TIMEOUT / HZ) || 
> >\
> >+                    timeout >= (LONG_MAX / HZ - 1000) ?
> >                  MAX_SCHEDULE_TIMEOUT: (timeout * HZ + 999) / 1000;
> >
> >as both are constants, they can be optimized. Otherwise, we can resort to
> >using a MAX() macro to reduce this to only one test which will catch all
> >corner cases.
> 
> Using the MIN() macro would be better so we have a single check, and the 
> compiler optimize that automatically.

you're right, it's MIN() not MAX() ;-)
Anyway, I've checked the code and the compiler does a single test with -O2.

> Or we can force 'timeout * HZ' to use ULL math. I don't think it makes a lot of difference for something that is in a likely sleep path ;)

"likely", yes, but not necessarily. Under a high load, you can have enough
events queued so that epoll() will not wait at all. I've already encountered
such cases during benchmarks, and I noticed that epoll() took more time than
select() for small numbers of FDs (something like 20% below 100 FDs), but of
course, it is considerably faster above. So turning the multiply to an ULL
may increase this overhead on some architectures, while the double check
will leave the code identical.

Regards,
Willy

