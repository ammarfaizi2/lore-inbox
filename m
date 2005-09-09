Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030225AbVIIKeA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030225AbVIIKeA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 06:34:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030226AbVIIKeA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 06:34:00 -0400
Received: from web30311.mail.mud.yahoo.com ([68.142.201.229]:48245 "HELO
	web30311.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030225AbVIIKd7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 06:33:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=eZNGPaQE0R3219Vxrve8doTlzp30fnA3srbVQM+7FCTeP0SvDe/28I4JCzVyW3jeAic+1+I/aDVPcRWG4wcMOM5zTXwQceCcO8Et1njpVLNvrKn6EaDeTrUp+feKGDa4Shm+7hDe1Ph9EXTb/k/4Lr5FcaeFvhoUeDiRaCsjGK8=  ;
Message-ID: <20050909103353.69687.qmail@web30311.mail.mud.yahoo.com>
Date: Fri, 9 Sep 2005 11:33:52 +0100 (BST)
From: Mark Underwood <basicmark@yahoo.com>
Subject: Re: SPI redux ... driver model support
To: David Brownell <david-b@pacbell.net>, linux-kernel@vger.kernel.org
Cc: dpervushin@ru.mvista.com
In-Reply-To: <20050909030934.8419AE9DCC@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- David Brownell <david-b@pacbell.net> wrote:

> > Date: Wed, 7 Sep 2005 19:38:43 +0100 (BST)
> > From: Mark Underwood <basicmark@yahoo.com>
> > ...
> >
> > I see several posabiltiys of how SPI devices could
> be
> > connected to an adapter.
> 
> Certainly, and all are addressed cleanly by the kind
> of
> configuration scheme I showed.

And by my scheme :)

> 
> 
> > 1) All SPI devices are hardwired to the adapter. I
> > think this would be the most common.
> 
> For custom hardware, not designed for expansion,
> yes.  Zaurus Corgi
> models, for example, keep three SPI devices busy.
> 
> But in that category I'd also include custom
> hardware that happens to
> be packaged by connecting boards, which is also the
> territory of #2 or
> #3 below.  "Hard wired" can include connectors that
> are removable by
> breaking the warranty.  :)
> 
> 
> > 2) Some SPI devices are hardwired and some are
> > removable.
> 
> Development/Evaluation boards -- the reference
> implementations in most
> environments, not just Linux -- seem to all but
> universally choose this
> option (or, more rarely, #3).  There might be some
> domain-specific chips
> hardwired (touchscreen or CAN controller, ADC/DAC,
> etc), but expansion
> connectors WILL expose SPI.
> 
> That makes sense; one goal is to support system
> prototyping, and it's
> hard to do that if for any reason one of the major
> hardware connectivity
> options is hard to get at!
> 
> 
> > 3) All SPI devices are removable.
> 
> This is common for the sort of single board
> computers that get sold
> to run Linux (or whatever) as part of semicustom
> hardware:  maybe not
> much more than a few square inches packed with an
> SOC CPU, FLASH, RAM,
> and expansion connectors providing access to a few
> dozen SOC peripherals.
> (There might be 250 or so SOC pins, with expansion
> connectors providing
> access to some big portion of those pins ...
> including some for SPI.)
> 
> It'd be nice to be able to support those SBCs with a
> core Linux port,
> and then just layer support for addon boards on top
> of that without
> needing to touch a line of arch code.  And
> convenient for folk who
> are adding value through those addons.  :)
> 

And with my subsystem you don't can to change any arch
code, yay again! :)

> 
> 
> > 	 When you plug a card in you use
> > spi_device_register to add that device to the
> system
> > and when you remove the card you call
> > spi_device_unregister. You can then do the same
> for a
> > different card and at no time have you changed the
> > declaration of the controller.
> 
> That implies whoever is registering is actually
> going and creating the
> SPI devices ... and doing it AFTER the controller
> driver is registered.
> I actually have issues with each of those
> implications.

But how can you have a device that has no connection
to the system (i.e. no registered adapter) :(. Why
would you want to add SPI devices to adapters which
aren't yet in the system?

> 
> However, I was also aiming to support the model
> where the controller
> drivers are modular, and the "add driver" and
> "declare hardware" steps
> can go in any order.  That way things can work "just
> like other busses"

My subsystem does that. Once you have registered the
core layer you can add SPI device drivers before or
after registering SPI devices the only restriction is
the you have to register a SPI adapter before
registering any SPI devices which use that adapter. I
think this is sensible as otherwise you have to keep a
list of all SPI devices that have been registered and
didn't have an adapter at that time and go through
this list every time you register an adapter. This
sounds like putting the cart before the horse ;).

> when you load the controller drivers ... and the
> approach is like the
> familiar "boot firmware gives hardware description
> tables to the OS"
> approach used by lots of _other_ hardware that
> probes poorly.  (Except
> that Linux is likely taking over lots of that "boot
> firmware" role.)
> 
> 
> > > I'll post a refresh of my patch that seems to me
> to be
> > > a much better match for those goals.  The
> refresh includes
> > > some tweaks based on what you sent, but it's
> still just
> > > one KByte of overhead in the target ROM.  :)
> 
> Grr.  I added sysfs attributes and an I/O utility
> function,
> and now it's a bit bigger than 1KByte.  Especially
> with
> debugging enabled, it's nearer 1.5KB.  The curse of
> actually
> trying to hook up to hardware and its quirks.  :(
> 

I have built your spi_init.c for an ARM946EJS and I
get a .ko object of 5.1K this compares to my spi_core,
with transfer routines, of 10.6. I think there is
still some fat to trim from my core layer so I might
be able to get it smaller :).

> 
> > OK. I will post an updated version of my SPI
> subsystem
> > within the next few days with the transfer stuff
> added
> > and maybe the interrupt and GPO abstraction as
> well.
> 
> OK.
> 
> 
> > I haven't seen any replies to my SPI patch :( did
> you
> > reply to it?
> 
> No, I was going to sent it when I sent that refresh;
> it's helped
> focus my thoughts a bit.  :)

Glad to help :).

> 
> Several of the comments (like "get rid of algorithm
> layer!") you'll have
> heard before in response to the RFC from MontaVista.
>  It seems both
> approaches are still trying to make SPI seem like
> I2C, and not taking
> the opportunity to _fix_ very much of the I2C
> oddness.

OK. The only reason I had keept the algo layer is for
bitbashing, but thinking about it the pin set/clear
routines could be passed in as platform data. So I'll
remove the lago layer, cheers for the input.

Just to let you know I have been, my testing my
subsystem with a simple eeprom driver and a SPI
network device. So my subsystem is being tested under
heavy loads with transfers in size from 32K to 2
bytes!

Mark

> 
> - Dave
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
To help you stay safe and secure online, we've developed the all new Yahoo! Security Centre. http://uk.security.yahoo.com
