Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263762AbTLJRP3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 12:15:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263667AbTLJRP3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 12:15:29 -0500
Received: from zeus.kernel.org ([204.152.189.113]:63136 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S263809AbTLJRPP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 12:15:15 -0500
Date: Wed, 10 Dec 2003 14:41:03 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Bob <recbo@nishanet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Catching NForce2 lockup with NMI watchdog
In-Reply-To: <3FD5F9C1.5060704@nishanet.com>
Message-ID: <Pine.LNX.4.55.0312101421540.31543@jurand.ds.pg.gda.pl>
References: <20031205045404.GA307@tesore.local> <16336.13962.285442.228795@alkaid.it.uu.se>
 <20031205085829.GL29119@mis-mike-wstn.matchmail.com> <3FD3DFEB.1010902@nishanet.com>
 <Pine.LNX.4.55.0312091514130.20948@jurand.ds.pg.gda.pl> <3FD5F9C1.5060704@nishanet.com>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Dec 2003, Bob wrote:

> > You don't have the NMI watchdog working, because the timer interrupt is
> >configured as an 8259A interrupt ("XT-PIC" for IRQ 0 in the output above).  
> >This usually means the wiring of a particular system doesn't provide any
> >other alternative or configuration data provided by the BIOS is broken.
> >The timer interrupt has to be configured as an I/O APIC interrupt for the
> >watchdog to work, or you can select "nmi_watchdog=2" for an alternative 
> >watchdog internal to processors if they support it.
> >
> Using a patch that fixes a number of people's nforce2
> lockups while enabling io-apic edge timer, I can now
> use nmi_watchdog=2 but not =1

 The I/O APIC NMI watchdog utilizes the property of being transparent to a
single IRQ source of a specially reconfigured 8259A PIC (the master one in
the IA32 PC architecture).  There are more prerequisites that have to be
met and all indeed are for a 100% compatible PC as specified by the
Intel's Multiprocessor Specification.

1. The INT output of the master 8259A PIC has to be connected to the LINT0
(or LINTIN0; the name varies by implementations) inputs of all local APICs
in the system.

2a. The OUT0 output of the 8254 PIT (IOW the timer source) has to be 
directly connected to the INTIN2 input of the first I/O APIC.

2b. Alternatively the INT output of the master 8259A PIC has to be
connected to the INTIN0 input of the first I/O APIC.

3. There must be no glue logic that would change logical properties of the
signal between the INT output of the master 8259A PIC and the respective
APIC interrupt inputs.

In practice, assuming the MP IRQ routing information provided the BIOS has
been correct (which is not always the case), prerequisites #1 and #2 have
been met so far, but #3 has proved to be occasionally problematic.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
