Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161111AbWBAUVc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161111AbWBAUVc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 15:21:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161112AbWBAUVc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 15:21:32 -0500
Received: from mail.enyo.de ([212.9.189.167]:63941 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S1161111AbWBAUVb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 15:21:31 -0500
From: Florian Weimer <fw@deneb.enyo.de>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: [PATCH] AMD64: fix mce_cpu_quirks typos
References: <87fyn2yjpr.fsf@mid.deneb.enyo.de.suse.lists.linux.kernel>
	<p731wymn94l.fsf@verdi.suse.de>
Date: Wed, 01 Feb 2006 21:21:25 +0100
In-Reply-To: <p731wymn94l.fsf@verdi.suse.de> (Andi Kleen's message of "01 Feb
	2006 20:59:06 +0100")
Message-ID: <87ek2mx22i.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andi Kleen:

> Florian Weimer <fw@deneb.enyo.de> writes:
>
> First please send x86-64 patches cc to the maintainer, things can
> get lost in the noise of the list.

Oops, sorry about that.  Perhaps I should repeat that MCE for the sake
of discuss@, as decoded by mcelog:

MCE 0
CPU 0 4 northbridge TSC 91ec03f09330
ADDR 104500000
  Northbridge GART error
       bit61 = error uncorrected
  TLB error 'generic transaction, level generic'
STATUS a40000000005001b MCGSTATUS 0

>> The spurious MCE is TLB-related.  I *think* the bit for the correct
>> status code is stored at position 10 HEX, not 10 DEC.  At least I
>> still get those MCEs on a two-way Opteron box, even though they are
>> supposed to be filtered out.
>
> No, 10 is the correct bit index. But normally it's set by BIOS anyways.
>
> The reason you still see it is that setting the bit here only
> prevent MCE exceptions,

And thus a kernel panic?

> but it's still logged and the regular polling picks them up
> anyways. I have not found a nice way to handle this (other than
> adding a ugly CPU specific special case in the middle of the nice
> cpu independent machine check handler, which I couldn't bring myself
> to do so far...)

Someone tried to track these messages down together with someone else
from AMD, but they never got it finished.

For reference, here's the lspci -n output for the system.  It's a
two-way Opteron box (248, 2.2 GHz, stepping 10) with 8 GB of RAM.
(BIOS and chipset details are not available to me at the moment.)
The MCEs only appeared after a switch to a 64-bit kernel (2.6.15.2),
adding the second CPU, along with 4 GB of RAM.  Previously, the box
ran 2.6.13 in 32-bit mode, and no MCEs appeared regularly.

In the history of the system, there was one more MCE, but we thought
at that time it was related to thermal issues (it happened after
someone had switched off air conditioning in the server room *cough*).

0000:00:06.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8111 PCI (rev 07)
0000:00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-8111 LPC (rev 05)
0000:00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-8111 IDE (rev 03)
0000:00:07.2 SMBus: Advanced Micro Devices [AMD] AMD-8111 SMBus 2.0 (rev 02)
0000:00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-8111 ACPI (rev 05)
0000:00:0a.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge (rev 12)
0000:00:0a.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC (rev 01)
0000:00:0b.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge (rev 12)
0000:00:0b.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC (rev 01)
0000:00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:19.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:19.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:19.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:19.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:01:05.0 RAID bus controller: 3ware Inc 3ware ATA-RAID
0000:02:09.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5704 Gigabit Ethernet (rev 03)
0000:02:09.1 Ethernet controller: Broadcom Corporation NetXtreme BCM5704 Gigabit Ethernet (rev 03)
0000:03:00.0 USB Controller: Advanced Micro Devices [AMD] AMD-8111 USB (rev 0b)
0000:03:00.1 USB Controller: Advanced Micro Devices [AMD] AMD-8111 USB (rev 0b)
0000:03:06.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
0000:03:08.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 10)
