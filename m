Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262566AbVAUWUr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262566AbVAUWUr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 17:20:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262564AbVAUWUL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 17:20:11 -0500
Received: from mail0.lsil.com ([147.145.40.20]:969 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S262566AbVAUWTS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 17:19:18 -0500
Message-ID: <0E3FA95632D6D047BA649F95DAB60E5705A70B74@exa-atlanta>
From: "Mukker, Atul" <Atulm@lsil.com>
To: "'James Bottomley'" <James.Bottomley@SteelEye.com>,
       "'Matt Domsch'" <Matt_Domsch@Dell.com>
Cc: "'Salyzyn, Mark'" <mark_salyzyn@adaptec.com>,
       "Bagalkote, Sreenivas" <sreenib@lsil.com>,
       "'brking@us.ibm.com'" <brking@us.ibm.com>,
       "'Linux Kernel'" <linux-kernel@vger.kernel.org>,
       "'SCSI Mailing List'" <linux-scsi@vger.kernel.org>,
       "'bunk@fs.tum.de'" <bunk@fs.tum.de>, "'Andrew Morton'" <akpm@osdl.org>,
       "Ju, Seokmann" <sju@lsil.com>, "Doelfel, Hardy" <hdoelfel@lsil.com>,
       "Mukker, Atul" <Atulm@lsil.com>
Subject: RE: How to add/drop SCSI drives from within the driver?
Date: Fri, 21 Jan 2005 17:11:17 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All right! The implementation is complete for this and the driver has
thoroughly gone through testing. Everything looks good except for a minor
glitch.

After the new logical drives are created with "- - -" written to the
scsi_host scan attribute, there is a highly noticeable delay before device
names (e.g., sda) appears in the /dev directory. If the management
application tried to access the device immediately after creating new, the
access fails. Putting a 1 second delay helped, but of course this is not a
deterministic solution.

What are the other possibilities?

Thanks
-Atul Mukker
LSI Logic

> -----Original Message-----
> From: James Bottomley [mailto:James.Bottomley@SteelEye.com] 
> Sent: Wednesday, December 15, 2004 1:49 PM
> To: Matt Domsch
> Cc: Salyzyn, Mark; Bagalkote, Sreenivas; brking@us.ibm.com; 
> Linux Kernel; SCSI Mailing List; bunk@fs.tum.de; Andrew 
> Morton; Ju, Seokmann; Doelfel, Hardy; Mukker, Atul
> Subject: Re: How to add/drop SCSI drives from within the driver?
> 
> On Wed, 2004-12-15 at 01:24 -0600, Matt Domsch wrote:
> > James, I've been thinking about this a little more, and you 
> may be on 
> > to something here. Let each driver add files as such:
> > 
> > /sys/class/scsi_host
> >  |-- host0
> >  |   |-- add_logical_drive
> >  |   |-- remove_logical_drive
> >  |   `-- rescan_logical_drive
> > 
> > Then we can go 2 ways with this.
> > 1) driver functions directly call scsi_add_device(), 
> > scsi_remove_device(), and something for rescan (option 2 
> handles this 
> > one cleanly for us).  ATM, megaraid_mbox doesn't implement a rescan 
> > function, so this point may be moot.
> > 
> > 2) driver functions call a midlayer library function, which invokes
> >    /sbin/hotplug with appropriate data, and add a new /etc/hotplug.d
> >    helper app which would then write to these files:
> > 
> > /sys/class/scsi_host
> > |-- host0
> > |   |-- scan
> > /sys/devices/pci0000:0x/0000:0x:0x.0/host0
> > |-- 0:0:0:0
> > |   |-- delete
> > |   |-- rescan
> > 
> > to do likewise.
> 
> I'll buy this (option 2).. it seems like a good way to export 
> the megaraid specific information and at the same time 
> integrate it more fully into the evolving hotplug infrastructure.
> 
> James
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in the body of a message to 
> majordomo@vger.kernel.org More majordomo info at  
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
