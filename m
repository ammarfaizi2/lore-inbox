Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265895AbUATX30 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 18:29:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265899AbUATX0O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 18:26:14 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:61066 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S265892AbUATXZt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 18:25:49 -0500
Message-ID: <400DB781.4229A084@us.ibm.com>
Date: Tue, 20 Jan 2004 15:19:29 -0800
From: Jim Keniston <jkenisto@us.ibm.com>
X-Mailer: Mozilla 4.75 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, jgarzik@pobox.com,
       scott.feldman@intel.com, kessler@us.ibm.com
Subject: Re: [PATCH 2.6.1] Net device error logging
References: <400C3D3E.BFCC25CE@us.ibm.com> <20040119184630.5d066735.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
>
> Jim Keniston <jkenisto@us.ibm.com> wrote:
> >
> > The enclosed patch implements the netdev_* error-logging macros for
> >  network drivers.
>
> Looks OK to me.
>
> But it does make one wonder whether we'll soon see standalone patches for
> scsi_printk(), pci_bridge_printk(), random_other_subsystem_printk(), ...?

Well, there is indeed sdev_printk for the SCSI mid-layer and low-level
drivers.  Dan Stekloff posted an updated patch for this on linux-scsi
yesterday.

When Alan Cox suggested dev_printk, it was with the idea that other
subsystems might have similar macros.  Although I don't know of other
such macros in the works, I wouldn't rule them out.

>
> Or is it intended that the backend logging code will be implemented mainly
> in terms of the `struct device'?  So netdev_printk() will be a bit of
> netdev-specific boilerplate which then calls into a more generic
> device_printk()?

I think dev_printk will work just fine for drivers where [driver name +
bus ID] is the appropriate message tag.  Where that's not the case, other
macros emerge.  (For example, for net devices you want the interface
name, and for SCSI devices the SCSI bus ID is more interesting than the
PCI bus ID.)

Another thing to consider is whether, for the subsystem in question,
some other struct pointer (e.g., struct net_device* or struct
scsi_device*) might prove more useful in the future than the struct
device pointer.  I.e., such pointers could be used to get at the struct
device AND other subsystem-specific info.

Also, there are also situations where there is no underlying struct
device (e.g., some upper-level network drivers) or the driver is not yet
defined (e.g., during a SCSI scan).

Jim Keniston
