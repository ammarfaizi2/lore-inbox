Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932068AbWELRQg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbWELRQg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 13:16:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833AbWELRQg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 13:16:36 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:6484 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1750823AbWELRQf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 13:16:35 -0400
Date: Fri, 12 May 2006 19:16:33 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Or Gerlitz <or.gerlitz@gmail.com>
Cc: linux-scsi@vger.kernel.org, rmk@arm.linux.org.uk, axboe@suse.de,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [BUG 2.6.17-git] kmem_cache_create: duplicate cache scsi_cmd_cache
Message-ID: <20060512171632.GA29077@harddisk-recovery.com>
References: <20060511151456.GD3755@harddisk-recovery.com> <15ddcffd0605112153q57f139a1k7068e204a3eeaf1f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15ddcffd0605112153q57f139a1k7068e204a3eeaf1f@mail.gmail.com>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2006 at 06:53:27AM +0200, Or Gerlitz wrote:
> On 5/11/06, Erik Mouw <erik@harddisk-recovery.com> wrote:
> >Hi,
> >
> >While playing with libata in 2.6.17-git from today, I got this bug:
> >
> >SCSI subsystem initialized
> >libata version 1.20 loaded.
> >sata_promise 0000:02:05.0: version 1.04
> >kmem_cache_create: duplicate cache scsi_cmd_cache
> > <c0159591> kmem_cache_create+0x331/0x390
> > <e0924371> scsi_setup_command_freelist+0x71/0xf0 [scsi_mod]
> > <e092588e> scsi_host_alloc+0x17e/0x270 [scsi_mod]
> > <e08fd061> ata_host_add+0x41/0xc0 [libata]
> > <c0148c9f> __kzalloc+0x1f/0x50
> > <e08fd190> ata_device_add+0xb0/0x240 [libata]
> > <e0839baf> pdc_ata_init_one+0x27f/0x330 [sata_promise]
> > <c01dd1a9> pci_call_probe+0x19/0x20
> > <c01dd20e> __pci_device_probe+0x5e/0x70
> > <c01dd24f> pci_device_probe+0x2f/0x50
> > <c0220977> driver_probe_device+0xb7/0xe0
> > <c02b338a> klist_dec_and_del+0x1a/0x20
> > <c0220a30> __driver_attach+0x0/0x90
> > <c0220aa1>__driver_attach+0x71/0x90
> > <c021fd49> bus_for_each_dev+0x69/0x80
> > <c0220ae6> driver_attach+0x26/0x30
> > <c0220a30> __driver_attach+0x0/0x90
> > <c02202a3> bus_add_driver+0x83/0xc0
> > <c01dd4ed> __pci_register_driver+0x4d/0x70
> > <e0880017> pdc_ata_init+0x17/0x1b [sata_promise]
> > <c013a1a0> sys_init_module+0x120/0x1b0
> > <c0102f27> syscall_call+0x7/0xb
> 
> I was pointing on 2.6.17 kmem_cache related  issues while back to LKML
> and it turns out that you can reproduce them easily with standalone
> trivial module, see
> http://openib.org/pipermail/openib-general/2006-April/020582.html
> 
> So far no one picked the issue anb i was adviced to use bisection...

I tracked it down with git bisect. The culprit is this commit:

56cf6504fc1c0c221b82cebc16a444b684140fb7 is first bad commit
diff-tree 56cf6504fc1c0c221b82cebc16a444b684140fb7 (from
d98550e334715b2d9e45f8f0f4e1608720108640)
Author: Russell King <rmk@dyn-67.arm.linux.org.uk>
Date:   Fri May 5 17:57:52 2006 +0100

    [BLOCK] Fix oops on removal of SD/MMC card

    The block layer keeps a reference (driverfs_dev) to the struct
    device associated with the block device, and uses it internally
    for generating uevents in block_uevent.

    Block device uevents include umounting the partition, which can
    occur after the backing device has been removed.

    Unfortunately, this reference is not counted.  This means that
    if the struct device is removed from the device tree, the block
    layers reference will become stale.

    Guard against this by holding a reference to the struct device
    in add_disk(), and only drop the reference when we're releasing
    the gendisk kobject - in other words when we can be sure that no
    further uevents will be generated for this block device.

    Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
    Acked-by: Jens Axboe <axboe@suse.de>

:040000 040000 4923c988a57db93382546cd83f4e3043b06c0eed 08e396a4fbf3c7d0beb9178f0fd0c9205c0b5305 M      block

After reverting this commit in 2.6.17-rc4 I can't trigger the bug
anymore. Might be worth fixing before 2.6.17-final.

Note: I'm going on holiday next week, so I'm not able to test any
fixes. However, because this bug is very easy to trigger[1], anybody
with root on NFS and fully modular SCSI or libata should be able to
test.


Erik

[1] See http://marc.theaimsgroup.com/?l=linux-scsi&m=114736053211943&w=2

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
