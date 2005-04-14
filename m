Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261472AbVDNInJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261472AbVDNInJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 04:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261473AbVDNInJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 04:43:09 -0400
Received: from fmr17.intel.com ([134.134.136.16]:51891 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S261472AbVDNInF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 04:43:05 -0400
Subject: Re: [PATCH 6/6]suspend/resume SMP support
From: Li Shaohua <shaohua.li@intel.com>
To: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
       ACPI-DEV <acpi-devel@lists.sourceforge.net>,
       Len Brown <len.brown@intel.com>, Zwane Mwaikambo <zwane@linuxpower.ca>
In-Reply-To: <1113467253.2568.10.camel@sli10-desk.sh.intel.com>
References: <1113283867.27646.434.camel@sli10-desk.sh.intel.com>
	 <20050412105115.GD17903@elf.ucw.cz>
	 <1113309627.5155.3.camel@sli10-desk.sh.intel.com>
	 <20050413083202.GA1361@elf.ucw.cz>
	 <1113467253.2568.10.camel@sli10-desk.sh.intel.com>
Content-Type: text/plain
Message-Id: <1113468032.2568.17.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 14 Apr 2005 16:40:33 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-04-14 at 16:27, Li Shaohua wrote:
> On Wed, 2005-04-13 at 16:32, Pavel Machek wrote:
> > root@hobit:/sys/devices/system/cpu/cpu1# dmesg | tail -25
> >  [<c011d001>] activate_task+0x1/0xa0
> >  [<c011d128>] resched_task+0x68/0x90
> >  [<c011d8ba>] try_to_wake_up+0x2aa/0x2f0
> >  [<c025ed7a>] fbcon_cursor+0x19a/0x270
> >  [<c02c4958>] hide_cursor+0x18/0x30
> >  [<c02c758f>] vt_console_print+0x24f/0x260
> >  [<c02c7340>] vt_console_print+0x0/0x260
> >  [<c01247e7>] __call_console_drivers+0x57/0x60
> >  [<c01248e0>] call_console_drivers+0x80/0x110
> >  [<c0124d8e>] release_console_sem+0x4e/0xc0
> >  [<c0124c12>] vprintk+0x192/0x240
> >  [<c0528891>] preempt_schedule_irq+0x51/0x80
> >  [<c02adeca>] acpi_processor_idle+0x0/0x265
> >  [<c010325e>] need_resched+0x1f/0x21
> >  [<c02adeca>] acpi_processor_idle+0x0/0x265
> >  [<c0124a77>] printk+0x17/0x20
> >  [<c010b583>] cpu_init+0x73/0x360
> >  [<c0117bd6>] start_secondary+0x6/0x170
> > Code: d2 74 bd fc 8b 44 24 28 b9 0e 00 00 00 8b 74 24 14 01 c6 b8 0e
> > 00 00 00 89 74 24 1c 8b 74 24 30 89 44 24 10 8b 7c 24 1c 83 c6 10 <f3>
> > a5 8b 74 24 24 8b 44 24 1c 89 4c 24 10 01 ee f7 d5 21 ee 89
> >  <0>Kernel panic - not syncing: Attempted to kill the idle task!
> >  Stuck ??
> > Inquiring remote APIC #0...
> > ... APIC #0 ID: 00000000
> > ... APIC #0 VERSION: 00040011
> > ... APIC #0 SPIV: 000000ff
> > root@hobit:/sys/devices/system/cpu/cpu1#
> Andrew,
> Below patch fixed Pavel's oops. But strange is the 'system_state' check
> is added for CPU hotplug by Rusty. This really makes me confused. Could
> you please look at it.
> This can be reproduced 100% with radeonfb driver load. Attached is the
> dmesg of an oops. It seems the 'objp' parameter for
> 'cache_alloc_debugcheck_after' is invalid.
Looks the per-cpu array_cache isn't initialized. It's initialized in a
cpuhotplug callback. So before the CPU call cpu_up, all kmalloc will
failed. Isn't it?

Thanks,
Shaohua

