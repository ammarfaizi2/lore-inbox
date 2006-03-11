Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751143AbWCKRL4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbWCKRL4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 12:11:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751297AbWCKRL4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 12:11:56 -0500
Received: from 66.239.25.20.ptr.us.xo.net ([66.239.25.20]:51894 "EHLO
	zoot.lnxi.com") by vger.kernel.org with ESMTP id S1751143AbWCKRLy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 12:11:54 -0500
Message-Id: <4412A0AB02000036000015D4@zoot.lnxi.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 Beta 
Date: Sat, 11 Mar 2006 10:04:27 -0700
From: "Doug Thompson" <dthompson@lnxi.com>
To: <dsp@llnl.gov>
Cc: <arjan@infradead.org>, <greg@kroah.com>, <gregkh@kroah.com>,
       <bluesmoke-devel@lists.sourceforge.net>,
       "Doug Thompson" <dthompson@lnxi.com>, <torvalds@osdl.org>,
       <alan@redhat.com>, <linux-kernel@vger.kernel.org>,
       <rdunlap@xenotime.net>
Subject: Re: [PATCH] EDAC: core EDAC support code
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-03-11 at 01:57 +0000, Dave Peterson  wrote:
> On Friday 10 March 2006 13:23, Arjan van de Ven wrote:
> > hmm ok so I want a function that takes a device as parameter, and checks
> > the state of that device for errors. Internally that probably has to go
> > via a function pointer somewhere to a device specific check method.
> >
> > Or maybe a per test-type (pci parity / ECC / etc) check
> >
> > int pci_check_parity_errors(struct pci_dev *dev, int flags);
> >
> > something like that, or pci_check_and_clear_parity_errors()
> > (although that gets too long :)
> >
> > drivers can call that, say, after firmware init or something to validate
> > their device is sanely connected. Maybe pci_enable_device() could call
> > it too.
> >
> > This also needs a pci_suspend_parity_check() ... _resume_ ... so that
> > the driver can temporarily disable any checks, for example during device
> > reset/init. And then just before resume, it manually clears a check.
> 
> ok, perhaps things might look something like this?
> 
>     - A check_error() function checks a device for errors.  As you
>       mention above, this may be a device-specific check method or a
>       function like pci_check_parity_errors(dev, flags).  In either
>       case, if check_error() finds an error, it clears the error from
>       the device's registers and returns the error.  If check_error()
>       finds multiple errors, here are couple of options:
> 
>           - Return a list of all errors detected.
>           - Return a single error along with a boolean value that says
>             whether more errors are present.  If so, check_error() may
>             be called repeatedly until no errors remain.
> 
>     - A handle_error() function handles errors returned by
>       check_error().  Here are a few options: Each device may have a
>       handle_error() method that takes an error as a parameter.  Or,
>       each type of error may have its own handle_me() method.  A third
>       option is something like pci_handle_parity_error(dev, error).
>       In any case, depending on the error type, the handler may choose
>       to feed the error to EDAC.
> 
>     - Each hardware subsystem or device driver may determine its own
>       error checking/handling strategy.  Some may want to poll for
>       errors.  Others may want error detection to be asynchronous
>       (driven by interrupts or exceptions).  Or a subsystem may poll
>       for some kinds of errors and detect others asynchronously.  As
>       you suggest, errors may also be checked for in other situations,
>       such as after firmware init.
> 
>       For polling, the poll function calls check_error(), and then
>       calls handle_error() if an error is found.  For interrupt-driven
>       error checking, the interrupt handler calls check_error().  If
>       an error is found, the interrupt handler may either call
>       handle_error() directly or defer invocation of handle_error()
>       outside interrupt context.  If the interrupt is an NMI, deferred
>       invocation of handle_error() allows it to execute without
>       introducing deadlocks or race conditions.
> 
>     - For some types of hardware, at boot time the device's registers
>       contain spurious error info, which should be discarded.  This
>       may be done by calling check_error() and discarding the results.
> 
> > > > 2) per bus code that calls the do check functions and whatever is
> > > > needed for bus checks
> > > >
> > > > 3) "EDAC" central command, which basically gathers all failure reports
> > > > and does something with them (push them to userspace or implement the
> > > > userspace chosen policy (panic/reboot/etc))
> > >
> > > Are you suggesting something like the following?
> > >
> > >     - The controls that determine how the error checking is done are
> > >       located within the various hardware subsystems.  For instance,
> > >       with PCI parity checking, this would include stuff like setting
> > >       the polling frequency and determining which devices to check.
> >
> > yes. I would NOT make it overly tunable btw. For many things a sane
> > default can be chosen, and the effect of picking a different tuning
> > isn't all that big. Maybe think of it this way: a tuneable to a large
> > degree is an excuse for not determining the right value / heuristic in
> > the first place.
> 
> Sounds good.
> 
> > >     - When an error is actually detected, the subsystem that detected
> > >       the error (for instance, PCI) would feed the error information
> > >       to EDAC.  Then EDAC would determine how to respond to the error
> > >       (for instance, push it to userspace or implement the
> > >       userspace-chosen policy (panic/reboot/etc))
> >
> > yup.
> 
> Cool!  I think this also coincides with what Doug is saying.  Doug, how
> does this sound?

It sounds good. One issue is how this works with the IBM PCI Parity
handling submission? I don't remember if it has been included yet or
not. I haven't fully studied their model, but it allowed for device
drivers to register notification functions. The PCI subsystem would then
notify the driver of such errors so the driver could do what ever it
needed to do in the bad-thing-happened event.

What we are trying to accomplish is a 'detection, harvesting and
logging' mechanism of these events so that these events can be available
for userland harvesting and possibly can do an alarm of some sort.





