Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262368AbSKCTZo>; Sun, 3 Nov 2002 14:25:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262369AbSKCTZo>; Sun, 3 Nov 2002 14:25:44 -0500
Received: from NEUROSIS.MIT.EDU ([18.243.0.82]:58343 "EHLO neurosis.mit.edu")
	by vger.kernel.org with ESMTP id <S262368AbSKCTZn>;
	Sun, 3 Nov 2002 14:25:43 -0500
Date: Sun, 3 Nov 2002 14:32:16 -0500
From: Jim Paris <jim@jtan.com>
To: linux-kernel@vger.kernel.org
Subject: Re: time() glitch on 2.4.18: solved
Message-ID: <20021103143216.A27147@neurosis.mit.edu>
References: <20021102013704.A24684@neurosis.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021102013704.A24684@neurosis.mit.edu>; from jim@jtan.com on Sat, Nov 02, 2002 at 01:37:04AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The problem is with time().  Every second, for approximately 1.1ms,
> time() reports a value that is about 2^32 microseconds (4295 seconds,
> or about an hour and a quarter) in the future.  The glitches always
> occur between a change of seconds.

I finally found the problem.

My i8253 was out of phase.  The 16-bit timer value is read in two
8-bit reads from the 8253 in arch/i386/kernel/time.c, and this value
should be between 0 and LATCH-1.  My kernel was getting the MSB and
LSB reversed, and so the read values were usually too high, and
delay_at_last_interrupt ended up negative.  This caused some small
random negative amount to be subtracted from usecs during
do_gettimeofday, and so my clock was always making small jumps
backwards, and occasionally jumping forward 2^32 when usecs was small.

To fix it, I just read a single byte from port 0x40.  If I do it
again, the problem returns (and I've tested that this is the case on
multiple systems, so it's not just a problem with my 8253).

After 180 days of uptime, it's not surprising that there would have
been one read of the port that failed, triggering the problem, so I
think the kernel should detect and fix this.  We could just check for
it: if the returned count > LATCH, read an extra byte from port 0x40,
as I did.  Or, use the method in do_slow_gettimeoffset, which
basically resets the 8253's counter if count > LATCH.

Any comments?

-jim
