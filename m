Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264824AbTFBSCP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 14:02:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264827AbTFBSCO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 14:02:14 -0400
Received: from chaos.analogic.com ([204.178.40.224]:30605 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264824AbTFBSCL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 14:02:11 -0400
Date: Mon, 2 Jun 2003 14:18:16 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Jody Pearson <J.Pearson@cern.ch>
cc: linux-kernel@vger.kernel.org
Subject: Re: Documentation / code sample wanted.
In-Reply-To: <Pine.LNX.4.44.0306021939490.31408-100000@lxplus077.cern.ch>
Message-ID: <Pine.LNX.4.53.0306021409080.17768@chaos>
References: <Pine.LNX.4.44.0306021939490.31408-100000@lxplus077.cern.ch>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Jun 2003, Jody Pearson wrote:

> Hi All,
>
> I am looking for some source code or a document which outlines how to open
> a TCP connection within kernel space.
>
> After many google searches, and a search of the archives, I cannot seem to
> find an example which says "do this".
>
> There are many references to sk_buff and friends, but nothing more
> practical.
>
> I have looked over khttpd, which has been some help, and I looked briefly
> at the nfs code, but I don't want to use RPC.
>
> Can anybody point me to a document/code/patch to help me out ?
>
> For more information, I basically want to emulate a userland
> gethostbyname() in kernel space.
>
> Thanks
>
> Jody
>
> --
> Chaos, Panic, Pandemonium...  my work here is done.


This has become a FAQ, probably because people
don't know what a kernel is. They think it's
just some 'C' code in which you can do anything
the 'C' compiler lets you do.

Important! The kernel is not a 'task' it doesn't
have a context. Everything it has been designed
to do, is to perform systematic tasks upon behalf
of the caller, calling from user-mode context.
When it is executing, it is executing upon behalf
of a user-mode task. It is doing what the user-mode
task doesn't know how, or isn't trusted, to do.

The only thing that can call the kernel and
successfully accomplish what it intended to do, is
a user-mode task. Therefore, if you want to call
the kernel, you do it from a user-mode program.
It's just that simple.

For some reason, you want to translate the name
of a host to its IP address or vice-versa from
inside the kernel. Notwithstanding that it is
patently absurd to require such text translation
inside the kernel, it certainly is possible.
The kernel code (a module) needs a user-mode
daemon to perform user-mode tasks on its behalf.

This is bas-ackwards because code should be written
the other way around, i.e., the kernel performs
tasks upon behalf of a calling task.

You do this, by creating a user-mode daemon that
sleeps in select() or poll() until the kernel code
wakes it, using wake_up_interruptible(), after
making information available (probably via ioctl())
about what the kernel code wants it to do. The user-
mode daemon, awakened from poll() will perform an
ioctl() and find out what the kernel code wants it
to do. It will then do it, and pass the information
to the kernel code via ioctl(), read() or write().
The kernel code will 'know" when the information
has been returned because the user-mode daemon will
then sleep in poll() or select() again.

You can also create a "kernel thread" to do something
like this. However, nothing in the kernel can use the
'C' runtime library, running the risk of the kernel
being called from that library. The interface to
socket() stuff is a single kernel function, socketcall,
function number 102. You don't want to have to do
all the socket stuff by hand, you really want to
use the 'C' runtime library, so you must use a user-
mode daemon instead of a kernel thread.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

