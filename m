Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267645AbTAQTrM>; Fri, 17 Jan 2003 14:47:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267649AbTAQTrM>; Fri, 17 Jan 2003 14:47:12 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:12200 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S267645AbTAQTrL>; Fri, 17 Jan 2003 14:47:11 -0500
Date: Fri, 17 Jan 2003 13:56:07 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Russell King <rmk@arm.linux.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Initcall / device model meltdown?
In-Reply-To: <20030117192356.F13888@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0301171342410.15056-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jan 2003, Russell King wrote:

> Both the input core and the multifunction chip drivers are using
> module_init(), the order in which these are initialised is link-order
> specific, and it happens that drivers/input is initialised really late
> during boot, after drivers/misc.
> 
> Since the device model requires any object to be initialised before it
> is used, this causes an oops from devclass_add_driver().
> 
> We appear to have two conflicting requirements here:
> 
> 1. the device model requires a certain initialisation order.
> 2. modules need to use module_init() which means the initialisation order
>    is link-order dependent, despite our multi-level initialisation system.

I think there's basically two ways to overcome the current fragility:

o Get the init order right. Well, doing it by hand is obviously fragile,
  so it needs to be done automatically. I think rusty had patches floating
  about which would ensure proper ordering depending on the exported 
  interfaces. Example: The pci code exports pci_register_driver(), so we
  make sure that every (built-in) module which uses pci_register_driver() 
  runs only after the the module which defines pci_register_driver() has 
  finished its initcall.

  Note that this is how things are done today for actual modules, you 
  cannot load a module which depends on symbols defined in another module
  which has not yet been loaded, thus not yet initialized.

  However, it relies on sufficient modularization, which is true for much
  of the driver business, but e.g. pci isn't modularized and thus
  a bad example (USB, ISDN, etc are better ones). This method however
  does not help with early arch init etc., where I think explicit ordering
  is a better idea, anyway.

o Make the init order not matter. That is, make sure that the registration
  routines ("pci_register_driver()") can be run safely even before
  the corresponding __initcall() has executed. E.g. have 
  pci_register_driver() only add the driver to a (statically initialized)
  list of drivers. Then, when pci_init() gets executed, walk the list of
  registered drivers, call ->probe() etc.

--Kai


