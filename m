Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130434AbRCWJga>; Fri, 23 Mar 2001 04:36:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130438AbRCWJgU>; Fri, 23 Mar 2001 04:36:20 -0500
Received: from fs1.dekanat.physik.uni-tuebingen.de ([134.2.216.20]:18692 "EHLO
	fs1.dekanat.physik.uni-tuebingen.de") by vger.kernel.org with ESMTP
	id <S130434AbRCWJgI>; Fri, 23 Mar 2001 04:36:08 -0500
Date: Fri, 23 Mar 2001 10:34:14 +0100 (CET)
From: Richard Guenther <richard.guenther@student.uni-tuebingen.de>
To: Alexander Viro <viro@math.psu.edu>
cc: Colin Watson <cjw44@flatline.org.uk>,
        Richard Guenther <richard.guenther@student.uni-tuebingen.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: How to mount /proc/sys/fs/binfmt_misc ?
In-Reply-To: <Pine.GSO.4.21.0103221338300.5619-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.30.0103231030060.462-100000@fs1.dekanat.physik.uni-tuebingen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Mar 2001, Alexander Viro wrote:

> Actually, the right thing to do would be to drop the ugly tricks with
> writing to .../register and use normal create()/write()/close() to add
> entries. Commit-on-close and there you go. unlink() to remove these
> suckers, chmod g-r to disable.
>
> IOW, instead of
> echo ':foo:.......' >register		echo ':.....' > /etc/binfmt_misc/foo
> echo '-1' > foo				rm /etc/binfmt_misc/foo
> echo '0' > foo				chmod g-r /etc/binfmt_misc/foo
> echo '1' > foo				chmod g+r /etc/binfmt_misc/foo
> echo '-1' > status			rm /etc/binfmt_misc/*
> echo '0' > status			chmod -x /etc/binfmt_misc
> echo '1' > status			chmod +x /etc/binfmt_misc
> cat status				cat /etc/binfmt_misc/*
>
> Normal behaviour instead of black magic, no checks for duplicate entries,
> special names, yodda, yodda - everything would work as one expects from
> normal directory. When you want to create a file you create it, not write
> an incantation into a magic file. And when you want to remove it, the
> last thing you would normally think of is writing "-1" into the victim.
> Yes, I know that procfs doesn't allow that. Mark the correct conclusion:
> 	(A)	procfs is not suitable for the task
> 	(B)	we should invent a kludgy way to create files, etc. on
> 		procfs without using normal create() and reimplement the
> 		sanity checks
> 	(C)	same as (B), but ignore sanity
> Your choice being...?

My choice would have been (A) if there was a nice way to create small
filesystems at the time I did binfmt_misc. This is also the reason I
dont like your rewrite - it does the same sucky kludges, but with an
own filesystem that could do a lot better - _and_ it breaks
backward compatibility wrt mounting. Doh - I thought you could do
better.

> And yes, I'm quite aware of the fact that we are stuck with the current
> kludgy API - compatibility issues and all such. Pity, that...
>
> Al, very unimpressed both with design and implementation of that kludge...

The first version was w/o /proc support but used sysctl and a userspace
program. But well, people wantet /proc and /proc was sexy, everything
was done using /proc, so I did use it, too. Bad decision - I should have
started rewriting the fs layer at that time...

Richard.

--
Richard Guenther <richard.guenther@student.uni-tuebingen.de>
WWW: http://www.anatom.uni-tuebingen.de/~richi/
The GLAME Project: http://www.glame.de/

