Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283390AbRLRBXB>; Mon, 17 Dec 2001 20:23:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283409AbRLRBWv>; Mon, 17 Dec 2001 20:22:51 -0500
Received: from sushi.toad.net ([162.33.130.105]:3264 "EHLO sushi.toad.net")
	by vger.kernel.org with ESMTP id <S283390AbRLRBWl>;
	Mon, 17 Dec 2001 20:22:41 -0500
Subject: Re: APM driver patch summary
From: Thomas Hood <jdthood@mail.com>
To: linux-kernel@vger.kernel.org
Cc: Russell King <rmk@arm.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 17 Dec 2001 20:22:40 -0500
Message-Id: <1008638563.5515.96.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> Actually you're right, it doesn't send a resume event.
> However, It's worse than that - it will leave all sleeping
> listeners still sleeping.
> Try this patch instead - this should cause all listeners
> to get a -EIO to indicate that the suspend failed, and also
> get the resume event.

Hmm.  You know what?  I don't think the listeners really
need to be sent a resume event if they are already getting
an error code back!  The listeners should take the error
code as a cue to undo whatever they did to prepare for
the suspend.  The only thing is that the error code should
not be EIO, since this currently means "the BIOS returned
something other than APM_SUCCESS".  The current code returns
EAGAIN when the suspend attempt is rejected by a driver
(look in do_ioctl()) and we should stick to that.

If the above is right, then in suspend() you should set
"err = -EAGAIN" instead of "err = -EIO" and you should put
"out:" just after the "queue_event(APM_NORMAL_RESUME, NULL);"
instead of just before it.

I just checked, and apmlib 3.0.2 does not return the error code
from apm_suspend(); and apmd 3.0.2 does not undo anything when
apm_suspend() returns an error.  These need to be fixed right
away.  I'll file bug reports against Debian apmd since the
Debian maintainer is also the upstream maintainer -- Avery Pennarun.

Finally, think carefully about where the cli() and sti() should go.

--
Thomas

