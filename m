Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265269AbUATCDv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 21:03:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265298AbUATCAu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 21:00:50 -0500
Received: from magic.adaptec.com ([216.52.22.17]:14551 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S265212AbUATB4s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 20:56:48 -0500
Date: Mon, 19 Jan 2004 19:02:29 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Reply-To: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
cc: Xose Vazquez Perez <xose@wanadoo.es>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Tosatti <marcelo.tosatti@cyclades.com>,
       linux-scsi <linux-scsi@vger.kernel.org>
Subject: Re: AIC7xxx kernel problem with 2.4.2[234] kernels
Message-ID: <3942145408.1074564149@aslan.btc.adaptec.com>
In-Reply-To: <1074559838.2078.1.camel@mulgrave>
References: <400BDC85.8040907@wanadoo.es>	<1074532919.1895.32.camel@mulgrave> 	<3747775408.1074537497@aslan.btc.adaptec.com> <1074559838.2078.1.camel@mulgrave>
X-Mailer: Mulberry/3.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, 2004-01-19 at 13:38, Justin T. Gibbs wrote: 
>> Can you provide your definition of "maintainer"?  I know that I am maintainer
>> of the drivers distributed from my website, but I don't feel I have ever
>> been maintainer of the drivers in the 2.4.X, 2.5.X, or 2.6.X trees.
> 
> A maintainer is a person who works with the kernel community to keep the
> driver (or subsystem, filesystem or whatever) up to date.  Such a person
> may or possibly may not have an entry in the MAINTAINERS file. 

Does the maintainer have the ability to veto changes that harm the
code they maintain?  In otherwords, you claim that I am the maintainer
of the drivers in the kernel.org tree.  This has not prevented changes
from being made to these drivers without adequate review.  Even your last
update to the driver threw away all of the changelog state and left at
least the aic79xx driver in a worse state than it was in before (see
changelog entries for the driver versions after the one that you imported
for details - this was exactly why I didn't submit that particular revision).
You didn't even bother to ask me if importing 1.3.11 was appropriate.  This
is why I say I don't feel like a maintainer.  I'm not given adequate control
over the end product yet I'm supposed to take the blame when it doesn't work.

>> I'm open to ideas, but from this one line summary, this sounds like a
>> workaround and not a real solution.  Can you say more about your proposal?
> 
> It actually wasn't mine, it was Alan Cox's.  There was a thread about it
> (on which you were cc'd), but I'm currently on a 'plane to NY for
> LinuxWorld and don't have it handy. 

That proposal was to allow the timeout handler to be redirected.  This
is different than an early notification.  Allowing the timeout handler
to be redirected is a required step toward making the recovery code
work.

> Well, I'm thinking of having a class based error recovery scheme, built
> upon an extension of the transport class patch that has been floating
> around this list.

That's all fine for "status based" recovery.  All I'm trying to resolve
are issues with watchdog recovery.  Can we limit the discussion to that
area?

> However, my problem is that the aic7xxx/79xx chips
> are basically SPI, and therefore, even under the new scheme, should be
> using the SPI recovery class.  Therefore, just providing an override
> mechanism for all drivers to use isn't what I want.  What I want is a
> robust SPI recovery mechanism usable by all. 

I understand that, but it just isn't possible to do well for watchdog
recovery.  For status based recovery, sure.

> This is what "working with the kernel community" means.  If there's a
> bug, I don't want it fixed by driver work arounds, I want it fixed in
> the core code.  Having driver writers ignore the APIs and roll their own
> will simply create problems. 

In this case, the bug is that the mid-layer tries to handle watchdog
recovery on its own.  It will never, in my opinion, having reviewed
lots of systems that have tried to do it in a centralized way, work well.
The mid-layer just doesn't have the necessary state to make intelligent
decisions and exporting that state will always be cumbersome and incomplete.

>> Most SCSI commands are only idempotent if replayed in the same order
>> as originally issued (consider FSes that rely on write ordering to
>> keep their meta-data coherent).  Some commands are retriable but only if
>> they have actually failed.  The mid-layer has no concept currently of these
>> issues, yet it acts on behalf of the peripheral drivers that can better
>> understand how the device they control behaves and act accordingly.
>> 
>> Bugs are defects that render non-ideal behavior.  The only question is
>> what types of non-ideal behaviors you are willing to tolerate.
> 
> This is the old barrier debate.

Not entirely.  Tapes are allowed to accept multiple commands and some
FCTape drives do.  But even if you throw away that argument completely,
you still haven't resolved how to deal with retriable commands that
are only retriable if they have actually failed.

My feeling is that any situation where the mid-layer or HBA drivers fail
to provide complete and acurate state for the commands that are completed
is a bug.  The peripheral drivers cannot do their job if they aren't
given good information.

>> That wouldn't help things.  For example, lets say that there is one
>> command active on the bus holding up the completion of 32 others.
>> "Waiting for a bit" will never release the other 32 commands.  You must
>> abort the bus hog.  Once  you abort the problem command, you get flooded
>> with the completions of the 32 others.  The bus is recovered.  You can now
>> safely go about your business.  An HBA watchdog handler can properly deal
>> with this situation since it has state that the mid-layer does not.
> 
> I don't understand this.  If by "active on the bus" you mean is holding
> the bus in a busy state, then you cannot get access to the bus to to
> send an abort or a device reset...the only recourse is a bus
> reset...which the mid layer will do. 

If we are talking SPI, then aborts, device resets, and lun resets
are all handled with either message bytes transmitted via a message phase,
or via command packets with the task management function set appropriately.
If you cannot send an abort message, you cannot send any message, so claiming
that a BDR request will resolve the problem doesn't make any sense if you
believe that a device active on the bus prevents aborts for working.  In any
event, just because a device is active on the bus doesn't mean that the
bus is hung and that you cannot abort a command.  By raising the ATN line,
the target may decide to change phase to accept your message byte.  It
may not, but if it doesn't, then your only recourse is to reset the
bus.  Looping through all the other commands that happen to be stalled
and asking the driver to abort them will only delay the inevitable.

> If the drive has actually freed the bus but lost the tag, then it's a
> drive queueing bug, and the solution is usually to lower the TCQ depth
> (we should probably have a blacklist for this).  This is where the mid
> layer quiesce is good...if all the other commands complete, the bus is
> free and we still don't get a response from the missing command, then
> you know the drive firmware lost it, and the driver should adjust the
> queue depth downwards. 

How does the mid-layer know that the "bus is free".  What transports even
have this concept?  If one drive has lost a command, and the transport
is functioning normally, why are you penalizing the other devices attached
to the HBA while you "sort this out"?  There is no need to do that.

As for reducing the queue depth in response to repeated timeouts by a
device, this is easy enough to do with your "multi-layered", status based
recovery code.  All that is required is for the HBA to tell you that a
particular command was aborted due to timeout as well as indicate what
side-effects occurred because of the abort process (bus reset, device reset,
lun reset, LIP, etc).   Some of the latter is already provided for by the
reset and bus reset entry points, but a better solution would be to have
a single "async event" callback that can encompass any transport notifications
needed by SPI, FC, SAS, and any future transports without adding more
entry points.

> If the drive is just off servicing other tags, then it's tag starvation.
>> As for tag starvation, just inserting a periodic ordered tag on devices
>> that show signs of starvation is a much better approach than shutting
>> down the flow of commands to the whole controller at the first sign of
>> trouble.  Luckily, most vendors stopped making drives with tag starvation
>> issues in the mid-90's.  For this reason, the tag starvation code in
>> my drivers is off by default, but can be enabled via a module or kernel
>> command line option.
> 
> Well, I have to deal with old hardware... 

Sure, just don't penalize the other disks on the transport because you
have one disk out there that is affected by this issue.

--
Justin

