Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130439AbRCKKk1>; Sun, 11 Mar 2001 05:40:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130444AbRCKKkS>; Sun, 11 Mar 2001 05:40:18 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:1238 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S130439AbRCKKkG>; Sun, 11 Mar 2001 05:40:06 -0500
Message-ID: <3AAB5626.A01EEF8F@uow.edu.au>
Date: Sun, 11 Mar 2001 21:40:38 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.3-pre3 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linuxconsole-dev@lists.sourceforge.net,
        FrameBuffer List <linux-fbdev@vuser.vu.union.edu>,
        lkml <linux-kernel@vger.kernel.org>
Subject: fbdev cursor management
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guys,

I've been taking a look at the cursor flashing code,
from the point of view of how it's affected by the
recent enabling of interrupts across the console code.

Pretty much all of the cursor-blink stuff is racy,
and has always been racy on SMP.  Enabling the
interrupts has made it racy on UP as well.

It all happens in timer handlers and interrupt handlers,
with no protection against mainline code accessing the
hardware simultaneously.  As far as I can see, the
races will be harmless - the worst they can do is to
leave some snailtrails on the screen, which will soon
scroll away. So unless someone feels strongly about it,
or can pick a problem which I've missed I'd propose that
we leave it as it is for now.

vgacon looks OK.


Some things which I'd propose for future work:

- Collapse all the various per-driver cursor flashing
  routines into a single place - manage the timer from
  drivers/video/fbcon.c and from there, call into the
  driver layer if requested.

- The cursor flash code should do the actual flash stuff
  from within process context, not interrupt context.  This
  way, it can do acquire_console_sem() to serialise
  everything properly.

  The only way we have of doing this at present is to call
  schedule_task() from within the timer handler.  This works
  fine, but it complicates the device close and module unload
  problem somewhat.  del_timer_sync + flush_scheduled_tasks
  will be needed in the right places.

  There are lots of places in the kernel which would benefit
  from a process-context timer callback mechanism - ethernet
  drivers in particular.  So this is a piece of infrastructure
  which we should develop for 2.5.  It'll be just fine for
  use in das blinkencursor code.

- With rivafb, I note that fbcon_vbl_handler() is being
  called at 50 Hz, and it doesn't actually *do* anything.
  All the work is being done by riva_cursor_timer_handler().
  Seems a little inefficient?

- riva_cursor_timer_handler() is being called at 100Hz,
  which is also more costly than it needs to be.  Also,
  it does this:

	rinfo->cursor->timer->expires = jiffies + (HZ / 100);

  so if the system has HZ < 100, the machine locks
  up - run_timer_list() never returns.  Minor point, but
  it's another argument in favour of using, say, HZ/10.

-
