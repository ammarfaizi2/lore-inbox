Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261952AbVEDXL6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261952AbVEDXL6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 19:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261954AbVEDXL6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 19:11:58 -0400
Received: from open.hands.com ([195.224.53.39]:17315 "EHLO open.hands.com")
	by vger.kernel.org with ESMTP id S261952AbVEDXLq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 19:11:46 -0400
Date: Thu, 5 May 2005 00:20:24 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux ARM Kernel list 
	<linux-arm-kernel@lists.arm.linux.org.uk>
Subject: Re: tricky challenge for getting round level-driven interrupt problem: help!
Message-ID: <20050504232024.GH8537@lkcl.net>
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

 oh.

 ah.

 wait - this might be the bit i don't get 

 when you say poll again, do you mean poll again inside the ISR?

 so:
 
 * we do the read (which creates the interrupt to the PIC) and
   then sit there polling the level-driven interrupt status
   register
 
 * the PIC, having no more bytes to write, clears the ARM
   level-driven interrupt.

 * the ARM detects the change of the level-driven interrupt
   status register

 * the ARM pauses for, oh, i dunno... mmm... 6mhz equals 166ns
   so we call udelay(10) or something ridiculously long...

 * the ARM then checks the level-driven interrupt status register
   AGAIN, and if it's clear, goes "oh, we ain't gonna get no
   more data".

 something like that? [am trying it now, anyway - on the basis that it
 can't hurt :)]

 i'm not being deliberately thick - honest - i've just never had to
 do this sort of thing before.

 btw alan where would you recommend i read up on this type of thing?
 [_please_ don't say "on the inside of my skull" i'll be tempted to
 go get a saw and a spoon i've _so_ got to get this to work...]
 

> >  hence the redesign to do alternate read-write-read-write, and making
> >  reads exclusive of writes, etc.
> 
> and maybe even turn the IRQ off and use a timer if its slow and not
> sensitive to latency.. ?
 
 tried that last month [i'm not sending to lkml about this as a first
 resort - honest!]
 
 the baud rate from the GPS is 4800 baud, so that's 600 chars/sec.

 the jiffies timer on the ARM is ... er... 250? per second?

 so ... hey, yeh, that would explain why i saw about 1
 character in 3 :)



> >  ... so - in your opinion, alan, is the old approach we had
> >  actually _on_ the right lines?
> 
> level triggered IRQ does sort of expect the other end responds promptly
> to be efficient as opposed to merely reliable.

 ... and a 6mhz processor vs a 90mhz processor... 

> >  also, are you going to ukuug in august, it being _in_
> >  aberystwyth and all :)
> 
> Its not in Aberystwyth, but I might be. Its in Swansea 8)

 ahhh :)

 glad i checked then, 'cos up until 30 seconds ago i was gonna
 drive to aber.

 *wonders why the hell i've been let loose on this project...*

