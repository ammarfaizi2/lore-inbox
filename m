Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130252AbRCHXdv>; Thu, 8 Mar 2001 18:33:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130261AbRCHXdm>; Thu, 8 Mar 2001 18:33:42 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:28042 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S130252AbRCHXde>; Thu, 8 Mar 2001 18:33:34 -0500
Message-ID: <3AA8169F.FAE81841@uow.edu.au>
Date: Thu, 08 Mar 2001 23:32:47 +0000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.61 [en] (X11; I; Linux 2.4.1-pre10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andreas Dilger <adilger@turbolinux.com>
CC: Vibol Hou <vhou@khmer.cc>, Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: kernel BUG doing sysrq-t on 2.4.2-ac14
In-Reply-To: <200103081934.f28JYGS05891@webber.adilger.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:
> 
> > [< c0109557>] kernel BUG at printk.c:327!
> 
> It may be that if the tasklist is too long, and it runs with interrupts
> disabled, that this will trigger the NMI watchdog timer.  Since I don't
> know anything about the console, I can't help.

Yes, this is being a pest.  I assume what is happening
is that a CPU is (slowly) doing a print to the serial
console with console_sem held.  Then the NMI watchdog
fires and it reinitialises the console semaphore.  On return
from the NMI handler, console_sem is now released.  It's off-by-one.

So subsequent attempts to use printk() hit the BUG().  ho-hum.
The machine is of course completely kaput by this stage
but this really should be fixed.  This'll be fun to test.

A wider question is why are we still getting NMI watchdog
triggering during SYSRQ-T on a serial console.  This
is the second time this has been reported.  It can certainly
happen if the serial port is set up for hardware handshaking
and the modem control lines aren't set up right - we loop
for ever in the serial console code.  Fair enough.

Maybe the sysrq handler should communicate with the NMI
watchdog code, and tell it not to fire while it's dumping 
stuff.  hmm...  Messy.

-
