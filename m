Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965263AbVIOTYY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965263AbVIOTYY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 15:24:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965264AbVIOTYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 15:24:23 -0400
Received: from web30311.mail.mud.yahoo.com ([68.142.201.229]:49078 "HELO
	web30311.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S965263AbVIOTYW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 15:24:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=uY+ouidZ0BMme5UkWItFr5kGqkrSAZoJBypvRyt62p6qt5/bwaTOgIJOiRxWsC/umJtBiG88m6mfl++U6OoOnC22sauWGNcip5i1tqdBRZ2ePGvwr2EbWdgAmE65O2u74B3N22dMeY+PBV4IxJC0A+NGCfm02fW5LNnC1qwwH7w=  ;
Message-ID: <20050915192408.7378.qmail@web30311.mail.mud.yahoo.com>
Date: Thu, 15 Sep 2005 20:24:08 +0100 (BST)
From: Mark Underwood <basicmark@yahoo.com>
Subject: Re: [RFC][PATCH] SPI subsystem
To: David Brownell <david-b@pacbell.net>, linux-kernel@vger.kernel.org
Cc: dpervushin@ru.mvista.com
In-Reply-To: <20050915000811.D69E1EA56F@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- David Brownell <david-b@pacbell.net> wrote:

> > Date: Sat, 10 Sep 2005 12:17:06 +0100 (BST)
> > From: Mark Underwood <basicmark@yahoo.com>
> >
> > > 
> > >   - A "workqueue/task per driver" assumption. 
> This
> > > is interesting, because
> > >     it might be easier to port existing drivers
> into
> > > this new framework if
> > >     there were always a "free" task context
> > > available.  But on the other
> > >     hand ... not all drivers will need or want a
> > > workqueue, and those which
> > >     do can always create their own if keventd
> isn't
> > > good enough.
> >
> >
> >
> > Without the transfer routines I know it is hard to
> see
> > why I have used a workqueue so let me explain.
> > The workqueue is used as a scheduler for the
> adapter.
> > What happens is that a SPI device driver calls
> > transfer which creates a work item on the
> workqueue to
> > do the transfer. ...
> 
> In short, it's an artifact of how some controller
> drivers are
> implemented.  So it looks even more as if the right
> thing to do
> there is to NOT require all controller drivers to do
> that.
> 
> Plus, since you've made it public, there's no way to
> ensure
> that nobody else uses that work queue.  You're not
> following
> the basic "information hiding" rule for interface
> design.
> 

Sorry I must not be explaining this very well :(.
_Only_ the core uses the work queue. This is what
happens: 
 
1) SPI device driver creates message. 
2) SPI device passes this message to the core. 
3) The core puts this message on the work queue. 
4) When the controller is ready to receive the next
message the message is passed to the adapter driver. 
 
The work queue is used to isolate and serializes the
transfer calls from the SPI driver to the adapter.

> 
> >    You have to
> > have such a mechanism as you may have several SPI
> > devices on an adapter doing asynchronous IO at the
> > same time (i.e. giving an adapter that is in the
> > middle of doing work more work).
> 
> No, you do not "have" to have such a mechanism.  You
> can look at the USB
> stack  for a counterexample.  Both host and
> peripheral/gadget side adapter
> drivers manage request queues just fine without
> requiring such a task.
> And I assure you the queueing structure inside any
> USB Host Controller is
> orders of magnitude more complex than any SPI
> adapter needs.
> 

First, quoting from urb.c 
"Host Controller Drivers (HCDs) place all the URBs for
a particular endpoint in a queue." 
So USB does use queues. 
 
Here's that situation that shows why you need to queue
transfers. 
 
A SPI adapter has two devices, a networking device and
an EEPROM. 
The SPI network device doing asynchronous transfers
with call back the packets might be up to 1.5K. During
one of these transfers another device (in this example
an EEPROM) has to be read and thus the EEPROM driver
does a transfer. The transfer request from the EEPROM
gets put in the queue. When the adapter has finished
transmitting the message it notifies the core and the
core passes the EEPROM transfer request to the
adapter. 
 
What could be even worse is that there might be two
(or more!) networking devices on one SPI adapter so a
message from one will have to be queued while a
message from the other is being transfered. 


> 
> > >   - You set global policy on what
> "platform_data"
> > > should hold.  That makes it
> > >     not be platform-specific data any more!! 
> All
> > > that info should be moved
> > >     someplace else.  (E.g. in my patch, some of
> it
> > > is held by the SPI core.)
> >
> > No, but don't the serial port drivers do that with
> the
> > serial_struct structure? 
> > Anyway surely what SPI devices are on an adapter
> is
> > platform data! Why give the core work more to do?
> 
> Well, I've repeatedly given examples of cases where
> that is the
> wrong model ... where the devices are associated
> with an expansion
> card, so any reliance on platform data (that's set
> up by and coupled
> to the baseboard) causes lots of problems.
> 

I know! I agree that you can't always use the cs table
as you don't always know what devices are connected to
it. The problem that I have with your solution is how
can I deal with a hotplugable adapter? I don't know
what is bus number will be as I don't know what order
the adapters will be registered in. How else can I
solve this problem?

> 
> > >   - There's stuff I don't think should be in the
> > > device, like a semaphore
> > >     (in addition to the driver model one!) and
> an
> > > "spi_driver" pointer
> > >     (mirroring driver model dev->driver).
> >
> > As the comment says, it is used to sleep on for
> > blocking transfers, it's not a structure lock.
> 
> The traditional way to do this is more like what I
> did in the refresh of my patch:
> 

I'll have a look.

>  
>
http://marc.theaimsgroup.com/?l=linux-kernel&m=112631114922427&w=2
>  
>
http://marc.theaimsgroup.com/?l=linux-kernel&m=112631175219099&w=2
> 
> The first of those shows how to do it without that
> sort
> of pre-allocation; see the synchronous calls.
> 
> 
> > >   - And there's code to register and unregister
> a
> > > "spi_device".  I've been
> > >     thinking of that as the responsibility of
> the
> > > "SPI core", and that things
> > >     should work like most other bus frameworks
> on
> > > Linux (other than I2C!!).
> > >     That is, few folk (basically just subsystem
> > > maintainers) ever need to muck
> > >     with those particular "innards".  (That's
> the
> > > case in the code I sent.)
> > >     For better or worse, such code has proven
> quite
> > > error prone.
> >
> > But the idea is that it's the same style as the
> > platform bus in which you register and unregister
> a
> > platform device.
> 
> For SPI, there needs to be a layer between the
> platform device and the
> SPI devices.  That's the sort of code that I was
> pointing out tends to
> be error prone.
>

I'm not talking about a layer between platform device
and SPI devices. I'm talking about using the same
style.
 
> 
> > How else is the core going to know about the
> device?
> 
> See the patches above; I've explained that before.
> 
> 
> > My idea is that most people will
> > pass in a cs_table which has the SPI devices on
> that
> > adapter in it, but as you have pointed out this
> will
> > not always be what people want (for more
> hotplug'ish
> > devices) in which case they register those SPI
> devices
> > in the same manor as platform devices (I need to
> do a
> > bit work more work on this).
> 
> I've already done this work.  You could just reuse
> my code.  :)
> 

I plan to :), although I might modify it a bit :O, I
would prefer to use bus_id then some randon bus number
number (it also makes it easier from looking at the
code to see where devices are in the system and
vicevisa).

> 
> > > The I/O layer stub is less minimal than what I
> sent,
> > > but it's very similar
> > > in structure, names, and roles.  A few things
> live
> > > in different places. 
> > > I see convergence there!
> >
> > Good :). Although that patch didn't have the
> transfer
> > method in it :(.
> 
> I'm not sure how to parse that.  I remember seeing a
> transfer
> method of some kind; otherwise I'd not have been
> able to
> make such a comment.  (And the "different places"
> seemed
> like a real issue ... per-request flags in the
> device,
> per-device flags in the request, etc.)
> 

There is a transfer prototype (for adapters) and
message structures in the header file :).

> 
> > > As for I/O fast paths, I was thinking more about
> > > "write word then read word"
> > > stuff than bulk transfers, since so many SPI
> devices
> > > seem to use that sort
> > > of protocol convention (including MicroWire
> > > hardware).  And the message
> > > structure that's there now is prety
> bulk-oriented
> > > ... I modeled it on one
> > > from a DataFlash driver, not a sensor driver.
> > > 
> >
> > The problem is that the "write word then read
> word"
> > model is not universal and the msg structure is.
> 
> You can express "write word then read word" in terms
> of those messages;
> necessarily so.  The controller method accepting a
> message structure
> would be be a "must implement" (otherwise the rest
> couldn't just be
> optional "fast path" support).
> 
> OR ... for the very common case that the hardware
> supports such things
> directly, you could also add some fast paths.  So
> folk wanting quick
> audio control, or sensor access, could get that. 
> (Unless the controller
> were busy with some other request, in which case the
> request would need
> to get queued up as a "message".  Not a fastpath.)
> 

I'm not quite sure what your trying to achieve here.
These suggestions sound like hacks for  specific
classes of devices which will not work (or would
require more code in the core layer) as you have to
remember that all these devices (EEPROM's, ADC's,
network adapters, flash devices etc) all have to live
on the same adapter and so should all use the same
transfer method/structures.

> 
> > > > but what about
> > > > PCI cards which will have one interrupt line
> to
> > > > the interrupt controller and a interrupt
> status
> > > > register.
> > > > In this case the adapter will have to take the
> > > > interrupt and workout if it was for it or for
> the
> > > > SPI device.
> > > 
> > > Are you implying the standard interrupt
> framework
> > > would NOT work here?
> >
> > Yes.
> 
> You should maybe explain why it fails, in some other
> thread.
> I assure you the IRQ framework will not be changed
> just to
> make one exotic SPI implementation happier.
> 

I'm not talking about changing the IRQ framework just
pointing out that it fails in this case.

> 
> > > It already handles shared IRQs, whether for PCI
> or
> > > GPIO or whatever.
> > > (Or are you getting at something else?)
> >
> > But if a SPI device generates an interrupt on a
> PCI
> > card which has only one interrupt line, how does
> the
> > SPI device enable/disable/clear that interrupt
> given
> > that the register is in the PCI device and the SPI
> > device has no knowledge of that?
> 
> This sounds like exactly the same problem lots of
> device drivers
> have:  they may have one PCI interrupt, but
> internally the device
> has its own IRQ status, enable, and disable masks. 
> Then they do
> the dispatch to different parts of the driver
> internally, based
> on the status which triggered the IRQ.
> 
> SPI over PCI is reasonably exotic.  Seems to me as
> if the best way
> to solve that kind of problem would involve
> specialized SPI-over-PCI
> code, matching that one board.  Don't force every
> SPI implementations
> to cope with the quirks of that one PCI card,
> especially when most
> SPI hardware tres to be dead simple, to save costs.
> 

No, no, no and no! For a start many manufactures
producing SPI devices don't have a OMAP board to test
there device but they all have a PC :). If you can do
it right then do it right, don't have 'specialized' or
hacked version of things. We are working on a 2.6
kernel not a 2.4 kernel ;). The way I suggested
requires 0 work to be done by most adapters and a
small amount of work the be done by 'special'
adapters.

> 
> > > > 2) Extra GPO lines used for reset, etc. 
> > > > These could be treated like extra CS lines
> which
> > > > can be changed in a spi_msg.
> > > 
> > > Same as with IRQs: just pass them in with the
> chip's
> > > platform_data.
> > > 
> > > What's problematic is the fact that all GPIO
> code is
> > > platform specific.
> > > What works on PXA250 won't work on x86 or OMAP,
> and
> > > it may not even work
> > > on PXA270.  We'll still have limits to how
> portable
> > > drivers can be.
> > > 
> >
> > Not if you treat GPO pins as chip selects and let
> the
> > adapter abstract them for you :).
> 
> That assumes the GPIO pin is being used as a chip
> select,
> not as an input or output.  :)

The point is that you can pass GPIO pins and routines
to handle them to the adapter (after first setting
them to output) as platform data this means that you
don't have to do any nasty platform specific hacks in
the SPI device driver, which can only be a good thing
:).

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
