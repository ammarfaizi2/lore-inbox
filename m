Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261289AbVDZDnA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261289AbVDZDnA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 23:43:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261295AbVDZDnA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 23:43:00 -0400
Received: from gate.crashing.org ([63.228.1.57]:4038 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261289AbVDZDmn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 23:42:43 -0400
Subject: Re: [PATCH] PCI: Add pci shutdown ability
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Greg KH <greg@kroah.com>
Cc: Pavel Machek <pavel@ucw.cz>, Amit Gud <gud@eth.net>,
       Alan Stern <stern@rowland.harvard.edu>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, Andrew Morton <akpm@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>, cramerj@intel.com,
       USB development list <linux-usb-devel@lists.sourceforge.net>
In-Reply-To: <20050425210014.GA25247@kroah.com>
References: <Pine.LNX.4.44L0.0504251128070.5751-100000@iolanthe.rowland.org>
	 <20050425182951.GA23209@kroah.com>
	 <SVLXCHCON1syWVLEFN00000099e@SVLXCHCON1.enterprise.veritas.com>
	 <20050425185113.GC23209@kroah.com> <20050425190606.GA23763@kroah.com>
	 <20050425204207.GA23724@elf.ucw.cz>  <20050425210014.GA25247@kroah.com>
Content-Type: text/plain
Date: Tue, 26 Apr 2005 13:41:55 +1000
Message-Id: <1114486915.7112.17.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > I believe it should just do suspend(PMSG_SUSPEND) before system
> > shutdown. If you think distintion between shutdown and suspend is
> > important (I am not 100% convinced it is), we can just add flag
> > saying "this is system shutdown".
> 
> Then why even have the device_shutdown() call and notifier in the struct
> device_driver?

Historical bad ideas...

> > Actually this patch should be in the queue somewhere... We had it in
> > suse trees for a long time, and IMO it can solve problem easily.
> > 
> > 								Pavel
> > 
> > --- clean-git/kernel/sys.c	2005-04-23 23:21:55.000000000 +0200
> > +++ linux/kernel/sys.c	2005-04-24 00:20:47.000000000 +0200
> > @@ -404,6 +404,7 @@
> >  	case LINUX_REBOOT_CMD_HALT:
> >  		notifier_call_chain(&reboot_notifier_list, SYS_HALT, NULL);
> >  		system_state = SYSTEM_HALT;
> > +		device_suspend(PMSG_SUSPEND);
> >  		device_shutdown();
> 
> Again, why keep device_shutdown() around at all then?

I've argued for folding shutdown and suspend for some time now, though
some drivers who rely on shutdown today will need fixing I suppose.

Also, I think kexec shouldn't use "shutdown" but a different message.
There are some conceptual differences, things like stopping the platters
on disk etc... things you want to do on one and not the other. In a way,
kexec needs are very similar to suspend-to-disk "freeze" state. I'd
rather call PMSG_FREEZE there.

Ben.
 

