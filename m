Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269963AbUJHBCn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269963AbUJHBCn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 21:02:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269957AbUJHA7X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 20:59:23 -0400
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:56730 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S269896AbUJHA6q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 20:58:46 -0400
From: David Brownell <david-b@pacbell.net>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: PATCH/RFC: usbcore wakeup updates (3/4)
Date: Thu, 7 Oct 2004 17:58:48 -0700
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <200410041407.47500.david-b@pacbell.net> <200410070835.53261.david-b@pacbell.net> <20041007211921.GE1447@elf.ucw.cz>
In-Reply-To: <20041007211921.GE1447@elf.ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200410071758.48625.david-b@pacbell.net>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 07 October 2004 2:19 pm, Pavel Machek wrote:
> 
> Hmm, perhaps it is wrong thing to tell the devices what state to enter
> in the first place.

As a rule, yes.  (I think you've made that point before!)

During system suspend transitions, pmcore should just
be telling drivers to "get compatible with system state X",
after "idle everything" and (for swsusp/pmdisk) "write
this image to swap" steps.  PMcore has no business
telling drivers which device-specific modes to use; it
isn't supposed to know any hardware that well.  It
wouldn't know, for example, that when wakeup is
enabled, certain states are ruled out ...

Though I don't see anything obviously broken about
(for example) using sysfs to force some devices into
PCI_D3hot state ... or with maintaining compatibility
with today's PCI API, which talks in terms of power state.


> > Do you think adding those two bits to per-device PM state
> > is basically a good way to introduce their wakeup capabilities
> > to the PM core?  Suggestions on the next step?
> 
> It did not look overly ugly to me... so it is probably okay. Not sure
> what the next step is 

Merging into some tree... presumably after 2.6.10 opens!  :)


> -- you'll probably want some sysfs interface for 
> suspending single devices?

Other than "echo -n $(IDENTIFIER) > power/state" ?  No,
we have sysfs support already!  But problems with it include:

 - Minor annoyance:  "echo" doesn't work, "echo -n" does!

 - The sysfs code needs to handle suspending a _tree_ not
   just a single device ... it'll have children if the device is a
   bus adapter (HCD), bridge (hub), or just the floor of a stack
   of virtualized drivers (usb-storage hotplugging SCSI hosts and
   disks on the fly, network adapters, etc).  This needs to do
   bottom-up-suspend and top-down-resume -- but it doesn't.
   (And USB has some workarounds, but they may need to cross
   from USB into other driver stacks ...)

 - Semantics of $(IDENTIFIER).  I think those need to include
   driver-specific values, and that means ripping out code that
   "knows" otherwise.  That includes in PMcore code.  And
   what makes most sense to me there involves two different
   sets of state identifiers, identified as meaningful strings not
   cryptic digits:  (a) a handful of generic states like "idle",
   "lowpower", "on", and "off", plus (b) device-specific states
   that might borrow from the bus (PCI_D1, PCI_D3hot, etc)
   but which can be customized to match the hardware.

   For some devices, "idle" and "lowpower" may both map
   to "off"; for some, "lowpower" may mean "cut power when
   idle" (instead of "full power all the time").

Near term, I'd hope for tree suspend/resume but start to clean
up the mess involved with $(IDENTIFIER).  (Plus make the
wakeup mechanisms work better.)


> > > Introducing enums where PCI suspend level is stored in u32
> > > would be welcome... 
> > 
> > I'm not averse to enums, especially once sparse does good things
> > with them, but I still think that sort of change would just be nibbling
> > around the edges of a larger problem.  (Which should be addressed
> > by different patches making device power states/policies, like G0/D1
> > or "idle yourself", be types that are fully distinct from system power
> > states like G1/S3, and for which abuse creates compiler errors.)
> 
> I'm not sure we want to move to anything complicated than simple enum.

I'm pretty sure we should.  If for no other reason than to force
all the drivers to change.  They disagree about what $IDENTIFIER
means because enums are basically un-typechecked integers,
and that's unlikely to change.

But also, since a typed struct pointer can support lots of other
policy structures, including things analagous to "cpufreq"
governors.  A set of drivers can agree (maybe because they
share the same bus, or are otherwise related) that the
pointer gets container_of() treatment to morph to something
packaginging much more interesting power policies than a
simple PCI bus needs.  Like for example suspending four
devices, on different busses, together -- or not at all.  Or
understanding that when these devices all suspend, one
of the power supplies (or clocks) can be disabled.

- Dave


> 								Pavel
> -- 
> People were complaining that M$ turns users into beta-testers...
> ...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
> 
