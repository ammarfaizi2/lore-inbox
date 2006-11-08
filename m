Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754554AbWKHMKO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754554AbWKHMKO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 07:10:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750724AbWKHMKN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 07:10:13 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:58061 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1754554AbWKHMKL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 07:10:11 -0500
Date: Wed, 8 Nov 2006 13:09:14 +0100
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: mm-commits@vger.kernel.org, tglx@linutronix.de,
       Andrew Morton <akpm@osdl.org>
Subject: Re: + i386-lapic-timer-calibration.patch added to -mm tree
Message-ID: <20061108120914.GB19843@elte.hu>
References: <200611012045.kA1KjM1p018949@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611012045.kA1KjM1p018949@shell0.pdx.osdl.net>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* akpm@osdl.org <akpm@osdl.org> wrote:

> Subject: i386/apic: Rework local apic timer calibration
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> The local apic timer calibration has two problem cases:
> 
> 1. The calibration is based on readout of the PIT/HPET timer to detect 
> the wrap of the periodic tick. It happens that a box gets stuck in the
> calibration loop due to a PIT with a broken readout function.
> 
> 2. CoreDuo boxen show a sporadic PIT runs too slow defect, which results
> in a wrong lapic calibration. The PIT goes back to normal operation once
> the lapic timer is switched to periodic mode.
> 
> Rework the code to address both problems:
> - Make the calibration interrupt driven. This removes the wait_timer_tick
>   magic hackery from lapic.c and time_hpet.c. The clockevents framework
>   allows easy substitution of the global tick event handler for the
>   calibration. This is more accurate than monitoring jiffies. At this
>   point of the boot process, nothing disturbes the interrupt delivery, so
>   the results are very accurate.
> 
> - Verify the calibration against the PM timer, when available by using the
>   early access function. When the measured calibration period is outside
>   of an one percent window, then the lapic timer calibration is adjusted
>   to the pm timer result.
> 
> - Verify the calibration by running the lapic timer with the calibration
>   handler. Disable lapic timer in case of deviation.
> 
> This also removes the "synchronization" of the local apic timer to the
> global tick. This synchronization never worked, as there is no way to
> synchronize PIT(HPET) and local APIC timer. The synchronization by waiting
> for the tick just alignes the local APIC timer for the first events, but
> later the events drift away due to the different clocks. Removing the
> "sync" is just randomizing the asynchronous behaviour at setup time.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Andrew Morton <akpm@osdl.org>

i agree with this method.

one question:

> +	long tapic = apic_read(APIC_TMCCT);
> +	unsigned long pm = acpi_pm_read_early();

is this function call safe if the box has no pm-timer?

otherwise, i have tested this on a couple of boxes, it looks good. This 
patch should also solve some apic-calibration hangs reported against 
Fedora.

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
