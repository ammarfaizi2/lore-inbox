Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262664AbVF2VaP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262664AbVF2VaP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 17:30:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262667AbVF2V3a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 17:29:30 -0400
Received: from magic.adaptec.com ([216.52.22.17]:16002 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S262664AbVF2V2Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 17:28:24 -0400
Message-ID: <42C31268.8010606@adaptec.com>
Date: Wed, 29 Jun 2005 17:28:08 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
CC: Greg KH <greg@kroah.com>
Subject: struct class question
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Jun 2005 21:27:18.0083 (UTC) FILETIME=[538FE930:01C57CF1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

AFAIU, struct class describes a class of devices
for which a driver/kernel interface exists.  That is, the
implication is "struct class => driver interface (i.e. LLDD)".

The reason for this, as I understand it, is that the kernel
wants to be able to control such devices through the class
interface (and the class device interface), and possibly
hotplugging.

Thus we get the pretty flat sysfs class hierarchy:
/sys/class/<if>/<device>

But there may be devices which are embedded in the controlled
device and/or which are part of it but are _not_ directly controlled
by the kernel or the driver interface and for which no driver
interface exists.  And representing such devices on their own
doesn't make sense: they do not exist on their own or/and they
cannot be directly controlled.

Example of such devices are phys, ports, of a SAS host adapter
and expanders on the SAS domain.  They are "embedded devices",
not directly controllable by the kernel or through the kernel
interface.

Such devices are controlled by the SAS Discover process.

Now the SAS Discover process sees those devices as they're
physically (and logically) connected (simplified):

host adapter --> phys
             --> ports (may not exists)
                 --> participating phys (list, mask, etc)
                 --> SAS device (target or initiator)
                 --> expander device (edge or fanout)

I was wondering if it is viable to represent
this hierarchy, *as the SAS discover process sees it*, in
sysfs, possibly through the class interface.

So in effect, (remote) targets and initiators _would_ be present
in /sys/class/scsi_device/ (as is normal) and hosts
in /sys/class/scsi_host/ (again as is normal), but that the
picture as seen by the SAS Discover process (intermediate)
would be represented:

/sys/class/sas/
/sys/class/sas/ha0/
/sys/class/sas/ha1/
/sys/class/sas/ha1/phys/
/sys/class/sas/ha1/ports/
etc.

And this is also what the Discover process would use in order
to discover domains, control zones, configure expanders, etc.

That is, this is nothing more but my trying to export in
viewable form what the SAS Discover process saw and what it
would use.

Is this okay with kernel and scsi people?

Thanks,
	Luben



