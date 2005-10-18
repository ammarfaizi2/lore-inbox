Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751506AbVJRU7i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751506AbVJRU7i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 16:59:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751509AbVJRU7i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 16:59:38 -0400
Received: from mail.kroah.org ([69.55.234.183]:30418 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751506AbVJRU7h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 16:59:37 -0400
Date: Tue, 18 Oct 2005 13:59:08 -0700
From: Greg KH <gregkh@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Roland Dreier <rolandd@cisco.com>, linux-kernel@vger.kernel.org
Subject: Re: What is struct pci_driver.owner for?
Message-ID: <20051018205908.GA32435@suse.de>
References: <52sluymu26.fsf@cisco.com> <435560D0.8050205@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <435560D0.8050205@pobox.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2005 at 04:53:36PM -0400, Jeff Garzik wrote:
> Roland Dreier wrote:
> >I just noticed that at some point, struct pci_driver grew a .owner
> >member.  However, only a handful of drivers set it:
> >
> >    $ grep -r -A10 pci_driver drivers/ | grep owner
> >    drivers/block/sx8.c-    .owner          = THIS_MODULE,
> >    drivers/ieee1394/pcilynx.c-     .owner =           THIS_MODULE,
> >    drivers/net/spider_net.c-       .owner          = THIS_MODULE,
> >    drivers/video/imsttfb.c-        .owner          = THIS_MODULE,
> >    drivers/video/kyro/fbdev.c-     .owner          = THIS_MODULE,
> >    drivers/video/tridentfb.c-      .owner  = THIS_MODULE,
> >
> >Should all drivers be setting .owner = THIS_MODULE?  Is this a good
> >kernel janitors task?
> 
> In theory its for module refcounting.  With so many PCI drivers and so 
> few pci_driver::owner users, it makes me wonder how needed it is.

It might in the future be needed for refcounting, I originally added it
when I thought it was needed.

But what it really does today is create the symlink from the driver to
the module that is contained in it, in sysfs.  Which is very invaluable
for people who want to know these things (installer programs, etc.)

For example:
$ tree /sys/bus/pci/drivers/uhci_hcd/
/sys/bus/pci/drivers/uhci_hcd/
|-- 0000:00:1d.0 -> ../../../../devices/pci0000:00/0000:00:1d.0
|-- 0000:00:1d.1 -> ../../../../devices/pci0000:00/0000:00:1d.1
|-- 0000:00:1d.2 -> ../../../../devices/pci0000:00/0000:00:1d.2
|-- 0000:00:1d.3 -> ../../../../devices/pci0000:00/0000:00:1d.3
|-- bind
|-- module -> ../../../../module/uhci_hcd
|-- new_id
`-- unbind


That "module" symlink is created only if the .owner field is set.
That's why people are going through and adding it to all of the drivers
in the system.

Hope this helps,

greg k-h	
