Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263679AbUECNJq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263679AbUECNJq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 09:09:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263686AbUECNJq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 09:09:46 -0400
Received: from chaos.analogic.com ([204.178.40.224]:1923 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263679AbUECNJn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 09:09:43 -0400
Date: Mon, 3 May 2004 09:11:14 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Libor Vanek <libor@conet.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: Read from file fails
In-Reply-To: <20040503000004.GA26707@Loki>
Message-ID: <Pine.LNX.4.53.0405030852220.10896@chaos>
References: <20040503000004.GA26707@Loki>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 May 2004, Libor Vanek wrote:

> Hi,
> can anybody help me with reading from file? I've got this code in my module for 2.6.5-mm6:
>
> char buffer[4096];
> ssize_t read;
> file *f;
> f = filp_open("/some/file",O_RDONLY | O_LARGEFILE,0);
> f->f_pos = 0;
> read = vfs_read(f,(char __user *) buffer,4096,&f->f_pos);
>
>
> but here read value is "-14" :-((( any hints?
>

Sure it's -EFAULT. In user-space, you would get a core-dump.


> It seems that file is opened OK (I've tested:
> if (f->f_op->read) {
> 	read = f->f_op->read(file, buf, count, pos);
> }
> and result was the same - so I assume that file is opened OK and
> structure "file f" is filled correctly.

This has become a FAQ and NO If you know what you are doing, you
NEVER need to read files from within the kernel. PERIOD. There are
Hacks that __sometimes__ allow code to get away with it, but
they are only going to work --- sometimes ---.

>
> I need to copy files (yes - I know that kernel shouldn't do this but I REALLY need) and  there is nothing like "sys_copy" and "sys_sendfile" is not exported (which seems strange to me but there is nothing like EXPORT_SYMBOL(sys_sendfile) in fs/read_write.c
>

I will explain for the Nth time. The kernel is a bunch of code
that performs functions on behalf of a process. It does that in
the context of that process. A file descriptor is a number that
belongs to a process. It is worthless without a process with which
to associate. If the kernel were to open a file, who owns the
file descriptor? The kernel isn't a process, it's a big LIBRARY!
So, if you are lucky, you can steal the context from another
unknowing process. This works unless there was a context-switch or
if the process was asleep so it didn't access any files of
its own. It leaves the kernel in a bad state because there
is a wild file-descriptor that nobody owns that will never be
closed because when your cludge closes that file-descriptor, you
probably end up closing STDOUT_FILENO of some important task
that you haven't discovered yet.

The cludges that work involve creating a "kernel thread" which
has a process context. That thread does the file I/O. However,
it's certainly easier to create a user-mode task (program) that
opens your module and, using an ioctl(), sends it anything from
anywhere in the known universe. You can get data from a file or
from anywhere.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5557.45 BogoMips).
            Note 96.31% of all statistics are fiction.


