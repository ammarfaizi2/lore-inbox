Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261203AbVDYVQq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261203AbVDYVQq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 17:16:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261209AbVDYVOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 17:14:36 -0400
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:39140 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S261203AbVDYVNi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 17:13:38 -0400
X-ORBL: [69.107.61.180]
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: [PATCH] PCI: Add pci shutdown ability
Date: Mon, 25 Apr 2005 14:13:21 -0700
User-Agent: KMail/1.7.1
Cc: Pavel Machek <pavel@ucw.cz>, Greg KH <greg@kroah.com>,
       Amit Gud <gud@eth.net>, Alan Stern <stern@rowland.harvard.edu>,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       akpm@osdl.org, jgarzik@pobox.com, cramerj@intel.com
References: <Pine.LNX.4.44L0.0504251128070.5751-100000@iolanthe.rowland.org> <20050425190606.GA23763@kroah.com> <20050425204207.GA23724@elf.ucw.cz>
In-Reply-To: <20050425204207.GA23724@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504251413.21996.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > So here's a patch for the PCI core that allows pci drivers to now just
> > add a "shutdown" notifier function that will be called when the system
> > is being shutdown.  It happens just after the reboot notifier happens,
> > and it should happen in the proper device tree order, so everyone should
> > be happy.

Both kexec and sys_shutdown always call notifiers first, then the
device shutdown stuff, as I understand.  (I didn't see the patch,
so I don't know what it should do...)

If there's going to be a "shutdown" primitive, I certainly think
that it should work for PCI devices.

There's a separate issue about needing to clone such stuff into
every version of bus glue.  For example, OHCI runs on PCI ... but
also on lots of non-PCI hardware.  It's actually cleaner to use
a notifier than to write almost-identical shutdown methods for
each different bus it may be glued to.  Same thing with EHCI;
other bus-neutral register APIs will have the same issue.


> > Any objections to this patch?
> 
> Yes.
> 
> I believe it should just do suspend(PMSG_SUSPEND) before system
> shutdown. If you think distintion between shutdown and suspend is
> important (I am not 100% convinced it is), we can just add flag
> saying "this is system shutdown".

I've made that point before -- essentially that shutdown() in
the driver model itself is superfluous, either remove() or
maybe suspend() would achieve the same result, without adding
any special code that's run/tested rather infrequently ...

That is:  if shutdown() isn't going to be removed, then the
code that shuts down devices should invoke remove() or even
suspend() in cases that there's no shutdown() method.

But the pushback was that shutdown() methods are allowed to
be much lighter weight, and really ought to work even when
big parts of the system are misbehaving.  So they'd just do
stuff like resetting chips, sanitizing GPIOs, and so on ...
and nothing that'd be likely to break if significant parts
of kernel memory were corrupted.

- Dave


