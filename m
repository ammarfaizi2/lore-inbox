Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261841AbTJABww (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 21:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261844AbTJABww
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 21:52:52 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:58762 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261841AbTJABwu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 21:52:50 -0400
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM LTC
To: Chris Rankin <rankincj@yahoo.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: APIC error on SMP machine
Date: Tue, 30 Sep 2003 18:52:47 -0700
User-Agent: KMail/1.5
References: <3F79F8BB.2080905@yahoo.com>
In-Reply-To: <3F79F8BB.2080905@yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309301852.47835.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 30 September 2003 2:42 pm, Chris Rankin wrote:
> Linux-2.4.22-SMP, 1 GB RAM, devfs, gcc-3.2.3.
>
> Hi,
>
> Today, my dual PIII (Coppermine) refused to boot, and wrote a large number
> of these messages to the serial console instead:
>
> APIC error on CPU1: 04(04)
> APIC error on CPU1: 04(04)
> APIC error on CPU1: 04(04)
> APIC error on CPU1: 04(04)
> APIC error on CPU1: 04(04)
> APIC error on CPU1: 04(04)
> APIC error on CPU1: 04(04)
> APIC error on CPU1: 04(04)
> APIC error on CPU1: 04(04)
> APIC error on CPU1: 04(04)
> APIC error on CPU1: 04(04)
> APIC error on CPU1: 04(04)
> APIC error on CPU1: 04(04)
> APIC error on CPU1: 04(04)
> APIC error on CPU1: 04(04)
>
> Can anyone tell me what these might mean, please? The kernel source implies
> that it's a "Send accept error", but this doesn't help me in an "Ah, I can
> fix that!" sense.
>
> Does this APIC error just mean that the CPU is unhappy in this slot, and is
> refusing to listen to the motherboard? Or is the motherboard refusing to
> listen to the CPU?

Neither.  An APIC send accept error means that when trying to send an 
interrupt, it was not accepted by the target.  In this case, the target is a  
CPU, either your other CPU or the same one (a CPU can send itself an 
interrupt).

While there are several reasons why this can happen, the most common ones are:

1) The target CPU is "full".  The local APIC on P54Cs through P3s only has two 
interrupt latches per interrupt "level", which is the high nibble of the IRQ 
vector number.  So, if a CPU had already latched interrupt vectors 0x30 and 
0x3A, it would have to reject any other 0x3X vector that was sent until it 
could service one of the two latched vectors.

You can force this to happen by manually binding too many IRQs that happen to 
be on the same "level" to one CPU, then causing a lot of interrupt traffic on 
those devices.

In order to avoid this problem, Linux spreads the IRQs among as many vector 
levels as possible.  Still, the vector assignment is done before any devices 
have requested interrupts.  You may get unlucky and have 3 devices on one 
level.

2) The interrupt cannot be delivered because something is wrong with it.  This 
can happen if the kernel screws up and picks "clustered" APIC mode on a 
"flat" system or vice versa.  A dual P3 system should be flat.  Check your 
dmesg log to make sure it was properly detected.  (This seldom happens unless 
you're doing interrupt development work in Linux.)

3) Maybe the other CPU is broken and physically cannot accept the interrupt.  
Do any previous kernels boot?

> Background:
> This machine has been misbehaving for a while. I thought I had worked
> around the problem by underclocking the FSB from 133 MHz to 100 MHz, but
> that now looks like it was just a "reprieve". I have tried running "nosmp",
> "pci=noacpi" and "noapic pci=noacpi" without success, and have resorted to
> yanking the CPU out of this slot entirely. (I suspect that the CPU is fine,
> however.) I have also restored the FSB to 133 MHz, so I am currently
> running the SMP kernel on a single 933 MHz PIII.
>
> Cheers,
> Chris
>
> -


-- 
James Cleverdon
IBM xSeries Linux Solutions
{jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot comm
