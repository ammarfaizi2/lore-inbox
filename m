Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264605AbUBRLTA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 06:19:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264893AbUBRLTA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 06:19:00 -0500
Received: from delerium.kernelslacker.org ([81.187.208.145]:59050 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S264605AbUBRLS5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 06:18:57 -0500
Date: Wed, 18 Feb 2004 11:16:12 +0000
From: Dave Jones <davej@redhat.com>
To: Marc Zyngier <mzyngier@freesurf.fr>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: EISA & sysfs.
Message-ID: <20040218111612.GM6242@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Marc Zyngier <mzyngier@freesurf.fr>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20040217235431.GF6242@redhat.com> <wrpfzd87mg6.fsf@panther.wild-wind.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wrpfzd87mg6.fsf@panther.wild-wind.fr.eu.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 18, 2004 at 10:42:49AM +0100, Marc Zyngier wrote:

 > Dave> Wouldn't it make sense to have eisa_driver_register() check that the
 > Dave> root EISA bus actually got registered, and if not, -ENODEV
 > Dave> immediately ?
 > 
 > Most of the time, the bus driver kicks in *after* the device driver is
 > registered to the EISA framework (eisa is second to last in the driver
 > list, so if the driver is built-in, it is guaranted to init before the
 > root driver has a chance to discover the bus).

sounds like the initcall needs a different priority.

 > So, returning -ENODEV immediatly in this case prevents you from using
 > any built-in EISA driver. A possible solution to this problem would be
 > to move eisa just after the pci init (and even that would cause some
 > trouble, because the virtual_root driver would register before the
 > parisc root driver has a chance to be probed...).
 > 
 > So yes, this sucks, but I can't come up with a better solution...

This problem is not just cosmetic btw, it kills boxes.
For example, hp100 is a net driver that supports multiple busses.
Trying to modprobe it on a kernel that supports EISA on a box that
doesn't gets a hung modprobe. Backtrace shows..

 modprobe      D 00000082     0 23407  15920                     (NOTLB)
        c1fe3f2c 00000082 c031ba08 00000082 ffffffff c031bb90 cc318219 00000092
        c6ee8ca0 c6ee8cc0 c111acc0 0040603e cc532c37 00000092 c267eca0 c267ee70
        c6c6375c 00000001 000005a0 c035ffcc ffffffff c7c5e644 c267eca0 c01d4583
 Call Trace:
  [<c01d4583>] rwsem_down_write_failed+0x141/0x15c
  [<c01d3742>] .text.lock.kobject+0x36/0x74
  [<c01d339a>] kobject_register+0x19/0x39
  [<c0221a5c>] bus_add_driver+0x2e/0x83
  [<c02622d4>] eisa_driver_register+0xf/0x19
  [<c786e91e>] hp100_module_init+0x12/0x2e [hp100]
  [<c013c0c0>] sys_init_module+0x14e/0x25e
  [<c010b697>] syscall_call+0x7/0xb

I've seen same exactly the same behaviour with quite a few other modules.
For my 'modprobe/rmmod script-o-death', I just ended up disabling EISA
in that test tree, as it was too painful to hit this issue over and over,
but its a real situation that could bite users of for eg, vendor kernels.

		Dave

