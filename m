Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263804AbTEFPUQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 11:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263809AbTEFPUQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 11:20:16 -0400
Received: from chaos.analogic.com ([204.178.40.224]:35201 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263804AbTEFPUM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 11:20:12 -0400
Date: Tue, 6 May 2003 11:34:53 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Sumit Narayan <sumit_uconn@lycos.com>
cc: Matti Aarnio <matti.aarnio@zmailer.org>, linux-kernel@vger.kernel.org
Subject: Re: Write file in EXT2
In-Reply-To: <DCFLDJPJGNMBCDAA@mailcity.com>
Message-ID: <Pine.LNX.4.53.0305061115160.6637@chaos>
References: <DCFLDJPJGNMBCDAA@mailcity.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 May 2003, Sumit Narayan wrote:

> Thanks for the details,
>
> But I would like to know when each FS is being accessed, and by
> which application. Isnt there a single path, say something in the
> driver code, from where all write/read commands pass? So that we
> can have a function call from that place, and create a log?
>

The proper place for this is between the 'C' runtime library
and the kernel. You can use ld.so.preload to attach your hooks
into some code that communicates with a user-mode daemon and
writes a log of the file-system activity.

This will not catch statically-linked programs or programs
written in assembly that don't use the 'C' shared library,
but these are not normal programs.

> And also, how do I create a logfile on my own. With my own function
> within the kernel. I dont wish to go to Userland and do the write
> process.
>

Please fix your mail program, UNIX/Linux text has a control
character after, roughly 79 characters, to continue the string
on the left-hand side of the screen. This is unlike Windows
that assumes you are peering into some RAM in a garbage dump.

> Thanks in advance.
>
> Sumit
>

You use a kernel thread. The kernel is designed to perform tasks
on behalf of a caller. Therefore, it doesn't have a context.
Therefore, a particular file-number doesn't mean anything without
its association with some process ID. You can either steal the
context of some unweary user and screw up its file-system access,
or you can make your own process, called a kernel thread. A
kernel thread has its own context so file system access works.
However, you cannot call the kernel from within the kernel, so
you can't use 'C' runtime libraries, etc. Instead, you call things
like sys_open() to open a file, sys_close() to close it, etc.

Also, don't assume that /var/log actually exists. The kernel may
be alive and well without a mounted file-system, and without
anything writable in the file-system.

It is definitely not a good idea to perform file-system access
from within your 'driver'. When you do this, you are not making
a driver, but a kludge.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

