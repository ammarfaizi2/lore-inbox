Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266868AbTGKVpS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 17:45:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266869AbTGKVpR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 17:45:17 -0400
Received: from air-2.osdl.org ([65.172.181.6]:33734 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266868AbTGKVpG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 17:45:06 -0400
Date: Fri, 11 Jul 2003 14:53:09 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org, acpi-support@lists.sourceforge.net,
       Scott Feldman <scott.feldman@intel.com>
Subject: Re: [2.5.75] S3 and S4
Message-Id: <20030711145309.091069e6.akpm@osdl.org>
In-Reply-To: <20030711215240.GA335@elf.ucw.cz>
References: <20030711193611.GA824@dreamland.darkstar.lan>
	<20030711200053.GA402@elf.ucw.cz>
	<20030711134833.1adeceb1.akpm@osdl.org>
	<20030711215240.GA335@elf.ucw.cz>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@suse.cz> wrote:
>
> > > > Suspending devices
> > > > Badness in local_bh_enable at kernel/softirq.c:113
> > > > Call Trace:
> > > >  [<c0130078>] local_bh_enable+0x88/0x90
> > > >  [<f0a44fa4>] e100_do_wol+0x14/0x60 [e100]
> > > >  [<f0a461ee>] e100_suspend+0x3e/0xa0 [e100]
> > > >  [<f0a461b0>] e100_suspend+0x0/0xa0 [e100]
> > > >  [<c0212577>] pci_device_suspend+0x47/0x70
> > > >  [<c029bc99>] device_suspend+0xd9/0x100
> > > >  [<c023e047>] acpi_system_save_state+0x42/0x8c
> > > >  [<c023e153>] acpi_suspend+0x5e/0xb3
> > > >  [<c023e394>] acpi_system_write_sleep+0xe3/0x132
> > > >  [<c0177de0>] filp_open+0x60/0x70
> > > >  [<c017952d>] vfs_write+0xad/0x120
> > > >  [<c017963f>] sys_write+0x3f/0x60
> > > >  [<c010b10f>] syscall_call+0x7/0xb
> > > > 
> > > 
> > > If e100. You have the hardware...
> > 
> > No, it's acpi_system_save_state() illegally calling device_suspend() under
> > local_irq_disable().
> 
> Oops, I failed to see this is S3.
> 
> I can see that device_suspend( ..., SUSPEND_POWER_DOWN) is called with
> interrupts disabled. But thats okay: (driver.txt) All calls are made
> with interrupts enabled, except for the SUSPEND_POWER_DOWN level.

OK, it's an e100 bug then.  Not allowed to sleep or do spin_unloch_bh() in
device_suspend( ..., SUSPEND_POWER_DOWN).

That's a fairly awkward restriction.
