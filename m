Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317030AbSHWJa0>; Fri, 23 Aug 2002 05:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317034AbSHWJa0>; Fri, 23 Aug 2002 05:30:26 -0400
Received: from [217.167.51.129] ([217.167.51.129]:63485 "EHLO zion.wanadoo.fr")
	by vger.kernel.org with ESMTP id <S317030AbSHWJaZ>;
	Fri, 23 Aug 2002 05:30:25 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: IDE-flash device and hard disk on same controller
Date: Fri, 23 Aug 2002 13:36:23 +0200
Message-Id: <20020823113624.22612@192.168.4.1>
In-Reply-To: <3D656FDC.8040008@mandrakesoft.com>
References: <3D656FDC.8040008@mandrakesoft.com>
X-Mailer: CTM PowerMail 3.1.2 carbon <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>There is no ATA bsy flag check at only one point, and that is before 
>EXECUTE DEVICE DIAGNOSTIC is issued.  The idea with this command is that 
>it pretty much stomps up and down the ATA bus, trouncing ongoing 
>activity in the process.

After mucking around with problematic drives that needed such
a busy wait on the Xserve, it seems that you still need at least
a busy wait with timeout before doing anything on the bus in
some cases. Typically what happens to me is that the disks
were beeing reset (via the control register) by the firmware
just prior to booting the kernel, and those disks (or maybe
it's a Promise controller issue ?) appear to need up to 30
seconds before beeing useable again. Waiting for the busy bit
appear to be a working solution, it worked for me at least
and is what Apple did both in Darwin and in the firmware,
prior to sending the execute diag. command.

Though I can still try to send it here and see if it helps...

The actual scenario followed by Apple's firmware apparently
is:

 - wait busy to go away
 - select 0
 - write 8 to control register (clearing any possible
   residual reset)
 - delay 2ms
 - wait busy to go away
 - select 1
 - write 8 to control register (clearing any possible
   residual reset)
 - delay 2ms
 - wait busy to go away

Then do the normal probe, which in their case involves the
diagnostics command, checking signatures, etc...

I implemented that in ide-probe and this seem to fix the
problem I have with the Xserve and a few other machines,
though I need to get some user reports before I can tell if
it helps with some other problems I was reported with some
ATAPI combo drives.

The only thing I added to it was to have the busy wait loop
exit when reading 0xff from the status reg, assuming some
controllers (especially hand-made embedded stuffs) would
return that when nothing is plugged.

I will try the full execute diag. on the Xserve tonight or
tomorrow and see if it works without the above, but I doubt
it as the drive seem to be totally unresponsive during this
period when it gets out of reset.

Ben.


