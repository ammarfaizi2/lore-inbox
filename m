Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275380AbTHNUDf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 16:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275405AbTHNUDf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 16:03:35 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:59867 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S275380AbTHNUDc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 16:03:32 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16187.60175.449778.748247@gargle.gargle.HOWL>
Date: Thu, 14 Aug 2003 22:03:27 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Jamie Lokier <jamie@shareable.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Ruben Puettmann <ruben@puettmann.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.22 APM problems with IBM Thinkpad's
In-Reply-To: <20030814173327.GB10889@mail.jlokier.co.uk>
References: <20030813123119.GA25111@puettmann.net>
	<16186.14686.455795.927909@gargle.gargle.HOWL>
	<1060783884.8008.64.camel@dhcp23.swansea.linux.org.uk>
	<20030814173327.GB10889@mail.jlokier.co.uk>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier writes:
 > Alan Cox wrote:
 > > On Mer, 2003-08-13 at 14:13, Mikael Pettersson wrote:
 > > > With APIC support enabled (SMP or UP_APIC), APM must be constrained:
 > > > DISPLAY_BLANK off
 > > > CPU_IDLE off
 > > > built-in driver, not module
 > > 
 > > This isnt sufficient because some of the SMM traps off the FN-key 
 > > sequences also crash thinkpads if APIC is enabled. Basically *dont use
 > > local apic* except on SMP.
 > 
 > Is it feasible to disable the APIC during BIOS calls,?

I don't think so.
One problem is that BIOS calls can be very frequent (one every time
the kernel calls pm_idle, if CPU_IDLE=y, and one each time one of those
battery-monitoring applets feels like polling the battery status).
Each time we'd have to go through a full lapic_suspend/lapic_resume
cycle, like we do now for PM suspends, and each time the local APIC
timer would lose ticks. And in an UP_IOAPIC system we'd better disable
and reenable the I/O-APIC too (or reprogram it to PIC mode, but that's
horrible). Not pretty.

Personally I'd prefer checks in apm.c that cause it to refuse to do
any BIOS calls except at suspend or poweroff.
