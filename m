Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262591AbTKDVBV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 16:01:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262598AbTKDVBU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 16:01:20 -0500
Received: from 206-158-102-129.prx.blacksburg.ntc-com.net ([206.158.102.129]:58532
	"EHLO wombat.ghz.cc") by vger.kernel.org with ESMTP id S262591AbTKDVBS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 16:01:18 -0500
Date: Tue, 4 Nov 2003 16:01:01 -0500
Subject: Re: [PATCH] amd76x_pm on 2.6.0-test9 cleanup
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v552)
Cc: lkml <linux-kernel@vger.kernel.org>
To: Pasi Savolainen <pasi.savolainen@hut.fi>
From: Charles Lepple <clepple@ghz.cc>
In-Reply-To: <20031104202104.GA408936@kosh.hut.fi>
Message-Id: <FF494619-0F09-11D8-A943-003065DC6B50@ghz.cc>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.552)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, November 4, 2003, at 03:21 PM, Pasi Savolainen wrote:

> * Tony Lindgren <tony@atomide.com> [031104 21:24]:
>> I have problem where my S2460 goes into sleep for a while if compiled 
>> in,
>> but this does not happen when loaded as module.
>
> Could you have some AMD_76X -define left over? I skimmed through MP &
> MPX AMD documents, but found nothing incriminating.
> Could it be ACPI doing it's things with S -states? (it does check for
> SMP, but does report S -states as supported). And if ACPI isn't
> enabled, could you toggle it on, or vice-versa.

I wonder if the initialization code puts the chipset to sleep as it is 
setting up the stopgrant control bits?

Here's a wild hypothesis: module loads, twiddles the registers, and the 
chipset enters sleep mode. In certain cases, enough interrupts are 
unmasked that the next interrupt wakes the chipset up, and things 
continue on their merry way. In other cases, it takes an ACPI interrupt 
(which, in my case, has not been initialized, since my BIOS evidently 
doesn't officially support ACPI C states) to wake things up (e.g. from 
a front-panel button).

FWIW, I just found this in the dmesg output:

irq 9: nobody cared!
Call Trace:
  [<c010b7ba>] __report_bad_irq+0x2a/0x90
  [<c010b8ac>] note_interrupt+0x6c/0xa0
  [<c010bbdb>] do_IRQ+0x15b/0x190
  [<c0109d88>] common_interrupt+0x18/0x20
  [<e10ac26d>] amd76x_smp_idle+0x0/0xba [amd76x_pm]
  [<e10ac302>] amd76x_smp_idle+0x95/0xba [amd76x_pm]
  [<c0106f63>] cpu_idle+0x33/0x40
  [<c0120f04>] printk+0x164/0x1d0

handlers:
[<c01ebeb3>] (acpi_irq+0x0/0x16)
Disabling IRQ #9

Interestingly enough, I guess the 'button' module has claimed IRQ 9, 
since I have this in /proc/interrupts:

   9:       5013      94989    IO-APIC-edge  acpi

Well, I'm officially confused :-)

-- 
Charles Lepple
clepple@ghz.cc

