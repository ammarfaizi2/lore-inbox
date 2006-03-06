Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752407AbWCFTHj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752407AbWCFTHj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 14:07:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752405AbWCFTHj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 14:07:39 -0500
Received: from spirit.analogic.com ([204.178.40.4]:26642 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP
	id S1752406AbWCFTHi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 14:07:38 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <200603061327_MC3-1-B9F7-26DD@compuserve.com>
x-originalarrivaltime: 06 Mar 2006 19:07:33.0385 (UTC) FILETIME=[392A0790:01C64151]
Content-class: urn:content-classes:message
Subject: Re: spin_lock_irqsave only re-enables interrupts while spinning  on some archs?
Date: Mon, 6 Mar 2006 14:07:33 -0500
Message-ID: <Pine.LNX.4.61.0603061344360.4735@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: spin_lock_irqsave only re-enables interrupts while spinning  on some archs?
Thread-Index: AcZBUTkxcJ5aDqEiT/2ftvx2zrPzcQ==
References: <200603061327_MC3-1-B9F7-26DD@compuserve.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Chuck Ebbert" <76306.1226@compuserve.com>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 6 Mar 2006, Chuck Ebbert wrote:

> On some architectures, spin_lock_irqsave() re-enables interrupts when
> spinning while waiting for the lock to become available.  The list
> of archs includes i386, powerpc and ia64.  Others leave interrupts
> disabled while spinning (x86_64, arm, alpha).  They just define
> __raw_spin_lock_flags to be the same as __raw_spin_lock.  (And
> because predication is so efficient, ia64 does the opposite:
> it uses __raw_spin_lock_flags for everything -- a neat trick.)
>
> Shouldn't there be a standard way of doing this?  Is there any practical
> difference in behavior?
>
> --
> Chuck
> "Penguins don't come from next door, they come from the Antarctic!"

I think you just discovered a bug! I haven't looked at the
spin-locks for over a year. If the interrupts are enabled
during the spin, a lower priority task may never get the
lock! A deadlock is not only possible, but probable. It needs
to just spin until the lock is given up. That's why they
are called spin-locks.

The __raw_spin_lock_string_flags looks completely wrong! The
interrupts on the local CPU must be disabled first and left
alone (off). Then the lock should be taken, spinning until
it succeeds.

The code decrements the lock variable over-and-over again
on each jump back to the 1: label. Since the interupts
are enabled when the lock-variable is tested after the
3: label,  the byte will eventually wrap so the "got the
lock" condition occurs even if the holder of the lock
never releases it! This is not good code even though it
might accidentally work.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.15.4 on an i686 machine (5589.50 BogoMips).
Warning : 98.36% of all statistics are fiction, book release in April.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
