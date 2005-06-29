Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262673AbVF2WBU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262673AbVF2WBU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 18:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262669AbVF2WBU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 18:01:20 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:51079 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262667AbVF2WBK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 18:01:10 -0400
Subject: Re: struct class question
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Luben Tuikov <luben_tuikov@adaptec.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Greg KH <greg@kroah.com>
In-Reply-To: <42C31268.8010606@adaptec.com>
References: <42C31268.8010606@adaptec.com>
Content-Type: text/plain
Date: Wed, 29 Jun 2005 18:01:05 -0400
Message-Id: <1120082466.5866.13.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-06-29 at 17:28 -0400, Luben Tuikov wrote:
> AFAIU, struct class describes a class of devices
> for which a driver/kernel interface exists.  That is, the
> implication is "struct class => driver interface (i.e. LLDD)".

Not necessarily "driver" interface, but device interface (which is often
implemented by a driver.  The distinction is subtle, but it's the basis
of how transport classes work).

> The reason for this, as I understand it, is that the kernel
> wants to be able to control such devices through the class
> interface (and the class device interface), and possibly
> hotplugging.
> 
> Thus we get the pretty flat sysfs class hierarchy:
> /sys/class/<if>/<device>

That's by design.  The class contains a list of all the devices
implementing the interface.

> But there may be devices which are embedded in the controlled
> device and/or which are part of it but are _not_ directly controlled
> by the kernel or the driver interface and for which no driver
> interface exists.  And representing such devices on their own
> doesn't make sense: they do not exist on their own or/and they
> cannot be directly controlled.

Interface (class) is tied to struct device.  If it doesn't have a struct
device, then it can't have a class and isn't a proper sysfs leaf.  If
the device doesn't exist or it can't be directly controlled, then we
probably don't need a class for it, right?  As to whether it needs to
exist at all if we can't do anything with it, I suppose that depends on
whether it's necessary to the tree representation or not (a bit like
channels in SCSI.  They have meaning, but no sysfs representation on
their own).

> Example of such devices are phys, ports, of a SAS host adapter
> and expanders on the SAS domain.  They are "embedded devices",
> not directly controllable by the kernel or through the kernel
> interface.
> 
> Such devices are controlled by the SAS Discover process.
> 
> Now the SAS Discover process sees those devices as they're
> physically (and logically) connected (simplified):
> 
> host adapter --> phys
>              --> ports (may not exists)
>                  --> participating phys (list, mask, etc)
>                  --> SAS device (target or initiator)
>                  --> expander device (edge or fanout)
> 
> I was wondering if it is viable to represent
> this hierarchy, *as the SAS discover process sees it*, in
> sysfs, possibly through the class interface.

Pretty much yes, that's what SCSI FC adapters do with rports.

> So in effect, (remote) targets and initiators _would_ be present
> in /sys/class/scsi_device/ (as is normal) and hosts
> in /sys/class/scsi_host/ (again as is normal), but that the
> picture as seen by the SAS Discover process (intermediate)
> would be represented:
> 
> /sys/class/sas/
> /sys/class/sas/ha0/
> /sys/class/sas/ha1/
> /sys/class/sas/ha1/phys/
> /sys/class/sas/ha1/ports/
> etc.

No, this is where you go wrong.  The sysfs tree exists under the host<n>
for scsi (and is parented to the PCI/etc device), so you can have
something like

.../host1/
.../host1/phys/
.../host1/ports/

(and obviously you need to know where you're putting the targets under
this).

So the rich deep tree is under devices and the class tree represents a
flat look into that for devices implementing the specific interface.

James


