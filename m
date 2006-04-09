Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750712AbWDIJso@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbWDIJso (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 05:48:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750715AbWDIJso
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 05:48:44 -0400
Received: from ns2.suse.de ([195.135.220.15]:22919 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750712AbWDIJso (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 05:48:44 -0400
From: Neil Brown <neilb@suse.de>
To: Robert Hancock <hancockr@shaw.ca>
Date: Sun, 9 Apr 2006 19:48:22 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17464.55398.270243.839773@cse.unsw.edu.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: How to correct ELCR? - was Re: [PATCH 2.6.16] Shared interrupts sometimes lost
In-Reply-To: message from Robert Hancock on Saturday April 8
References: <5Zd5E-3vi-7@gated-at.bofh.it>
	<4437C45E.8010503@shaw.ca>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday April 8, hancockr@shaw.ca wrote:
> Neil Brown wrote:
> >  However there is room for a race here.  If an event occurs between
> >  the read and the write, then this will NOT de-assert the IRQ line.
> >  It will remain asserted throughout.
> > 
> >  Now if the IRQ is handled as an edge-triggered line (which I believe
> >  they are in Linux), then losing this race will mean that we don't see
> >  any more interrupts on this line.
> 
> PCI interrupts should always be level triggered, not edge triggered 

Ok... so I guess I jumped to the wrong conclusion. Thanks for
straightening me out.
But it is behaving like edge-triggered..

So I have explored about the i8259 (wikipedia helped) and discovered
the ELCR (Edge/Level Control Register).  Apparently this is meant to
be set up by the BIOS to the correct values.  It seems that this isn't
happening. 

It seems to get the value 0x0800 which corresponds to IRQ11 being the
only level-triggered interrupt.  But I need IRQ10 to be level
triggered.  I hacked the code to set the 0x0400 bit, and it seems to
work OK without my other patch.

Now I just need a way to set this correctly at boot time without a
hack.

I currently have Linux compiled without ACPI support (as I don't
really want that and being an oldish notebook I gather it has a good
chance of causing problems) so that isn't fiddling with the ELCR.

So thank you for helping me a step further in understand, but now I
have a new question:

 How can I make sure the ELCR is set correctly?
and I guess,
 What is the correct setting?

My /proc/interrupts is below.

Thanks.

NeilBrown

           CPU0       
  0:     505852          XT-PIC  timer
  1:         10          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  4:         10          XT-PIC  serial
  8:          4          XT-PIC  rtc
 10:      16442          XT-PIC  yenta, yenta, ohci_hcd:usb1, ohci_hcd:usb2, ehci_hcd:usb4, eth0
 11:          0          XT-PIC  uhci_hcd:usb3
 12:        110          XT-PIC  i8042
 14:       5114          XT-PIC  ide0
 15:         38          XT-PIC  ide1
NMI:          0 
ERR:          0
