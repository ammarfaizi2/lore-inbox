Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263032AbUCMCxh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 21:53:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263033AbUCMCxh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 21:53:37 -0500
Received: from gate.crashing.org ([63.228.1.57]:3545 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263032AbUCMCxe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 21:53:34 -0500
Subject: Broken PM semantics (WAS: PATCH: Shutdown IDE before powering off).
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       Karol Kozimor <sziwan@hell.org.pl>, Russell King <rmk@arm.linux.org.uk>
In-Reply-To: <20040311214601.GA3109@hell.org.pl>
References: <1gC8S-6UB-5@gated-at.bofh.it> <1gIHq-3JU-23@gated-at.bofh.it>
	 <1gPzb-1OM-17@gated-at.bofh.it> <1gQET-2Qn-9@gated-at.bofh.it>
	 <20040311214601.GA3109@hell.org.pl>
Content-Type: text/plain
Message-Id: <1079146102.2302.60.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 13 Mar 2004 13:48:22 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-03-12 at 08:46, Karol Kozimor wrote:
> Thus wrote Bartlomiej Zolnierkiewicz:
> > 
> > On Thursday 22 of January 2004 17:02, Jeff Garzik wrote:
> > > I'm either shock or very very worried that the reboot notifier that
> > > flushes IDE in 2.4.x, ide_notifier, is nowhere to be seen in 2.6.x :(
> > > That seems like the real problem -- the code _used_ to be there.
> > 
> > Yep, it should be re-added.  I wonder when/why it was removed?

Ideally, it should use the same mecanism as the PM requests...

In fact, the shutdown is just a special case of PM request. I think
ultimately, we should drop the various "shutdown()" functions in the
drivers in favor of a "state" selector for PM. That goes along with
the current problem of "state" in PM beeing completely bogus. The
constants defined by linux/pm.h are in no way related to what
the various drivers have come to expect.

enum {
        PM_SUSPEND_ON,
        PM_SUSPEND_STANDBY,
        PM_SUSPEND_MEM,
        PM_SUSPEND_DISK,
        PM_SUSPEND_MAX,
};
                                                                                                                   
Which basically gives is MEM=2 and DISK=3, while drivers usually
expect MEM=3 and DISK=4 while nobody really cares about 2 except
some specific stuffs in the arch code (or radeonfb on pmacs...)

We should get rid of this assumption that we are passing a D-type
anyway. I suggest we define once for all that what we are passing
down the driver is really the overall system state we are getting
to, that is MEM,DISK,KEXEC,SHUTDOWN, eventually STANDBY if we
ever do something like that (useful for handhelds that have a
special idle state and really don't care about scheduling whne
nothing happens for a while).

Ben.


