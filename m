Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932449AbWEJScr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932449AbWEJScr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 14:32:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932456AbWEJScr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 14:32:47 -0400
Received: from pat.qlogic.com ([198.70.193.2]:58339 "EHLO avexch2.qlogic.com")
	by vger.kernel.org with ESMTP id S932449AbWEJScq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 14:32:46 -0400
Date: Wed, 10 May 2006 11:31:44 -0700
From: Andrew Vasquez <andrew.vasquez@qlogic.com>
To: Linux-SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: rmk+kernel@arm.linux.org.uk, axboe@suse.de
Subject: OOPS during FC-aware-driver module reload...
Message-ID: <20060510183144.GG2190@andrew-vasquezs-powerbook-g4-15.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: QLogic Corporation
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 10 May 2006 18:32:45.0693 (UTC) FILETIME=[21A742D0:01C67460]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Recent linux-2.6.git trees introduced some oddities while performing a
simple load/unload/load of the qla2xxx (a FC transport aware driver)
driver.

Basically on module reload, I'd consistently hit the following

	# insmod qla2xxx
	# rmmod qla2xxx
	# insmod qla2xxx

	BUG: unable to handle kernel NULL pointer dereference at virtual address 00000000
	 printing eip: 00000000
	*pde = 00000000
	Oops: 0000 [#1]
	SMP
	Modules linked in: qla2xxx scsi_transport_fc
	CPU:    1
	EIP:    0060:[<00000000>]    Not tainted VLI
	EFLAGS: 00010246   (2.6.17-rc3 #32)
	EIP is at _stext+0x3feffd68/0x23
	eax: 00000000   ebx: f7c6c448   ecx: f3e92128   edx: 00000000
	esi: f3e92128   edi: c02fe420   ebp: 6b6b6b6b   esp: ea290dcc
	ds: 007b   es: 007b   ss: 0068
	Process insmod (pid: 10001, threadinfo=ea290000 task=f40ada90)
	Stack: <0>c0226794 6b6b6b6b f3e92128 f8b216e0 f3e92128 f3e92000 00000000 000000d0 
	       c0226cc3 f3e92128 c0226c90 c02598e4 f3e92128 f3e920f1 f3e92000 c02520c7 
	       f3e92000 ffff5e05 f3e92358 f3e93b14 f3e92000 f8b04d29 f3e92000 c1b2eb5c 
	Call Trace:
	 <c0226794> attribute_container_add_device+0x4b/0x135  <c0226cc3> transport_setup_device+0xe/0x11
	 <c0226c90> transport_setup_classdev+0x0/0x25   <c02598e4> scsi_sysfs_add_host+0x9e/0xac
	 <c02520c7> scsi_add_host+0x129/0x179   <f8b04d29> qla2x00_probe_one+0xa33/0xb34 [qla2xxx]
	 <c0125eb3> call_usermodehelper_keys+0xf7/0x104   <c0125d78> __call_usermodehelper+0x0/0x44
	 <f8b05e1b> qla2xxx_probe_one+0xe/0x11 [qla2xxx]   <c01e4ae6> pci_call_probe+0xf/0x12
	 <c01e4b1c> __pci_device_probe+0x33/0x47   <c01e4b4f> pci_device_probe+0x1f/0x34
	 <c0223ec4> driver_probe_device+0x43/0xa4   <c0223f95> __driver_attach+0x0/0x84
	 <c0223fee> __driver_attach+0x59/0x84   <c02235aa> bus_for_each_dev+0x47/0x6d
	 <c01dc91e> kobject_add+0xae/0xf7   <c022402d> driver_attach+0x14/0x18
	 <c0223f95> __driver_attach+0x0/0x84   <c02239d1> bus_add_driver+0x57/0x8d
	 <c02244b6> driver_register+0xb9/0xbe   <c01e4d4e> __pci_register_driver+0x85/0x96
	 <f883c07b> qla2x00_module_init+0x7b/0xa2 [qla2xxx]   <c01308c1> sys_init_module+0x8d/0x171
	 <c010266f> sysenter_past_esp+0x54/0x75  
	Code:  Bad EIP value.
	EIP: [<00000000>] _stext+0x3feffd68/0x23 SS:ESP 0068:ea290dcc

after some churning, git-bisect pointed to commit:

	commit 56cf6504fc1c0c221b82cebc16a444b684140fb7
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

after reverting the commit, all is fine again (no more panics during
reload).  My fear though is that we're simply masking an underlying
problem which the commit attempted to correct.

Ideas?

--
av
