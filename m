Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132153AbRCVTIh>; Thu, 22 Mar 2001 14:08:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132158AbRCVTIS>; Thu, 22 Mar 2001 14:08:18 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:53479 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S132156AbRCVTIG>;
	Thu, 22 Mar 2001 14:08:06 -0500
Date: Thu, 22 Mar 2001 14:07:23 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Colin Watson <cjw44@flatline.org.uk>
cc: Richard Guenther <richard.guenther@student.uni-tuebingen.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: How to mount /proc/sys/fs/binfmt_misc ?
In-Reply-To: <E14g9p0-0005yj-00@riva.ucam.org>
Message-ID: <Pine.GSO.4.21.0103221338300.5619-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 22 Mar 2001, Colin Watson wrote:

> I would very much like to be able to assume that a filesystem never
> contains two identical filenames linking to different inodes, and that
> any . and .. links I find always point to things that are vaguely like
> directories! I realize that you can't assume much about /proc, and that
> the kernel shouldn't spend forever checking it, but I would hope that
> it's generally expected to conform to basic rules of sanity. I'd like my
> binfmt_misc management tool to be able to say "OK, beware that you can
> screw up your system with this - but if you ask me for a status report
> I'll be able to deliver the right answer". That's what I mean by "manage
> reliably". As it is, I can only guarantee that I'll give the right
> answer to status reports or be able to successfully register and
> unregister even sane binary formats if my program is the only interface
> being used to binfmt_misc, and I'm not doing any expensive checks.

Actually, the right thing to do would be to drop the ugly tricks with
writing to .../register and use normal create()/write()/close() to add
entries. Commit-on-close and there you go. unlink() to remove these
suckers, chmod g-r to disable.

IOW, instead of
echo ':foo:.......' >register		echo ':.....' > /etc/binfmt_misc/foo
echo '-1' > foo				rm /etc/binfmt_misc/foo
echo '0' > foo				chmod g-r /etc/binfmt_misc/foo
echo '1' > foo				chmod g+r /etc/binfmt_misc/foo
echo '-1' > status			rm /etc/binfmt_misc/*
echo '0' > status			chmod -x /etc/binfmt_misc
echo '1' > status			chmod +x /etc/binfmt_misc
cat status				cat /etc/binfmt_misc/*

Normal behaviour instead of black magic, no checks for duplicate entries,
special names, yodda, yodda - everything would work as one expects from
normal directory. When you want to create a file you create it, not write
an incantation into a magic file. And when you want to remove it, the
last thing you would normally think of is writing "-1" into the victim.
Yes, I know that procfs doesn't allow that. Mark the correct conclusion:
	(A)	procfs is not suitable for the task
	(B)	we should invent a kludgy way to create files, etc. on
		procfs without using normal create() and reimplement the
		sanity checks
	(C)	same as (B), but ignore sanity
Your choice being...?

And yes, I'm quite aware of the fact that we are stuck with the current
kludgy API - compatibility issues and all such. Pity, that...

Al, very unimpressed both with design and implementation of that kludge...

