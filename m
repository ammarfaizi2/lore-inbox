Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263095AbUEWPtX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263095AbUEWPtX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 11:49:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263121AbUEWPtX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 11:49:23 -0400
Received: from fdd.com ([64.81.147.80]:14387 "EHLO FDD.COM")
	by vger.kernel.org with ESMTP id S263095AbUEWPtE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 11:49:04 -0400
Date: Sun, 23 May 2004 10:48:59 -0500
From: Billy Biggs <vektor@dumbterm.net>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: tvtime and the Linux 2.6 scheduler
Message-ID: <20040523154859.GC22399@dumbterm.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  I am the author of tvtime, a TV application with advanced image
processing algorithms.  Some users are complaining about poor
performance under Linux 2.6, and I would like more information about how
tvtime will be treated by the scheduler.  Here is an example of the
intended usage:

  - Program running as root and SCHED_FIFO
  - NTSC, input ~30 fps, each field processed for an output of ~60 fps
  - CPU intensive processing, say 9 ms per field on my P3-733
  - with a typical AGP card, the X driver takes 4 ms to draw
  - Wait using /dev/rtc set to 1024 Hz

  for(;;)
      9 ms : process frame
      4 ms : draw frame
      3 ms : wait until next field time using /dev/rtc
      9 ms : process frame
      4 ms : draw frame
      3 ms : block on /dev/video0 for next frame
     -----
     33 ms : time per NTSC frame

  The theory is that Linux classifies this as a CPU hog regardless of
its priority, and preempts tvtime with other processes.  Oswald
Buddenhagen describes the effect as this:

  "[...] it starts up fine, but after a few seconds (when the scheduler
gathered some stats) ... well, it looks funny: the scene goes roughly
exponentially into slow motion, then there is a frame drop and the
process starts over.  this behaviour can be observed at any priority,
which is clearly against the claim "no normally priorized interactive
process will preempt a highly priorized cpu-hog" that i've read
somewhere.  the xserver priority does not change anything, either;"

  Avoiding root/SCHED_FIFO and using usleep() instead of /dev/rtc seems
to exhibit the same behavior.

  Thoughts?

  -Billy

