Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272447AbTHNPyH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 11:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272449AbTHNPyH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 11:54:07 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:26158 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP id S272447AbTHNPyE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 11:54:04 -0400
To: Russell King <rmk@arm.linux.org.uk>
Cc: Christoph Hellwig <hch@infradead.org>, Pavel Machek <pavel@suse.cz>,
       Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] call drv->shutdown at rmmod
References: <m1he4kzpiy.fsf@frodo.biederman.org>
	<20030814085442.A21232@infradead.org>
	<20030814090605.A25516@flint.arm.linux.org.uk>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 14 Aug 2003 09:50:05 -0600
In-Reply-To: <20030814090605.A25516@flint.arm.linux.org.uk>
Message-ID: <m17k5gz1aq.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk@arm.linux.org.uk> writes:

> On Thu, Aug 14, 2003 at 08:54:43AM +0100, Christoph Hellwig wrote:
> > Sounds really confusing.  And having shutdown maybe called before remove
> > but not always sounds like a design mistake.

My patch always called shutdown before remove, but only if the methods
are implemented.  Mandating that shutdown and remove are implemented 
is not something I am changing with this patch.

> > Why do we have shutdown at all?  Can't we just call ->remove on shutdown
> > so the device always get's into proper unitialized state on shutdown, too?
> 
> That's likely to remove the keyboard driver, and some people like
> to configure their box so that ctrl-alt-del halts the system, and
> a further ctrl-alt-del reboots the system once halted.

Hmm.  That is a very weird case.  Semantically the keyboard driver
and everything else should be removed in any case.

After device_shutdown is called it is improper for any driver
to be handling interrupts because the are supposed to be in a quiescent
state.  And if they are not it is likely to break a soft reboot.

> There are also some bus drivers which want to know the difference
> between "device (driver) was removed" and "device was shutdown",
> eg, for setting bus-specific stuff back into a state where the
> machine can be soft-rebooted.
> 
> With the shutdown callback, drivers get the option whether to
> handle this event or not.  Combining it with remove gives them no
> option what so ever, and bus drivers loose this knowledge.

Reasonable.  And they still get that knowledge with the way I implemented
my patch.  They just get to shutdown first.

Russell do you have any objects to always calling shutdown before
remove?   I don't think this looses knowledge and in most cases it should
work, but if there are bus devices were we need to do things significantly
differently I am open to other solutions.

All I really care about is that we get something that is simple enough
that device driver authors can get it right.  And according to my limited
testing we don't have that right now.

Eric

