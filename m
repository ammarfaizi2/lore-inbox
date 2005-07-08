Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261508AbVGHDnn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261508AbVGHDnn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 23:43:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262248AbVGHDnn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 23:43:43 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:38094 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S261508AbVGHDnm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 23:43:42 -0400
X-ORBL: [69.107.32.110]
Date: Thu, 07 Jul 2005 20:43:02 -0700
From: david-b@pacbell.net
To: linville@tuxdriver.com, ink@jurassic.park.msu.ru
Subject: Re: [linux-pm] [patch 2.6.13-rc2] pci: restore BAR values in 
 pci_set_power_state for D3hot->D0
Cc: rmk+lkml@arm.linux.org.uk, matthew@wil.cx, linux-pm@lists.osdl.org,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       grundler@parisc-linux.org
References: <20050624022807.GF28077@tuxdriver.com>
 <20050630171010.GD11369@kroah.com>
 <20050701014056.GA13710@tuxdriver.com>
 <20050701022634.GA5629.1@tuxdriver.com>
 <20050702072954.GA14091@colo.lackof.org>
 <20050702090913.B1506@flint.arm.linux.org.uk>
 <20050705200555.GA4756@parcelfarce.linux.theplanet.co.uk>
 <20050705224620.B15292@flint.arm.linux.org.uk>
 <20050706033454.A706@den.park.msu.ru>
 <20050708005701.GA13384@tuxdriver.com>
 <20050708005934.GB13384@tuxdriver.com>
In-Reply-To: <20050708005934.GB13384@tuxdriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20050708034302.267AF85EC2@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Some PCI devices lose all configuration (including BARs) when
> transitioning from D3hot->D0.  This leaves such a device in an
> inaccessible state.  The patch below causes the BARs to be restored
> when enabling such a device, so that its driver will be able to
> access it.

Hmm, I wonder if I missed something in previous email, but exactly
why isn't this the responsibility of the driver for that device?
It's only one of several similar issues, and not necessarily the
dominant one.

We had to address this D3hot->D0uninitialized issue for various USB
HCDs, in conjunction with similar problems wherein BIOS or swsusp
may also have stuck their nasty little fingers in the middle of the
power state transitions.  (And similarly, the variability of system
sleep states putting a USB controller into D3hot or D3cold... not
always with system wakeup capabilities.)

There, it was relatively straightforward to NOT involve the PCI layer;
and given the complications with BIOS, "legacy PCI" hardware (without
PCI PM support), and swsusp (plus different types of hardware support
even for hardware that does support PCI PM) more or less essential not
to do so.  Though to be sure, it did involve PCI-specific usbcore glue
code in hcd-pci.c; the PCI PM framework seemed to maybe expect less
variation in system behavior than seems routine with USB controllers.
But all that's just to condition things so the HCDs more or less see
a limited and sane set of states in their resume() methods.

- Dave

p.s. Until I sort out some mailer issues, it seems like my email
  is getting filtered from many lists; remember that for followups.

