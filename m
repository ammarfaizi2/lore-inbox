Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132562AbRAQNlr>; Wed, 17 Jan 2001 08:41:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132665AbRAQNlh>; Wed, 17 Jan 2001 08:41:37 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:7178 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S132561AbRAQNl1>; Wed, 17 Jan 2001 08:41:27 -0500
Message-ID: <3A65A2F1.690CD6CF@uow.edu.au>
Date: Thu, 18 Jan 2001 00:49:37 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: James Simmons <jsimmons@suse.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        FrameBuffer List <linux-fbdev@vuser.vu.union.edu>,
        Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: Re: console spin_lock
In-Reply-To: <Pine.LNX.4.21.0101161554550.450-100000@euclid.oak.suse.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


James Simmons wrote:
> 
> Some time ago a intel i810 framebuffer driver was written. It only worked
> for 2.2.X. With 2.4.X a spinlock is used in the upper layers of the
> console system. Sooner or later we are going to run into the situtation
> where we will have graphics hardware which has no vga core and wih be
> purely DMA/irq based (i.e i810). In this case using the current
> console_lock will block the driver itself. I have thought about a
> possible solution. A semaphore can't be used since their is a spin_lock
> in the console_softirq. Since this is in a interrupt context a
> semaphore can't be used. Another idea was to do a
> 
> void get_vc_lock(void)
> {
>         while (test_and_set_bit(0, &vc_var))
>                 ;
> }
> 
> Any better ideas?
> 

heh.

I'm actually planning on grabbing console_lock and thoroughly strangling
it
next week.  It can block interrupts for up to a second. That just isn't
civil.

- Use a semaphore for serialisation.
- For printk in interrupt context, grab the
  semaphore (yes, you can do this).
- If it couldn't be acquired from interrupt context,
  buffer the text in the log buffer and return.  The text will be
  printed by whoever holds the semaphore before they
  drop it.
- Special "system booting" mode which bypasses all this
  stuff.
- Special "oops in progress" mode which just
  punches through everything.
- Get rid of the special printk buffer - share the
  log buffer.  (Implies writes to console
  devices will be broken into two writes when they
  wrap around).
- Teach vsprintf to print into a circular buffer
  (snprintf thus comes for free).
- Get rid of all the printk deadlock opportunities (fourth
  attempt).
- Get rid of console_tasklet.  Do it in process context callback
  or just do it synchronously.

Assumption:
- Once the system is up and running, it's always safe to
  call down() when in_interrupt() returns false - probably
  not the case in parts of the exit path - tough.


Anyway, that's the thoughtware.  Sound sane?

-
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
