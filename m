Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753561AbWKFU6d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753561AbWKFU6d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 15:58:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753546AbWKFU6d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 15:58:33 -0500
Received: from rhlx01.hs-esslingen.de ([129.143.116.10]:16070 "EHLO
	rhlx01.hs-esslingen.de") by vger.kernel.org with ESMTP
	id S1753525AbWKFU6c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 15:58:32 -0500
Date: Mon, 6 Nov 2006 21:58:25 +0100
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Andreas Mohr <andi@rhlx01.fht-esslingen.de>, Ingo Molnar <mingo@elte.hu>,
       len.brown@intel.com, linux-kernel@vger.kernel.org
Subject: Re: CONFIG_NO_HZ: missed ticks, stall (keyb IRQ required) [2.6.18-rc4-mm1]
Message-ID: <20061106205825.GA26755@rhlx01.hs-esslingen.de>
References: <20061101140729.GA30005@rhlx01.hs-esslingen.de> <1162417916.15900.271.camel@localhost.localdomain> <20061102001838.GA911@rhlx01.hs-esslingen.de> <1162452676.15900.287.camel@localhost.localdomain> <1162455263.15900.320.camel@localhost.localdomain> <1162488129.15900.396.camel@localhost.localdomain> <20061102192812.GA11815@rhlx01.hs-esslingen.de> <20061102203430.GA27729@rhlx01.hs-esslingen.de> <20061103000631.GA23182@rhlx01.hs-esslingen.de> <1162830033.4715.201.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1162830033.4715.201.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.2i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Nov 06, 2006 at 05:20:32PM +0100, Thomas Gleixner wrote:
> On Fri, 2006-11-03 at 01:06 +0100, Andreas Mohr wrote:
> > ACPI: lapic on CPU 0 stops in C2[C2]
> 
> > How probable is it that the APIC timer got killed due to mis-programming
> > in Linux versus VIA chipset design garbage probability? I.e. do you think
> > there's a chance to fix C2 malfunction by going into the innards of
> > VIA chipsets operation?
> > How useful would it be to simply disable C2 operation (but not C1)
> > in CONFIG_NO_HZ mode after's been determined to kill APIC timer?:
> 
> No, we better disable local apic timer in that case. What happens if you
> boot your machine with ACPI disabled ?

Oh, interesting. Why??

Anyway, acpi=off works perfectly fine (still running -rc4-mm1-dynticks4),
as does setting
	max_cstate = ACPI_STATE_C1;
in acpi_processor_power_init()!
(currently writing this mail with this hack ;)

So why not simply do
	max_cstate = ACPI_STATE_C1;
in case acpi_timer_check_state():

+/*
+ * Some BIOS implementations switch to C3 in the published C2 state. This seems
+ * to be a common problem on AMD boxen.
+ */

yells?
This definitely *is* the problem with my AMD Athlon BIOS, it seems...

Or is it an advantage to switch off lapic in case of C2 brokenness since
that will enable us to still safely drive C2 with dynticks despite those
BIOS bugs or what?
(if I managed to draw the right conclusions about your lapic statement,
that is...)

BTW, my GUI with dynticks seems quite a lot quicker than without.
Or is that a placebo? I don't think it is...

Thanks!

Andreas Mohr
