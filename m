Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262426AbULOUX5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262426AbULOUX5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 15:23:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262427AbULOUX5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 15:23:57 -0500
Received: from linux.us.dell.com ([143.166.224.162]:27727 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S262426AbULOUXr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 15:23:47 -0500
Date: Wed, 15 Dec 2004 14:22:22 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: "Mukker, Atul" <Atulm@lsil.com>
Cc: "'James Bottomley'" <James.Bottomley@SteelEye.com>,
       "'Salyzyn, Mark'" <mark_salyzyn@adaptec.com>,
       "Bagalkote, Sreenivas" <sreenib@lsil.com>,
       "'brking@us.ibm.com'" <brking@us.ibm.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'SCSI Mailing List'" <linux-scsi@vger.kernel.org>,
       "'bunk@fs.tum.de'" <bunk@fs.tum.de>, "'Andrew Morton'" <akpm@osdl.org>,
       "Ju, Seokmann" <sju@lsil.com>, "Doelfel, Hardy" <hdoelfel@lsil.com>
Subject: Re: How to add/drop SCSI drives from within the driver?
Message-ID: <20041215202222.GA6945@lists.us.dell.com>
References: <0E3FA95632D6D047BA649F95DAB60E57057A2156@exa-atlanta>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E57057A2156@exa-atlanta>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2004 at 02:42:21PM -0500, Mukker, Atul wrote:
> > 
> > Your management apps currently issue a private ioctl 
> > MEGAIOC_QNADAP which returns the number of 
> > megaraid_mm-handled adapters in the system.  How do you map a 
> > megaraid adapter number to a struct Scsi_Host device, to be 
> > sure you're acting on the controller you think you are?
>
> Megaraid_mm module maintains all the controllers on a list
> (mraid_mm_get_adapter), and each of the adapter maintains a pointer
> to the host object.

Yes, of course, I was unclear.  How do your userspace library and
management tools know that when they send commands via the
/dev/megaraid ioctls for adapter #5, that it's actually going to talk
to the PCI device at 0:03:06.0 (presumably the one it wants to do
configuration on) and not another megaraid-driven PCI device at
0:06:06.0 (which is not the one it wants) ?

If your management application doesn't care, or solves this in another
manner, please advise.

> Megaraid_mm is not a 'scsi' driver but only a conduit to pass the commands
> from application to the megaraid_mbox scsi module. 

But from your userspace tools perspective, it doesn't know that.  All
it knows is that (right now) it opens /dev/megaraid and issues ioctls
to a certain adapter number, yes?

What I'm trying to get to is a mapping, visible to userspace apps,
something like this.  You're right, megaraid_mm isn't a scsi driver,
so perhaps rather than having adapter0 with parent tree of
/sys/bus/scsi/drivers/megaraid_mm, it should be exposed with parent
tree /sys/module/megaraid_mm/, like so:

/sys
|-- class
|   `-- scsi_host
|       `-- host0
|-- devices
|   `-- pci0000:03
|       `-- 0000:03:06.0
`-- module
    |-- megaraid_mbox
    `-- megaraid_mm
        `-- adapter0
            |-- host0 -> ../../../class/scsi_host/host0
            `-- pci_dev -> ../../../devices/pci0000:03/0000:03:06.0

Your struct adapter_t has this mapping already, kernel-internal.  But
I think your userspace tools need to know the mapping too, to make
sure that adapter0 is the device they really intend to send management
commands to.

I think this question (do I have the right adapter), is analogous to
the question before (do I have the right HCTL tuple for this logical
drive), which my patch of last night may help address.

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
