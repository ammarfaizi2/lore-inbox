Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263019AbTDIMMw (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 08:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263204AbTDIMMw (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 08:12:52 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:32217 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S263019AbTDIMMv (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 08:12:51 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Helge Hafting <helgehaf@aitel.hist.no>
Date: Wed, 9 Apr 2003 14:24:00 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: 2.5.67-mm1 cause framebuffer crash at bootup
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, jsimmons@infradead.org,
       akpm@digeo.com
X-mailer: Pegasus Mail v3.50
Message-ID: <11CB582A88@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  9 Apr 03 at 11:42, Helge Hafting wrote:
> 
> 2.5.67-mm1 works if I drop framebuffer support completely.

Now when you sent full backtrace - it looks to me like that fbdev
drivers are initialized before pci subsystem in -mm1. Unfortunately,
as proven by i2c, kobjects infrastructure does not like if you reference
non-existing bus type before it is registered. 

Can you try reverting _initcall changes? Although I see no reason
why it should matter, it is clear that pci subsystem is a bit unhappy.
Maybe it is caused by driver or device which is probed before fbdev?
                                                    Petr Vandrovec
                                                    vandrove@vc.cvut.cz

P.S.: And what about change in drivers/pci/probe.c, which does

-  if (base && base <= limit) {
+  if (base <= limit) {


> Here is the printed backtrace for the radeon case, the matrox case was 
> similiar:
> 
> <a few lines scrolled off screen>
> pcibios_enable_device
> pci_enable_device_bars
> pci_enable_device
> radeonfb_pci_register
> sysfs_new_inode
> pci_device_probe
> bus_match
> device_attach
> bus_add_device
> kobject_add
> device_add
> pci_bus_add_devices
> pci_bus_add_devices
> pci_scan_bus_parented
> pcibios_scan_root
> pci_legacy_init
> do_initcalls
> init_workqueues
> init+0x36
> init+0x00
> kernel_thread_helper
> code: Bad EIP value <0>Kernel panic:attempt to kill init!

