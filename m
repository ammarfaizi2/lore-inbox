Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265924AbTLIOwi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 09:52:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265940AbTLIOvm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 09:51:42 -0500
Received: from chaos.analogic.com ([204.178.40.224]:19333 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S265939AbTLIOuj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 09:50:39 -0500
Date: Tue, 9 Dec 2003 09:52:13 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Andrea Arcangeli <andrea@suse.de>
cc: Kristian Peters <kristian.peters@korseby.net>,
       linux-kernel@vger.kernel.org,
       "Robert L. Harris" <Robert.L.Harris@rdlg.net>
Subject: Re: oom killer in 2.4.23
In-Reply-To: <20031209142151.GB12532@dualathlon.random>
Message-ID: <Pine.LNX.4.53.0312090942470.8772@chaos>
References: <Z6Iv-7O2-29@gated-at.bofh.it> <Z8Ag-3BK-3@gated-at.bofh.it>
 <Zbyn-23P-29@gated-at.bofh.it> <20031205140520.39289a3a.kristian.peters@korseby.net>
 <20031205195800.GB2121@dualathlon.random> <20031206103143.027ba4ec.kristian.peters@korseby.net>
 <20031209142151.GB12532@dualathlon.random>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Dec 2003, Andrea Arcangeli wrote:

> On Sat, Dec 06, 2003 at 10:31:43AM +0100, Kristian Peters wrote:
> > Andrea Arcangeli <andrea@suse.de> schrieb:
> > > what you're complaining is the 'selection of the task to be killed'.
> > > That's not solvable. the kernel can't read your brain period. Only if
> > > the kernel could read the brain of the adminstrator then you would be
> > > happy, there is no way the kernel can know which is the task you really
> > > want to have killed first.
> >
> > I agree. On a server the most likely application to be killed would be the service with the most pages in memory. And those services tend to be the important ones.
> >
> > However, for a simple desktop-linux that statistical approach seems to
> > be wrong. Your vm has even killed /sbin/getty sometimes, so that I
> > can't login via a simple console.
>

Not true! Killing a getty or agetty or any other login
program cannot prevent a login! Init will just start another
one if there is enough RAM to fork()/exec(). If there isn't,
it has nothing to do with killing the getties and everything
to do with being completely out of RAM. In that case, you
need to enable quotas and not let fork-bombs or other deliberate
crashers be executed by root.

Script started on Tue Dec  9 09:42:06 2003
# ps
  PID TTY STAT  TIME COMMAND
  478   3 S    0:00 /sbin/agetty 38400 tty3
  479   4 S    0:00 /sbin/agetty 38400 tty4
  480   5 S    0:00 /sbin/agetty 38400 tty5
  481   6 S    0:00 /sbin/agetty 38400 tty6
 4404   1 S    0:00 -bash
 6102   2 S    0:00 -bash
 8772   1 S    0:00 pine
 8778   2 S    0:00 script
 8779   2 S    0:00 script
 8780  p0 S    0:00 bash -i
 8784  p0 R    0:00 ps
# killall -9 agetty
# ps
  PID TTY STAT  TIME COMMAND
 4404   1 S    0:00 -bash
 6102   2 S    0:00 -bash
 8772   1 S    0:00 pine
 8778   2 S    0:00 script
 8779   2 S    0:00 script
 8780  p0 S    0:00 bash -i
 8787   3 S    0:00 /sbin/agetty 38400 tty3
 8788   4 S    0:00 /sbin/agetty 38400 tty4
 8789   5 S    0:00 /sbin/agetty 38400 tty5
 8790   6 S    0:00 /sbin/agetty 38400 tty6
 8791  p0 R    0:00 ps
# exit
exit

Script done on Tue Dec  9 09:42:41 2003

The above shows 4 getty's being killed. They are immediately
restarted by init. These getties become new shell-tasks in
the following order: exec /sbin/login, exec /bin/bash. There are
no additional forks so, in principle, you have nearly all the
resources needed for a shell as soon as a getty is started.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


