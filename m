Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264112AbRFFTfF>; Wed, 6 Jun 2001 15:35:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264114AbRFFTep>; Wed, 6 Jun 2001 15:34:45 -0400
Received: from cr502987-a.rchrd1.on.wave.home.com ([24.42.47.5]:63500 "EHLO
	the.jukie.net") by vger.kernel.org with ESMTP id <S264112AbRFFTek>;
	Wed, 6 Jun 2001 15:34:40 -0400
Date: Wed, 6 Jun 2001 15:34:32 -0400 (EDT)
From: Bart Trojanowski <bart@jukie.net>
X-X-Sender: <bart@localhost>
To: LKML <linux-kernel@vger.kernel.org>
Subject: 'SIG: sigpending lied' on 2.2.14 (Cobalt Networks)
Message-ID: <Pine.LNX.4.33.0106061517390.1787-100000@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have been seeing 'SIG: sigpending lied' when I change the current->blocked
value to ignore 'non shutdown' signals.  The messages does not show up on
2.2.16.

Searching with google I found a lot of problems being reported but no
solutions... Is this a 2.2.14 "feature"?  I ask because we have clients
that still rely on the Cobalt build of 2.2.14.

Here is the long explonation...

I have a driver for a device that processes a steady stream of commands to
a PCI device.  The calls come in on an ioctl and are send to the device.
While the command is being processed the user space process sleeps (in the
kernel).  To prevent this sleep from waking up on non threatening
signals (like thread debugging) I added this code...

  #define SHUTDOWN_SIGS \
    (sigmask(SIGKILL) | sigmask(SIGINT) | sigmask(SIGQUIT))

  spin_lock_irqsave(&current->sigmask_lock, irqflags);
  sigset = current->blocked;
  siginitsetinv(&current->blocked, SHUTDOWN_SIGS & ~sigset.sig[0]);
  recalc_sigpending(current);
  spin_unlock_irqrestore(&current->sigmask_lock, irqflags);

It is executed before I put the task on a wait queue and set it's state to
TASK_INTERRUPTIBLE.  After the command is finished the h/w interrupt will
wake up the waitqueue and the task will be set to TASK_RUNNING again.
Finally the following is done to restore the signal state.

  spin_lock_irqsave(&current->sigmask_lock, irqflags);
  current->blocked = sigset;
  recalc_sigpending(current);
  spin_unlock_irqrestore(&current->sigmask_lock, irqflags);

When I comment out these two blocks, or when I switch to 2.2.16 my problem
goes away.

Thanks for reading this far,
Bart.

-- 
	WebSig: http://www.jukie.net/~bart/sig/


