Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267632AbUIOWTD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267632AbUIOWTD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 18:19:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267648AbUIOWSH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 18:18:07 -0400
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:61135 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S267632AbUIOWRL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 18:17:11 -0400
Date: Thu, 16 Sep 2004 00:15:23 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Greg KH <greg@kroah.com>, "Marco d'Itri" <md@Linux.IT>,
       "Giacomo A. Catenazzi" <cate@pixelized.ch>,
       linux-kernel@vger.kernel.org
Subject: Re: udev is too slow creating devices
Message-ID: <20040915221523.GG15426@dualathlon.random>
References: <414757FD.5050209@pixelized.ch> <20040914213506.GA22637@kroah.com> <20040914214552.GA13879@wonderland.linux.it> <20040914215122.GA22782@kroah.com> <20040914224731.GF3365@dualathlon.random> <20040914230409.GA23474@kroah.com> <20040914232011.GG3365@dualathlon.random> <20040915161541.GD21971@kroah.com> <20040915192134.GA4197@dualathlon.random> <4148BD97.1080504@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4148BD97.1080504@nortelnetworks.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2004 at 04:09:27PM -0600, Chris Friesen wrote:
> Andrea Arcangeli wrote:
> 
> >the kernel certainly knows when it's about time to fork an userspace
> >process to create the device, doesn't it? then just wait4 while the
> >process is running.
> 
> Last I checked, if using udevsend the process that gets forked is not the 
> same process that actually creates the device node.

Good point, so wait4 wouldn't be enough, you'd need a bit more of API on
the udev side. But be sure, if dev.d can make it with a FIFO lock in
/var/run, then the kernel can make it too.

Also note the maybe usb is just completely async and when you load the
device driver you've no idea of when you'll get the signal and it's
impossible to make it sync, fine. I'm really not talking about hotplug,
hotplug basically has to be async by design.

But the microcode driver has nothing to do with hotplug or usb, and
waiting for the device creation in the insmod syscall is sure natural
and doable.  Now if we don't want to create a little bit of API in udev
to let insmod provide a sync behaviour and force people into the dev.d
scripts and file locking in /var/run that it's one issue (you can aruge
about higher perf), but there is a whole large class of devices that are
not hot-pluggable and where the discovery is definitely synchronous,
even common pci is fully sync in its discovery when you call
pci_find_device/get_device.
