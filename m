Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262253AbVAZXxQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262253AbVAZXxQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 18:53:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262142AbVAZXvt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 18:51:49 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:38633 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S262190AbVAZTon (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 14:44:43 -0500
Date: Wed, 26 Jan 2005 23:07:12 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: dtor_core@ameritech.net
Cc: dmitry.torokhov@gmail.com, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, greg@kroah.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc2-mm1
Message-ID: <20050126230712.1dd63589@zanzibar.2ka.mipt.ru>
In-Reply-To: <d120d5000501261026700e37c0@mail.gmail.com>
References: <20050124021516.5d1ee686.akpm@osdl.org>
	<1106727902.5257.109.camel@uganda>
	<d120d5000501260546536647e7@mail.gmail.com>
	<1106751547.5257.162.camel@uganda>
	<d120d5000501260726714e8251@mail.gmail.com>
	<1106754848.5257.189.camel@uganda>
	<d120d500050126082515bd68f9@mail.gmail.com>
	<1106757974.5257.229.camel@uganda>
	<d120d50005012608556ab05a96@mail.gmail.com>
	<1106761176.5257.246.camel@uganda>
	<d120d5000501261026700e37c0@mail.gmail.com>
Reply-To: johnpol@2ka.mipt.ru
Organization: MIPT
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jan 2005 13:26:38 -0500
Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> > > > > > Since each logical device does not know who use it, it can not be,
> > > > > > for example, removed optimally.
> > > > > > You need to run through whole superio device set to find those one that
> > > > > > has reference to logical device being removed.
> > > > >
> > > > > What do you mean by removing optimally? Consider teher 2 scenarios:
> > > > >  - you unload logical device driver which knows all the logical
> > > > > devices (interfaces) it is bound to and it releases those devices.
> > > >
> > > > It does not know chip drivers, which reference it.
> > >
> > > Of course it does, every logical device has one parent. Individual
> > > GPIO pins are not spread across your motherboard. Every one of them
> > > lives on some chip. They can all be driven by the same driver but they
> > > are different devices. It is like all your IDE drives are driven by
> > > the same driver but (unless LVM which is diffrent layer comes to play)
> > > they are still different drives.
> > 
> > No, there is no "parent".
> > Each logical device is "shared" between several superio chips.
> > It is presented design.
> 
> Ok, I presume that userspace although you saying that logical device
> is "shared" between chips different GPIO pins still visible to
> userspace as separate entities (correct me if I am wrong). That means
> that you chose in your implementation not to abstract out individual
> parts of SuperIO container as individual devices and instead have
> several logical drivers bound directly to a same chip. And that is why
> you need n-m relationship and inability to fit to the driver model and
> potential issues with power management. Instead of this

Userspace has access to GPIO logical device by it's name 
and name of the superio chip it is connected to.
 
>                                                       / <ldev>
>  <base-dev (PCI|ISA|other)> - <sdev> - <ldev>
>                                                      \ <ldev>
> 
> you need this
> 
>                                         /<sdev> - <ldev>
> <base-dev (PCI|ISA|other)> - <sdev> - <ldev>
>                                         \ <sdev> - <ldev>
> 
> This will decouple chip drivers from the logical drivers.
> 
> I argue that present design is sub-optimal and will hurt in the long run.


This picture is somewhat better presents superio design:

sdev           sdev
  |-----| |-----|
ldev   ldev   ldev

Where |---| links are bidirectional.

Probably you are right, but I doubt :)

> > > > We need to scan all superio chips to find that.
> > > >
> > > > > - you unload chip driver which knows what logical devices it has
> > > > > registered and removes them. Logical devices in turn unbind themselves
> > > > > from the logical drivers thay are bound to (only one for each device
> > > > > and they have link).
> > > > > Seems pretty clean to me.
> > > >
> > > > Yes, since there is sc->ldev relation.
> > > >
> > > > > > And situation become much worse, when we have so called logical device
> > > > > > clones -
> > > > > > it is virtual logical device that emulates standard one, but inside
> > > > > > performs
> > > > > > in a different way. Clone creates inside superio device(for example such
> > > > > > device
> > > > > > can live at different address).
> > > > > > When you do not have ldev->sc relation, you must traverse through each
> > > > > > logical device
> > > > > > in each superio chip to find clones.
> > > > > > Thus you will need to traverse through each superio chip,
> > > > > > then through each logical device it references, just to remove one
> > > > > > logical device.
> > > > >
> > > > > I am confused and need a concrete example. I would think that cases
> > > > > such as these should not require eny special handling, hardware access
> > > > > should be hidden from logical drivers by the chip driver. Or if only
> > > > > difference is the port address then it probably should be set by the
> > > > > chip driver as attribute of logical device.
> > > >
> > > > Consider sc.c and GPIO logical device in SC1100 (scx driver).
> > > >
> > > >                /*
> > > >                 * SuperIO core is registering logical device.
> > > >                 * SuperIO chip knows where it must live.
> > > >                 * If logical device being registered lives at the different location
> > > >                 * (for example when it was registered for all devices,
> > > >                 * but has address(index) corresponding to only one SuperIO chip)
> > > >                 * then we will register new logical device with the same name
> > > >                 * but with the different location(index).
> > > >                 *
> > > >                 * It is called clone.
> > > >                 */
> > > >
> > >
> > > In this sense every device is a clone. Consider I have 2 EtherExpress
> > > cards in my box. They surely live at different addresses but PCI
> > > system does not mess with "clones". And network layer does not care
> > > whether both of them driven by e100 or one is e100 and the other is
> > > RTL.
> > 
> > It is not the same as two different devices on the bus.
> > 
> > Consider sc1100 - GPIO lives in PCI aperture, absolutely not where
> > superio lives.
> > (And it is actully not logical device in this case, but it fits well
> > into design).
> 
> It does not matter where it "lives". The chip driver should not expose
> these details to interface driver. Although you said serio examples
> are not applicable here let's take another look there: i8042 and
> pcips2 modules. One provides serio ports that live in legacy IO space,
> the other is PCI-based. psmouse would not care less which one is
> behind the port it is bound to.

Chip driver provides access methods to the attached logical devices.
It probes and activates them, if appropriate module is loaded.

Your example again is not suitable for superio case.

With superio you have several identical logical devices, access to which
is absolutely standard in second level(logic befind access), 
but in first one(physicall access) it can differ.

So here is the real example of superio usage:

     userspace
        |
    superio core
      ......

       GPIO
  |----|  |--|
pc87366     sc1100
  |----| |---|
       WDT

Logical device GPIO is accessed by read/write methods, which only have
pin number(it is not how this methods are exactly implemeted though)
as parameter.

For example userspace accesses GPIO at sc1100 - it will be translated
into read methods called from appropriate superio chip with appropriate
parameters.

When we have multiple GPIO logical devices(each in it's own superio chip)
it is more convenient to use just the same object.


I did not understand you from the beginning...
It can be turned into device model quite well, only individual objects
should have backward references to allow easier manipulation with it's
"owners". Your above schema with device model is quite right, just add
invisible links from each device to/from it's "masters".

> 
> -- 
> Dmitry


	Evgeniy Polyakov

Only failure makes us experts. -- Theo de Raadt
