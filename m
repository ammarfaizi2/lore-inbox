Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932148AbWHQAPu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbWHQAPu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 20:15:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932149AbWHQAPu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 20:15:50 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:25043 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932148AbWHQAPt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 20:15:49 -0400
Subject: Re: PATCH: Multiprobe sanitizer
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Greg KH <greg@kroah.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060816222633.GA6829@kroah.com>
References: <1155746538.24077.371.camel@localhost.localdomain>
	 <20060816222633.GA6829@kroah.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 17 Aug 2006 01:36:33 +0100
Message-Id: <1155774994.15195.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-08-16 am 15:26 -0700, ysgrifennodd Greg KH:
> What would this help out with?  Would the PCI layer (for example) handle
> this "notify the core that it can continue" type logic?  Or would the
> individual drivers need to be able to control it?
> 
> I'm guessing that you are thinking of this in relation to the disk
> drivers, have you found cases where something like this is necessary due
> to hardware constraints?

Actually it occurs everywhere because what happens is

	PCI enumerates in bus order
	Threads *usually* run in bus order

so every n'th boot your devices re-order themselves out of bus order,
and eth1 becomes eth0 for the day.

If you have a "ok now continue scanning" API then we can do

	Grab resources
	Register driver
	Go parallel
	[Slow stuff]

I was thinking if we set multithread = 2 (and define some constants)
then the core code would do

	if (multithread == WAIT)
		down(&drv->wait);


and we'd have

	pci_driver_continue_enumerating(struct pci_driver *drv) {
		up(&drv->wait);
	}


