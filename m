Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261406AbULFOPS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261406AbULFOPS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 09:15:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261524AbULFOPS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 09:15:18 -0500
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:67 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S261406AbULFOPI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 09:15:08 -0500
Message-ID: <41B46975.6050609@microgate.com>
Date: Mon, 06 Dec 2004 08:15:17 -0600
From: Paul Fulghum <paulkf@microgate.com>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ryan Reading <rreading@msm.umr.edu>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.27 Potential race in n_tty.c:write_chan()
References: <1102280061.10493.19.camel@localhost>	 <1102286420.3386.20.camel@at2.pipehead.org> <1102307945.1876.27.camel@localhost>
In-Reply-To: <1102307945.1876.27.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ryan Reading wrote:
> Per tty instance this is true, but this is not the case for multiple
> userland::write() calls.

If the write calls are accessing different
tty instances there is no interaction
between the write calls.

> Ideally the driver should be able to
> recover.  I'm not sure if we can guarantee that user_land protocol could
> recover though, especially if write()s aren't guaranteed to complete
> successfully.

I don't see that there is anything for the driver
to recover from. The driver sees a series of
write method calls and blocks, processes, or
rejects them as appropriate.

> Should a driver be able to rely on the
> schedule() call to complete its write?  It seems that since the driver
> is responsible for waking up the tty->write_wait, it should be able to
> rely on the schedule() call.  However in this implementation it cannot
> which I'm sure is for performance reasons.  Because of this, I don't
> think the USB layer should be interacting with the tty layer in this
> fashion.

The driver should not require anything from the caller
after the write method has returned. The driver waking
a caller is a service *to* the caller *if*
the caller is interested (on a wait queue).

The only purpose of the schedule() call is for the
caller to temporarily yield execution while waiting
on write_wait. If the caller doesn't care, such as when
the driver indicates all data accepted, then there
is no reason to call schedule(). In this case, the
break is hit and the caller removes itself from the wait queue.

> So for this implementation of write_chan(), the tty_driver::write()
> interface should note that the driver needs only to wakeup the
> tty->write_wait iff it does not write all of the requested data in this
> call.  Is this a fair assessment and can this be depended on for future
> implementations?

The write_wait queue wakes code blocked in the write path
due to a component (ldisc, driver, etc) being busy
so it can try again. It is not an indication that a particular
write call completed successfully.
It is a write throttling mechanism. When a waiting
process is woken, there is no guarantee that *all*
components in the write path are ready for more data.
The process must observe return codes and wait
again if so indicated.

Short of a major rewrite of the tty code,
this behavior will be stable.

-- 
Paul Fulghum
paulkf@microgate.com
