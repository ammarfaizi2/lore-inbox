Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130096AbRCDHcK>; Sun, 4 Mar 2001 02:32:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130461AbRCDHcA>; Sun, 4 Mar 2001 02:32:00 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:49356 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S130096AbRCDHbr>; Sun, 4 Mar 2001 02:31:47 -0500
Message-ID: <3AA1EF6C.A9C7613E@uow.edu.au>
Date: Sun, 04 Mar 2001 18:31:56 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.2-pre2 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-fbdev-devel@sourceforge.net, lkml <linux-kernel@vger.kernel.org>,
        lad <linux-audio-dev@ginette.musique.umontreal.ca>,
        James Simmons <jsimmons@linux-fbdev.org>,
        Brad Douglas <brad@neruo.com>
Subject: [prepatches] removal of console_lock
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


All console-related activity curently happens under spin_lock_irqsave(&console_lock). 
This causes interrutps to be blocked for 1-2 milliseconds with vgacon, and for
hundreds of milliseconds with fbdevs.  This results in network overruns, audio
dropouts, dropped characters on serial ports and other such nice things.

This patch fixes it.  Interrupts are enabled across all console operations.

It's still somewhat a work-in-progress.

- There are (pre-existing) races around the timer functions in
  console.c. The dirty fix is to push all this stuff into keventd
  context and to use acquire_cosole_sem().  The clean fix is to
  rewrite the timer state machine.

  Or do nothing.  This thing only fires four times a day, the race
  doesn't look like it'll crash the machine and there have been no
  bug reports...

- console_print().   blah.  What's this for?  I just mapped it
  onto printk().  My preferred option is to kill it off altogether.


I'm putting this out now for comments, and for interested parties to
test.  Please.  I'm serious.


Patches against 2.4.3-pre1 and 2.4.2-ac9 are at

	http://www.uow.edu.au/~andrewm/linux/console.html

These patches are ~1600 lines and touch 35 files.



Some notes:

- show_console() had been removed.  It's unused.

- console_tasklet has been replaced with a keventd callback,
  `console_callback'.

- unblank_console() has gone.  It was only used by panic(),
  and...

- ... the call to poke_blanked_console() in vt_console_print() has
  been restored.  It doesn't deadlock during oopses now.

- arch/s390x/kernel/cpprintk.c has been removed.

- bust_spinlocks() has been enhanced (x86 and mips64).

- Major revamp of printk().  The approach taken in printk() is to try
  to acquire the (new) console_sem.  If we succeed, the output is
  placed into the log buffer and is printed to the consoles.  If we fail
  to acquire the semaphore we just buffer the output in the log buffer
  and the current holder of the console_sem will do the printing for us
  prior to releasing console_sem.

  If an oops is in progress we simply reset the locking and print
  things immediately.

- Added a new syslog() mode: syslog(9, ...).  It returns the number
  of characters which are currently queued in the log buffer.  Needed
  to do this for kmsg_poll().

- Being heartily sick of reverse-engineering interface information
  from implementations, I have gratuitously added comments in several
  random parts of the kernel.  Shoot me.

- Several video drivers are using spin_lock() in a timer
  handler.  There's a remote possibility that these can
  deadlock (say, the timer fires again while the lock is held).
  These have been changed to use _irqsave.

- The various low-level drivers have been reviewed to ensure that
  they are safe when interrupts are enabled.  Looks OK.

-
