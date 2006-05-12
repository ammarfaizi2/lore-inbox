Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751142AbWELR1c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbWELR1c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 13:27:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751180AbWELR1c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 13:27:32 -0400
Received: from pat.qlogic.com ([198.70.193.2]:30219 "EHLO avexch1.qlogic.com")
	by vger.kernel.org with ESMTP id S1751142AbWELR1b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 13:27:31 -0400
Date: Fri, 12 May 2006 10:27:29 -0700
From: Andrew Vasquez <andrew.vasquez@qlogic.com>
To: Erik Mouw <erik@harddisk-recovery.com>
Cc: Or Gerlitz <or.gerlitz@gmail.com>, linux-scsi@vger.kernel.org,
       rmk@arm.linux.org.uk, axboe@suse.de, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: [BUG 2.6.17-git] kmem_cache_create: duplicate cache scsi_cmd_cache
Message-ID: <20060512172729.GA2321@andrew-vasquezs-powerbook-g4-15.local>
References: <20060511151456.GD3755@harddisk-recovery.com> <15ddcffd0605112153q57f139a1k7068e204a3eeaf1f@mail.gmail.com> <20060512171632.GA29077@harddisk-recovery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060512171632.GA29077@harddisk-recovery.com>
Organization: QLogic Corporation
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 12 May 2006 17:27:30.0348 (UTC) FILETIME=[58C086C0:01C675E9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 May 2006, Erik Mouw wrote:

> On Fri, May 12, 2006 at 06:53:27AM +0200, Or Gerlitz wrote:
> > On 5/11/06, Erik Mouw <erik@harddisk-recovery.com> wrote:
> > >Hi,
> > >
> > >While playing with libata in 2.6.17-git from today, I got this bug:
> > >
> > >SCSI subsystem initialized
> > >libata version 1.20 loaded.
> > >sata_promise 0000:02:05.0: version 1.04
> > >kmem_cache_create: duplicate cache scsi_cmd_cache
> > > <c0159591> kmem_cache_create+0x331/0x390
> > > <e0924371> scsi_setup_command_freelist+0x71/0xf0 [scsi_mod]
> > > <e092588e> scsi_host_alloc+0x17e/0x270 [scsi_mod]
> > > <e08fd061> ata_host_add+0x41/0xc0 [libata]
> > > <c0148c9f> __kzalloc+0x1f/0x50
> > > <e08fd190> ata_device_add+0xb0/0x240 [libata]
> > > <e0839baf> pdc_ata_init_one+0x27f/0x330 [sata_promise]
> > > <c01dd1a9> pci_call_probe+0x19/0x20
> > > <c01dd20e> __pci_device_probe+0x5e/0x70
> > > <c01dd24f> pci_device_probe+0x2f/0x50
> > > <c0220977> driver_probe_device+0xb7/0xe0
> > > <c02b338a> klist_dec_and_del+0x1a/0x20
> > > <c0220a30> __driver_attach+0x0/0x90
> > > <c0220aa1>__driver_attach+0x71/0x90
> > > <c021fd49> bus_for_each_dev+0x69/0x80
> > > <c0220ae6> driver_attach+0x26/0x30
> > > <c0220a30> __driver_attach+0x0/0x90
> > > <c02202a3> bus_add_driver+0x83/0xc0
> > > <c01dd4ed> __pci_register_driver+0x4d/0x70
> > > <e0880017> pdc_ata_init+0x17/0x1b [sata_promise]
> > > <c013a1a0> sys_init_module+0x120/0x1b0
> > > <c0102f27> syscall_call+0x7/0xb
> > 
> > I was pointing on 2.6.17 kmem_cache related  issues while back to LKML
> > and it turns out that you can reproduce them easily with standalone
> > trivial module, see
> > http://openib.org/pipermail/openib-general/2006-April/020582.html
> > 
> > So far no one picked the issue anb i was adviced to use bisection...
> 
> I tracked it down with git bisect. The culprit is this commit:
> 
> 56cf6504fc1c0c221b82cebc16a444b684140fb7 is first bad commit
> diff-tree 56cf6504fc1c0c221b82cebc16a444b684140fb7 (from
> d98550e334715b2d9e45f8f0f4e1608720108640)
> Author: Russell King <rmk@dyn-67.arm.linux.org.uk>
> Date:   Fri May 5 17:57:52 2006 +0100
> 
>     [BLOCK] Fix oops on removal of SD/MMC card
> 
>     The block layer keeps a reference (driverfs_dev) to the struct
>     device associated with the block device, and uses it internally
>     for generating uevents in block_uevent.
> 
>     Block device uevents include umounting the partition, which can
>     occur after the backing device has been removed.
...

THat's really weird... I reported a completely unrelated problem some
days ago:

	http://marc.theaimsgroup.com/?l=linux-kernel&m=114728598328769&w=2

> After reverting this commit in 2.6.17-rc4 I can't trigger the bug
> anymore. Might be worth fixing before 2.6.17-final.

and similarly reverted the commit in question...

I'm still trying to track this down...

> Note: I'm going on holiday next week, so I'm not able to test any
> fixes. However, because this bug is very easy to trigger[1], anybody
> with root on NFS and fully modular SCSI or libata should be able to
> test.

--
Andrew Vasquez
