Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932402AbWFJHbj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932402AbWFJHbj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 03:31:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932439AbWFJHbj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 03:31:39 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:61874 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S932402AbWFJHbi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 03:31:38 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <448A74B1.5000606@s5r6.in-berlin.de>
Date: Sat, 10 Jun 2006 09:28:49 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: Miles Lane <miles.lane@gmail.com>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       linux1394-devel@lists.sourceforge.net
Subject: Re: 2.6.17-rc6-mm1 -- BUG: warning at drivers/ieee1394/ohci1394.c:235/get_phy_reg()
References: <a44ae5cd0606092234k70f92bfajb359a9e0c09db3b9@mail.gmail.com>
In-Reply-To: <a44ae5cd0606092234k70f92bfajb359a9e0c09db3b9@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (0.877) AWL,BAYES_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miles Lane wrote at lkml:
> BUG: warning at drivers/ieee1394/ohci1394.c:235/get_phy_reg()
> [<c0103999>] show_trace_log_lvl+0x53/0xff
> [<c0103ff1>] show_trace+0x16/0x19
> [<c0104037>] dump_stack+0x1a/0x1f
> [<f9295ade>] get_phy_reg+0x77/0xe4 [ohci1394]
> [<f9295e66>] ohci_devctl+0x49/0x56c [ohci1394]
> [<f9298e82>] ohci_irq_handler+0x329/0x720 [ohci1394]
> [<c01435cd>] handle_IRQ_event+0x18/0x4d
> [<c01443fb>] handle_fasteoi_irq+0x57/0x95
> [<c01050bf>] do_IRQ+0xa1/0xc6
> [<c0103475>] common_interrupt+0x25/0x2c
> BUG: warning at drivers/ieee1394/ohci1394.c:264/set_phy_reg()
> [<c0103999>] show_trace_log_lvl+0x53/0xff
> [<c0103ff1>] show_trace+0x16/0x19
> [<c0104037>] dump_stack+0x1a/0x1f
> [<f9295a14>] set_phy_reg+0x84/0xd7 [ohci1394]
> [<f9295e79>] ohci_devctl+0x5c/0x56c [ohci1394]
> [<f9298e82>] ohci_irq_handler+0x329/0x720 [ohci1394]
> [<c01435cd>] handle_IRQ_event+0x18/0x4d
> [<c01443fb>] handle_fasteoi_irq+0x57/0x95
> [<c01050bf>] do_IRQ+0xa1/0xc6
> [<c0103475>] common_interrupt+0x25/0x2c

Above trace seems to appear due to a hack to get certain FireWire 
controllers going: Apple UniNorth, NVidia nForce2. Miles, do you have 
one of those?

A similar trace occurs as ohci_irq_handler -> hpsb_selfid_complete
-> highlevel_host_reset -> csr.c::host_reset -> {ohci_}hw_csr_reg -> 
mdelay. This host_rest's purpose is to mark iso channel 31 as default 
broadcast channel. This functionality can probably be moved into a 
workqueue job or into nodemgr's kthread. This is currently being tracked 
as http://bugzilla.kernel.org/show_bug.cgi?id=6070 but I am afraid 
nobody is actively working on it yet.
-- 
Stefan Richter
-=====-=-==- -==- -=-=-
http://arcgraph.de/sr/
