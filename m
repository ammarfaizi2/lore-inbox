Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261735AbUBHBM3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 20:12:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261774AbUBHBM2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 20:12:28 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56513 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261735AbUBHBM0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 20:12:26 -0500
Date: Sun, 8 Feb 2004 01:12:25 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: walt <wa1ter@myrealbox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.1] Kernel panic with ppa driver updates
Message-ID: <20040208011225.GB21151@parcelfarce.linux.theplanet.co.uk>
References: <4023D098.1000904@myrealbox.com> <20040206182844.GJ21151@parcelfarce.linux.theplanet.co.uk> <40257081.50706@myrealbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40257081.50706@myrealbox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 07, 2004 at 03:10:57PM -0800, walt wrote:
>  [<c027bd3b>] ppa_pb_claim+0x7b/0x80
>  [<c027d577>] __ppa_attach+0x127/0x350
>  [<c027bc50>] ppa_wakeup+0x0/0x70
>  [<c011aa40>] autoremove_wake_function+0x0/0x50
>  [<c011aa40>] autoremove_wake_function+0x0/0x50
>  [<c023a746>] parport_register_driver+0x36/0x70
>  [<c0485b83>] ppa_driver_init+0x23/0x30
>  [<c046e74c>] do_initcalls+0x2c/0xa0
>  [<c012c9ff>] init_workqueues+0xf/0x30
>  [<c01050d2>] init+0x32/0x140
>  [<c01050a0>] init+0x0/0x140
>  [<c0106fe9>] kernel_thread_helper+0x5/0xc
> 
> Code: c7 80 24 01 00 00 01 00 00 00 c3 8b 42 50 b9 01 00 00 00 ba
>  <0>Kernel panic: Attempted to kill init!

Ouch.  So we somehow got the call of ppa_pb_claim() with dev->cur_cmd being
0x7232b2df, which wasn't a valid address.  Better yet, we've got it from
ppa_attach() and that bugger had just explicitly zeroed *dev out.  And that
bites us only in the built-in case.

Very interesting...  Could you add
	printk("dev = %p, dev->cur_cmd = %p\n", dev, dev->cur_cmd);
right before the call of ppa_pb_claim() call in __ppa_attach(), the
same - right before if (dev->wanted) in the same function and
	printk("dev = %p, dev->cur_cmd set to %p\n", dev, dev->cur_cmd);
right after dev->cur_cmd = cmd; in ppa_queuecommand()?
