Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261637AbUCBNTM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 08:19:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261642AbUCBNTM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 08:19:12 -0500
Received: from chaos.analogic.com ([204.178.40.224]:25733 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261637AbUCBNTK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 08:19:10 -0500
Date: Tue, 2 Mar 2004 08:20:42 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Mihai RUSU <dizzy@roedu.net>
cc: Ben <linux-kernel-junk-email@slimyhorror.com>,
       linux-kernel@vger.kernel.org
Subject: Re: epoll and fork()
In-Reply-To: <Pine.LNX.4.58L0.0403021454070.20334@ahriman.bucharest.roedu.net>
Message-ID: <Pine.LNX.4.53.0403020809140.15850@chaos>
References: <Pine.LNX.4.58.0403021224520.20736@baphomet.bogo.bogus>
 <Pine.LNX.4.58L0.0403021454070.20334@ahriman.bucharest.roedu.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Mar 2004, Mihai RUSU wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On Tue, 2 Mar 2004, Ben wrote:
>
> > Is there a defined behaviour for what happens when a process with an epoll
> > fd forks?
> >
> > I've an app that inherits an epoll fd from its parent, and then
> > unregisters some file descriptors from the epoll set. This seems to have
> > the nasty side effect of unregistering the same file descriptors from the
> > parent process as well. Surely this can't be right?
> >
> > This is on 2.6.2.
>
> Currect me if Im wrong but...
>
> After a fork() arent all the parent's fds shared with the children ? This
> means that both processes can access the same fds right ? So the epoll fd
> (beeing just another fd as any other) is too shared between parent and
> child ? Which would mean both parent and child will "control" the same
> epoll kernel struct when doing epoll_ctl on it ?
>
> > Ben
>

The child's fds are separate, though. The parent can close
its fds without affecting the child's and the child can close
its fds without affecting the parent. Given that, suppose that
the fds related to a terminal. If the child changed the terminal
attributes, this would certainly affect the parent's terminal
since they are the same. It is possible that epoll handles
these attributes the same way and it is likely that such
behavior is "undefined". A fix may be for the child to dup()
the fds and set up its own epoll_ctl using them. If the epoll
relates to a controlling terminal, it is possible that if the
child executes setsid(), becomes its own session leader, then
the epoll  problem will go away because the parent's controlling
terminal and the child's controlling terminal become divorced.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


