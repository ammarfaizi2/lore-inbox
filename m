Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264641AbSJTU0D>; Sun, 20 Oct 2002 16:26:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264642AbSJTU0D>; Sun, 20 Oct 2002 16:26:03 -0400
Received: from syr-24-24-11-40.twcny.rr.com ([24.24.11.40]:25334 "EHLO
	server.foo") by vger.kernel.org with ESMTP id <S264641AbSJTU0C>;
	Sun, 20 Oct 2002 16:26:02 -0400
Date: Sun, 20 Oct 2002 16:31:50 -0400
From: Dan Maas <dmaas@maasdigital.com>
To: Constantine Gavrilov <const-g@optibase.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Problems implementing poll call
Message-ID: <20021020163150.A3962@morpheus>
References: <3DB2D7BC.5080809@optibase.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3DB2D7BC.5080809@optibase.com>; from const-g@optibase.com on Sun, Oct 20, 2002 at 06:20:12PM +0200
X-Info: http://www.maasdigital.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Constantine Gavrilov (const-g@optibase.com) wrote:
> As far as races are concerned, it should be OK. This is because my
> condition uses testbit() and interrupt handler uses setbit(). These
> operations are atomic even on SMP configurations. Right?

Yes, test/setbit() are atomic, but that's not the point - the "do I
need to sleep?" check must be atomic with respect to
sleep_on(). Consider the following case:

if(testbit(...)) {
	// bit is TRUE now
	
	// now the interrupt handler runs:
	// setbit(FALSE)
	// wake_up_interruptible(...)
	
	interruptible_sleep_on(...);
}

Since wake_up() is called before sleep_on(), it will not wake you
up. If this case occurs, you will remain asleep forever.

You will probably find a few places in the kernel that suffer this
condition; the race window is very small so it's not likely to happen
in practice. But if I were developing a driver I'd definitely pay
attention to it...

A good description of the problem and solution is on page 287 of
Rubini's "Linux Device Drivers", 2nd ed. (I highly recommend this book
btw).

I just learned that there are macros in sched.h that encapsulate the
race-free solution (wait_event() and wait_event_interuptible()):
instead of the if() statement, you can write wait_event(..., !testbit());

> What do you think is of lower latency -- a poll() hook or an ioctl()
> hook?

Probably ioctl(). But ioctl() has the disadvantage that you can only
wait on one file descriptor. It's easy to provide both...

> With poll(), I do not know how to catch an error, because the poll
> function is called many times and I do not know which return is
> last. But it is not critical for me.

poll() should not return an error unless there is something wrong with
poll() itself. poll() merely tells the user that "some activity has
occurred on this file descriptor" - where "some activity" may include
an error. Device-specific errors should be returned when the user
subsequently calls read() write() or ioctl() on your device.

Regards,
Dan
