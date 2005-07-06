Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262027AbVGFAkZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262027AbVGFAkZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 20:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262025AbVGFAkZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 20:40:25 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:2182 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262027AbVGFAjw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 20:39:52 -0400
Date: Tue, 5 Jul 2005 17:38:50 -0700
From: Patrick Mansfield <patmans@us.ibm.com>
To: Greg K-H <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, mochel@digitalimplant.org,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH] Use device_for_each_child() to unregister devices in scsi_remove_target().
Message-ID: <20050706003850.GA11542@us.ibm.com>
References: <11193083662356@kroah.com> <11193083663269@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11193083663269@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg / Patrick -

I'm getting an oops with current (pulled today) 2.6 git, the
device_for_each_child() does not seem to be deletion safe.

We hold the klist in place via the n_ref, but the kobj (in the struct
device for the struct scsi_target) containing it is freed when the
kref->refcount goes to zero.

Any fixes or ?

I haven't found any relevant patches or similar oopses.

The only (current) caller of scsi_remove_target() is in
scsi_transport_fc.c, for scsi you could only hit this running with the
emulex or qlogic drivers, but it could affect other replacements of
list_for_each_entry_safe with device_for_each_child.

The oops:

[linux root]# Oops: Kernel access of bad area, sig: 11 [#1]
SMP NR_CPUS=128 NUMA PSERIES LPAR 
Modules linked in: qla2300 qla2xxx scsi_transport_fc scsi_mod<7>kobject_get -> c00000001dfde390 kref c00000001dfde3ac mem: 33
 tg3 evdev joydev ipv6 ohci_hcd usbcore dm_mod
NIP: C00000000020C408 XER: 00000000 LR: C000000000394DB8 CTR: C0000000002106D0
REGS: c00000001414b240 TRAP: 0300   Not tainted  (2.6.13-rc1pm)
MSR: 8000000000009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11 CR: 24000422
DAR: 6b6b6b6b6b6b6b7b DSISR: 0000000040000000
TASK: c000000002754030[12001] 'rmmod' THREAD: c000000014148000 CPU: 0
GPR00: C000000000394DAC C00000001414B4C0 C0000000005F4618 6B6B6B6B6B6B6B7B 
GPR04: 8000000000009032 FFFFFFFFFFFFFFFF 0000000000000037 C0000000005111A4 
GPR08: C000000000511198 C000000000514A60 C0000000006024D0 C0000000006023F0 
GPR12: 0000000000000010 C0000000004B2000 0000000000000000 0000000010000000 
GPR16: 0000000000000000 0000000000000000 0000000010000000 0000000000000000 
GPR20: 0000000000000800 0000000000000002 0000000000000880 00000000FFFA7AF0 
GPR24: 00000000FFFAA320 0000000010013008 D0000000003D5460 D0000000003D53D8 
GPR28: 6B6B6B6B6B6B6B63 C00000001414B5C0 C000000000582FB8 6B6B6B6B6B6B6B6B 
NIP [c00000000020c408] .kref_get+0x0/0x28
LR [c000000000394db8] .klist_next+0x90/0x104
Call Trace:
[c00000001414b4c0] [c000000000394dac] .klist_next+0x84/0x104 (unreliable)
[c00000001414b550] [c00000000026c8e0] .device_for_each_child+0x7c/0xd0
[c00000001414b600] [d00000000030ac78] .scsi_remove_target+0xa8/0xe8 [scsi_mod]
[c00000001414b690] [d0000000002c6898] .fc_rport_tgt_remove+0xb8/0xdc [scsi_transport_fc]
[c00000001414b720] [d0000000002c6918] .fc_rport_terminate+0x5c/0xf0 [scsi_transport_fc]
[c00000001414b7b0] [d0000000002c6b7c] .fc_remove_host+0x40/0xb8 [scsi_transport_fc]
[c00000001414b830] [d0000000003e6a58] .qla2x00_remove_one+0x34/0x7c [qla2xxx]
[c00000001414b8c0] [d0000000003b7010] .qla2300_remove_one+0x10/0x24 [qla2300]
[c00000001414b940] [c00000000021bc88] .pci_device_remove+0x80/0x88
[c00000001414b9c0] [c00000000026efb0] .__device_release_driver+0xd4/0xdc
[c00000001414ba50] [c00000000026f100] .driver_detach+0x148/0x14c
[c00000001414baf0] [c00000000026e0d8] .bus_remove_driver+0xa0/0x128
[c00000001414bb90] [c00000000026f628] .driver_unregister+0x1c/0x40
[c00000001414bc20] [c00000000021bf58] .pci_unregister_driver+0x24/0xbc
[c00000001414bcb0] [d0000000003b7068] .qla2300_exit+0x1c/0x34 [qla2300]
[c00000001414bd30] [c000000000080014] .sys_delete_module+0x220/0x368
[c00000001414be30] [c00000000000d580] syscall_exit+0x0/0x18
Instruction dump:
4bfffd94 e89e8080 e87e80f0 4be4baad 60000000 4bffff60 e89e8080 e87e80c8 
4bffffec 38000001 90030000 4e800020 <81230000> 2fa90000 7c000026 5400fffe 

-- Patrick Mansfield

On Mon, Jun 20, 2005 at 03:59:26PM -0700, Greg KH wrote:
> [PATCH] Use device_for_each_child() to unregister devices in scsi_remove_target().
> 
> Signed-off-by: Patrick Mochel <mochel@digitalimplant.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> 
> Index: gregkh-2.6/drivers/scsi/scsi_sysfs.c
> ===================================================================
> 
> ---
> commit 20b1e674230b642be662c5975923a0160ab9cbdc
> tree 749e1384c57576bfbe3ffd1414df321cc783296f
> parent 0293a509405dccecc30783a5d729d615b68d6a77
> author mochel@digitalimplant.org <mochel@digitalimplant.org> Thu, 24 Mar 2005 19:03:59 -0800
> committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 15:15:19 -0700
> 
>  drivers/scsi/scsi_sysfs.c |   14 +++++++++-----
>  1 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
> --- a/drivers/scsi/scsi_sysfs.c
> +++ b/drivers/scsi/scsi_sysfs.c
> @@ -669,6 +669,13 @@ void __scsi_remove_target(struct scsi_ta
>  	scsi_target_reap(starget);
>  }
>  
> +static int __remove_child (struct device * dev, void * data)
> +{
> +	if (scsi_is_target_device(dev))
> +		__scsi_remove_target(to_scsi_target(dev));
> +	return 0;
> +}
> +
>  /**
>   * scsi_remove_target - try to remove a target and all its devices
>   * @dev: generic starget or parent of generic stargets to be removed
> @@ -679,7 +686,7 @@ void __scsi_remove_target(struct scsi_ta
>   */
>  void scsi_remove_target(struct device *dev)
>  {
> -	struct device *rdev, *idev, *next;
> +	struct device *rdev;
>  
>  	if (scsi_is_target_device(dev)) {
>  		__scsi_remove_target(to_scsi_target(dev));
> @@ -687,10 +694,7 @@ void scsi_remove_target(struct device *d
>  	}
>  
>  	rdev = get_device(dev);
> -	list_for_each_entry_safe(idev, next, &dev->children, node) {
> -		if (scsi_is_target_device(idev))
> -			__scsi_remove_target(to_scsi_target(idev));
> -	}
> +	device_for_each_child(dev, NULL, __remove_child);
>  	put_device(rdev);
>  }
>  EXPORT_SYMBOL(scsi_remove_target);
