Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268575AbUJDVnP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268575AbUJDVnP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 17:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268591AbUJDVgM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 17:36:12 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:25547 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S268609AbUJDVcG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 17:32:06 -0400
From: David Brownell <david-b@pacbell.net>
To: linux-kernel@vger.kernel.org
Subject: PATCH/RFC:  driver model/pmcore wakeup hooks (0/4)
Date: Mon, 4 Oct 2004 13:54:37 -0700
User-Agent: KMail/1.6.2
Cc: linux-usb-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200410041354.37932.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There's been some discussion about limitations of the current
pmcore for systems that want to be partially suspended most
of the time.  That is, where the power management needs to
affect ACPI G0 states, not G1 states like S1/S3/S4, and isn't cpufreq.

One significant example involves USB mice.  If they were to be
suspended (usb_suspend_device) after a few seconds of inactivity,
that change could often spread up the device tree and let the
USB host controller stop DMA access.  Some x86 CPUs could
then enter C3 and save a couple Watts of battery power ... until
the mouse moved, and woke that branch of the device tree
for a while (until the mouse went idle again).

Most of the parts for that are now in place.  But trying to use
them will turn up places where the pieces don't fit together
very well yet ... and wakeup support is one of them!  So for
example it's not possible to disable such an autosuspend
mechanism for mice that can't actually issue wakeups.

So here are a few patches that add some driver model support
for wakeup capabilities, and use it for PCI and USB.

 - wake-core.patch, adds two bits and sysfs control over one of them
 - wake-pci.patch, makes pci use those bits
 - wake-usbcore.patch, makes usb do so (replacing code/hacks)
 - wake-ohci.patch, matching wake-usbcore

The patches follow this, going to LKML.

Comments?

- Dave
