Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275052AbTHRUn2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 16:43:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275055AbTHRUn2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 16:43:28 -0400
Received: from mail.kroah.org ([65.200.24.183]:5761 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S275052AbTHRUnS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 16:43:18 -0400
Date: Mon, 18 Aug 2003 13:42:18 -0700
From: Greg KH <greg@kroah.com>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: jw schultz <jw@pegasys.ws>, linux-kernel@vger.kernel.org
Subject: Re: your mail
Message-ID: <20030818204218.GA3220@kroah.com>
References: <E19odOM-000NwL-00.arvidjaar-mail-ru@f22.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E19odOM-000NwL-00.arvidjaar-mail-ru@f22.mail.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 18, 2003 at 10:21:22AM +0400, "Andrey Borzenkov"  wrote:
> 
> just to show what I expected from sysfs - here is entry from Solaris
> /devices:
> 
> brw-r-----   1 root     sys       32,240 Jan 24  2002 /devices/pci@16,4000/scsi@5,1/sd@0,0:a
> 
> this entry identifies disk partition 0 on drive with SCSI ID 0, LUN 0
> connected to bus 1 of controller in slot 5 of PCI bus identified
> by 16. Now you can use whatever policy you like to give human
> meaningful name to this entry. And if you have USB it will continue
> further giving you exact topology starting from the root of your
> device tree.
> 
> and this path does not contain single logical id so it is not subject
> to change if I add the same controller somewhere else.
> 
> hopefully it clarifies what I mean ...

Hm, a bit.  First, have you looked at what sysfs provides?  Here's one
of my machines and tell me if it has all the info you are looking for:

$ tree /sys/bus/scsi/
/sys/bus/scsi/
|-- devices
|   `-- 0:0:0:0 -> ../../../devices/pci0000:00/0000:00:1e.0/0000:02:05.0/host0/0:0:0:0
`-- drivers
    `-- sd
        `-- 0:0:0:0 -> ../../../../devices/pci0000:00/0000:00:1e.0/0000:02:05.0/host0/0:0:0:0

$ tree /sys/block/sda/
/sys/block/sda/
|-- dev
|-- device -> ../../devices/pci0000:00/0000:00:1e.0/0000:02:05.0/host0/0:0:0:0
|-- queue
|   |-- iosched
|   |   |-- antic_expire
|   |   |-- read_batch_expire
|   |   |-- read_expire
|   |   |-- write_batch_expire
|   |   `-- write_expire
|   `-- nr_requests
|-- range
|-- sda1
|   |-- dev
|   |-- size
|   |-- start
|   `-- stat
|-- sda2
|   |-- dev
|   |-- size
|   |-- start
|   `-- stat
|-- sda3
|   |-- dev
|   |-- size
|   |-- start
|   `-- stat
|-- sda4
|   |-- dev
|   |-- size
|   |-- start
|   `-- stat
|-- size
`-- stat


Now, from that you can see exactly where my scsi device is in the pci
tree, and you can see in the block directory, what block device is
assigned to what physical device in the device tree.  Then there are 4
partitions on this disk, all what those specific paramaters.

So, when sda shows up, udev can determine that it lives on a specific
scsi device, located in a specific place in the pci space, and that it
has some number of partitions, all of specific sizes, wich specific
major/minor numbers.  It can then create all of the /dev links based on
this.

Please, take a few minutes looking at the existing sysfs tree on Linux.
If you then have any specific questions, I would be glad to answer
them.

Hope this helps,

greg k-h
