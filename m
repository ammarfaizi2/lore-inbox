Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932369AbWCKB5g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932369AbWCKB5g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 20:57:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752290AbWCKB5g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 20:57:36 -0500
Received: from smtp-3.llnl.gov ([128.115.41.83]:46785 "EHLO smtp-3.llnl.gov")
	by vger.kernel.org with ESMTP id S1752064AbWCKB5f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 20:57:35 -0500
From: Dave Peterson <dsp@llnl.gov>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] EDAC: core EDAC support code
Date: Fri, 10 Mar 2006 17:57:00 -0800
User-Agent: KMail/1.5.3
Cc: Greg KH <greg@kroah.com>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, alan@redhat.com,
       gregkh@kroah.com, Doug Thompson <dthompson@lnxi.com>,
       bluesmoke-devel@lists.sourceforge.net
References: <200601190414.k0J4EZCV021775@hera.kernel.org> <200603101313.09754.dsp@llnl.gov> <1142025821.2876.106.camel@laptopd505.fenrus.org>
In-Reply-To: <1142025821.2876.106.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603101757.00060.dsp@llnl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 10 March 2006 13:23, Arjan van de Ven wrote:
> hmm ok so I want a function that takes a device as parameter, and checks
> the state of that device for errors. Internally that probably has to go
> via a function pointer somewhere to a device specific check method.
>
> Or maybe a per test-type (pci parity / ECC / etc) check
>
> int pci_check_parity_errors(struct pci_dev *dev, int flags);
>
> something like that, or pci_check_and_clear_parity_errors()
> (although that gets too long :)
>
> drivers can call that, say, after firmware init or something to validate
> their device is sanely connected. Maybe pci_enable_device() could call
> it too.
>
> This also needs a pci_suspend_parity_check() ... _resume_ ... so that
> the driver can temporarily disable any checks, for example during device
> reset/init. And then just before resume, it manually clears a check.

ok, perhaps things might look something like this?

    - A check_error() function checks a device for errors.  As you
      mention above, this may be a device-specific check method or a
      function like pci_check_parity_errors(dev, flags).  In either
      case, if check_error() finds an error, it clears the error from
      the device's registers and returns the error.  If check_error()
      finds multiple errors, here are couple of options:

          - Return a list of all errors detected.
          - Return a single error along with a boolean value that says
            whether more errors are present.  If so, check_error() may
            be called repeatedly until no errors remain.

    - A handle_error() function handles errors returned by
      check_error().  Here are a few options: Each device may have a
      handle_error() method that takes an error as a parameter.  Or,
      each type of error may have its own handle_me() method.  A third
      option is something like pci_handle_parity_error(dev, error).
      In any case, depending on the error type, the handler may choose
      to feed the error to EDAC.

    - Each hardware subsystem or device driver may determine its own
      error checking/handling strategy.  Some may want to poll for
      errors.  Others may want error detection to be asynchronous
      (driven by interrupts or exceptions).  Or a subsystem may poll
      for some kinds of errors and detect others asynchronously.  As
      you suggest, errors may also be checked for in other situations,
      such as after firmware init.

      For polling, the poll function calls check_error(), and then
      calls handle_error() if an error is found.  For interrupt-driven
      error checking, the interrupt handler calls check_error().  If
      an error is found, the interrupt handler may either call
      handle_error() directly or defer invocation of handle_error()
      outside interrupt context.  If the interrupt is an NMI, deferred
      invocation of handle_error() allows it to execute without
      introducing deadlocks or race conditions.

    - For some types of hardware, at boot time the device's registers
      contain spurious error info, which should be discarded.  This
      may be done by calling check_error() and discarding the results.

> > > 2) per bus code that calls the do check functions and whatever is
> > > needed for bus checks
> > >
> > > 3) "EDAC" central command, which basically gathers all failure reports
> > > and does something with them (push them to userspace or implement the
> > > userspace chosen policy (panic/reboot/etc))
> >
> > Are you suggesting something like the following?
> >
> >     - The controls that determine how the error checking is done are
> >       located within the various hardware subsystems.  For instance,
> >       with PCI parity checking, this would include stuff like setting
> >       the polling frequency and determining which devices to check.
>
> yes. I would NOT make it overly tunable btw. For many things a sane
> default can be chosen, and the effect of picking a different tuning
> isn't all that big. Maybe think of it this way: a tuneable to a large
> degree is an excuse for not determining the right value / heuristic in
> the first place.

Sounds good.

> >     - When an error is actually detected, the subsystem that detected
> >       the error (for instance, PCI) would feed the error information
> >       to EDAC.  Then EDAC would determine how to respond to the error
> >       (for instance, push it to userspace or implement the
> >       userspace-chosen policy (panic/reboot/etc))
>
> yup.

Cool!  I think this also coincides with what Doug is saying.  Doug, how
does this sound?

