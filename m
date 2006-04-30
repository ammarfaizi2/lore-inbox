Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750951AbWD3Esy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750951AbWD3Esy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 00:48:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750952AbWD3Esy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 00:48:54 -0400
Received: from cantor.suse.de ([195.135.220.2]:25476 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750948AbWD3Esy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 00:48:54 -0400
From: Neil Brown <neilb@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Date: Sun, 30 Apr 2006 14:48:43 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17492.16811.469245.331326@cse.unsw.edu.au>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Stephen Hemminger <shemminger@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: better leve triggered IRQ management needed
In-Reply-To: message from Linus Torvalds on Saturday April 29
References: <20060424114105.113eecac@localhost.localdomain>
	<1146345911.3302.36.camel@localhost.localdomain>
	<Pine.LNX.4.64.0604291453220.3701@g5.osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday April 29, torvalds@osdl.org wrote:
> 
> 
> On Sat, 29 Apr 2006, Alan Cox wrote:
> > 
> > Trying to guess the current IRQ level v edge on a PC is very hard.
> > Trying to set it correctly from the driver is rather easier.
> 
> I disagree. It's not any easier at all.
> 
> On PC's (x86 and x86-64) we actually already set the ELCR as well as we 
> can (look for "eisa_set_level_irq()"). And a driver _literally_ cannot 
> change it from the system value, because of the polarity confusion.
> 
> In the other cases (IO-APIC) we usually have it level, but when we have it 
> marked as an edge, there is almost always a real reason for that too (ie 
> legacy interrupt, it really _is_ edge-high, not level-low).

So what do you propose should be done to better handle such poorly
built machines?

As a concrete example I have a notebook which definitely assigns
shared interrupts to IRQ-10 (See /proc/interrupts below) yet the ELCR
only flags IRQ-11 as being level triggered and the rest are edge
triggered.
And with this configuration I definitely lose interrupts to the
wireless ethernet (ra0).

How do I make this work reliably?
I could:

1/ modify handle_IRQ_event so that it is more resilient to the
  possibility that shared interrupts are edge triggered.  This can be
  done be iterating over all action->handlers until they all return
  IRQ_NONE.

2/ Arrange that the ELCR bit is set for any IRQ for which a shared
  interrupt is registered (on the basis that the code for handling
  shared interrupts is not resilient against them being edge triggered).

3/ Have a kernel parameter, or sysfs variable, or magic
  write-to-/proc/interrupts of something that allows the ELCR to be read
  and set, and leave it up to user-space to perform the risky task of
  fiddling with ELCR

4/ As userspace can do inb/outb itself simply leave it all to
  userspace to worry about.

5/ Something I haven't thought of.

I don't much care which (those 2 seems best based on my limited
understanding) but I would be good to know how you think this should
be handled so that progress can be made.

Thanks,
NeilBrown

 


           CPU0       
  0:  180230371          XT-PIC  timer
  1:         91          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  4:         10          XT-PIC  serial
  8:          4          XT-PIC  rtc
 10:    3812362          XT-PIC  yenta, yenta, ohci_hcd:usb2, ohci_hcd:usb3, ehci_hcd:usb4, ra0
 11:          0          XT-PIC  uhci_hcd:usb1
 12:       3290          XT-PIC  i8042
 14:      63804          XT-PIC  ide0
 15:         37          XT-PIC  ide1
NMI:          0 
LOC:          0 
ERR:          0
MIS:          0
