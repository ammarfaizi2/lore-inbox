Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130645AbQKREY7>; Fri, 17 Nov 2000 23:24:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131384AbQKREYu>; Fri, 17 Nov 2000 23:24:50 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:21405 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S130645AbQKREYn>; Fri, 17 Nov 2000 23:24:43 -0500
Message-ID: <3A15FD94.F19DA5F0@uow.edu.au>
Date: Sat, 18 Nov 2000 14:55:00 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: [patch] Remove tq_scheduler
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch removes tq_scheduler from the kernel.  All uses of
tq_scheduler are migrated over to use schedule_task().

Notes:

- In two places: drivers/block/paride/pseudo.h and
  drivers/net/wan/sdlamain.c we are re-adding tasks to tq_scheduler
  within the callback.  That means that these functions are being
  called _every_ time the machine calls schedule().

  It may be a limited case for paride, but sdlamain.c appears to be
  doing this wicked thing all the time.

  Now, if you do this with the current schedule_task() your machine
  will hang up.  So schedule_task() has been changed to support this
  practice.  If we see that the task queue has waiters on it we still
  call schedule(), but we do it in state TASK_RUNNING.

- The patch adds to context.c a new API function
  run_schedule_tasks() which immediately runs the queued tasks.  Must
  only be called from process context.  serial.c needs this in its
  shutdown routines.

- If anyone sleeps in a callback, then all other users of
  schedule_task() also sleep.  But there's nothing new here.  Kinda
  makes one wonder why schedule_task exists.  But what-hey, it's neat.

- Note the careful massaging of module reference counts.

  Yes my friends, much usage of task queues in modules is racy wrt
  module removal.  This patch fixes some of them.

  The approach taken here is to increment the module refcount when we
  enqueue a task and to decrement it in the handler:

	mainline()
	{
		...
		MOD_INC_USE_COUNT;
		if (schedule_task(some_wq) == 0)
			MOD_DEC_USE_COUNT;
	}

	handler()
	{
		...
		MOD_DEC_USE_COUNT;
		/* Wheee!  Tiny race here */
		return;
	}

  Note that queue_task and schedule_task have been enhanced to return
  a success indicator.  If this is non-zero you know that your task
  will be run.  If it returns zero then your tq_struct was already
  queued and you lose.

  The patch against test11-pre7 (1043 lines) is at

	http://www.uow.edu.au/~andrewm/linux/tq_scheduler.patch

  It affects the following files:

include/linux/tqueue.h
include/linux/sched.h
include/linux/compatmac.h
arch/ppc/8xx_io/uart.c
arch/ppc/8xx_io/fec.c
arch/ppc/8260_io/uart.c
drivers/net/wan/sdlamain.c
drivers/block/paride/pseudo.h
drivers/char/tty_io.c
drivers/char/esp.c
drivers/char/istallion.c
drivers/char/riscom8.c
drivers/char/serial.c
drivers/char/README.epca
drivers/char/specialix.c
drivers/char/epca.c
drivers/char/isicom.c
drivers/char/moxa.c
drivers/char/mxser.c
drivers/char/stallion.c
drivers/scsi/megaraid.c
drivers/scsi/qla1280.c
drivers/isdn/avmb1/b1capi.c
drivers/isdn/avmb1/kcapi.c
drivers/sbus/char/sab82532.c
drivers/sbus/char/aurora.c
drivers/ide/ide.c
drivers/usb/serial/keyspan_pda.c
drivers/usb/serial/digi_acceleport.c
drivers/i2o/i2o_lan.c
fs/smbfs/sock.c
kernel/sched.c
kernel/ksyms.c
kernel/timer.c
kernel/context.c
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
