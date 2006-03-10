Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932309AbWCJVXr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932309AbWCJVXr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 16:23:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932328AbWCJVXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 16:23:47 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:32449 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932309AbWCJVXq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 16:23:46 -0500
Subject: Re: [PATCH] EDAC: core EDAC support code
From: Arjan van de Ven <arjan@infradead.org>
To: Dave Peterson <dsp@llnl.gov>
Cc: Greg KH <greg@kroah.com>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, alan@redhat.com,
       gregkh@kroah.com, Doug Thompson <dthompson@lnxi.com>,
       bluesmoke-devel@lists.sourceforge.net
In-Reply-To: <200603101313.09754.dsp@llnl.gov>
References: <200601190414.k0J4EZCV021775@hera.kernel.org>
	 <200603101107.27244.dsp@llnl.gov>
	 <1142019195.2876.100.camel@laptopd505.fenrus.org>
	 <200603101313.09754.dsp@llnl.gov>
Content-Type: text/plain
Date: Fri, 10 Mar 2006 22:23:41 +0100
Message-Id: <1142025821.2876.106.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-10 at 13:13 -0800, Dave Peterson wrote:
> On Friday 10 March 2006 11:33, Arjan van de Ven wrote:
> > > Regarding the actual call to run it, I guess it depends on which of
> > > the following you prefer:
> > >
> > >     Scenario A
> > >     ----------
> > >     A more decentralized layout.  Here, the controls that govern the
> > >     error handling behavior for a given category of hardware (a
> > >     category might be "PCI devices" or "devices that use bus
> > >     technology XYZ") are grouped together with other stuff for that
> > >     category.
> >
> > this would basically make edac a place to report "help something went to
> > the gutter". Sure. I see that useful.
> >
> > In fact there are 3 layers then
> >
> > 1) low level "do check" function
> 
> I'm a bit unclear here.  Are you thinking of a single "do check"
> function that bus-specific code and chipset-specific code can hook
> into, or individual "do check" functions for various bus-specific and
> chipset-specific modules?

hmm ok so I want a function that takes a device as parameter, and checks
the state of that device for errors. Internally that probably has to go
via a function pointer somewhere to a device specific check method.

Or maybe a per test-type (pci parity / ECC / etc) check

int pci_check_parity_errors(struct pci_dev *dev, int flags);

something like that, or pci_check_and_clear_parity_errors()
(although that gets too long :)

drivers can call that, say, after firmware init or something to validate
their device is sanely connected. Maybe pci_enable_device() could call
it too.

This also needs a pci_suspend_parity_check() ... _resume_ ... so that
the driver can temporarily disable any checks, for example during device
reset/init. And then just before resume, it manually clears a check.




> 
> > 2) per bus code that calls the do check functions and whatever is needed
> > for bus checks
> >
> > 3) "EDAC" central command, which basically gathers all failure reports
> > and does something with them (push them to userspace or implement the
> > userspace chosen policy (panic/reboot/etc))
> 
> Are you suggesting something like the following?
> 
>     - The controls that determine how the error checking is done are
>       located within the various hardware subsystems.  For instance,
>       with PCI parity checking, this would include stuff like setting
>       the polling frequency and determining which devices to check.

yes. I would NOT make it overly tunable btw. For many things a sane
default can be chosen, and the effect of picking a different tuning
isn't all that big. Maybe think of it this way: a tuneable to a large
degree is an excuse for not determining the right value / heuristic in
the first place.



>     - When an error is actually detected, the subsystem that detected
>       the error (for instance, PCI) would feed the error information
>       to EDAC.  Then EDAC would determine how to respond to the error
>       (for instance, push it to userspace or implement the
>       userspace-chosen policy (panic/reboot/etc))

yup.


