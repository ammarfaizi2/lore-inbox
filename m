Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261810AbVCOTZ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261810AbVCOTZ1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 14:25:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261796AbVCOTWo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 14:22:44 -0500
Received: from hqemgate01.nvidia.com ([216.228.112.170]:36118 "EHLO
	HQEMGATE01.nvidia.com") by vger.kernel.org with ESMTP
	id S261811AbVCOTUS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 14:20:18 -0500
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: User mode drivers: part 1, interrupt handling (patch for 2.6.11)
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Date: Tue, 15 Mar 2005 11:20:13 -0800
Message-ID: <DBFABB80F7FD3143A911F9E6CFD477B0056A96EF@hqemmail02.nvidia.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: User mode drivers: part 1, interrupt handling (patch for 2.6.11)
Thread-Index: AcUoN0sg8eoMEFcXStiRxjNGGn/zKwBXAaag
From: "Stephen Warren" <SWarren@nvidia.com>
To: "Peter Chubb" <peterc@gelato.unsw.edu.au>,
       "Jon Smirl" <jonsmirl@gmail.com>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 15 Mar 2005 19:20:15.0242 (UTC) FILETIME=[04352EA0:01C52994]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Peter Chubb
> >>>>> "Jon" == Jon Smirl <jonsmirl@gmail.com> writes:
> 
> >>  The scenario I'm thinking about with these patches are things like
> >> low-latency user-level networking between nodes in a cluster, where
> >> for good performance even with a kernel driver you don't want to
> >> share your interrupt line with anything else.
> 
> Jon> The code needs to refuse to install if the IRQ line is shared.
> 
> It does.  The request_irq() call explicitly does not include SA_SHARED
> in its flags, so if the line is shared, it'll return an error to user
> space when the driver tries to open the file representing the
interrupt. 

I actually have a simple case of user-mode handling of shared IRQs
working, based off the Gelato work from maybe 6 months ago.

What I did was add a new IOCTL to tell the kernel code how to clear the
interrupt status (or disable the interrupt output on the card, as
appropriate).

This basically took the form of telling the kernel to map a specified
subsection of a specified BAR into kernel space for register access,
then execute a small configurable read-modify-write sequence for the
actual interrupt disable (configurable read/write address, optionally no
read, configurable and/or/shift of the read value (or initial constant)
before write etc.)

This would probably cover most situations.

Once the interrupt is disabled/cleared, user-space can handle it just
like a non-shared IRQ, and finally re-enable it if the kernel mode
twiddling was a disable rather than a status clear.

This is probably pretty generic, and at least will open the code up to
handling a lot more devices, even if not everthing.

Also, the kernel detects a release on the file-handle, and can execute a
different configurable register access sequence to permanently disable
interrupts and/or reset the device, for safety once the user-space app
quits.

-- 
Stephen Warren, Software Engineer, NVIDIA, Fort Collins, CO
swarren@nvidia.com        http://www.nvidia.com/
swarren@wwwdotorg.org     http://www.wwwdotorg.org/pgp.html
