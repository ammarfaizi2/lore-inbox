Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751213AbVIOX1b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213AbVIOX1b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 19:27:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751218AbVIOX1b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 19:27:31 -0400
Received: from web30307.mail.mud.yahoo.com ([68.142.200.100]:55198 "HELO
	web30307.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751213AbVIOX1b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 19:27:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=CgCS2jMU+BPF5DXAL0Y3118gTpAoY8AcvHwhswagLwt1m4nWVHscFdD4NysCAxti4v0xR6krYaRLqZolkvo0Pjfl602TaCcWnw1o1gZVkNgj3o6zX/ncugVapcFtIoeDQSTNkplxdPRw5enP22g+D9UgVhSjAKtXNp3BSb57MPU=  ;
Message-ID: <20050915232723.1416.qmail@web30307.mail.mud.yahoo.com>
Date: Fri, 16 Sep 2005 00:27:23 +0100 (BST)
From: Mark Underwood <basicmark@yahoo.com>
Subject: Re: [RFC][PATCH] SPI subsystem
To: David Brownell <david-b@pacbell.net>, linux-kernel@vger.kernel.org
Cc: dpervushin@ru.mvista.com
In-Reply-To: <20050915221445.06473C10B9@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- David Brownell <david-b@pacbell.net> wrote:

> > _Only_ the core uses the work queue. This is what
> > happens: 
> >  
> > 1) SPI device driver creates message. 
> > 2) SPI device passes this message to the core. 
> > 3) The core puts this message on the work queue. 
> > 4) When the controller is ready to receive the
> next
> > message the message is passed to the adapter
> driver. 
> >  
> > The work queue is used to isolate and serializes
> the
> > transfer calls from the SPI driver to the adapter.
> 
> I see what's going on.  You're assuming there even
> IS a core!
> 
> Where I assumed otherwise ... drivers that want a
> workqueue should
> allocate their own.  The cost of that task shouldn't
> be inflicted on
> drivers that are happy just having their IRQ
> handlers start the next
> transfer right from the driver's request queue.  (I
> tend to avoid
> layers -- like a "core" -- unless they're
> unavoidable.  That helps
> code stay smaller, faster, and more comprehensible
> code.)
> 

I think my explanation is getting there! I'll
hopefully post the transfer routines this weekend
which will shine some light on this, but I keep having
to work on other things :( ).
 
The workqueue belongs to an adapter as you _will_ have
several SPI device drivers all trying trying send
messages through that _one_ adapter. Unless you only
allow blocking I/O which I _don't_ want to do then the
core has to handle the fact that _different_ SPI
device drivers will be trying to transfer messages
while the adapter is already in the middle of a
transfer.

ASCII art time :)

SPI device drivers|    Core    |   Adapter driver
----------   msg  |            |
| EEPROM |------> |-           |
----------        | |          |
------------ msg  | | -------  | msg ------
| ETHERNET |----> |-->|Queue|->|---->|xfer|
------------      | | -------  |     ------
---------    msg  | |    ^     |       |
| FLASH |-------> |-     ------|<------- Next/done
---------         |            |

> 
> > > >    You have to
> > > > have such a mechanism as you may have several
> SPI
> > > > devices on an adapter doing asynchronous IO at
> the
> > > > same time (i.e. giving an adapter that is in
> the
> > > > middle of doing work more work).
> > > 
> > > No, you do not "have" to have such a mechanism. 
> You
> > > can look at the USB
> > > stack  for a counterexample.  Both host and
> > > peripheral/gadget side adapter
> > > drivers manage request queues just fine without
> > > requiring such a task.
> > > 
> >
> > First, quoting from urb.c 
> > "Host Controller Drivers (HCDs) place all the URBs
> for
> > a particular endpoint in a queue." 
> > So USB does use queues. 
> 
> Exactly as I wrote ...  the issue isn't having
> request queues.
> The point of the example is that USB doesn't require
> workqueues.
> In fact, they're normally not used by HCDs.
> 

If you don't have a queue of some sort how do you
handle the fact that one or more devices will want to
send asynchronous messages through one adapter while
that adapter is still busy transferring a previous
message?

> 
> > > Well, I've repeatedly given examples of cases
> where
> > > that is the
> > > wrong model ... where the devices are associated
> > > with an expansion
> > > card, so any reliance on platform data (that's
> set
> > > up by and coupled
> > > to the baseboard) causes lots of problems.
> > > 
> >
> > I know! I agree that you can't always use the cs
> table
> > as you don't always know what devices are
> connected to
> > it. The problem that I have with your solution is
> how
> > can I deal with a hotplugable adapter? I don't
> know
> > what is bus number will be as I don't know what
> order
> > the adapters will be registered in. How else can I
> > solve this problem?
> 
> A hot pluggable adapter is going into some bus, and
> its driver will
> be bound through that bus.  Its probe routine will
> then create and
> register the "struct spi_master".  Output of that
> step includes the bus
> number assigned to the adapter ... which is pretty
> much The Linux Way,
> I can't think of a bus that works any other way.
> 

OK. But you also need to see what else is in the cs
table, namely the default level of the cs's. The issue
which we have to solve is that all the cs's have to be
put into their non-active state before any transfer
can be done. If devices are added into a running SPI
adapter (I mean registration of devices not physical
plugging) then how do you know what their idle state
is at the beginning (when the first SPI device does a
transfer? To me the only solution seems to be to pass
the idle state of all the devices that will be on that
device (be they hardwire, plugged or what ever) when
then adapter gets registered which is why I put it in
as part of platform data.

> 
> > > OR ... for the very common case that the
> hardware
> > > supports such things
> > > directly, you could also add some fast paths. 
> So
> > > folk wanting quick
> > > audio control, or sensor access, could get that.
> 
> > > 
> >
> > I'm not quite sure what your trying to achieve
> here.
> 
> Trying to derail some confusion of yours,
> unsuccessfully.  :(
> 
> The original observation was just that fast pathing
> _could_ be done
> that way.  I'd hope to avoid needing it, but
> experience suggests it's
> good to explore that design space before settling on
> one approach.
> 

I agree. The problem is, as far as I can see, every
message will have to be placed in a queue and then
passed to an adapter if several devices are going to
be living on the same adapter.

> 
> > > SPI over PCI is reasonably exotic.  Seems to me
> as
> > > if the best way
> > > to solve that kind of problem would involve
> > > specialized SPI-over-PCI
> > > code, matching that one board.
> >
> > No, no, no and no! For a start many manufactures
> > producing SPI devices don't have a OMAP board to
> test
> > there device but they all have a PC :)
> 
> Actually they can use any of hundreds of different
> Linux-equipped
> embedded boards.  Their _target_ environment is
> rarely a PC, and that
> means most of the development cycle won't run there
> either.  Ergo the
> framework shouldn't be stretching _too_ much to
> handle issues that
> only appear with one particular vendor's PCI-based
> eval hardware.

OK.

> 
> I can certainly understand how, say, Philips might
> want to support
> evaluation boards in PC environments.   It can be
> easier to debug on
> PCs; not everyone has JTAG tools; and so on.
> 

That's my thinking. Plus I was planning on writing a
parallel port bit-banging adapter as a sweetnear for
the PC Linux folk and later a SPI MMC driver so your
PC could have a MMC slot :) (even old 386's & 486's
which don't have USB and thus no card readers!).

> 
> > > > Not if you treat GPO pins as chip selects and
> let
> > > > the adapter abstract them for you :).
> > > 
> > > That assumes the GPIO pin is being used as a
> chip
> > > select, not as an input or output.  :)
> >
> > The point is that you can pass GPIO pins and
> routines
> > to handle them to the adapter (after first setting
> > them to output) as platform data this means that
> you
> > don't have to do any nasty platform specific hacks
> in
> > the SPI device driver, which can only be a good
> thing :).
> 
> Sure, I've certainly done that.  And that'd be the
> best way 
> to build a bitbanging SPI adapter too ... every
> platform
> will bang the bits differently (GPIOs, parport,
> etc).

More common ground :)!

Mark

> 
> - Dave
> 
> 
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 



	
	
		
___________________________________________________________ 
Yahoo! Messenger - NEW crystal clear PC to PC calling worldwide with voicemail http://uk.messenger.yahoo.com
