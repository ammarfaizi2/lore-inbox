Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129091AbQKPS7r>; Thu, 16 Nov 2000 13:59:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130512AbQKPS7m>; Thu, 16 Nov 2000 13:59:42 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:4102 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S129091AbQKPS7X>;
	Thu, 16 Nov 2000 13:59:23 -0500
Message-ID: <3A14275E.99DF4D89@mandrakesoft.com>
Date: Thu, 16 Nov 2000 13:28:46 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Alexander Viro <viro@math.psu.edu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: PATCH: 8139too kernel thread
In-Reply-To: <Pine.LNX.4.10.10011161008060.2513-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> But yes, on 2.4.x the cost of threads is fairly low. The biggest cost by
> far is probably the locking needed for the scheduler etc, and there the
> best rule of thumb is probably to see whether the driver really ends up
> being noticeably simpler.

My main motivations for moving media selection from a timer into a
kernel thread are:
* the timer oftens takes a loooong time to run (some drivers have extra
junk in the timer funcs that really should be in a kthread anyway),  and
* do_ioctl, which calls the mdio_xxx functions, holds rtnl_lock, which
is a semaphore.  the kernel thread can easily acquire this semaphore
too, a timer can't.

I agree that it needs to be examined on a case-by-case basis.  Better
hardware, where MDIO access is just a few bus reads/writes, probably
doesn't need a kernel thread.

Finally, for most net drivers, media selection occurs once every 60
seconds or so, not a big impact even on 2.2.x...


> The event stuff that we are discussing for pcmcia may make all of this
> moot, maybe media selection is the perfect example of how to do the very
> same thing. I'll forward Jeff the emails on that.

I think I'm already on the CC list.

I'm confused here though....   How does tq_context apply here?  Your
suggested direction of tq_context seems ok, but I don't see how it
applies to situations where polling needs to occur, like where yenta
polls when request_irq fails, or when net drivers poll media selection
here.

Regards,

	Jeff


-- 
Jeff Garzik             |
Building 1024           | The chief enemy of creativity is "good" sense
MandrakeSoft            |          -- Picasso
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
