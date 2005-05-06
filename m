Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261207AbVEFKsX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261207AbVEFKsX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 06:48:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261208AbVEFKsX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 06:48:23 -0400
Received: from open.hands.com ([195.224.53.39]:28906 "EHLO open.hands.com")
	by vger.kernel.org with ESMTP id S261207AbVEFKsQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 06:48:16 -0400
Date: Fri, 6 May 2005 11:57:31 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux ARM Kernel list 
	<linux-arm-kernel@lists.arm.linux.org.uk>
Subject: Re: tricky challenge for getting round level-driven interrupt problem: help!
Message-ID: <20050506105731.GF7632@lkcl.net>
References: <20050503215634.GH8079@lkcl.net> <1115171395.14869.147.camel@localhost.localdomain> <20050504205831.GF8537@lkcl.net> <1115243014.19844.62.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1115243014.19844.62.camel@localhost.localdomain>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 04, 2005 at 10:43:35PM +0100, Alan Cox wrote:

> On Mer, 2005-05-04 at 21:58, Luke Kenneth Casson Leighton wrote:
> >  i believe i get it: you raise a level-triggered interrupt which _stays_
> >  raised until such time as your fifo is empty.
> 
> Bingo. It only goes away when the chip really has nothing left to say.
> 
> >  all - that sometimes (frequently, in fact - about 1 in every
> >  50 times) it hasn't got round to clearing the level-driven
> >  interrupt by the time we come out of the ARM ISR (!)
> 
> So you'll poll again and find there is no pending work to do.
> 
> >  hence the redesign to do alternate read-write-read-write, and making
> >  reads exclusive of writes, etc.
> 
> and maybe even turn the IRQ off and use a timer if its slow and not
> sensitive to latency.. ?

 okay.

 you will be pleased to know that the switch-off-irqs-in-the-isr
 and then switch-it-back-on-in-the-FIQ approach works.

 *gibber*

 basically i am doing this:

 * in the ARM interrupt read routine, first thing i do is mask
   read interrupts.

 * i then set up the ARM port for "read", including disabling the
   keyboard which shares some of the port lines.

 * i then read the byte (which causes an edge-triggered interrupt
   to the PIC, which then sets about clearing the interrupt).
 
 * i then re-enable the keyboard.

 * at the end of the routine, i then set a flag.


 some time later, within 1/8000th of a second, this flag is checked.
 if it's set, read interrupts are unmasked.

 
 ... btw when you say "using the linux interrupt management" routines,
 what exactly do you mean?

 at the moment (because that's what was done when i stepped in
 to sort out this code) i am directly accessing the INTMR1 and
 INTSR1 registers - _not_ calling enable_irq() or disable_irq()
 or other)

 (and in the FIQ handler of course i _can't_ call those functions).

 is that a problem?

 l.

