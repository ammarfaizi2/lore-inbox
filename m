Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312928AbSDKUnk>; Thu, 11 Apr 2002 16:43:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312930AbSDKUnj>; Thu, 11 Apr 2002 16:43:39 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:5644 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S312928AbSDKUnh>; Thu, 11 Apr 2002 16:43:37 -0400
Message-ID: <3CB5E6E4.981B8C0D@zip.com.au>
Date: Thu, 11 Apr 2002 12:41:24 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: the oom killer
In-Reply-To: <20020405164348.K32431@dualathlon.random> <Pine.LNX.4.21.0204051844521.11472-100000@freak.distro.conectiva> <20020411151353.K14605@dualathlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> > How did you fixed this specific problem?
> 
> I didn't really fixed it, it's just that the problem never existed in my
> tree. I don't" min += z->pages_min" and so the
> check_classzone_need_balance path sees exactly the same state of the VM
> as the main allocator, so if it breaks the loop the main allocator will
> go ahead just fine.

Yup, we need to pull that fix into 2.4.

wrt the oom-killer, I think we can keep everyone happy by
implementing both solutions ;)  If the aa approach reaches
the point where it will fail a page allocation we run the
oom-killer, yield and then have another go at the allocation.
Do that a couple of times and *then* fail the page allocation.

This fixes the problem where the VM will (effectively) kill
a randomly chosen process rather than a deliberately chosen
one, and fixes the lockup problem which Andrea identifies,
where the victim process is stuck somewhere in-kernel
ignoring signals.

It'd be nice if the second and subsequent passes of the oom
killer were able to note that a kill was already outstanding,
so they don't just kill the same process all the time.  Or
perhaps the oom killer should just skip over processes which
are in TASK_UNINTERRUPTIBLE.  Probably this is getting a
little too elaborate.  Generally, the oom killer works OK
as-is (that is, it kills stuff and the machine recovers.
I won't vouch for the accuracy of its targetting).

-
