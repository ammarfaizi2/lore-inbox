Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263711AbUATAyP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 19:54:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265434AbUATAwJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 19:52:09 -0500
Received: from stat1.steeleye.com ([65.114.3.130]:39307 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S263711AbUATAuq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 19:50:46 -0500
Subject: Re: AIC7xxx kernel problem with 2.4.2[234] kernels
From: James Bottomley <James.Bottomley@steeleye.com>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: Xose Vazquez Perez <xose@wanadoo.es>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Tosatti <marcelo.tosatti@cyclades.com>,
       linux-scsi <linux-scsi@vger.kernel.org>
In-Reply-To: <3747775408.1074537497@aslan.btc.adaptec.com>
References: <400BDC85.8040907@wanadoo.es>
	<1074532919.1895.32.camel@mulgrave> 
	<3747775408.1074537497@aslan.btc.adaptec.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 19 Jan 2004 19:50:37 -0500
Message-Id: <1074559838.2078.1.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-01-19 at 13:38, Justin T. Gibbs wrote: 
> Can you provide your definition of "maintainer"?  I know that I am maintainer
> of the drivers distributed from my website, but I don't feel I have ever
> been maintainer of the drivers in the 2.4.X, 2.5.X, or 2.6.X trees.

A maintainer is a person who works with the kernel community to keep the
driver (or subsystem, filesystem or whatever) up to date.  Such a person
may or possibly may not have an entry in the MAINTAINERS file. 

If you want to maintain a reference driver and have someone else do the
legwork with the community, that's fine by me...do you have someone in
mind, or should I find this person? 

> I'm open to ideas, but from this one line summary, this sounds like a
> workaround and not a real solution.  Can you say more about your proposal?

It actually wasn't mine, it was Alan Cox's.  There was a thread about it
(on which you were cc'd), but I'm currently on a 'plane to NY for
LinuxWorld and don't have it handy. 

> In my mind, an easy resolution would be to:
> 
> 1) Let me fix the SCSI layer so that the error recovery handler override
>    already there will actually work - cleanly.
> 
> 2) Let my drivers use that mechanism.
> 
> While working on 1, I would appreciate being able to "maintain" these
> drivers with their current error recovery workaround in place.

Well, I'm thinking of having a class based error recovery scheme, built
upon an extension of the transport class patch that has been floating
around this list.  However, my problem is that the aic7xxx/79xx chips
are basically SPI, and therefore, even under the new scheme, should be
using the SPI recovery class.  Therefore, just providing an override
mechanism for all drivers to use isn't what I want.  What I want is a
robust SPI recovery mechanism usable by all. 

This is what "working with the kernel community" means.  If there's a
bug, I don't want it fixed by driver work arounds, I want it fixed in
the core code.  Having driver writers ignore the APIs and roll their own
will simply create problems. 

> Most SCSI commands are only idempotent if replayed in the same order
> as originally issued (consider FSes that rely on write ordering to
> keep their meta-data coherent).  Some commands are retriable but only if
> they have actually failed.  The mid-layer has no concept currently of these
> issues, yet it acts on behalf of the peripheral drivers that can better
> understand how the device they control behaves and act accordingly.
> 
> Bugs are defects that render non-ideal behavior.  The only question is
> what types of non-ideal behaviors you are willing to tolerate.

This is the old barrier debate.  The scsi subsytem does not advertise an
ordering property to the block layer and thus is not required to
preserve order over error recovery.  This problem, therefore, does not
exist in linux. 

We had this debate years ago...the upshot being that the performance
benefits of order preservation were uncertain at best so it was never
implemented.  Linux works just fine without it. 

> That wouldn't help things.  For example, lets say that there is one command
> active on the bus holding up the completion of 32 others.  "Waiting for a bit"
> will never release the other 32 commands.  You must abort the bus hog.  Once
> you abort the problem command, you get flooded with the completions of the
> 32 others.  The bus is recovered.  You can now safely go about your business.
> An HBA watchdog handler can properly deal with this situation since it has
> state that the mid-layer does not.

I don't understand this.  If by "active on the bus" you mean is holding
the bus in a busy state, then you cannot get access to the bus to to
send an abort or a device reset...the only recourse is a bus
reset...which the mid layer will do. 

If the drive has actually freed the bus but lost the tag, then it's a
drive queueing bug, and the solution is usually to lower the TCQ depth
(we should probably have a blacklist for this).  This is where the mid
layer quiesce is good...if all the other commands complete, the bus is
free and we still don't get a response from the missing command, then
you know the drive firmware lost it, and the driver should adjust the
queue depth downwards. 

If the drive is just off servicing other tags, then it's tag starvation.
> As for tag starvation, just inserting a periodic ordered tag on devices
> that show signs of starvation is a much better approach than shutting
> down the flow of commands to the whole controller at the first sign of
> trouble.  Luckily, most vendors stopped making drives with tag starvation
> issues in the mid-90's.  For this reason, the tag starvation code in
> my drivers is off by default, but can be enabled via a module or kernel
> command line option.

Well, I have to deal with old hardware... 

James 


