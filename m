Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264369AbUEDNsX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264369AbUEDNsX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 09:48:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264368AbUEDNsX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 09:48:23 -0400
Received: from chaos.analogic.com ([204.178.40.224]:59011 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264370AbUEDNrP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 09:47:15 -0400
Date: Tue, 4 May 2004 09:49:06 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Libor Vanek <libor@conet.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: Read from file fails
In-Reply-To: <20040504011957.GA20676@Loki>
Message-ID: <Pine.LNX.4.53.0405040947070.13706@chaos>
References: <20040503000004.GA26707@Loki> <Pine.LNX.4.53.0405030852220.10896@chaos>
 <20040503150606.GB6411@Loki> <Pine.LNX.4.53.0405032020320.12217@chaos>
 <20040504011957.GA20676@Loki>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 May 2004, Libor Vanek wrote:

[SNIPPED...all]

Did you catch this information? If all you want to do is to
make a new version of a file, owned by the person who accesses the file
(like VAX/VMS), then you trap open with O_RDWR or O_CREAT or O_TRUNC
and make a copy with a numeral appended like: filename.typ;2.

You do this by making a shared object that does what you want.
The total affect upon user-mode code is a delayed (slow) open().


>From der.eremit@email.de Tue May  4 09:21:52 2004
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
From: Pascal Schmidt <der.eremit@email.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Reading from file in module fails

On Mon, 03 May 2004 14:50:10 +0200, you wrote in linux.kernel:

> That can all be done in userspace.
>
> $ export LD_PRELOAD=3Dlibcopyfilesbeforemodify.so
>
> You just need to program a library that provides all functions that
> modify files (eg. write, open with O_CREAT, ...) and you're done - 100%
> in userspace.

This won't catch asm programs that do syscalls by hand or statically
linked programs. If you really need to catch all write accesses, it
needs to be done in the kernel, probably as an LSM hook or something.

-- 
Ciao,
Pascal


Now, if you need to squirrel the file away to some secret location
owned by root, then you might want to use a kernel thread. It will
take the same time and delay the open the same amount.
Kernel mode is all about privilige, not about speed. A user-mode
program daemon that operates as root, could also perform the
same function by having the LD_PRELOAD code pipe information to
it. One needs to make sure that the daemon as finished copying
the file before the open() returns of it would be possible for
the original caller to trash the file before it was copied.

If I were given the task of; "Make sure that an idiot can't
delete his files in such a way they can't be restored....".
I'd use a daemon, simply because it's easier and more
interesting. Also, the daemon is configurable. It can read
some configuration file and the password file to find out
where to stash the "wastebaskets". You end up with an extensible
solution. Kernel mode programming is the last thing you want
to do, not the first. You can't access any of the 'C' runtime
library functions although there a few cloned for kernel
programming. It's a bitch to write your own string functions
in such a way that they catch all the corner cases that can
trash the kernel.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5557.45 BogoMips).
            Note 96.31% of all statistics are fiction.


