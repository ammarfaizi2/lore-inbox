Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262172AbSITJ2G>; Fri, 20 Sep 2002 05:28:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262137AbSITJ2F>; Fri, 20 Sep 2002 05:28:05 -0400
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:41746 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S262113AbSITJ2C>; Fri, 20 Sep 2002 05:28:02 -0400
Date: Fri, 20 Sep 2002 11:32:42 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Rusty Russell <rusty@rustcorp.com.au>
cc: kaos@ocs.com.au, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] In-kernel module loader 1/7 
In-Reply-To: <20020920000502.242CF2C100@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0209201105330.338-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 20 Sep 2002, Rusty Russell wrote:

> 1) You keep ignoring the load race problem.  Your solution does not
>    solve that, so you will need something else as well.

Could you please explain, why you think I'm ignoring this problem?
(I think I don't, but I want to be sure we talk about the same problem.)

> 2) Several places in the kernel do *not* keep reference counts, for
>    example net/core/dev.c's dev_add_pack and dev_remove_pack.  You
>    want to add reference counts to all of them, but the only reason
>    for the reference counts is for module unload: you are penalizing
>    everyone just *in case* one is a module.

For an alternative solution:
http://marc.theaimsgroup.com/?l=linux-kernel&m=103246649130126&w=2

> 3) The cost of doing atomic_incs and decs on eg. our network performance
>    is simply unacceptable.  The only way to avoid hitting the same
>    cacheline all the time is to use bigrefs, and the kernel bloat will
>    kill us (and they're still not free for the 99% of people who don't
>    have IPv4 and TCP as modules).

Even your bigref is still overkill. When packets come in, you already have
to take _some_ lock, under the protection of this lock you can implement
cheap, simple, portable and cache friendly counts, which can be used for
synchronization.

> 4) Your solution does not allow implementation of "rmmod -f" which
>    prevents module count from increasing, and removes it when it is
>    done.  This is very nice when your usage count is controlled by an
>    external source (eg. your network).

Multiple possible solutions:
- Separate stop/exit is probably the most elegant solution.
- A call to exit does in any case start the removal of the module, that
means it starts removing interface (and which won't get reinstalled).
If there is still any user, exit will fail, you can try it later again
after you killed that user.
Anyway, almost any access to a driver goes through the filesystem and
there it's a well known problem of unlinked but still open files. Driver
access is pretty much the same problem to which you can apply the same
well known solutions.

bye, Roman

