Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263862AbTJ1Ghf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 01:37:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263866AbTJ1Ghf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 01:37:35 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:48839 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S263862AbTJ1Ghe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 01:37:34 -0500
Date: Tue, 28 Oct 2003 01:27:09 -0500
To: linux-kernel@vger.kernel.org
Cc: corey@world.std.com, rmk@arm.linuk.org.uk
Subject: PCMCIA (ray_cs) and CONFIG_ISA
Message-ID: <20031028062709.GA5658@pimlott.net>
Mail-Followup-To: linux-kernel@vger.kernel.org, corey@world.std.com,
	rmk@arm.linuk.org.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Andrew Pimlott <andrew@pimlott.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just tried to use the in-kernel ray_cs driver in 2.4.22 (after
having used the stand-alone PCMCIA driver for years).  I encountered
much frustration, and while I don't have a complete understanding of
the issues, it seems that there is a tangled relationship between
CONFIG_ISA and allocating interrupts for PCMCIA devices.  In short,
everything works with CONFIG_ISA enabled (even only in cs.c and
rsrc_mgr.c) and fails otherwise.  I'm pretty sure my notebook
doesn't have any ISA, and there is nothing in kconfig to require
CONFIG_ISA, leaving a nasty trap.

Looking at pcmcia_request_irq, it seems that there is no chance to
pick an irq if CONFIG_ISA is disabled and the IRQ_HANDLE_PRESENT
flag is set.  The only chance is if the socket irq_mask is zero, but
this doesn't seem to be the case for PC sockets (I'm using
yenta_socket).  So it ends up requesting irq 0, which doesn't work
out so well (CS_IN_USE).

The code is basically the same in the stand-alone drivers, but I
noticed that the Debian build scripts for the stand-alone drivers
force CONFIG_ISA on.  I didn't find any documentation of why.  I
guess that's why I never had a problem before.

So how are things supposed to work?  Is this driver doing something
wrong (I observed the pcnet_cs driver works fine without CONFIG_ISA:
it doesn't get its own irq and is happy with that)?  Pilot error?
Or just an undocumented pitfall?

Here are the kernel messages for a failed attempt to use the
in-kernel ray_cs driver:

    Linux Kernel Card Services 3.1.22
      options:  [pci] [cardbus] [pm]
    cs.c 1.279 2001/10/13 00:08:28 (David Hinds)
    PCI: Found IRQ 11 for device 00:0b.0
    PCI: Found IRQ 11 for device 00:0b.1
    Yenta IRQ list 06b0, PCI irq11
    Socket status: 30000007
    cs: pcmcia_register_socket(0xd0b9f360)
    Yenta IRQ list 06b0, PCI irq11
    ray_cs Detected: WebGear PC Card WLAN Adapter Version 4.88 Jan 1999
    ray_cs: AccessConfigurationRegister: Resource in use

Andrew

Cc: Rusty King since he seems to have submitted some maybe-related
patches for 2.5.
