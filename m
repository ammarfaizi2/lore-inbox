Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932485AbVIKJDA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932485AbVIKJDA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 05:03:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932468AbVIKJDA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 05:03:00 -0400
Received: from web30305.mail.mud.yahoo.com ([68.142.200.98]:16523 "HELO
	web30305.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932467AbVIKJC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 05:02:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=DbL6g3AMcTU7sPTmd0E/xj4y28MOGgf6FXJ1vQrm2x9iKBDff+UsWnjNT9QflKEPWpjv9ey0aJx7OiyO9e8EDU9ZgzaaAXIh2+fYGVtmWzKiK9wNoGAF14WUdZbbhyqUDidkQ4AEflDch93LB56wRfjch1Hbd1Fl4PYE5w2eLGo=  ;
Message-ID: <20050911090244.52084.qmail@web30305.mail.mud.yahoo.com>
Date: Sun, 11 Sep 2005 10:02:43 +0100 (BST)
From: Mark Underwood <basicmark@yahoo.com>
Subject: Re: SPI redux ... driver model support
To: David Brownell <david-b@pacbell.net>, linux-kernel@vger.kernel.org
Cc: dpervushin@ru.mvista.com
In-Reply-To: <20050910014821.62D26E9DF1@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- David Brownell <david-b@pacbell.net> wrote:

> > Date: Fri, 9 Sep 2005 11:33:52 +0100 (BST)
> > From: Mark Underwood <basicmark@yahoo.com>
> >
> > ...
> > > That implies whoever is registering is actually
> > > going and creating the
> > > SPI devices ... and doing it AFTER the
> controller
> > > driver is registered.
> > > I actually have issues with each of those
> > > implications.
> >
> > But how can you have a device that has no
> connection
> > to the system (i.e. no registered adapter) :(. Why
> > would you want to add SPI devices to adapters
> which
> > aren't yet in the system?
> 
> The devices and adapters certainly are in the
> system;
> that's hardware!  Do you maybe mean "before the
> driver
> for an SPI adapter is bound to its device", and are
> you maybe talking about driver model data
> structures?

Yes

> 
> The thing which exists before the SPI adapter driver
> is
> bound to its device node is just a table.  It lists
> the
> SPI devices, and holds information needed later to
> set
> up the hardware.  Way simpler than ACPI or BIOS
> tables.
> 
> 
> > > However, I was also aiming to support the model
> > > where the controller
> > > drivers are modular, and the "add driver" and
> > > "declare hardware" steps
> > > can go in any order.  That way things can work
> "just
> > > like other busses"
> >
> > My subsystem does that. Once you have registered
> the
> > core layer you can add SPI device drivers before
> or
> > after registering SPI devices the only restriction
> is
> > the you have to register a SPI adapter before
> > registering any SPI devices which use that
> adapter.
> 
> That "only restriction" is the one I was talking
> about!!
> 
> It contorts the normal roles and responsiblities of
> the
> adapter drivers; and it's not necessary.
> 
> 
> > I think this is sensible as otherwise you have to
> keep a
> > list of all SPI devices that have been registered
> and
> > didn't have an adapter at that time and go through
> > this list every time you register an adapter.
> 
> Lots of systems have their earliest boot code
> provide a
> table of devices that exist (but which can't be
> probed).
> That's how my patch approaches SPI.
> 
> As for that "every time" ... I don't know about you,
> but
> the systems I've seen will register at most a
> handful of
> devices and adapters; and adapters register just
> once.
> For those numbers, even linear search is just fine.
> 

OK. Perhaps it's time to lay out the arguments so far
and see where we go from there :).

I want to pass a cs table in as platform data because
it means you don't have to know what bus number the
adapter is (which you can't easily tell for
hotplugable devices) and for most cases I think the
SPI devices will be hardwire to the adapter. This
approach of defining a structure to be used in
platform_data seems to be used by some serial drivers
so I think it's OK, but your not so sure.
How else could I do it? I could use driver_data but
that seems an even worse solution :(.

You want to pass in SPI devices in a table that gets
registered with the subsystem and when the adapter
that they sit on gets registered (known by the bus
number) all the devices in that table get registered
in the core. I like this solution for registering
hotplug'ish devices :), although I would prefer to use
the bus_id then a bus number. This solution doesn't
work very well for hotplug adapters as you don't know
what bus number they will be given (you would have to
do some undefined sysfs magic). 

So how would you feel about the core supporting both
cs tables as platform data and SPI device tables?

> 
> > I have built your spi_init.c for an ARM946EJS and
> I
> > get a .ko object of 5.1K
> 
> ... but the ".text" size is MUCH less; and what I
> sent
> was not built as a ".so", so there's other oddness
> too.

Sorry, I must be missing something here but isn't a
".so" a shared library not a kernel module? Or where
you only building it as a ".so" to find the text size?

Mark

> I got something on the order of 0x04d0 bytes with
> the
> refresh I just posted (call it 1200 bytes text).
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
