Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968032AbWLEC2N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968032AbWLEC2N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 21:28:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968033AbWLEC2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 21:28:12 -0500
Received: from smtp107.sbc.mail.mud.yahoo.com ([68.142.198.206]:24994 "HELO
	smtp107.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S968032AbWLEC2K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 21:28:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Disposition:Message-Id:Content-Type:Content-Transfer-Encoding;
  b=QN+Oa0i8ZsNzTDMFY6OAioxglcL7C31t+HgTRk7h5GhHRZnCuIlPHCThzZR6ud9txEVHKW0uWps69VLj/AyvDi0dcxLCLMeFzWqGvVJmZQukINTCBftos4fKUoJdVbSmErViGDqlcWDXJUbNmTaO3xQPsRpNcH1w9Idr/MdjcPY=  ;
X-YMail-OSG: tf0Ly3MVM1mZVK.lp8xQqJxnqxAoNW.y4yczQSudShcYaD3awuhVr_H32Q1FMiEWEi8cZmr_QuHFy.U21z5Pthoqw14H.67R_pBZ0IFAq3VmR59z0cJmWA--
From: David Brownell <david-b@pacbell.net>
To: Greg KH <gregkh@suse.de>
Subject: Re: [patch 2.6.19-rc6] fix hotplug for legacy platform drivers
Date: Mon, 4 Dec 2006 18:28:00 -0800
User-Agent: KMail/1.7.1
Cc: Kay Sievers <kay.sievers@vrfy.org>, "Marco d'Itri" <md@Linux.IT>,
       linux-kernel@vger.kernel.org
References: <20061122135948.GA7888@bongo.bofh.it> <200611291727.31999.david-b@pacbell.net> <20061201070407.GL16413@suse.de>
In-Reply-To: <20061201070407.GL16413@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200612041828.01381.david-b@pacbell.net>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 30 November 2006 11:04 pm, Greg KH wrote:
> On Wed, Nov 29, 2006 at 05:27:31PM -0800, David Brownell wrote:
> > On Wednesday 29 November 2006 3:02 pm, Greg KH wrote:
> > > > 
> > > > Here's my fix.  ...
> > > > ... I audited all the drivers using the relevant APIs, and I can't 
> > > > see many (if any!) folk hitting problems from this.
> > > 
> > > But this still can cause the problem that your 'modalias' file in sysfs
> > > contains exactly the same name as the module itself, right?
> > 
> > Not a problem if folk stick to the original design.  Hotplug will at
> > most "modprobe $MODALIAS" (iff the device needs a driver) before doing
> > a udevsend ... and only coldplug uses "modprobe $(cat modalias)".
> 
> I'm not saying that the design does not have problems, but having a

No design is problem free, but I was just saying that any problems
in that context are because of someone needlessly fighting that design.

Like "of course you get into accidents when you drive on the wrong
side of the road", or "of course zeroing /dev/kmem as root crashes".


> modalias with no real alias does not make much sense to me.
> 
> > I could update the patch so that attribute turns into a null string,
> > but that would have a **negative effect** since it would break coldplug
> > for all the platform init code which doesn't use platform_add_devices()
> > or maybe platform_device_register().
> 
> Ok, I'm being thick here, but why do we need a modalias with the same
> name as the module?

We don't, today.  But that's the direct consequence of the change Kay has
promoted ... that is, the pushback on the $SUBJECT patch, trying to cast
the issue as related to how drivers are identified, not than how they act.

It's either create such pointless aliases for quite a few drivers *OR* break
what is currently _working_ hotplug on many busses ... nontrivial regression,
requiring a lot of work to resolve that would mean deployment delays on the
(usual/optimistic) order of 12 months or so for tool updates.

Or, more directly and simply, merge the $SUBJECT patch; no regression, no
deployment delays in userspace tools, etc.


In reality, "modalias" is the misnomer ... it's the kind of implementation
detail that's bad to put into an interfaces.  The role of that information
is "driver identifier".  Which for many busses is the module name.

For some expansion busses, like PCI and USB, the identifier supports
some bus-specific wildcard match rules.  Those busses were architected
around such driver match rules.  And modprobe was modified to understand
those wildcard rules; and kbuild was modified to generate module aliases
that hotplug could feed to "modprobe".  Fancy busses, fancy infrastructure;
it took a long time to get to the point where /sbin/hotplug can be as
simple as "modprobe $MODALIAS" (if needed!) plus "udevsend".

Busses like that are the exception though.  Most don't have any kind
of dynamic identification/enumeration infrastructure, or multi-vendor
driver match algorithm ... those have both design and implementation
costs, which are not always justifiable.  (Once you know the chip/board,
you know every device on it; so there's no point in adding any support
for auto-enumeration.  There are also power management issues, since
devices' interface clocks likely default to "off".  Linux must explicitly
enable those clocks, defeating the purpose of auto-enumeration...)

So the best that most busses can have is a Linux-specific driver ID;
although if you were judging by PC expansion busses, you might think
otherwise.  To Linux, "platform_bus" covers many dozens of different
hardware implementations.  On one SOC series, I can easily count a
dozen such busses ... sometimes just within one chip.

And in the context of platform_device and platform_driver, the driver
ID has always been the driver name ... which in all but a few cases
is also the module name.  There's been a trivial workaround for those
few cases:  MODULE_ALIAS(driver_name).


> > > That's not good, it should be an alias, not the "real name".
> > 
> > Well, adding unjustified complexity _after the fact_ isn't good either,
> > and that's what I see going on here.
> > 
> > How many years has KMOD been around?  It's worked just fine without that
> > sort of bizarre (and un-needed) rule.
> 
> What rule?

The new rule that's being promoted, with effect of breaking hotplug
and coldplug for platform drivers.  (And SPI drivers, and any other
bus that doesn't want to create needless complexity by requiring
updates to module-init-tools and kbuild.)  And some cases of KMOD.

That is, the new rule that requires the driver identifier never to be
the same as its module name ... and (a different rule?) requiring that
the driver identifer always be an alias, since (courtesy of the other
rule) the identifier couldn't be the module name.  The one requiring
that $MODALIAS become an actual alias, instead of a driver ID.

(You can tell those are new rules by the fact that applying them
would immediately break hotplug for some busses.  As well as KMOD
in various cases.  And that they literally have nothing to do with
the root cause of the problem addressed by $SUBJECT patch.)


> KMOD worked off of char device aliases for the most part. 

Not always.  I did a grep.  Things will (needlessly) break if anyone
starts to apply those new rules.  Platform bus is not the only example.
Notice how ata_probe() gets "ide-cd.ko", etc.


> > Aliases were provided just to give *additional* names to modules ...
> > not to make one needlessly "special".  Kernel request_module() calls
> > make no distinction between which type of name they use ... and when
> > the filesystem name changes, they still work when the old name is
> > properly aliased.
> > 
> > That whole "give a module an alias of itself" model just seems ludicrous
> > to me.  We _know_ that "A" means "A", so there's no point in aliasing it
> > as itself.
> 
> I thought that was my point here :)
> 
> So what's the issue?

The pushback on $SUBJECT patch.  Which amounts to wanting to break hotplug
for several busses, unless someone (NOT the folk promoting the breakage!)
updates (a) every driver on those busses, to add some new annotations for
hotplug, (b) kbuild, to handle those annotations so that (c) some new and
as-yet-undesigned/undeployed module-init-tool modifications can return those
systems back to **TODAY'S LEVEL OF FUNCTIONALITY** ... it'd likely be sometime
late next year before very many systems get back to working as well as they
work right now.

Just because of someone wanting to create a _new kernel policy_ about driver
identification ... requiring it to only be done using aliases, making real
names become, in some sense, second class citizens.  (Which is a bizarre notion
on so many levels I have a hard time starting to describe them all...)


> > ... plus it's a distraction from the real problem, namely that certain
> > "legacy" drivers, primarily stuffed onto the "platform" bus, can't ever
> > hotplug.  (While normal platform drivers do so just fine, without needing
> > strange rules to make some names "more equal than others".)
> 
> But does this solve that problem?
> 
> ugh, I'm confused...

There are really two issues here:

 - The "real one", as (yes!) fixed by the $SUBJECT patch.  Troublesome legacy
   drivers, like "i82365", written so they can't hotplug ... but the kernel
   hasn't previously known that.

 - The confusion, caused by a false identification of the "i82365" issue
   being a problem related to module aliasing ... instead of being rooted in
   the fact that it's a "legacy style" non-hotpluggable driver, since it
   creates its own device node.

The only _problem_ ever identified to me is the one where "modprobe i82365"
on systems without that hardware could make trouble.  That should be fixed
by $SUBJECT patch; a few dozen other ISA-era drivers have the same issue.

The _confusion_ is all this noise about wanting to change the rules associated
with module naming instead ... while still letting non-hotpluggable drivers try
to hotplug.  Most of it could have been avoided by not dodging the "legacy driver"
issue each time it was highlighted, or the way that half-formed rule change
proposal would cause significant regressions.

- Dave

