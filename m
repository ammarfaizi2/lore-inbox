Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267285AbSLKTNx>; Wed, 11 Dec 2002 14:13:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267286AbSLKTNw>; Wed, 11 Dec 2002 14:13:52 -0500
Received: from chaos.analogic.com ([204.178.40.224]:51844 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S267285AbSLKTNs>; Wed, 11 Dec 2002 14:13:48 -0500
Date: Wed, 11 Dec 2002 14:24:17 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Justin Hibbits <jrh29@po.cwru.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: Destroying processes
In-Reply-To: <20021211190132.GF147@lothlorien.cwru.edu>
Message-ID: <Pine.LNX.3.95.1021211140643.26467A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Dec 2002, Justin Hibbits wrote:

> Hey 00ber-geeks,
> 
> I'm not subscribed (yet....still too lazy to subscribe ;P ), but I have a
> question and/or suggestion.
> 
> Is there a system call that would destroy a process?  Sometimes I end up with
> zombie processes, other times I end up with a process attaching to a device
> driver, and hanging, so I want to be able to completely destroy the
> process...image, file handle, driver hooks, everything.  If there isn't one,
> and noone wants to do it, I'll gladly do it (may take a few weeks tho).  I just
> don't wanna do what someone else has already done.
> 
> Thanks,
> 
> Justin Hibbits

A process gets destroyed when it calls exit() (actually sys_exit()
in the kernel). However, in Unix/Linux machines, it will wait until
somebody executes wait(), wait3(), or similar procedures to get the
return status of the task. A task that is waiting to be "reaped"
in this manner is called a zombie task and it shows up in `ps` with
a state of "Z".

If you have zombie tasks, they are caused by incorrectly written
programs that fork() child tasks without either setting up a signal
handler for SIGCHLD or, at least executing a wait() to get the
return status. The zombie must be reaped by its parent. This means
that if the parent task didn't do this, or no longer exists, the
zombie will remain until all possible parents (parents of parents)
exit. In that case, the parent of a parents, "init" will (should)
reap the status of the child and throw it away.

So, if you run programs that create zombies, the zombies should
go away as soon as you log-off. If you are running from X-Windows,
you may need to get out of X completely. If the zombies don't go away,
you have a broken `init` which should be replaced. You need to add
the proper code to programs that execute fork(), so that they don't
generate zombies.

Programs that exit always end up closing all file-handles. The kernel
does this automatically. Therefore, there should never be any hung
processes attaching a device driver unless there are errors inside
the device driver. In that case, you need to fix the device driver.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


