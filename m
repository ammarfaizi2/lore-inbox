Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261354AbSKLSEM>; Tue, 12 Nov 2002 13:04:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266957AbSKLSEM>; Tue, 12 Nov 2002 13:04:12 -0500
Received: from [217.167.51.129] ([217.167.51.129]:39929 "EHLO zion.wanadoo.fr")
	by vger.kernel.org with ESMTP id <S261354AbSKLSEL>;
	Tue, 12 Nov 2002 13:04:11 -0500
Subject: ATM stack locking broken
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linux-kernel@vger.kernel.org
Cc: werner.almesberger@epfl.ch
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 12 Nov 2002 19:11:19 +0100
Message-Id: <1037124679.2774.111.camel@zion>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

I've spent some time trying to figure out why an ATM driver
I was hacking with kept deadlocking until I figured out the
problem actually is the kernel ATM stack on SMP.

spinlock usage in net/atm/* seem to be utterly broken, though
I don't know the ATM stack well enough myself to fix it quickly,
I though you may want to know about it :)

Typicaly examples are:

atm_ioctl() in net/atm/common.c

  That one grabs a spinlock for the entire duration of the
  function, which includes doing things like get/put_user
  (can schedule), copy_to/from_user (can schedule), or
  call the low level driver's ioctl() callback, which in
  lots of cases will want to be able to schedule as well.
  I'm not even looking at the other code path going deep
  inside the ATM code here.

The above is what I ran into. Quick look at the code shows
others though, like bind_vcc() beeing called with lock held,
itself calling then will call unlink_vcc() which can itself
eventually call shutdown_atm_dev(). At this point, you can
happily try to double take the spinlock (among others).
Another example is atm_do_connect_dev() called with the lock,
itself calling dev->open(). I can imagine a whole bunch of
reasons why the low driver would want to schedule in there.

Another issue is that this lock is protecting against another
CPU or preempt, but not against interrupts (maybe this is by
design though).

Regards,
Ben.


