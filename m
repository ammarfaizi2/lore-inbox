Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268950AbTBWUvF>; Sun, 23 Feb 2003 15:51:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268954AbTBWUvE>; Sun, 23 Feb 2003 15:51:04 -0500
Received: from newmail.somanetworks.com ([216.126.67.42]:11463 "EHLO
	mail.somanetworks.com") by vger.kernel.org with ESMTP
	id <S268950AbTBWUvD>; Sun, 23 Feb 2003 15:51:03 -0500
Date: Sun, 23 Feb 2003 16:01:10 -0500 (EST)
From: Scott Murray <scottm@somanetworks.com>
X-X-Sender: scottm@rancor.yyz.somanetworks.com
To: Linus Torvalds <torvalds@transmeta.com>
cc: Russell King <rmk@arm.linux.org.uk>, <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>, Greg KH <greg@kroah.com>
Subject: Re: [PATCH] Make hot unplugging of PCI buses work
In-Reply-To: <Pine.LNX.4.44.0302231054420.11584-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0302231531450.2559-100000@rancor.yyz.somanetworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Feb 2003, Linus Torvalds wrote:

> 
> On Sun, 23 Feb 2003, Russell King wrote:
> > 
> > Linus - this patch is for discussion, NOT for applying unless you have
> > zero problems with it since it actively breaks existing hotplug PCI.
> 
> Well, I definitely want it, and you should add Alan to the cc list since 
> he apparently even _has_ one of these devices.
> 
> I don't have any objections to the patch, but I won't apply it until the 
> otehr PCI people have had a chance to weigh in on it.

Having beaten out something roughly similiar for the cPCI hotplug code, 
I have a couple of comments:
1) The description of pci_remove_bus_device says "informing the drivers 
   that the device has been removed", yet unless I'm missing some sysfs
   wrinkle, no call will be made to an attached driver's remove callback.
2) The recursive bus handling in pci_remove_bus_device should probably 
   call pci_proc_detach_bus and potentially should also update the parent 
   bridge's subordinate field.  The latter is something that I'm doing
   at the moment in the cPCI hotplug code, but have just recently decided
   needs further investigation, as my solution does not handle multiple
   remove and insert cycles with different boards (e.g. it's easy to end
   up with overlapping ranges behind different bridges).

> > Furthermore, I propose that pci_remove_device() shall disappear -
> > and this devices makes it so (thereby breaking existing hotplug
> > drivers.)
> 
> Can't you just fix up the current users to use "pci_remove_bus_device()". 
> The breakage seems a bit spiteful ;)

The current device removal code in all of the PCI hotplug drivers are 
based to varying degrees on sets of callbacks driven by the pci_visit_* 
family of functions, and will hence need varying amounts of rework to be 
able to just call pci_remove_bus_device instead.  My cPCI hotplug driver 
and the ACPI based driver are likely the easiest to change over, since 
they attempt none of the more sophisticated resource management tricks 
that the Compaq and IBM drivers do.

Scott


-- 
Scott Murray
SOMA Networks, Inc.
Toronto, Ontario
e-mail: scottm@somanetworks.com




