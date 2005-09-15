Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932417AbVIOAI3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932417AbVIOAI3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 20:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932495AbVIOAI2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 20:08:28 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:53898 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S932417AbVIOAI2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 20:08:28 -0400
X-ORBL: [69.107.75.50]
DomainKey-Signature: a=rsa-sha1; s=sbc01; d=pacbell.net; c=nofws; q=dns;
	h=received:date:from:to:subject:cc:references:in-reply-to:
	mime-version:content-type:content-transfer-encoding:message-id;
	b=IYjf/hW5X8nkc9mQkN91gaZ61qvgN2mDoouL3LooSOZchuMNj1XuyAyDrB5gERyK6
	K3qy+RyobbYCsYqUiYSfg==
Date: Wed, 14 Sep 2005 17:08:11 -0700
From: David Brownell <david-b@pacbell.net>
To: linux-kernel@vger.kernel.org, basicmark@yahoo.com
Subject: Re: [RFC][PATCH] SPI subsystem
Cc: dpervushin@ru.mvista.com
References: <20050910111706.90598.qmail@web30304.mail.mud.yahoo.com>
In-Reply-To: <20050910111706.90598.qmail@web30304.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20050915000811.D69E1EA56F@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Sat, 10 Sep 2005 12:17:06 +0100 (BST)
> From: Mark Underwood <basicmark@yahoo.com>
>
> > 
> >   - A "workqueue/task per driver" assumption.  This
> > is interesting, because
> >     it might be easier to port existing drivers into
> > this new framework if
> >     there were always a "free" task context
> > available.  But on the other
> >     hand ... not all drivers will need or want a
> > workqueue, and those which
> >     do can always create their own if keventd isn't
> > good enough.
>
>
>
> Without the transfer routines I know it is hard to see
> why I have used a workqueue so let me explain.
> The workqueue is used as a scheduler for the adapter.
> What happens is that a SPI device driver calls
> transfer which creates a work item on the workqueue to
> do the transfer. ...

In short, it's an artifact of how some controller drivers are
implemented.  So it looks even more as if the right thing to do
there is to NOT require all controller drivers to do that.

Plus, since you've made it public, there's no way to ensure
that nobody else uses that work queue.  You're not following
the basic "information hiding" rule for interface design.


> 		 You have to
> have such a mechanism as you may have several SPI
> devices on an adapter doing asynchronous IO at the
> same time (i.e. giving an adapter that is in the
> middle of doing work more work).

No, you do not "have" to have such a mechanism.  You can look at the USB
stack  for a counterexample.  Both host and peripheral/gadget side adapter
drivers manage request queues just fine without requiring such a task.
And I assure you the queueing structure inside any USB Host Controller is
orders of magnitude more complex than any SPI adapter needs.


> >   - You set global policy on what "platform_data"
> > should hold.  That makes it
> >     not be platform-specific data any more!!  All
> > that info should be moved
> >     someplace else.  (E.g. in my patch, some of it
> > is held by the SPI core.)
>
> No, but don't the serial port drivers do that with the
> serial_struct structure? 
> Anyway surely what SPI devices are on an adapter is
> platform data! Why give the core work more to do?

Well, I've repeatedly given examples of cases where that is the
wrong model ... where the devices are associated with an expansion
card, so any reliance on platform data (that's set up by and coupled
to the baseboard) causes lots of problems.


> >   - There's stuff I don't think should be in the
> > device, like a semaphore
> >     (in addition to the driver model one!) and an
> > "spi_driver" pointer
> >     (mirroring driver model dev->driver).
>
> As the comment says, it is used to sleep on for
> blocking transfers, it's not a structure lock.

The traditional way to do this is more like what I
did in the refresh of my patch:

  http://marc.theaimsgroup.com/?l=linux-kernel&m=112631114922427&w=2
  http://marc.theaimsgroup.com/?l=linux-kernel&m=112631175219099&w=2

The first of those shows how to do it without that sort
of pre-allocation; see the synchronous calls.


> >   - And there's code to register and unregister a
> > "spi_device".  I've been
> >     thinking of that as the responsibility of the
> > "SPI core", and that things
> >     should work like most other bus frameworks on
> > Linux (other than I2C!!).
> >     That is, few folk (basically just subsystem
> > maintainers) ever need to muck
> >     with those particular "innards".  (That's the
> > case in the code I sent.)
> >     For better or worse, such code has proven quite
> > error prone.
>
> But the idea is that it's the same style as the
> platform bus in which you register and unregister a
> platform device.

For SPI, there needs to be a layer between the platform device and the
SPI devices.  That's the sort of code that I was pointing out tends to
be error prone.


> How else is the core going to know about the device?

See the patches above; I've explained that before.


>	My idea is that most people will
> pass in a cs_table which has the SPI devices on that
> adapter in it, but as you have pointed out this will
> not always be what people want (for more hotplug'ish
> devices) in which case they register those SPI devices
> in the same manor as platform devices (I need to do a
> bit work more work on this).

I've already done this work.  You could just reuse my code.  :)


> > The I/O layer stub is less minimal than what I sent,
> > but it's very similar
> > in structure, names, and roles.  A few things live
> > in different places. 
> > I see convergence there!
>
> Good :). Although that patch didn't have the transfer
> method in it :(.

I'm not sure how to parse that.  I remember seeing a transfer
method of some kind; otherwise I'd not have been able to
make such a comment.  (And the "different places" seemed
like a real issue ... per-request flags in the device,
per-device flags in the request, etc.)


> > As for I/O fast paths, I was thinking more about
> > "write word then read word"
> > stuff than bulk transfers, since so many SPI devices
> > seem to use that sort
> > of protocol convention (including MicroWire
> > hardware).  And the message
> > structure that's there now is prety bulk-oriented
> > ... I modeled it on one
> > from a DataFlash driver, not a sensor driver.
> > 
>
> The problem is that the "write word then read word"
> model is not universal and the msg structure is.

You can express "write word then read word" in terms of those messages;
necessarily so.  The controller method accepting a message structure
would be be a "must implement" (otherwise the rest couldn't just be
optional "fast path" support).

OR ... for the very common case that the hardware supports such things
directly, you could also add some fast paths.  So folk wanting quick
audio control, or sensor access, could get that.  (Unless the controller
were busy with some other request, in which case the request would need
to get queued up as a "message".  Not a fastpath.)


> > > but what about
> > > PCI cards which will have one interrupt line to
> > > the interrupt controller and a interrupt status
> > > register.
> > > In this case the adapter will have to take the
> > > interrupt and workout if it was for it or for the
> > > SPI device.
> > 
> > Are you implying the standard interrupt framework
> > would NOT work here?
>
> Yes.

You should maybe explain why it fails, in some other thread.
I assure you the IRQ framework will not be changed just to
make one exotic SPI implementation happier.


> > It already handles shared IRQs, whether for PCI or
> > GPIO or whatever.
> > (Or are you getting at something else?)
>
> But if a SPI device generates an interrupt on a PCI
> card which has only one interrupt line, how does the
> SPI device enable/disable/clear that interrupt given
> that the register is in the PCI device and the SPI
> device has no knowledge of that?

This sounds like exactly the same problem lots of device drivers
have:  they may have one PCI interrupt, but internally the device
has its own IRQ status, enable, and disable masks.  Then they do
the dispatch to different parts of the driver internally, based
on the status which triggered the IRQ.

SPI over PCI is reasonably exotic.  Seems to me as if the best way
to solve that kind of problem would involve specialized SPI-over-PCI
code, matching that one board.  Don't force every SPI implementations
to cope with the quirks of that one PCI card, especially when most
SPI hardware tres to be dead simple, to save costs.


> > > 2) Extra GPO lines used for reset, etc. 
> > > These could be treated like extra CS lines which
> > > can be changed in a spi_msg.
> > 
> > Same as with IRQs: just pass them in with the chip's
> > platform_data.
> > 
> > What's problematic is the fact that all GPIO code is
> > platform specific.
> > What works on PXA250 won't work on x86 or OMAP, and
> > it may not even work
> > on PXA270.  We'll still have limits to how portable
> > drivers can be.
> > 
>
> Not if you treat GPO pins as chip selects and let the
> adapter abstract them for you :).

That assumes the GPIO pin is being used as a chip select,
not as an input or output.  :)

- Dave

