Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262795AbUASScl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 13:32:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262838AbUASScl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 13:32:41 -0500
Received: from magic.adaptec.com ([216.52.22.17]:65156 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S262795AbUASScf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 13:32:35 -0500
Date: Mon, 19 Jan 2004 11:38:17 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Reply-To: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: James Bottomley <James.Bottomley@SteelEye.com>,
       Xose Vazquez Perez <xose@wanadoo.es>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Tosatti <marcelo.tosatti@cyclades.com>,
       linux-scsi <linux-scsi@vger.kernel.org>
Subject: Re: AIC7xxx kernel problem with 2.4.2[234] kernels
Message-ID: <3747775408.1074537497@aslan.btc.adaptec.com>
In-Reply-To: <1074532919.1895.32.camel@mulgrave>
References: <400BDC85.8040907@wanadoo.es> <1074532919.1895.32.camel@mulgrave>
X-Mailer: Mulberry/3.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, 2004-01-19 at 08:32, Xose Vazquez Perez wrote:
>> It looks like the _kernel_ driver is going to be without a maintainer
>> unless somebody works on it, porting ADAPTEC fixes/features to the kernel driver.
> 
> As I told you in private email, this is *not* the way I see it.  At the
> moment, Ataptec is the maintainer of that driver unless they choose
> formally to relinquish it.

Can you provide your definition of "maintainer"?  I know that I am maintainer
of the drivers distributed from my website, but I don't feel I have ever
been maintainer of the drivers in the 2.4.X, 2.5.X, or 2.6.X trees.

> There is a glimmering of a resolution of the problem in an early
> notification API for command timeouts.

I'm open to ideas, but from this one line summary, this sounds like a
workaround and not a real solution.  Can you say more about your proposal?

In my mind, an easy resolution would be to:

1) Let me fix the SCSI layer so that the error recovery handler override
   already there will actually work - cleanly.

2) Let my drivers use that mechanism.

While working on 1, I would appreciate being able to "maintain" these
drivers with their current error recovery workaround in place.

> Although throwing away successful completions when error recovery is in
> progress isn't a bug (scsi commands are either idempotent or non
> retryable), it's certainly not ideal.

Most SCSI commands are only idempotent if replayed in the same order
as originally issued (consider FSes that rely on write ordering to
keep their meta-data coherent).  Some commands are retriable but only if
they have actually failed.  The mid-layer has no concept currently of these
issues, yet it acts on behalf of the peripheral drivers that can better
understand how the device they control behaves and act accordingly.

Bugs are defects that render non-ideal behavior.  The only question is
what types of non-ideal behaviors you are willing to tolerate.

> I'm thinking about a better
> framework where we would quiesce the device but pull back from
> activating the eh thread if all commands return.  This would also fix
> the tag starvation issue that many drivers tackle independently too.

That wouldn't help things.  For example, lets say that there is one command
active on the bus holding up the completion of 32 others.  "Waiting for a bit"
will never release the other 32 commands.  You must abort the bus hog.  Once
you abort the problem command, you get flooded with the completions of the
32 others.  The bus is recovered.  You can now safely go about your business.
An HBA watchdog handler can properly deal with this situation since it has
state that the mid-layer does not.

As for tag starvation, just inserting a periodic ordered tag on devices
that show signs of starvation is a much better approach than shutting
down the flow of commands to the whole controller at the first sign of
trouble.  Luckily, most vendors stopped making drives with tag starvation
issues in the mid-90's.  For this reason, the tag starvation code in
my drivers is off by default, but can be enabled via a module or kernel
command line option.

--
Justin

