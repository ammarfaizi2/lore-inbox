Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264105AbUEDAoR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264105AbUEDAoR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 20:44:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264134AbUEDAoR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 20:44:17 -0400
Received: from chaos.analogic.com ([204.178.40.224]:30339 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264105AbUEDAoN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 20:44:13 -0400
Date: Mon, 3 May 2004 20:47:54 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Libor Vanek <libor@conet.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: Read from file fails
In-Reply-To: <20040503150606.GB6411@Loki>
Message-ID: <Pine.LNX.4.53.0405032020320.12217@chaos>
References: <20040503000004.GA26707@Loki> <Pine.LNX.4.53.0405030852220.10896@chaos>
 <20040503150606.GB6411@Loki>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 May 2004, Libor Vanek wrote:

> > I will explain for the Nth time. The kernel is a bunch of code
> > that performs functions on behalf of a process. It does that in
> > the context of that process. A file descriptor is a number that
> > belongs to a process. It is worthless without a process with which
> > to associate. If the kernel were to open a file, who owns the
> > file descriptor? The kernel isn't a process, it's a big LIBRARY!
>
> OK - speaking of this I just want call one public (exported) function
> of library from another.
>


No, you are corrupting the library by inserting a "man in the middle".
The man in the middle needs resources and can only steal them
because he doesn't have his own context.

> > So, if you are lucky, you can steal the context from another
> > unknowing process. This works unless there was a context-switch or
> > if the process was asleep so it didn't access any files of
> > its own. It leaves the kernel in a bad state because there
> > is a wild file-descriptor that nobody owns that will never be
> > closed because when your cludge closes that file-descriptor, you
> > probably end up closing STDOUT_FILENO of some important task
> > that you haven't discovered yet.
> >
> > The cludges that work involve creating a "kernel thread" which
> > has a process context. That thread does the file I/O. However,
> > it's certainly easier to create a user-mode task (program) that
> > opens your module and, using an ioctl(), sends it anything from
> > anywhere in the known universe. You can get data from a file or
> > from anywhere.
>
> OK - so speaking of kernel thread - what function should I use?
> Or do you think that only the difference of having process context
> and  pid will cause read to work? (I'm willing to believe it ;-) -
> I'll try it later)
>

Search existing drivers for "kernel_thread"
		.../linux/drivers/net/8139too.c is a start.

And yes, kernel threads work. Pay particular attention to the
way to run one down before you remove your module. They can
do everything user-mode code can do and have the priviliges to
totally screw up anything and everything in the kernel.

> I think there are reasons (speed, speed, speed...)  why some things

Wrong. The kernel was designed to perform services on behalf of
a user-mode task. That's how it will function the fastest. There is
no "speed advantage" to kernel mode, only the lack of memory
and instruction protection. None of these kernel mode instructions
have anything to do with speed (except the ability to STOP everything)
with cli;hlt. Then you have no speed at all.

> should be done kernel-space. And I think that this is one of them.
> I know that I'll never want to "send data from anywhere in the known
> universe" (famous last words?) - I just need to create backup copy of
> file.
>
>
> Libor

Common problem when persons first see the kernel code. They say;
"Oh it's just 'C'! I can write this. I know 'C'! Next thing you
know, they are trying to read/write files inside the kernel.
Before you write kernel code, you need to understand what the
kernel DOES.  Bottom line, it does the stuff that user-mode
code isn't allowed to do on its own. For instance, user mode
code can't be allowed to read/write files on its own because
(1) it doesn't know how to do it, and (2) it could screw up
the entire file-system either accidentally or on purpose.
Therefore the  kernel does it for the user task, but on behalf of the
user.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5557.45 BogoMips).
            Note 96.31% of all statistics are fiction.


