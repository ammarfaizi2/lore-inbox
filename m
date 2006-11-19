Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755432AbWKSAMh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755432AbWKSAMh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 19:12:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755436AbWKSAMg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 19:12:36 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:32968 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1755432AbWKSAMg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 19:12:36 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <455FA159.2080303@s5r6.in-berlin.de>
Date: Sun, 19 Nov 2006 01:12:09 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060730 SeaMonkey/1.0.4
MIME-Version: 1.0
To: linux1394-devel@lists.sourceforge.net
CC: Alan Stern <stern@rowland.harvard.edu>,
       Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org
Subject: deadlock in "modprobe -r ohci1394" shortly after "modprobe ohci1394"
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just rediscovered a deadlock in drivers/ieee1394/nodemgr.c which I
thought didn't exist anymore. It's still there, it's just a matter of
timing to trigger this. Quoting myself from
http://bugzilla.kernel.org/show_bug.cgi?id=6706 :

------------------------------------------------------------------------
# modprobe ohci1394 && modprobe -r ohci1394
works.

# modprobe ohci1394 && sleep 1 && modprobe -r ohci1394
gets stuck in uninterruptible sleep on kthread_stop(). This is trying to
stop the knodemgrd which uninterruptibly sleeps on
bus_rescan_devices_helper() meanwhile.


Call trace of the modprobe -r context:
    kthread_stop		in kernel/kthread.c
    nodemgr_remove_host		in drivers/ieee1394/nodemgr.c
    __unregister_host		in drivers/ieee1394/highlevel.c
    highlevel_remove_host	in drivers/ieee1394/highlevel.c
    hpsb_remove_host		in drivers/ieee1394/hosts.c
    ohci1394_pci_remove		in drivers/ieee1394/ohci1394.c
    pci_device_remove		in pci/pci-driver.c
    __device_release_driver	in drivers/base/dd.c
    driver_detach		in drivers/base/dd.c

Call trace of the knodemgrd context:
    bus_rescan_devices_helper	in drivers/base/bus.c
    bus_rescan_devices		in drivers/base/bus.c
    nodemgr_node_probe		in drivers/ieee1394/nodemgr.c
    nodemgr_host_thread		in drivers/ieee1394/nodemgr.c


It seems the following is the culprit:

Since Linux 2.6.16, bus_rescan_devices_helper takes
down(&dev->parent->sem) if a parent device exists. This is true for all
devices that are managed by nodemgr. (FireWire ud's have ud's or ne's as
parent, and FireWire ne's have hosts as parent.) And yes, the call in
driver_detach to __device_release_driver is enclosed in down(&dev->sem).
------------------------------------------------------------------------


The relevant change to bus_rescan_devices_helper in 2.6.16 is
http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=bf74ad5bc41727d5f2f1c6bedb2c1fac394de731

> commit bf74ad5bc41727d5f2f1c6bedb2c1fac394de731
> Author: Alan Stern <stern@rowland.harvard.edu>
> Date:   Thu Nov 17 16:54:12 2005 -0500
> 
>     [PATCH] Hold the device's parent's lock during probe and remove
> 
>     This patch (as604) makes the driver core hold a device's parent's lock
>     as well as the device's lock during calls to the probe and remove
>     methods in a driver.  This facility is needed by USB device drivers,
>     owing to the peculiar way USB devices work:
[...]
>     I have not tested this patch for conflicts with other subsystems.  As
>     far as I can see, the only possibility of conflict would lie in the
>     bus_rescan_devices pathway, and it seems pretty remote.  Nevertheless,
>     it would be good for this to get a lot of testing in -mm.

Yes, it's pretty remote but there is indeed one if I'm not entirely
mistaken.

Right now I don't see a sane fix but I will have a few nights sleep over
it...
-- 
Stefan Richter
-=====-=-==- =-== =--==
http://arcgraph.de/sr/
