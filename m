Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267720AbUIZJcb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267720AbUIZJcb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Sep 2004 05:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268525AbUIZJca
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Sep 2004 05:32:30 -0400
Received: from anchor-post-34.mail.demon.net ([194.217.242.92]:64012 "EHLO
	anchor-post-34.mail.demon.net") by vger.kernel.org with ESMTP
	id S267720AbUIZJc2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Sep 2004 05:32:28 -0400
Date: Sun, 26 Sep 2004 10:32:54 +0100
From: Colin Phipps <cph@cph.demon.co.uk>
To: Maurice Volaski <mvolaski@aecom.yu.edu>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
       davem@nuts.davemloft.net, mchan@broadcom.com
Subject: Re: 2.68.rc4 affected by tg3 [Was Re: tg3 module in kernel 2.6.5 panics ]
Message-ID: <20040926093254.GA2593@cph.demon.co.uk>
Mail-Followup-To: Maurice Volaski <mvolaski@aecom.yu.edu>,
	Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
	davem@nuts.davemloft.net, mchan@broadcom.com
References: <a06100547bcd3f33b5b73@[129.98.90.227]> <40AE4DDC.7050508@pobox.com> <a06100577bd7bc87d92ee@[129.98.90.227]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a06100577bd7bc87d92ee@[129.98.90.227]>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 25, 2004 at 09:26:07PM -0400, Maurice Volaski wrote:
> I just tested with 2.68.rc4 from gentoo and although it doesn't panic 
> and the driver even appears to load, the kernel spews out a crash 
> message in the log similar to before. The eth0 interface doesn't show 
> up in ifconfig.

Going back to your original oops

> RIP <ffffffff802ad048>{kobject_add+120}
> call trace: <ffffffff802ad0c8>{kobject_register+40}<ffffffff80306676>{bus_add_driver+86} <ffffffff802380e0{pci_register_driver+128}<ffffffffa00c06010>{:tg3:tg3_init +16} <ffffffff80157404>{sys_init_module+436}<ffffffff80110e24>{system_call+124>

this looks similar to one I saw with 2.6.8.1 on a machine here on its
first upgrade to 2.6.x - except it was with totally different modules
(oops in kobject_add reached via pnp_register_driver loading ns558).

: EIP; c01a432f <kobject_add+6f/100>
: Call Trace: [<c01a43e8>] kobject_register+0x28/0x60 [<c01f5fe0>] bus_add_driver+0x50/0xb0  [<c01f65cf>] driver_register+0x2f/0x40   [<c01ced5d>] pnp_register_driver+0x2d/0x70    [<d0825030>] ns558_init+0x30/0x50 [ns558]     [<c0133030>] sys_init_module+0x100/0x210      [<c010603b>] syscall_call+0x7/0xb

It turned out to be due to hotplug loading a buggy module earlier in the
boot, which did a pnp_register_driver and then aborted the module load
when it found nothing, without unregistering itself. The problem went
away with 2.6.9-rc2 for me, the offending module (cs4232) seems to be
fixed.  So it's worth looking for any modules that failed to load
earlier in the boot, they could be leaving junk in pci_bus_type.drivers
.

-- 
Colin Phipps <cph@cph.demon.co.uk>
