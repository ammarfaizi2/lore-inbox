Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752050AbWISUZV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752050AbWISUZV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 16:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752051AbWISUZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 16:25:21 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:21508 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1752050AbWISUZU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 16:25:20 -0400
Date: Tue, 19 Sep 2006 16:25:19 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: David Brownell <david-b@pacbell.net>
cc: linux-usb-devel@lists.sourceforge.net,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] [RFC] USB device persistence across suspend-to-disk
In-Reply-To: <200609191052.58196.david-b@pacbell.net>
Message-ID: <Pine.LNX.4.44L0.0609191604080.4631-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Sep 2006, David Brownell wrote:

> > what matters is that people have been forced to unmount all 
> > filesystems on USB devices before doing suspend-to-disk.  On some systems
> > this is necessary even for suspend-to-RAM.
> 
> Most PCs maintain the USB connections during suspend-to-RAM; ISTR seeing
> some hardware design guidelines from SFT saying to do it that way, so that
> remote wakeup works.  (E.g. on systems with only USB keyboards and mice,
> you want wakeup to be natural.)

I also saw some guidelines from Microsoft, perhaps the very same ones.  
They described the tasks the BIOS was supposed to undertake with regard to 
USB controllers.  However they didn't address the (IMO) really important 
issues.  And the vendor in question at the time interpreted the document 
to mean exactly the opposite of what you're saying!  (Of course, that's 
not saying much...)

> A mechanism that's this dangerous deserves to be discouraged much more
> strongly, if it's even merged.  (I'm not a big fan of giving people
> quite that much rope.)  Having it depend on CONFIG_EMBEDDED as well as
> CONFIG_EXPERIMENTAL (or better yet CONFIG_DANGEROUS) seems a better route...

I'll be happy to change the enabling mechanism from a module parameter to 
a config option -- or even both.

How dangerous would this turn out to be in the real world?  It's hard to 
say.  No doubt there would be occasional instances of crashes, but just 
how occasional is impossible to estimate.  My guess is pretty infrequent.

> > + * changed.  If the user replaces a flash memory card while the system is
> > + * asleep, he will have only himself to blame when the filesystem on the
> > + * new card is corrupted and the system crashes.
> 
> I'll disagree on the "only himself to blame".  If this mechanism is trivial
> to kick in, it will be kicked in even by (or on behalf of) users that have
> no reason to understand how dangerous this is.

This is the flip side of the argument.  How easy should it be to invoke 
this feature?  Most users at the level of ignorance you're assuming don't 
ever set up nontrivial module parameters.  Even fewer users bother to 
recompile kernels with config options different from those used by their 
distribution.

> > +			WARNING!!  If a USB mass-storage device or its media
> > +			are changed while the system is suspended, the kernel
> > +			may not realize what has happened.  If this option is
> > +			enabled then filesystem corruption and a system crash
> > +			may result.
>                         ^^^
>                         File system corruption ** WILL ** result...

Not necessarily.  The example that provoked this was an embedded system 
with its root fs on a non-accessible USB flash device.

> > +According to the USB specification, when a USB bus is suspended the
> > +bus must continue to supply suspend current (around 1-5 mA).  This
> 
> No ... it's normally 500 uA, or for high powered devices up to 2500 uA.
> The specification is a per-device average over 1 second, not per bus.

Okay, so I wrote that from memory and I was off by a factor of 2 (it does
say "around"!).  Since I didn't say whether the figure was per-device or
per-bus, you can't criticize that aspect.  :-)

> > +Loss of power isn't the only mechanism to worry about.  Anything that
> > +interrupts a power session will have the same effect.  For example,
> > +even though suspend current may have been maintained while the system
> > +was asleep, on many systems during the initial stages of wakeup the
> > +firmware (i.e., the BIOS) resets the motherboard's USB host
> > +controllers. 
> 
> That's called a BUG ... firmware shouldn't have reset any device
> that the OS was managing.  And in fact during true system suspend
> states, I've not heard any reports of a BIOS resetting a USB host
> controller.  Do you have examples of these "many" systems??

I don't have statistics.  But I have run across quite a few examples of
systems where this happens.  Lots of bug reports, plus at least one of my
own machines.  (I think -- haven't checked it recently.)

> > +On many systems the USB host controllers will get reset after a
>       ^^^^
>       "some" ... by numbers, not very many since ISTR it's against
> the hardware design guidelines from MSFT.

I wouldn't go so far as to say that, unless you can actually produce the
relevant quite from the guidelines document.  In any case, even if the
percentage of machines where this happens is relatively low it can still
amount to a lot of systems.

> > +suspend-to-RAM.  On almost all systems, no suspend current is
> > +available during suspend-to-disk (also known as swsusp).  You can
> > +check the kernel log after resuming to see if either of these has
> > +happened; look for lines saying "root hub lost power or was reset".
> > +
> > +In practice, people are forced to unmount any filesystems on a USB
> > +device before suspending.  
> 
> Just like for ** ALL ** other kinds of removable media, on any system
> where userspace isn't facilitating data corruption.

What about floppy disks?

> > +	WARNING: Using "persist=y" can be dangerous!!
> 
> You're understating this.  I really think that such a mechanism would
> need to be explicitly configured into the kernel.  Distros that want
> to cope with all the end-user "your kernel trashed my disk!!" service
> calls could do so ... others would keep that option off, and save lots
> of customer support and end user pain.

Would you prefer just a config option or a config option plus a module
parameter (both must be set to enable the feature)?

Alan Stern

