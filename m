Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261358AbUKCC4K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261358AbUKCC4K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 21:56:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261359AbUKCC4K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 21:56:10 -0500
Received: from smtp1.Stanford.EDU ([171.67.16.123]:8595 "EHLO
	smtp1.Stanford.EDU") by vger.kernel.org with ESMTP id S261358AbUKCCzr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 21:55:47 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.6.8
From: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Ingo Molnar <mingo@elte.hu>
Cc: Mark_H_Johnson@raytheon.com, Thomas Gleixner <tglx@linutronix.de>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Lee Revell <rlrevell@joe-job.com>,
       Paul Davis <paul@linuxaudiosystems.com>,
       LKML <linux-kernel@vger.kernel.org>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Rui Nuno Capela <rncbc@rncbc.org>, "K.R. Foley" <kr@cybsft.com>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
In-Reply-To: <20041102192709.GA1674@elte.hu>
References: <OFB38B3DE8.983DDEAD-ON86256F40.0062F170-86256F40.0062F1A5@raytheon.com>
	 <20041102191858.GB1216@elte.hu>  <20041102192709.GA1674@elte.hu>
Content-Type: text/plain
Organization: 
Message-Id: <1099450468.19451.260.camel@cmn37.stanford.edu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 02 Nov 2004 18:54:28 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-11-02 at 11:27, Ingo Molnar wrote:
> * Ingo Molnar <mingo@elte.hu> wrote:
> > > This build appears to run OK and then in the middle of the real time
> > > tests stops doing useful work (during network test).
> > 
> > weird, the deadlock detector did not trigger, although it is a clear
> > circular deadlock:
> 
> ah ... found it - a fair portion of spinlocks and rwlocks had deadlock
> detection turned off in -V0.6.6 - amongst them ptype_lock. I've uploaded
> -V0.6.9 that fixes this.

This happens with V0.6.9 running on an Athlon64:

r8169 Gigabit Ethernet driver 1.6LK loaded
ACPI: PCI interrupt 0000:00:0b.0[A] -> GSI 16 (level, low) -> IRQ 16
divert: allocating divert_blk for eth0
eth0: Identified chip type is 'RTL8169s/8110s'.
eth0: RTL8169 at 0xf88a0f00, 00:0c:76:b3:c2:43, IRQ 16
BUG: atomic counter underflow at:
 [<c0108153>] dump_stack+0x23/0x30 (20)
 [<c02f5e91>] qdisc_destroy+0xe1/0xf0 (28)
 [<c02f60ad>] dev_shutdown+0x3d/0xa0 (28)
 [<c02e6ffb>] unregister_netdevice+0x12b/0x2a0 (36)
 [<c0273ffe>] unregister_netdev+0x1e/0x30 (16)
 [<f8b0b8b5>] rtl8169_remove_one+0x25/0x50 [r8169] (32)
 [<c01f55a6>] pci_device_remove+0x76/0x80 (24)
 [<c025f15d>] device_release_driver+0x6d/0x70 (24)
 [<c025f18b>] driver_detach+0x2b/0x40 (20)
 [<c025f5ff>] bus_remove_driver+0x3f/0x70 (20)
 [<c025fb0c>] driver_unregister+0x1c/0x30 (16)
 [<c01f586c>] pci_unregister_driver+0x1c/0x30 (16)
 [<f8b0d357>] rtl8169_cleanup_module+0x17/0x1b [r8169] (12)
 [<c013fdb1>] sys_delete_module+0x121/0x150 (96)
 [<c010729d>] sysenter_past_esp+0x52/0x71 (-8124)
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<c013dc3d>] .... print_traces+0x1d/0x60
.....[<c0108153>] ..   ( <= dump_stack+0x23/0x30)
                                                                                
divert: freeing divert_blk for eth0
ip_tables: (C) 2000-2002 Netfilter core team

-- Fernando


