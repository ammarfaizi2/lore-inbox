Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262827AbTIQVdn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 17:33:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262843AbTIQVdm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 17:33:42 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:16134 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262827AbTIQVdj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 17:33:39 -0400
Date: Wed, 17 Sep 2003 22:33:36 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Sean Estabrooks <seanlkml@rogers.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PCMCIA]  Xircom nic hang on boot since cs.c race condition patch
Message-ID: <20030917223336.H16045@flint.arm.linux.org.uk>
Mail-Followup-To: Sean Estabrooks <seanlkml@rogers.com>,
	linux-kernel@vger.kernel.org
References: <20030917144406.753953dd.seanlkml@rogers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030917144406.753953dd.seanlkml@rogers.com>; from seanlkml@rogers.com on Wed, Sep 17, 2003 at 02:44:06PM -0400
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 17, 2003 at 02:44:06PM -0400, Sean Estabrooks wrote:
> [PCMCIA] Fix race condition causing cards to be incorrectly recognised
> 
> This patch that went into test5 causes my Toshiba laptop with Xircom 
> pcmcia nic to freeze on boot at "Socket status: 30000020".  

Unfortunately this patch does two things:

(a) it fixes the problem with PCMCIA cards not being recognised on boot.
(b) it introduces a deadlock between the PCMCIA layer and the driver
    model.

The trace I'm seeing is:

insmod        D C003AC98 28008860   446    422                     (NOTLB)
[<c003a9fc>] (schedule+0x0/0x368)
[<c002b4a0>] (__down+0x0/0x108)
[<bf0059bc>] (pcmcia_register_client+0x0/0x288 [pcmcia_core])
[<bf012458>] (pcmcia_bus_add_socket+0x0/0x168 [ds])
[<c00f5c48>] (class_device_add+0x0/0x10c)
[<bf00395c>] (pcmcia_register_socket+0x0/0x160 [pcmcia_core])
[<bf016558>] (yenta_probe+0x0/0x238 [yenta_socket])
[<c00cbc14>] (pci_device_probe_static+0x0/0x68)
[<c00cbd64>] (__pci_device_probe+0x0/0x58)
[<c00cbdbc>] (pci_device_probe+0x0/0x44)
[<c00f50b8>] (bus_match+0x0/0x70)
[<c00f51b8>] (driver_attach+0x0/0x80)
[<c00f53d0>] (bus_add_driver+0x0/0x84)
[<c00f5710>] (driver_register+0x0/0x40)
[<c00cc018>] (pci_register_driver+0x0/0x88)
[<c0053a00>] (sys_init_module+0x0/0x308)
pccardd       D C003AC98 4290282060   448      1                 418 (L-TLB)
[<c003a9fc>] (schedule+0x0/0x368)
[<c00c3de8>] (__down_write+0x0/0x98)
[<c00f52e0>] (bus_add_device+0x0/0x7c)
[<c00f4454>] (device_add+0x0/0xe4)
[<c00c8800>] (pci_bus_add_devices+0x0/0xf4)
[<bf0092e8>] (cb_alloc+0x0/0xd0 [pcmcia_core])
[<bf0042b0>] (socket_insert+0x0/0x1ec [pcmcia_core])
[<bf004694>] (socket_detect_change+0x0/0x90 [pcmcia_core])
[<bf004724>] (pccardd+0x0/0x178 [pcmcia_core])

The problem is that the semaphore which prevents ds interfering with the
sleepy card initialisation (in pccardd) is blocking insmod.  However,
the driver is being called with the PCI bus semaphore held.

pccardd in turn discovered a cardbus card, so it is trying to add the
PCI devices to the PCI bus, which requires the PCI bus semaphore.

At present, I do not see a sane solution to this problem - we have two
completely contradictory requirements.  The only way which may work is
to play tricks like "wait 1 second" and hope pccardd has completed type
hacks into PCMCIA to get around this, but that's somewhere I _do not_
want to go.

-- 
Russell King (rmk@arm.linux.org.uk)	http://www.arm.linux.org.uk/personal/
Linux kernel maintainer of:
  2.6 ARM Linux   - http://www.arm.linux.org.uk/
  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
  2.6 Serial core
