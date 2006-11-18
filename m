Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754576AbWKROvP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754576AbWKROvP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 09:51:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754780AbWKROvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 09:51:15 -0500
Received: from 147.175.241.83.in-addr.dgcsystems.net ([83.241.175.147]:29824
	"EHLO tmnt04.transmode.se") by vger.kernel.org with ESMTP
	id S1754576AbWKROvO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 09:51:14 -0500
From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
To: "'Jean Delvare'" <khali@linux-fr.org>,
       "'Kumar Gala'" <galak@kernel.crashing.org>
Cc: "'LKML'" <linux-kernel@vger.kernel.org>, <i2c@lm-sensors.org>
Subject: RE: RTC , ds1307 I2C driver and NTP does not work.
Date: Sat, 18 Nov 2006 15:51:09 +0100
Message-ID: <008801c70b20$fc0fee70$1e67a8c0@Jocke>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
Thread-Index: AccLHJA5WtCxWev1TLeFSODo5S0ZcwAA4qTg
In-Reply-To: <20061118151923.6044d956.khali@linux-fr.org>
X-OriginalArrivalTime: 18 Nov 2006 14:51:12.0692 (UTC) FILETIME=[FDB84740:01C70B20]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Fri, 17 Nov 2006 18:38:10 +0100, Joakim Tjernlund wrote:
> > On Nov 17, 2006, at 10:38 AM, Joakim Tjernlund wrote:
> > 
> > > I get this when I activathte NTP and ntp "sync" the time 
> the I2C HW  
> > > clock.
> > 
> > You may be better off posting this to lkml and copy the i2c 
> list (and  
> > rtc if one exists).  Since its more a driver issue than anything  
> > really ppc specific.  Clearly we are doing schedules() in 
> mpc_xfer()  
> > and maybe we shouldn't be.
> 
> It's OK to schedule or sleep in mpc_xfer. It's not OK to call mpc_xfer
> from an interrupt context, which is what appears to be happening here.
> So the ds1307 driver would need to be changed not to directly call
> i2c_transfer from the interrupt. Using a workqueue should work.
> 
> That being said, I wonder why one would want to set the time from an
> interrupt context in the first place. Maybe that's what needs fixing.

That's the way kernel NTP code always has done it. Probably to minimize latency, ideally
you want to set the time when a new second occur since that's what most RTC HW expects.

Will a workqueue run directly after the one return from IRQ context?

> 
> > > BUG: scheduling while atomic: swapper/0x00010000/0
> > > Call Trace:^M
> > > [C0245C80] [C000860C] show_stack+0x48/0x194 (unreliable)
> > > [C0245CB0] [C01BEFF4] schedule+0x5d4/0x618
> > > [C0245CF0] [C01BF9C8] schedule_timeout+0x70/0xd0
> > > [C0245D30] [C014416C] i2c_wait+0x164/0x1d8
> > > [C0245D80] [C0144490] mpc_xfer+0x2b0/0x3a8
> > > [C0245DD0] [C01423E8] i2c_transfer+0x58/0x7c
> > > [C0245DF0] [C0141124] ds1307_set_time+0x1bc/0x234
> > > [C0245E00] [C013F82C] rtc_set_time+0xb0/0xb8^M
> > > [C0245E20] [C000BFC4] set_rtc_class_time+0x34/0x58
> > > [C0245E40] [C000C8D0] timer_interrupt+0x5a0/0x5fc
> > > [C0245EE0] [C000F7B0] ret_from_except+0x0/0x14
> > > --- Exception: 901 at cpu_idle+0xc8/0xf0
> > >     LR = cpu_idle+0xec/0xf0
> > > [C0245FC0] [C000388C] rest_init+0x28/0x38
> > > [C0245FD0] [C01F36E0] start_kernel+0x1d8/0x228
> > > [C0245FF0] [00003438] 0x3438
> > >
> > > I have activated RTC CLASS and have this in my board file:
> > > #ifdef CONFIG_RTC_CLASS
> > > late_initcall(rtc_class_hookup);
> > > #endif
> > >
> > > kernel 2.6.19-rc5
> > >
> > >  Jocke
> 
> -- 
> Jean Delvare
> 
> 

