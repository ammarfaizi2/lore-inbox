Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262853AbVEHMYY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262853AbVEHMYY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 08:24:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262856AbVEHMYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 08:24:24 -0400
Received: from open.hands.com ([195.224.53.39]:62637 "EHLO open.hands.com")
	by vger.kernel.org with ESMTP id S262853AbVEHMYC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 08:24:02 -0400
Date: Sun, 8 May 2005 13:32:35 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux ARM Kernel list 
	<linux-arm-kernel@lists.arm.linux.org.uk>
Subject: Re: tricky challenge for getting round level-driven interrupt problem: help!
Message-ID: <20050508123235.GQ17194@lkcl.net>
References: <20050503215634.GH8079@lkcl.net> <1115171395.14869.147.camel@localhost.localdomain> <20050504205831.GF8537@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050504205831.GF8537@lkcl.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi: just a fyi.

i do not know, cannot tell, and do not care [ItNowWorks(tm)] why what i
have done manages to GetItToWork(tm) - i am merely providing you with
information such that _other people_ may dissect this issue, may look at
this in six months/years and go "oh yeah, maybe i should try that too".

in the write communications, i have REMOVED the use of interrupts and am
PURELY using the INTMR1 bit for polling purposes (!!!)

the code goes something like this:

int pic_misc_write( ..... char *data, int len)
{
	for (i = 0; i < data; i++)
	{
		pic_queue_byte(data[i]);
		pic_writable_int(0, 0, NULL);
	}
}

ha ha, i hear you say, very funny.

well, in pic_writable_int - which USED to be called as an interrupt
handler, i have this:

irq_return_t pic_writable_int(int irq, ....)
{
	/* check that the PIC is ready for us to proceed */
	while (!(clps_readl(INTMR) & 0x40)) {
	}
	...
	...

	/* place the byte on the 
	clps_writeb(pic_get_queued_byte(), PORT_A_DATA_REGISTER);

	/* this generates an interrupt to the PIC */
	clps_writeb(0x...., PORT_A_SOMETHING_REGISTER);

	/* ... which we sit there twiddling our thumbs waiting for
	   it to be cleared 
	 */
	while ((clps_readl(INTMR) & 0x40)) {
	}
}

ironically, it's _still_ not 100% reliable: about 1 in every 400 bytes
gets corrupted.

but that's probably due to bugs in the PIC assembly code, which i can
live with / get these guys to fix, or it's to do with the setup timing
of the port directions - again, i can deal with that.

... the question is - what the _hell_ is going on with the linux 2.6
level-based interrupt handling / my-braindead-way-of-using-them
that causes the above approach to be [virtually] 100% reliable
as compared to a 95%-reliable cock-up?

l.

On Wed, May 04, 2005 at 09:58:31PM +0100, Luke Kenneth Casson Leighton wrote:
> alan, thanks for responding directly.
> 
> the internet is down at the moment (at least, bt's bit is) so
> your continued direct responses, if you have the time, greatly
> appreciated.
> 
> i can't get http or ssh access to _anywhere_, but bizarrely,
> smtp is getting through.
> 
> [sod bt.  royally.]
> 
> On Wed, May 04, 2005 at 02:50:01AM +0100, Alan Cox wrote:
> 
> > On Maw, 2005-05-03 at 22:56, Luke Kenneth Casson Leighton wrote:
> > > it only does level-based interrupts and i need to create a driver
> > > that does two-way 8-bit data communication.
> > 
> > Level triggered is generally considered a feature by people less than
> > 200 years old 8)
>  
>  lots of experience, then, you'd say?  my experience with doing this
>  kind of stuff is kinda limited (doesn't stop me trying) so your
>  response is really appreciated.
> 
> > > i would genuinely appreciate some advice from people with
> > > more experience than i on how to go about getting round
> > > this stupid hardware design - in order to make a RELIABLE,
> > > non-race-conditioned kernel driver.
> > 
> > Assuming you are using the core Linux IRQ code 
> 
>  yep.
> 
> > then you shouldn't have
> > any great problem. The basic rules with level triggered IRQ are that 
> > 
> > - You must ack the IRQ on the device to clear it either specifically or
> > as part of some other process.
> > - The device must raise the IRQ again if the irq condition is present
> > *at* or after the point of the IRQ ack (or in many implementations 'just
> > before' in fact)
> > 
> > the core Linux code deals with masking on the controller to ensure IRQ's
> > dont get called recursively, and ensuring an IRQ gets rechecked/recalled
> > on the unmask/exit path if it is still asserted.
> > 
> > So an implementation is much like a serial port fifo, assert the IRQ
> > until the PC has fetched all the bits. In fact the IRQ line is
> > essentially "NOT(fifo_empty)" and rechecked each time a byte is fetched.
>  
>  okay.
> 
> > *WAY* simpler than nasty edge triggered stuff 8)
>  
>  bleh :)
> 
>  okay.
> 
>  i believe i get it: you raise a level-triggered interrupt which _stays_
>  raised until such time as your fifo is empty.
> 
>  the original protocol that was written [by somebody even less
>  experienced than i] was designed the way it is because the PIC chip
>  that's connected to the ARM only has *one* interrupt.
> 
>  that interrupt is triggered:
> 
>  * on a port read (there are four 8-bit ports!)
>  * on a port write 
>  * by the serial port
>  * by the timer
> 
>  [skip this bit if you're busy, it's just background info]
> 
> 	 so there's now a _thousand_ lines of hand-written assembly code
> 	 which took well over a year to write and debug on the PIC, that
> 	 implements the state-machine to deal with the GPS on the serial
> 	 port, interleaving the "device status" info into the GPS data
> 	 stream, getting the GPS data stream over the 8-bit port and
> 	 receiving LCD commands over the 8-bit port, interpreting them
> 	 and then feeding the LCD.
> 
>  okay.
> 
>  so.
> 
>  assuming that i can handle the pic having only a single interrupt, then
>  does the process go something like this (for read, e.g.):
> 
>  1) the ARM unmasks read interrupts when it's ready.
> 
>  2) when the PIC has data to be read (which is only ever a single byte),
>    it asserts the level-triggered read interrupt to the ARM.
> 
>  3) the ARM receives the interrupt, and reads the byte.  the _act_ of
>    reading the byte causes an edge-triggered interrupt to the PIC.
> 
> 
>  5) the first thing the PIC does in its [one] ISR is to de-assert the
>    read interrupt.  why? because there is only a one byte buffer.
> 
>  
>  we have an additional step in the chain - step 4 - which is:
> 
>  4) in the ISR, the ARM goes into a tight loop checking that the 
>     PIC has cleared the level-triggered interrupt.
>  
> 
>  the reason for checking this is so that when we come out of the
>  ISR on the ARM, the PIC is *SOOO* slow - it's only 6mhz after
>  all - that sometimes (frequently, in fact - about 1 in every
>  50 times) it hasn't got round to clearing the level-driven
>  interrupt by the time we come out of the ARM ISR (!)
> 
>  the problem we're having is actually worse than that.
> 
>  sometimes something goes screwy and _despite_ having this loop-check,
>  we get duplicated characters.
> 
>  sometimes, even worse, we lose sync, and the ARM sits there in the
>  loop...
> 
> 
>  i was getting _so_ fed up with this that i was thinking that there
>  was a problem with the approach being taken.
> 
>  hence the redesign to do alternate read-write-read-write, and making
>  reads exclusive of writes, etc.
> 
>  awful.  just awful :)
> 
> 
>  ... so - in your opinion, alan, is the old approach we had
>  actually _on_ the right lines?
> 
>  also, are you going to ukuug in august, it being _in_
>  aberystwyth and all :)
> 
>  l.
> 

-- 
--
<a href="http://lkcl.net">http://lkcl.net</a>
--
