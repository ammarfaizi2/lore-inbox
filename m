Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261748AbTCQPvx>; Mon, 17 Mar 2003 10:51:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261744AbTCQPvx>; Mon, 17 Mar 2003 10:51:53 -0500
Received: from chaos.analogic.com ([204.178.40.224]:18308 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S261759AbTCQPvq>; Mon, 17 Mar 2003 10:51:46 -0500
Date: Mon, 17 Mar 2003 11:19:17 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Linux-2.4.20 modem control
Message-ID: <Pine.LNX.4.53.0303171116160.22652@chaos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello any tty gurus,

If a modem is connected to /dev/ttyS0 and a getty (actually agetty)
is associated with that device, one can log-in using that modem.

This is how we've operated for many years. But, Linux version 2.4.20
presents a new problem.

When a logged-in caller logs out, it is mandatory for the modem
to disconnect. This has previously been done automatically when
the terminal is closed. The closing of the tasks file-descriptors
will eventually call tty_hangup() and the modem would (previously)
hang up.

Something has changed so that the hang-up sequence doesn't happen if
agetty has already opened the terminal for another possible connection.
It used to be that the caller, calling close(), did not get control
back until the modem had been hung up. This prevented another agetty
from opening that terminal for I/O because the previous task had not
completed its exit procedure until the terminal was hung up.

Now, the hang-up sequence appears to be queued. It can (and does)
happen after the previous terminal owner has expired and another
owner has opened the device. This makes /dev/ttyS0 useless for remote
log-ins.

It needs to be, that a 'close()' of a terminal, configured as a modem,
cannot return to the caller until after the DTR has been lowered, and
preferably, after waiting a few hundred milliseconds. Without this,
once logged in, the modem will never disconnect so a new caller
can't log in.

With faster machines, it is not sufficient to just lower DTR. One
needs to lower DTR and then wait. This is because the next task
can open that terminal in a few hundred microseconds, raising
DTR again. This is not enough time for the modem to hang up because
there is "glitch-filtering" on all modem-control leads. The hang-up
event won't even be seen by the modem.

So, either the modem control needs to be reverted to its previous
functionality or `agetty` needs to hang up its terminal when it
starts, which seems backwards. In other words, the user of kernel
services should not have to compensate for a defect in the logic
of that service.

I have temporarily "fixed" this problem by modifying `agetty`.
Can the kernel please be fixed instead?


Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

