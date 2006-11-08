Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423804AbWKHW0F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423804AbWKHW0F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 17:26:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423810AbWKHW0F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 17:26:05 -0500
Received: from www.osadl.org ([213.239.205.134]:13502 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1423804AbWKHW0B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 17:26:01 -0500
Subject: Re: various laptop nagles - any suggestions?   (note:
	2.6.19-rc2-mm1 but applies to multiple kernels)
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, teunis <teunis@wintersgift.com>,
       linux-kernel@vger.kernel.org, Dmitry Torokhov <dtor@mail.ru>,
       john stultz <johnstul@us.ibm.com>, Len Brown <lenb@kernel.org>,
       Arjan van de Ven <arjan@infradead.org>
In-Reply-To: <20061107231903.99156678.akpm@osdl.org>
References: <4537A25D.6070205@wintersgift.com>
	 <20061019194157.1ed094b9.akpm@osdl.org> <4538F9AD.8000806@wintersgift.com>
	 <20061020110746.0db17489.akpm@osdl.org>
	 <1161368034.5274.278.camel@localhost.localdomain>
	 <20061020112627.04a4035a.akpm@osdl.org>
	 <1161370015.5274.282.camel@localhost.localdomain>
	 <20061020121537.dea13469.akpm@osdl.org> <20061020203731.GA22407@elte.hu>
	 <20061020135450.6794a2bb.akpm@osdl.org> <20061020205651.GA26801@elte.hu>
	 <20061020182527.a07666a4.akpm@osdl.org>
	 <1161424147.5274.400.camel@localhost.localdomain>
	 <1161552160.22373.17.camel@localhost.localdomain>
	 <20061107231903.99156678.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 08 Nov 2006 23:28:13 +0100
Message-Id: <1163024893.8335.97.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-11-07 at 23:19 -0800, Andrew Morton wrote:
> I have a bad feeling about the hrtimer+dynticks patches, frankly.  We had a
> lot of discussion and review of the original patchset and it almost all
> seemed OK apart from this tsc-goes-silly problem.  But then this lot:
> 
> highres-timer-core-fix-status-check.patch
> highres-timer-core-fix-commandline-setup.patch
> clockevents-smp-on-up-features.patch
> highres-depend-on-clockevents.patch

Trivial fixups

> i386-apic-cleanup.patch
> pm-timer-allow-early-access.patch
> i386-lapic-timer-calibration.patch

This one solves real problems:
- hang in lapic calibration caused by buggy PIT readouts
- wrong lapic calibration seen on my VAIO CoreDuo (also reported by
others)

I did the i386-apic-cleanup.patch first, as I really did not want to add
more mess to the existing one. Sigh, I should have done that before
adding the clock events support.

> clockevents-add-broadcast-support.patch
> clockevents-add-broadcast-support-fix.patch
> acpi-include-apic-h.patch
> acpi-include-apic-h-fix.patch
> acpi-keep-track-of-timer-broadcast.patch
> i386-apic-timer-use-clockevents-broadcast.patch

Needs review

> acpi-verify-lapic-timer.patch
> acpi-verify-lapic-timer-exports.patch
> acpi-verify-lapic-timer-fix.patch

Those can be dropped, as the approach was too naive. At least we know,
that it can be detected, but this needs more effort to get this
straight.

I'm resorting to the following solution for now:

- Disable local APIC timer as the next event source on UP systems by
default.
- Add a command line option to enable it on sane hardware, as it is
faster.

I send a patch tomorrow morning including the fix for the OOPS reported
by Benoit Boissinot. -ETOOTIRED

If this works on your jinxed VAIO, I do a complete replacement rollup
for review.

	tglx



