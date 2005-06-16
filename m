Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261693AbVFPPrL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261693AbVFPPrL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 11:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261695AbVFPPrL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 11:47:11 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:23819 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S261693AbVFPPrF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 11:47:05 -0400
Date: Thu, 16 Jun 2005 16:46:53 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: karim@opersys.com, linux-kernel <linux-kernel@vger.kernel.org>,
       Kristian Benoit <kbenoit@opersys.com>
Subject: Re: Spurious parport interrupts (IRQ 7) / rt benchmarking
In-Reply-To: <200506160948.42880.vda@ilport.com.ua>
Message-ID: <Pine.LNX.4.61L.0506161556440.9172@blysk.ds.pg.gda.pl>
References: <42B09CB3.4030101@opersys.com> <200506160948.42880.vda@ilport.com.ua>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jun 2005, Denis Vlasenko wrote:

> IIRC specs of old AT PIC say that if input interrupt pins
> are no longer asserted by the time when CPU asserts IRQ and tries

 An x86 CPU issues an INTA special cycle actually.

> to read IRQ# from PIC, PIC returns 7. Thus you get IRQ7 or IRQ15
> depending on where that happened, on primary or secondary PIC.

 Well, for a spurious IRQ from a slave the timing is really tight -- you 
normally just receive IRQ 7 from the master.  Though I haven't thought of 
what would happen in this case if there was a slave on the IR7 input of 
the master... ;-)

> Presumably there can be 'bad' devices which momentarily flash
> their IRQ, confusing PIC.

 It can be noise due to a cross-talk.

> However, I am a bit surprized how often these IRQ7s happen.
> Maybe APIC's PIC emulation just reuses this convention to
> indicate APIC errors in PIC emulation mode. I am not familiar
> with APIC, tho... I did not yet read APIC docs.

 APICs edge-triggered inputs are "sticky", that is the chip remembers a 
rising edge has happened and do not clear the latch on a falling edge (or 
IOW it implements the mode correctly).  Therefore any noise from a PIC 
that's connected to an APIC that's makes an input to the APIC to be 
asserted for long enough for the chip to record it as an edge will trigger 
an interrupt.

 For a PIC routed straight to an x86 CPU the timing is rather tight -- the 
CPU has to issue an INTA cycle at about the time of the interrupt source 
going away.  For example in older PC/AT machines (based on an i386 or an 
80286) about the only way to trigger it was the keyboard interrupt (IRQ 
1), driven by an 8042 microcontroller.  The uc was slow enough in 
deasserting its outgoing IRQ line, that if you read its keyboard data port 
at i/o address 0x60 (which acted as an IRQ ack) with the keyboard 
interrupt enabled in the PIC, you'd almost always receive a spurious 
interrupt immediately after the i/o read instruction.

 Of course the same conditions apply to the polled mode of operation.

  Maciej
