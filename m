Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264974AbSJPIeG>; Wed, 16 Oct 2002 04:34:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264975AbSJPIeG>; Wed, 16 Oct 2002 04:34:06 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:17739 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S264974AbSJPIeD>; Wed, 16 Oct 2002 04:34:03 -0400
Date: Wed, 16 Oct 2002 07:06:42 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Srihari Vijayaraghavan <harisri@bigpond.com>
Cc: linux-kernel@vger.kernel.org, hpj@urpla.net,
       mcelrath+kernel@draal.physics.wisc.edu, pellegrini@mpcnet.com.br,
       lists@sapience.com, mroos@linux.ee, willi@7val.com
Subject: Re: 2.4.20-pre10aa1 oops report (was Re: Linux-2.4.20-pre8-aa2 oops report. [solved]) [solved2? ac97]
Message-ID: <20021016050642.GB6276@dualathlon.random>
References: <fd1cf102287.102287fd1cf@bigpond.com> <200210152305.32641.harisri@bigpond.com> <200210160013.02220.harisri@bigpond.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210160013.02220.harisri@bigpond.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2002 at 12:13:02AM +1000, Srihari Vijayaraghavan wrote:
> Hello,
> 
> > That precisely is the reason. The bad news is that system crashes when
> > agpgart and radeon are compiled as modules, and the good news is that I am
> > unable to crash it when they are not.
> 
> My goodness, I have spoken too early I guess. The -aa kernel crashes whether 
> agpgart and radeon are modules or not.

I'm running this kernel for 5 days now very often under heavy load (also with
thousand of tasks with volanomark in background and aio and flood of writes
from /dev/zero), and there's no sign of instability (besides a rare tcp race
that is been reported for 2.4.19 on l-k too, not fatal, it only deadlocks the
tcp connection and you've to kill the task because readmsg will never return
until it gets a signal, I tried to debug it but with no luck yet, but
that is also most certainly a mainline issue too and it triggers only
during heavy load).

You probably did something incidentally (not part of your regression
test loop) that corrupted memory. The regression test is a workload that
will show you if the corruption has happened in the past or not, but the
regression test loop is not the thing that is generating the corruption.
The regression test loop is what gets _harmed_ by the corruption, it's
not the culprit.

My crystall ball is telling me that you could reproduce it easily on my
tree because when you feel finally stable and that you can restart doing
your usual work without worrying about oopses, you enjoy yourself
playing some music to relax. And you instead don't play music while you
try to reproduce the problem because you're busy looking at stressing
the kernel and in turn you can't reproduce the bug. Is she right? ;)

Please try with CONFIG_SOUND=n and make sure to run:

	rm -r /lib/modules/2.4.20-pre10aa1

before "make modules_install" to avoid running stale modules (also enable
modversions just in case).

I see a pile of oopses all showing ac97 loaded into the kernel, some
also for 2.4.19, but they may be unrelated problems of course. A number
of reports showing definitive random mm corruption like yours on top of
2.4.20-pre vanilla (not -aa) are most certainly been affected too by the
ac97 bug (I'm CC'ing the other affected testers, they can try as well
the same as you). I never tried ac97 (I've a couple of boxes that could
handle it, but I never attempted to play sound on those yet and the
chipset may be different so it may not trigger for me after all even if
I could load that module).

Hint: in the past I found easier to reproduce various module bugs with a
loop like this:

	while :; do insmod ac97_codec.o; rmmod ac97_codec.o; done

you can try the above and see if it trigger in seconds.

>From the l-k db grepping it seems the bug is been introduced in 2.4.19.
So I would suggest you to try to reproduce after a:

	rm -r 2.4.20pre10aa1/drivers/sound
	cp -a 2.4.18/drivers/sound 2.4.20pre10aa1/drivers
	cd 2.4.20pre10aa1; make oldconfig ...

(of course you can replace 2.4.20pre10aa1 with 2.4.20pre11 vanilla or
2.4.20pre10ac2)

and see if the instability goes away?

Marcelo also included some further ac97 patch in pre11, maybe
2.4.20pre11aa1 will fix it, you may want to give it a try too when I
release it (OTOH, I'm fixing what seems to be a design bug in the o1
scheduler that is apparently generatating an huge cpu waste, so I don't
guarantee that the very first release with these changes will be as
solid as 2.4.20pre10aa1 ;)

Thanks for all the reports,

Andrea
