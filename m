Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750707AbVIJLRN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750707AbVIJLRN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 07:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750717AbVIJLRN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 07:17:13 -0400
Received: from web30304.mail.mud.yahoo.com ([68.142.200.97]:65156 "HELO
	web30304.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750707AbVIJLRN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 07:17:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=ineQqsJfF2USOirNVDE4ZLtwB1J2gs3ZR9CmWel/B4cxLic20Od6k5tHh5G3Z0eVg1tfLRtkc3l2N6T0cP5RyLJt1Z6O+J+TGPU2Vc2a2YG07EmW6A5Ch8nrsUXwWGOt5J87CF8VGofQbvTA+FDDnv94EjFv0bDJNLmNYXpO9lA=  ;
Message-ID: <20050910111706.90598.qmail@web30304.mail.mud.yahoo.com>
Date: Sat, 10 Sep 2005 12:17:06 +0100 (BST)
From: Mark Underwood <basicmark@yahoo.com>
Subject: Re: [RFC][PATCH] SPI subsystem
To: David Brownell <david-b@pacbell.net>, linux-kernel@vger.kernel.org
Cc: dpervushin@ru.mvista.com
In-Reply-To: <20050909213936.6BCD2E9DEF@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- David Brownell <david-b@pacbell.net> wrote:

> > Here is a SPI framework which tries to use the
> driver
> > framework provided by the 2.6 kernel which you can
> > play around with on any platform, even on your PC
> :). 
> 
> An idea I've used in the refresh of my simpler
> patch.
> More complete examples (often) help.  :)
> 
> 
> > This patch only contains a core layer that handles
> > un/registering of SPI adapters SPI devices and SPI
> > drivers.
> 
> It's got more than that:
> 
>   - An "algorithm" layer, an I2C leftover that IMO
> should be removed.

Will be removed in the next patch set.

> 
>   - A "workqueue/task per driver" assumption.  This
> is interesting, because
>     it might be easier to port existing drivers into
> this new framework if
>     there were always a "free" task context
> available.  But on the other
>     hand ... not all drivers will need or want a
> workqueue, and those which
>     do can always create their own if keventd isn't
> good enough.



Without the transfer routines I know it is hard to see
why I have used a workqueue so let me explain.
The workqueue is used as a scheduler for the adapter.
What happens is that a SPI device driver calls
transfer which creates a work item on the workqueue to
do the transfer. An adapter is given one SPI message
to process at a time and when it has finished it will
notify the core and the core will execute the next
item on the work list (the next transfer). You have to
have such a mechanism as you may have several SPI
devices on an adapter doing asynchronous IO at the
same time (i.e. giving an adapter that is in the
middle of doing work more work).
Hopefully its use will become clearer in the next
patch set I send.

> 
>   - Bits and pieces of some sort of procfs API,
> which I'm guessing you
>     haven't finished removing.

Yep, still removing I2C stuff!

> 
> And as for that core:
> 
>   - The "spi_cs_table" (entry) is very similar to
> the "spi_board_info" in
>     my patch, but it has some stuff I expect to live
> in platform_data.
>     And it's managed quite differently; it's not
> something early boot
>     code would just hand to the SPI core before it
> vanishes.
> 
>   - You set global policy on what "platform_data"
> should hold.  That makes it
>     not be platform-specific data any more!!  All
> that info should be moved
>     someplace else.  (E.g. in my patch, some of it
> is held by the SPI core.)

No, but don't the serial port drivers do that with the
serial_struct structure? 
Anyway surely what SPI devices are on an adapter is
platform data! Why give the core work more to do?

> 
>   - It has code to wrap "struct device_driver". I'd
> rather it work more
>     like the platform bus -- no wrapper at all!! 
> That's simpler, and easier
>     to understand.  It eliminates public API
> functions to manage "struct
>     spi_driver", as well as that struct itself; and
> also a bunch of internal
>     code that's more or less just mirroring what the
> driver model does.
>     Fewer parallel concepts means smaller and
> simpler code all around.

Yes. I was thinking the same thing (as you can see by
the comments in spi.h). I have now removed the
spi_driver structure. Yay, less code!

> 
>   - There's stuff I don't think should be in the
> device, like a semaphore
>     (in addition to the driver model one!) and an
> "spi_driver" pointer
>     (mirroring driver model dev->driver).

As the comment says, it is used to sleep on for
blocking transfers, it's not a structure lock.

> 
>   - And there's code to register and unregister a
> "spi_device".  I've been
>     thinking of that as the responsibility of the
> "SPI core", and that things
>     should work like most other bus frameworks on
> Linux (other than I2C!!).
>     That is, few folk (basically just subsystem
> maintainers) ever need to muck
>     with those particular "innards".  (That's the
> case in the code I sent.)
>     For better or worse, such code has proven quite
> error prone.

But the idea is that it's the same style as the
platform bus in which you register and unregister a
platform device. How else is the core going to know
about the device? My idea is that most people will
pass in a cs_table which has the SPI devices on that
adapter in it, but as you have pointed out this will
not always be what people want (for more hotplug'ish
devices) in which case they register those SPI devices
in the same manor as platform devices (I need to do a
bit work more work on this).

> 
> The I/O layer stub is less minimal than what I sent,
> but it's very similar
> in structure, names, and roles.  A few things live
> in different places. 
> I see convergence there!

Good :). Although that patch didn't have the transfer
method in it :(.

> 
> As for I/O fast paths, I was thinking more about
> "write word then read word"
> stuff than bulk transfers, since so many SPI devices
> seem to use that sort
> of protocol convention (including MicroWire
> hardware).  And the message
> structure that's there now is prety bulk-oriented
> ... I modeled it on one
> from a DataFlash driver, not a sensor driver.
> 

The problem is that the "write word then read word"
model is not universal and the msg structure is. We
have a SPI network device which requires both sort
messages (reading status) and large packets for data
and firmware download (upto 32K chunks). You may well
have a SPI network device on the same bus as an eeprom
(which we do) and so both have to be handled in the
same way.

> 
> 
> > This framework removes all the platform knowledge
> from
> > the SPI adapter and all SPI knowledge (chip
> selects,
> > which adapter, etc) from the SPI driver. 
> 
> It does that in a somewhat different way than mine
> did, and doesn't
> really decouple board descriptions (early boot
> stuff) from the
> driver load sequence (late boot, or even managed by
> userspace).
> 

It gives you the option to decouple board descriptions
form the adapter declaration if that's what you mean.
SPI devices and drivers can be loaded in any order.


> 
> > This patch still doesn&#8217;t address a couple of
> > platform abstraction problems. 
> >  
> > 1) How to handle SPI devices that require an
> interrupt
> > line.  This isn&#8217;t a problem on embedded
> systems as most
> > of these will have interrupt pins which are
> connected
> > directly to the interrupt controller,
> 
> As noted in comments, I expect IRQs to be passed
> with the similar sorts
> of board-specific platform_data, as one more "int"
> (likely it's a GPIO
> number, though the numbers request_irq takes can be
> useful too).
> 
> I considered passing a "struct resource" with the
> board description data,
> but decided against that ... "int" is smaller,
> cheaper, more obvious.
> 
> 
> 
> > but what about
> > PCI cards which will have one interrupt line to
> the
> > interrupt controller and a interrupt status
> register.
> > In this case the adapter will have to take the
> > interrupt and workout if it was for it or for the
> SPI
> > device.
> 
> Are you implying the standard interrupt framework
> would NOT work here?

Yes.

> It already handles shared IRQs, whether for PCI or
> GPIO or whatever.
> (Or are you getting at something else?)
> 

But if a SPI device generates an interrupt on a PCI
card which has only one interrupt line, how does the
SPI device enable/disable/clear that interrupt given
that the register is in the PCI device and the SPI
device has no knowledge of that?

> 
> > One idea as to have function pointers for
> > registering, enabling and disabling interrupts in
> the
> > adapter structure. The core layer could fill in
> the
> > normal functions if an adapter driver
> doesn&#8217;t
> > fill them in, that way most adapter drivers
> > don&#8217;t have to do any extra work. 
> 
> The normal thing is just to pass an IRQ number into
> the driver (maybe
> through platform_data) which then gets passed to
> request_irq() as usual.
> 
> The place that falls down is when that IRQ source
> hasn't been merged
> into the platform IRQ framework ... for example, the
> IRQ is reported
> indirectly, through some I2C based GPIO expander. 
> Those cases are
> not usually mainstream.  So I'm happy to leave them
> as platform-specific
> hacks for a very long time, rather than write code
> that handles the
> normal clean request_irq() path AND something less
> clean.  ;)

But if you can do it easily why not :)?

> 
> 
> > 2) Extra GPO lines used for reset, etc. 
> > These could be treated like extra CS lines which
> can
> > be changed in a spi_msg.
> 
> Same as with IRQs: just pass them in with the chip's
> platform_data.
> 
> What's problematic is the fact that all GPIO code is
> platform specific.
> What works on PXA250 won't work on x86 or OMAP, and
> it may not even work
> on PXA270.  We'll still have limits to how portable
> drivers can be.
> 

Not if you treat GPO pins as chip selects and let the
adapter abstract them for you :).

Mark

> - Dave
> 
> -
> To unsubscribe from this list: send the line
>"unsubscribe linux-kernel" in
> the body of a message to majordomo@xxxxxxxxxxxxxxx
> More majordomo info at
>http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at http://www.tux.org/lkml/


		
___________________________________________________________ 
How much free photo storage do you get? Store your holiday 
snaps for FREE with Yahoo! Photos http://uk.photos.yahoo.com
