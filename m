Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261631AbUCPUcy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 15:32:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261657AbUCPUcy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 15:32:54 -0500
Received: from ausadmmsps308.aus.amer.dell.com ([143.166.224.103]:57356 "HELO
	AUSADMMSPS308.aus.amer.dell.com") by vger.kernel.org with SMTP
	id S261631AbUCPUcv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 15:32:51 -0500
X-Server-Uuid: 5333cdb1-2635-49cb-88e3-e5f9077ccab5
X-MimeOLE: Produced By Microsoft Exchange V6.0.6527.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: spurious 8259A interrupt
Date: Tue, 16 Mar 2004 14:32:48 -0600
Message-ID: <6C07122052CB7749A391B01A4C66D31E014BEA49@ausx2kmps304.aus.amer.dell.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: spurious 8259A interrupt
Thread-Index: AcQLjEFmUsX57s12RxCwRj6gBiKbjQAAEJTw
From: Robert_Hentosh@Dell.com
To: fleury@cs.auc.dk, linux-kernel@vger.kernel.org
X-OriginalArrivalTime: 16 Mar 2004 20:32:48.0684 (UTC)
 FILETIME=[D8B2B6C0:01C40B95]
X-WSS-ID: 6C49BBFB4092525-05-01
Content-Type: text/plain; 
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of 
> Emmanuel Fleury
> Sent: Tuesday, March 16, 2004 12:36 PM
> 
> 
> Hi,
> 
> I noticed today that I had several "spurious 8259A interrupt":
> 
> Dec 20 15:02:45 hermes vmunix: spurious 8259<3>[drm:radeon_cp_init]

  :: SNIP ::

So a co-worker of mine (Stuart Hayes) did some digging into this issue.
What he found after putting a scope on the system was, in our situation
it was harmless:

The problem was actually caused by another IRQ (in our instance it was
IRQ10 associated with a gigabit NIC). The following steps took place:

>  IRQ10 asserted
>  INTACK cycle lets PIC deliver vector to processor
>  processor masks IRQ10 in PIC
>  processor sends EOI command to PIC
>  processor reads a status register in the NIC, which causes IRQ10 to
be deasserted
>  processor unmasks IRQ10 in PIC
>
> Sometimes the processor would unmask IRQ10 almost immediately after
reading the status
> register in the NIC, which results in IRQ10 being unmasked before the
IRQ10 signal has
> finished going high.  This causes the PIC to think that there is
another IRQ10, but, 
> by the time the processor asks for the vector, IRQ10 is no longer
asserted.

The PIC defaults to IRQ7 because of its design, when IRQ10 was already
cleared. Sticking delays in is not viable in a generic ISR routing.  A
possible fix to this issue would be to issue the EOI after the read to
the status register on the NIC, and I see some documentation on the PIC
that actually suggests that this is the way to service an interrupt.
This seemed like a risky change, since sending the EOI and using the
mask has been in use for some time and the change would effect all
devices using interrupts.

The spurious IRQ performance impact is negligible since it is logged
only once per IRQ at most.

