Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965269AbVIOWPA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965269AbVIOWPA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 18:15:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965276AbVIOWPA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 18:15:00 -0400
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:49109 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP id S965269AbVIOWO7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 18:14:59 -0400
X-ORBL: [69.107.75.50]
DomainKey-Signature: a=rsa-sha1; s=sbc01; d=pacbell.net; c=nofws; q=dns;
	h=received:date:from:to:subject:cc:references:in-reply-to:
	mime-version:content-type:content-transfer-encoding:message-id;
	b=pX+JbH+vSD2ML5WdRxC/5oahxh5ssJKCJe7tBqKqXt+3OEuNi0aUEtiL2lJGGlel2
	npByr89MaHaBXS3S+PAYQ==
Date: Thu, 15 Sep 2005 15:14:45 -0700
From: David Brownell <david-b@pacbell.net>
To: linux-kernel@vger.kernel.org, basicmark@yahoo.com
Subject: Re: [RFC][PATCH] SPI subsystem
Cc: dpervushin@ru.mvista.com
References: <20050915192408.7378.qmail@web30311.mail.mud.yahoo.com>
In-Reply-To: <20050915192408.7378.qmail@web30311.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20050915221445.06473C10B9@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> _Only_ the core uses the work queue. This is what
> happens: 
>  
> 1) SPI device driver creates message. 
> 2) SPI device passes this message to the core. 
> 3) The core puts this message on the work queue. 
> 4) When the controller is ready to receive the next
> message the message is passed to the adapter driver. 
>  
> The work queue is used to isolate and serializes the
> transfer calls from the SPI driver to the adapter.

I see what's going on.  You're assuming there even IS a core!

Where I assumed otherwise ... drivers that want a workqueue should
allocate their own.  The cost of that task shouldn't be inflicted on
drivers that are happy just having their IRQ handlers start the next
transfer right from the driver's request queue.  (I tend to avoid
layers -- like a "core" -- unless they're unavoidable.  That helps
code stay smaller, faster, and more comprehensible code.)


> > >    You have to
> > > have such a mechanism as you may have several SPI
> > > devices on an adapter doing asynchronous IO at the
> > > same time (i.e. giving an adapter that is in the
> > > middle of doing work more work).
> > 
> > No, you do not "have" to have such a mechanism.  You
> > can look at the USB
> > stack  for a counterexample.  Both host and
> > peripheral/gadget side adapter
> > drivers manage request queues just fine without
> > requiring such a task.
> > 
>
> First, quoting from urb.c 
> "Host Controller Drivers (HCDs) place all the URBs for
> a particular endpoint in a queue." 
> So USB does use queues. 

Exactly as I wrote ...  the issue isn't having request queues.
The point of the example is that USB doesn't require workqueues.
In fact, they're normally not used by HCDs.


> > Well, I've repeatedly given examples of cases where
> > that is the
> > wrong model ... where the devices are associated
> > with an expansion
> > card, so any reliance on platform data (that's set
> > up by and coupled
> > to the baseboard) causes lots of problems.
> > 
>
> I know! I agree that you can't always use the cs table
> as you don't always know what devices are connected to
> it. The problem that I have with your solution is how
> can I deal with a hotplugable adapter? I don't know
> what is bus number will be as I don't know what order
> the adapters will be registered in. How else can I
> solve this problem?

A hot pluggable adapter is going into some bus, and its driver will
be bound through that bus.  Its probe routine will then create and
register the "struct spi_master".  Output of that step includes the bus
number assigned to the adapter ... which is pretty much The Linux Way,
I can't think of a bus that works any other way.


> > OR ... for the very common case that the hardware
> > supports such things
> > directly, you could also add some fast paths.  So
> > folk wanting quick
> > audio control, or sensor access, could get that. 
> > 
>
> I'm not quite sure what your trying to achieve here.

Trying to derail some confusion of yours, unsuccessfully.  :(

The original observation was just that fast pathing _could_ be done
that way.  I'd hope to avoid needing it, but experience suggests it's
good to explore that design space before settling on one approach.


> > SPI over PCI is reasonably exotic.  Seems to me as
> > if the best way
> > to solve that kind of problem would involve
> > specialized SPI-over-PCI
> > code, matching that one board.
>
> No, no, no and no! For a start many manufactures
> producing SPI devices don't have a OMAP board to test
> there device but they all have a PC :)

Actually they can use any of hundreds of different Linux-equipped
embedded boards.  Their _target_ environment is rarely a PC, and that
means most of the development cycle won't run there either.  Ergo the
framework shouldn't be stretching _too_ much to handle issues that
only appear with one particular vendor's PCI-based eval hardware.

I can certainly understand how, say, Philips might want to support
evaluation boards in PC environments.   It can be easier to debug on
PCs; not everyone has JTAG tools; and so on.


> > > Not if you treat GPO pins as chip selects and let
> > > the adapter abstract them for you :).
> > 
> > That assumes the GPIO pin is being used as a chip
> > select, not as an input or output.  :)
>
> The point is that you can pass GPIO pins and routines
> to handle them to the adapter (after first setting
> them to output) as platform data this means that you
> don't have to do any nasty platform specific hacks in
> the SPI device driver, which can only be a good thing :).

Sure, I've certainly done that.  And that'd be the best way 
to build a bitbanging SPI adapter too ... every platform
will bang the bits differently (GPIOs, parport, etc).

- Dave


