Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965178AbWDOVzU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965178AbWDOVzU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 17:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965183AbWDOVzU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 17:55:20 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:17424 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S965178AbWDOVzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 17:55:19 -0400
Date: Sat, 15 Apr 2006 22:53:55 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: modpost: serial/8250_pci warnings
Message-ID: <20060415215355.GB19735@flint.arm.linux.org.uk>
Mail-Followup-To: Sam Ravnborg <sam@ravnborg.org>,
	"Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org,
	akpm@osdl.org
References: <20060415111712.311372aa.rdunlap@xenotime.net> <20060415132343.544357a2.rdunlap@xenotime.net> <20060415211435.GA24887@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060415211435.GA24887@mars.ravnborg.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 15, 2006 at 11:14:35PM +0200, Sam Ravnborg wrote:
> On Sat, Apr 15, 2006 at 01:23:43PM -0700, Randy.Dunlap wrote:
> > 
> > drivers/serial/8250_pci.o has 23 section mismatch warnings.
> > They are all related to (come from) this struct:
> > 
> > static struct pci_serial_quirk pci_serial_quirks[] = {
> > 
> > so maybe either "quirk" can go into the whitelist, or
> > Russell can tell us if these are false positives or need to be
> > fixed.
> .init is referenced from pciserial_init_ports() which is NOT marked
> __devinit.
> And pciserial_init_ports() is exported - so it cannot be marked
> __devinit => it is a bug.

Out of the seven functions marked __devinit, only one is actually
buggy, since only Netmos make both serial as well as serial and
parallel cards.

A problem will only occur if parport_serial registers a Netmos port
and the netmos quirk is marked as __devinit.  The other quirks
never match any parallel port devices, and so will never be called.

Splitting the quirk table into parport_serial doesn't resolve this
issue as far as static analysis goes either.

A better solution would be to fix the device model so that devices
can have more than one driver, so parport_serial doesn't have to
exist.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
