Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262112AbREQUZz>; Thu, 17 May 2001 16:25:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262116AbREQUZp>; Thu, 17 May 2001 16:25:45 -0400
Received: from corb.mc.mpls.visi.com ([208.42.156.1]:27267 "HELO
	corb.mc.mpls.visi.com") by vger.kernel.org with SMTP
	id <S262112AbREQUZj>; Thu, 17 May 2001 16:25:39 -0400
Message-ID: <3B042DD9.3BDA84D1@steinerpoint.com>
Date: Thu, 17 May 2001 15:00:25 -0500
From: Al Borchers <alborchers@steinerpoint.com>
Reply-To: alborchers@steinerpoint.com
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.5-15 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, macro@ds2.pg.gda.pl, tytso@mit.edu
Cc: Peter Berger <pberger@brimson.com>, James Puzzo <jamesp@dgii.com>
Subject: Re: [patch] 2.4.0, 2.2.18: A critical problem with tty_io.c
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maciej, Ted --

Maciej's patch to tty_io.c from lkml 2/22/01

  http://www.uwsg.indiana.edu/hypermail/linux/kernel/0101.2/1049.html

has been incorporated in RH 7.1's kernel (for example) but not in the
main 2.4.x kernels.

This presents two different interfaces for serial drivers, and it is
awkward to detect and support both interfaces.  The change breaks some
drivers from Digi International, for example.

In Maciej's patch, if a driver open is interrupted the driver close
IS NOT called.  In the 2.4.x series the close IS called.

A serial driver needs to know whether close is going to be called or
not after an interrupted open, so it can do clean up--like DEC_MOD_USE_COUNT--
appropriately.

Suppose the driver open calls INC_MOD_USE_COUNT, sleeps for the port to get
carrier, then gets interrupted.  If the open calls DEC_MOD_USE_COUNT after
the interrupt, the use count will be right under Maciej's patch but too low on
2.4.x.  If the open does not call DEC_MOD_USE_COUNT after an interrupt, instead
deferring that for the close, then the use count will be too high under
Maciej's patch, but right under 2.4.x.  This is particularly a problem if there
is another outstanding open on the port--in that case you can end up with zero
use count (and a closed port!) while the port is open or a non-zero use count
when no one has the port open. 

Personally, I think Maciej's patch is correct and interrupted opens should
clean up after themselves--however, this is a different interface than presented
by the tty subsystem up to now, and will require changes in some serial drivers.

Ted can you get this patch in the kernel or ban it as interface breaking
heresy?  It would be much nicer for us device driver writers to have just
one interface to support.

Thanks,
-- Al Borchers, Peter Berger

PS. James Puzzo at Digi first pointed out this problem to us.
